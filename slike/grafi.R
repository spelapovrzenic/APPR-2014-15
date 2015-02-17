#POREČJA(1)
cat("Uvažam graf porečja...\n")
cairo_pdf("slike/slike-grafi/porecja.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

porecja1 <- porecja[-1,]/1000
na.vrstice1 <- is.na(porecja1[,12])
reke <- (porecja1[!na.vrstice1,])[12]
o1<- order(reke, decreasing = TRUE)
barplot(reke[o1,],  ylab="količina dobavljene vode (milijon m3)", las = 2,
        main="Porečja, leto 2013", ylim=c(0,140),beside=TRUE, 
        names.arg = rownames(porecja1[!na.vrstice1,])[o1], cex.names = 0.4,
        col = rainbow(sum(!na.vrstice1)))

dev.off()

#PRESKRBA(2)
cat("Uvažam graf preskrba...\n")
cairo_pdf("slike/slike-grafi/preskrba.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

plot(2008:2013, poraba[1,1:6]/1000000, "b", xlab = "leto",
     ylab = "milijarda m3",main="Preskrba poslovnih subjektov z vodo, letno", col="blue",pch=8)

dev.off()

#REGIJE(3)
cat("Uvažam graf regije...\n")
cairo_pdf("slike/slike-grafi/regije.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

o <- order(regije[,11], decreasing = TRUE)
o <- o[o != 1] # znebimo se podatkov za celotno Slovenijo
barplot(as.matrix(regije[o,11]), beside=TRUE,legend.text = rownames(regije)[o], 
        col=c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", 
              "#D55E00", "#CC79A7","#FFFFCC","#FF33FF","#66FFFF","#FFCCFF"),
        main="Poraba vodovodne vode v gospodinjstvih na prebivalca (leto 2012)",
        ylab="m3/prebivalca")

dev.off()

#EURO(4)
cat("Uvažam graf euro...\n")
cairo_pdf("slike/slike-grafi/euro.pdf", width = 11.27, height = 9.69,
          family = "Arial", onefile = TRUE)


na.vrstice2 <- is.na(euro[,6])
preskrba <- (euro[!na.vrstice2,])[6]
oo <- order(preskrba, decreasing = FALSE)
barplot(preskrba[oo,], ylab = "milijon m3", las = 2,
        main="Preskrba z vodo v evropskih državah, leto 2005",
        names.arg = rownames(preskrba)[oo], cex.names = 0.7,
        col = heat.colors(sum(!na.vrstice2)))

dev.off()

#STOPNJE(5)
cat("Uvažam graf stopnje...\n")
cairo_pdf("slike/slike-grafi/stopnje.pdf", width = 10.27, height = 9.69,
          family = "Arial", onefile = TRUE)

barplot(as.matrix(stopnje[1:10, 4])/1000000, beside=TRUE, legend.text = rownames(stopnje)[1:10],
        main="Količina arzenika v vodovodnih sistemih (število delcev na milijon)", ylab = "milijoni")
abline(v =6, col="red") 

dev.off()


#PADAVINE(6)
cat("Uvažam graf padavin...\n")
cairo_pdf("slike/slike-grafi/padavine.pdf", width = 9.27, height = 8,
          family = "Arial", onefile = TRUE)
plot(2008:2013, padavine[1,], "b", xlab = "leto",
     ylab = "količine padavin (mm)",main="Povprečne letne količine padavin v Sloveniji", col="cyan",pch=19)

dev.off()
