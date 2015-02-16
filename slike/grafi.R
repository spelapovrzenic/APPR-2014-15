cat("Uvažam grafe...\n")
#pdf("slike/grafi.pdf",paper="a4")
cairo_pdf("slike/grafi.pdf", width = 9.27, height = 11.69,
          family = "Arial", onefile = TRUE)

#POREČJA(1)
porecja1 <- porecja[-1,]/1000
na.vrstice1 <- is.na(porecja1[,12])
reke <- (porecja1[!na.vrstice1,])[12]
o1<- order(reke, decreasing = TRUE)
barplot(reke[o1,],  ylab="količina dobavljene vode (milijon m3)", las = 2,
        main="Porečja, leto 2013", ylim=c(0,140),beside=TRUE, 
        names.arg = rownames(porecja1[!na.vrstice1,])[o1], cex.names = 0.5,
        col = rainbow(sum(!na.vrstice1)))

#PORABA(2)
plot(2008:2013, poraba[1,1:6]/1000000, "b", xlab = "leto",
     ylab = "milijarda m3",main="Preskrba poslovnih subjektov z vodo, letno", col="blue",pch=8)

#REGIJE(3)
o <- order(regije[,11], decreasing = TRUE)
o <- o[o != 1] # znebimo se podatkov za celotno Slovenijo
barplot(as.matrix(regije[o,11]), beside=TRUE,legend.text = rownames(regije)[o], 
        col=c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", 
              "#D55E00", "#CC79A7","#FFFFCC","#FF33FF","#66FFFF","#FFCCFF"),
        main="Poraba vodovodne vode v gospodinjstvih na prebivalca (leto 2012)",
        ylab="m3/prebivalca")

#EURO(4)

na.vrstice2 <- is.na(euro[,6])
preskrba <- (euro[!na.vrstice2,])[6]
oo <- order(preskrba, decreasing = FALSE)
barplot(preskrba[oo,], ylab = "milijon m3", las = 2,
        main="Preskrba z vodo v evropskih državah, leto 2005",
        names.arg = rownames(preskrba)[oo], cex.names = 0.5,
        col = heat.colors(sum(!na.vrstice2)))


#STOPNJE(5)
barplot(as.matrix(stopnje[1:10, 4])/1000000, beside=TRUE, legend.text = rownames(stopnje)[1:10],
        main="Količina arzenika v vodovodnih sistemih (število delcev na milijon)", ylab = "milijoni")
abline(v =6, col="red") 

dev.off()

#PADAVINE(6)
cat("Uvažam graf padavn...\n")
cairo_pdf("slike/graf_padavine.pdf", width = 9.27, height = 5,
          family = "Arial", onefile = TRUE)
plot(2008:2013, padavine[1,], "b", xlab = "leto",
     ylab = "količine padavin (mm)",main="Povprečne letne količine padavin v Sloveniji", col="cyan",pch=19)


dev.off()
