# 3. faza: Izdelava zemljevida

#1.ZEMLJEVID____________________________
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid slovenije...\n")
slo <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/SVN_adm.zip",
                          "slovenija", "SVN_adm1.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")

# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.slo <- c()
  manjkajo <- ! nove.slo %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.slo[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
rregije <- preuredi(regije[-1,], slo)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid slovenije...\n")
cairo_pdf("slike/slike-zemljevidi/slovenija1.pdf", width = 7.27, height = 5.69,
          family = "Arial", onefile = TRUE)

#Spremenjene koordinate in imena za Slovenijo
koordinate1 <- coordinates(slo)
imena1 <- as.character(slo$NAME_1)
rownames(koordinate1) <- imena1
names(imena1) <- imena1
koordinate1["Obalno-kraška",1] <- koordinate1["Obalno-kraška",1]+0.1 #levo,desno
koordinate1["Obalno-kraška",2] <- koordinate1["Obalno-kraška",2]+0.025 #dol,gor
koordinate1["Zasavska",2] <- koordinate1["Zasavska",2]+0.01 
koordinate1["Spodnjeposavska",1] <- koordinate1["Spodnjeposavska",1]+0.08
koordinate1["Spodnjeposavska",2] <- koordinate1["Spodnjeposavska",2]
imena1["Jugovzhodna Slovenija"] <- "Jugovzhodna\nSlovenija"
imena1["Notranjsko-kraška"] <- "Notranjsko-\nkraška"
imena1["Obalno-kraška"] <- "Obalno-\nkraška"

#ZEMLJEVID POVPREČJA 
rregije$povprecje <- apply(rregije,1, function(x) mean(x))
min.povprecje <- min(rregije[12], na.rm=TRUE)
max.povprecje <- max(rregije[12], na.rm=TRUE)
norm.povprecje <- (rregije[12]-min.povprecje)/(max.povprecje-min.povprecje)

n = 100
barve =rgb(1, 1, (n:1)/n)[unlist(1+(n-1)*norm.povprecje)]
plot(slo, col = barve,bg="lightblue")

legend("bottomright", legend = round(seq(min.povprecje, max.povprecje, (max.povprecje-min.povprecje)/5)),
       fill = rgb(1, 1, (6:1)/6), bg = "white")

text(koordinate1,labels=imena1,cex=0.4)
title("Povprečna poraba vode na prebivalca")


dev.off()



#PRIMERJAVA MED LETI 2003, 2007, 2012

#A
cairo_pdf("slike/slike-zemljevidi/slovenija2.pdf", width = 7.27, height = 5.69,
          family = "Arial", onefile = TRUE)
slo$vode2003 <- rregije[,2]
print(spplot(slo, "vode2003", col.regions  = topo.colors(50),
             main = "Poraba vode na prebivalca (leto 2003)",
             sp.layout = list(list("sp.text", koordinate1,imena1, cex = 0.5))))
dev.off()

#B
cairo_pdf("slike/slike-zemljevidi/slovenija3.pdf", width = 11.27, height = 5.69,
          family = "Arial", onefile = TRUE)
slo$vode2007 <- rregije[,6]
print(spplot(slo, "vode2007", col.regions  = topo.colors(50), 
             main = "Poraba vode na prebivalca (leto 2007)",
      sp.layout = list(list("sp.text", koordinate1,imena1, cex = 0.7))))
dev.off()

#C
cairo_pdf("slike/slike-zemljevidi/slovenija4.pdf", width = 11.27, height = 5.69,
          family = "Arial", onefile = TRUE)
slo$vode2012 <- rregije[,11]
print(spplot(slo, "vode2012", col.regions  = topo.colors(50), 
             main = "Poraba vode na prebivalca (leto 2012)",
      sp.layout = list(list("sp.text", koordinate1,imena1, cex = 0.7))))

dev.off()







#2.ZEMLJEVID_______________________

# Uvozimo zemljevid.
cat("Uvažam zemljevid sveta...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                          "europa", "ne_110m_admin_0_countries.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")
#EU <- svet[svet$name %in% rownames(euro),]

#Dodamo mankajoče države
manjkajoce.drzave <- c("Albania", "Belarus", "Kosovo", "Moldova", "Russian Federation", "Ukraine")
drzave <- c(rownames(euro), manjkajoce.drzave)
drzave <- drzave[drzave %in% svet$name_long]
EU <- svet[svet$name_long %in% drzave,]

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
manjkajo <- ! manjkajoce.drzave %in% rownames(euro)
M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(euro)))
names(M) <- names(euro)
row.names(M) <- manjkajoce.drzave[manjkajo]
eeuro <- rbind(euro, M)[as.character(EU$name_long),]

izbor <- !is.na(eeuro[,6])
koordinate <- coordinates(EU[izbor,])
imena <- as.character(EU$name[izbor])
rownames(koordinate) <- imena
names(imena) <- imena
koordinate["Norway",1] <- koordinate["Norway",1] - 2
koordinate["Cyprus",2] <- koordinate["Cyprus",2] - 1
koordinate["United Kingdom",1] <- koordinate["United Kingdom",1]+1
koordinate["United Kingdom",2] <- koordinate["United Kingdom",2]-1
koordinate["Sweden",1] <- koordinate["Sweden",1]-1
koordinate["Greece",1] <- koordinate["Greece",1]-0.8
imena["United Kingdom"] <- "United\nKingdom"


# Narišimo zemljevid v PDF.
cat("Rišem zemljevid europe...\n")
cairo_pdf("slike/slike-zemljevidi/europa.pdf", width = 7.27, height = 5.69,
          family = "Arial", onefile = TRUE)

rot <- ifelse(imena %in% "Portugal", 90, 0)
EU$voda2005 <- eeuro[,6]
print(spplot(EU, "voda2005", xlim=c(-25, 40), ylim=c(33, 73),
             main = "Preskrba z vodo v Evropi (leto 2005)",
             col.regions = topo.colors(100),col="dimgrey",
             sp.layout = list(
               list("sp.polygons", EU[is.na(eeuro[,6]),], fill = "white"),
               list("sp.text", koordinate, imena, cex = 0.35,col="black", srt = rot)),
             par.settings = list(panel.background=list(col="lightyellow"))))

dev.off()

#Preskrba na prebivalca
cat("Rišem zemljevid europe; preskrba na prebivalca...\n")
cairo_pdf("slike/slike-zemljevidi/europa2.pdf", width = 7.27, height = 5.69,
          family = "Arial", onefile = TRUE)
m <- match(row.names(eeuro), row.names(prebivalci))
povprecno.prebivalstvo <- apply(prebivalci[m, c("X2000", "X2010")], 1, mean)
EU$poraba05 <- eeuro$X2005/povprecno.prebivalstvo

print(spplot(EU, "poraba05", xlim=c(-25, 40), ylim=c(33, 73),
             main = "Povprečna preskrba z vodo v Evropi na prebivalca (leto 2005)",
             col.regions = topo.colors(100),
             sp.layout = list(
               list("sp.polygons", EU[is.na(eeuro[,6]),], fill = "white"),
               list("sp.text", koordinate, imena, cex = 0.3,col="black", srt = rot)),
             par.settings = list(panel.background=list(col="lightyellow"))))


dev.off()