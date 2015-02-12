# 4. faza: Analiza podatkov

#POREČJA PO GRUPAH (tree)

cat("Rišem porečja po grupah...\n")
cairo_pdf("slike/grupe_porecja.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
naporecja <- is.na(porecja[,11])
por <- porecja[!naporecja,]
porec<- por[c(-31,-30,-19, -24),]
h <- hclust(dist(scale(porec)),method="ward.D2")
plot(h, hang=0.1, cex=0.7, main = "Porečja v Sloveniji",xlab ="Porečja",ylab=NULL,sub = "od leta 2002 do 2012")
rect.hclust(h,k=6,border="violet")



#LINEARNA&KVADRATNA DONAVA~SLOVENIJA
cat("Rišem linearna&kvadratna donava~slovenija ...\n")

t <- apply(porecja, 1, c)
donava <- t[,2]
skupaj <- t[,1]
plot(donava, skupaj, xlab="Povodje Donave",ylab="Slovenija - skupaj")
legend(100000, 300000, c("Linerana", "Kvadratna"), lty=c(1,1), col = c("blue","red"))
linearna <- lm(donava~skupaj)
abline(linearna, col="blue")
kvadratna <- lm(donava ~ I(skupaj^2) + skupaj)
curve(predict(kvadratna, data.frame(skupaj=x)), add = TRUE, col = "red")

dev.off()



plot(t[,3], t[,1], xlab="Porečje Save",ylab="Slovenija - skupaj") #slo Porečje Save
#plot(t[,4], t[,1])
#plot(t[,5], t[,1], xlab="Sora",ylab="Slovenija - skupaj")  #Sora
plot(t[,10], t[,1], xlab="Krška-Sava",ylab="Slovenija - skupaj") #Krška-Sava
#plot(t[,11], t[,1],xlab="Krka",ylab="Slovenija - skupaj") # Krka
plot(t[,14], t[,1],xlab="Porečje Save",ylab="Slovenija - skupaj") #Porečje Drave
plot(t[,35], t[,1],xlab="Idrijca",ylab="Slovenija - skupaj") #Idrijca
plot(t[,33], t[,28],xlab="Povodje Soče",ylab="Povodje Jadranskega morja") #povodje soče & povodje jadranskega morja

#sava drava mura se zlivajo v povodje donavo[2]
plot(t[,14], t[,2], xlab="Porečje Drave",ylab="Povodje Donave") #Porečje Drave
plot(t[,3], t[,2],xlab="Porečje Save",ylab="Povodje Donave") #Porečje Save
#plot(t[,23], t[,2],xlab="Porečje Mure",ylab="Povodje Donave") #orečje Mure

pairs(porecja[2:12])
#PARI
#save
pairs(t[,c(3,4,6,8,10,12)])
#drave
pairs(t[,c(2,14,15,17,18,20,22)])



colnames(t)[c(2,1)]