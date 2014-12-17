# 3. faza: Izdelava zemljevida

#1.ZEMLJEVID____________________________
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
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

# Izračunamo povprečno velikost družine.
#druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
min.2012 <- min(rregije[11], na.rm=TRUE)
max.2012 <- max(rregije[11], na.rm=TRUE)
norm.2012 <- (rregije[11]-min.2012)/(max.2012-min.2012)


# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/slovenija.pdf", width=6, height=4)

n = 100
barve =topo.colors(n)[unlist(1+(n-1)*norm.2012)]
plot(slo, col = barve,bg="lightblue")
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
title("Poraba vode na prebivalca (leto 2012)")


# slo$regijee <- rregije[,11]
# spplot(slo, "regijee", col = topo.colors(100))







#2.ZEMLJEVID_______________________
## Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                          "europa", "ne_110m_admin_0_countries.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")
EU <- svet[svet$name %in% rownames(euro),]

# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi2 <- function(podatki, zemljevid) {
  nove.slo <- c()
  manjkajo <- ! nove.slo %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.slo[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$name)[rank(zemljevid$name)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}
# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
eeuro <- preuredi2(euro, EU)

# Izračunamo povprečno velikost družine.
min.euro <- min(eeuro[6], na.rm=TRUE)
max.euro <- max(eeuro[6], na.rm=TRUE)
norm.euro <- (eeuro[6]-min.euro)/(max.euro-min.euro)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/europa.pdf", width=6, height=4)

n = 100
barve =topo.colors(n)[unlist(1+(n-1)*norm.euro)]
plot(EU, xlim=c(0, 30), ylim=c(20, 90),col = barve,bg="lightyellow")
title("Preskrba z vodo v evropi (leto 2005)")

dev.off()