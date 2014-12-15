pdf("slike/grafi.pdf",paper="a4")

#POREČJA(1)
porecja1 <- porecja[-1,]/1000
na.vrstice1 <- is.na(porecja1[,12])
barplot(porecja1[!na.vrstice1,12],  ylab="količina dobavljene vode (milijon m3)", las = 2,
        main="Porečja, leto 2013", ylim=c(0,140),beside=TRUE, 
        names.arg = rownames(porecja1[!na.vrstice1,]), cex.names = 0.5,
        col = rainbow(sum(!na.vrstice1)))

#PORABA(2)
plot(2008:2013, poraba[1,1:6]/1000000, "b", xlab = "leto",
     ylab = "milijarda m3",main="Preskrba poslovnih subjektov z vodo letno", col="blue",pch=8)

#REGIJE(3)
barplot(as.matrix(regije[2:13,11]), beside=TRUE,legend.text = rownames(regije)[2:13], 
        col=c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", 
              "#D55E00", "#CC79A7","#FFFFCC","#FF33FF","#66FFFF","#FFCCFF"),
        xlim=c(0,23),main="Poraba vodovodne vode v gospodinjstvih na prebivalca (leto 2012)",ylab="m3/prebivalca")

#EURO(4)
na.vrstice2 <- is.na(euro[,6])
barplot(euro[!na.vrstice2,6], ylab = "milijon m3", las = 2,
        main="Preskrbi z vodo v evropskih državah, leto 2005",
        names.arg = rownames(euro[!na.vrstice2,]), cex.names = 0.5,
        col = heat.colors(sum(!na.vrstice2)))


#STOPNJE(5)
barplot(as.matrix(stopnje[1:10, 4])/1000000, beside=TRUE, legend.text = rownames(stopnje)[1:10],
        main="Količina arzenika v vodovodnih sistemih (število delcev na milijon)", ylab = "milijoni")


dev.off()
