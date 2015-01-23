# 4. faza: Analiza podatkov

#POREČJA PO GRUPAH
cat("Rišem porečja po grupah...\n")
cairo_pdf("slike/grupe_porecja.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
naporecja <- is.na(porecja[,11])
por <- porecja[!naporecja,]
porec<- por[c(-31,-30,-19, -24),]
h <- hclust(dist(scale(porec)),method="ward.D2")
plot(h, hang=0.1, cex=0.7, main = "Porečja v Sloveniji",xlab ="Porečja",ylab=NULL,sub = "od leta 2002 do 2012")
rect.hclust(h,k=6,border="violet")
dev.off()










t <- apply(porecja, 1, c)
plot(t[,2], t[,1]) #slo Povodje Donave
plot(t[,3], t[,1]) #slo Porečje Save
#plot(t[,4], t[,1])
plot(t[,5], t[,1])  #Sora
plot(t[,10], t[,1]) #Krška-Sava
plot(t[,11], t[,1]) # Krka
plot(t[,14], t[,1]) #Porečje Drave
plot(t[,35], t[,1]) #Idrijca
plot(t[,33], t[,28]) #povodje soče & povodje jadranskega morja

#sava drava mura se zlivajo v povodje donavo[2]
plot(t[,2], t[,14]) #Porečje Drave
plot(t[,2], t[,3]) #Porečje Save
plot(t[,2], t[,23]) #orečje Mure

pairs(porecja[2:12])
#PARI
#save
pairs(t[,c(3,4,6,8,10,12)])
#drave
pairs(t[,c(2,14,15,17,18,20,22)])



colnames(t)[c(2,1)]