pdf("slike/grafi.pdf",paper="a4r")

#POREČJA(1)
plot(porecja[,12], xlab="porečja", ylab="količina dobavljene vode", 
     main="Porečja, leto 2013",pch=20, col="blue")

#PORABA(2)
hist(as.matrix(poraba[1,1:6]),beside=TRUE, col=c("#00904B", "#64BD4F", "#E13987", "#F191BA", "#FEEA65", "#FFE9E8"))

#REGIJE(3)
barplot(as.matrix(regije[2:13,11]), beside=TRUE,legend.text = rownames(regije)[2:13], 
        col=c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", 
              "#D55E00", "#CC79A7","#FFFFCC","#FF33FF","#66FFFF","#FFCCFF"))

#EURO(4)


#STOPNJE(5)
barplot(as.matrix(stopnje[1:10, 4]), beside=TRUE, legend.text = rownames(stopnje)[1:10],
        main="Količina arzenika v vodovodnih sistemih")


dev.off()