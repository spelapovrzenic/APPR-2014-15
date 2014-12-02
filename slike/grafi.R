pdf("slike/grafi.pdf",paper="a4r")

plot(porecja[,12], xlab="porečja", ylab="količina dobavljene vode", 
     main="Porečja, leto 2013",pch=20, col="blue")

barplot(as.matrix(stopnje[1:10, 4]), beside=TRUE, legend.text = rownames(stopnje)[1:10],
        main="Količina arzenika v vodovodnih sistemih")

dev.off()