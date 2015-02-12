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

############################################################################

#LINEARNA&KVADRATNA  (izberi katere bi si izbrala!!)
#cat("Rišem linearna&kvadratna ...\n")

t <- apply(porecja, 1, c)
donava <- t[,2]
skupaj <- t[,1]
plot(donava, skupaj, xlab="Povodje Donave",ylab="Slovenija - skupaj")
linearna <- lm(skupaj~donava)
abline(linearna, col="blue")
kvadratna <- lm(skupaj ~ I(donava^2) + donava)
curve(predict(kvadratna, data.frame(donava=x)), add = TRUE, col = "red")

sava <- t[,3]
plot(sava,skupaj, xlab="Porečje Save",ylab="Slovenija - skupaj")
kvadratna <- lm(skupaj ~ I(sava^2) + sava)
curve(predict(kvadratna, data.frame(sava=x)), add = TRUE, col = "red")

krsava<-t[,10]
plot(krsava, skupaj, xlab="Krška-Sava",ylab="Slovenija - skupaj") 
kvadratna <- lm(skupaj ~ I(krsava^2) + krsava)
curve(predict(kvadratna, data.frame(krsava=x)), add = TRUE, col = "red")

drava<-t[,14]
plot(drava, skupaj,xlab="Porečje Drave",ylab="Slovenija - skupaj")
linearna <- lm(skupaj~drava)
abline(linearna, col="blue")
kvadratna <- lm(skupaj ~ I(drava^2) + drava)
curve(predict(kvadratna, data.frame(drava=x)), add = TRUE, col = "red")

idr<-t[,35]
plot(idr, skupaj,xlab="Idrijca",ylab="Slovenija - skupaj")
kvadratna <- lm(skupaj ~ I(idr^2) + idr)
curve(predict(kvadratna, data.frame(idr=x)), add = TRUE, col = "red")

soca<-t[,33]
morje <- t[,28]
plot(soca,morje ,xlab="Povodje Soče",ylab="Povodje Jadranskega morja")
linearna <- lm(morje~soca)
abline(linearna, col="blue")


#sava drava mura se zlivajo v povodje donavo[2]
#Porečje Drave
plot(drava, donava, xlab="Porečje Drave",ylab="Povodje Donave")
linearna <- lm(donava~drava)
abline(linearna, col="blue")
kvadratna <- lm(donava ~ I(drava^2) + drava)
curve(predict(kvadratna, data.frame(drava=x)), add = TRUE, col = "red")

#Porečje Save
plot(sava,donava,xlab="Porečje Save",ylab="Povodje Donave") 
linearna <- lm(donava~sava)
abline(linearna, col="blue")
kvadratna <- lm(donava ~ I(sava^2) + sava)
curve(predict(kvadratna, data.frame(sava=x)), add = TRUE, col = "red")

###############################################################################


#PARI
#save
pairs(t[,c(3,4,6,8,10,12)])
#drave
pairs(t[,c(2,14,15,17,18,20,22)])

##################################################
dev.off()














#colnames(t)[c(2,1)]

###########################################
#netoliko zanimivi grafi
#plot(t[,23], t[,2],xlab="Porečje Mure",ylab="Povodje Donave") #orečje Mure
#plot(t[,11], t[,1],xlab="Krka",ylab="Slovenija - skupaj") # Krka
#plot(t[,4], t[,1])
#plot(t[,5], t[,1], xlab="Sora",ylab="Slovenija - skupaj")  #Sora

#pairs(porecja[2:12]) #težko primerjet