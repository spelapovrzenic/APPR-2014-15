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
pdf("slike/slovenija.pdf")

#ZEMLJEVID A - leto 2002
min.2002 <- min(rregije[1], na.rm=TRUE)
max.2002 <- max(rregije[1], na.rm=TRUE)
norm.2002 <- (rregije[1]-min.2002)/(max.2002-min.2002)

n = 100
barve =topo.colors(n)[unlist(1+(n-1)*norm.2002)]
plot(slo, col = barve,bg="lightblue")
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
title("Poraba vode na prebivalca (leto 2002)")


#ZEMLJEVID B - leto 2007
min.2007 <- min(rregije[6], na.rm=TRUE)
max.2007 <- max(rregije[6], na.rm=TRUE)
norm.2007 <- (rregije[6]-min.2007)/(max.2007-min.2007)

n = 100
barve =topo.colors(n)[unlist(1+(n-1)*norm.2007)]
plot(slo, col = barve,bg="lightblue")
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
title("Poraba vode na prebivalca (leto 2007)")


#ZEMLJEVID C - leto 2012
min.2012 <- min(rregije[11], na.rm=TRUE)
max.2012 <- max(rregije[11], na.rm=TRUE)
norm.2012 <- (rregije[11]-min.2012)/(max.2012-min.2012)

n = 100
barve =topo.colors(n)[unlist(1+(n-1)*norm.2012)]
plot(slo, col = barve,bg="lightblue")
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
title("Poraba vode na prebivalca (leto 2012)")


#2.možnost
SLO <- slo$NAME_1

#A
slo$vode2003 <- rregije[,2]
spplot(slo, "vode2003", col = topo.colors(50), main = "Rodnost v Sloveniji za leto 2003")

#B
slo$vode2007 <- rregije[,6]
spplot(slo, "vode2007", col = topo.colors(50), main = "Rodnost v Sloveniji za leto 2007")

#C
slo$vode2012 <- rregije[,11]
spplot(slo, "vode2012", col = topo.colors(50), main = "Rodnost v Sloveniji za leto 2012")

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
imena["United Kingdom"] <- "United\nKingdom"


# Narišimo zemljevid v PDF.
cat("Rišem zemljevid europe...\n")
pdf("slike/europa.pdf")


EU$voda2005 <- eeuro[,6]
print(spplot(EU, "voda2005", xlim=c(-25, 40), ylim=c(33, 73),
             main = "Preskrba z vodo v Evropi (leto 2005)",
             col.regions = topo.colors(100),
             sp.layout = list(
               list("sp.polygons", EU[is.na(eeuro[,6]),], fill = "white"),
               list("sp.text", koordinate, imena, cex = 0.3)),
             par.settings = list(panel.background=list(col="lightyellow"))))


dev.off()