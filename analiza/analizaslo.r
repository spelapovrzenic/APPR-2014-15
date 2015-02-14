# 4. faza: Analiza podatkov

#POREČJA PO GRUPAH (tree) pogrupirane so po velikosti
cat("Rišem analizo...\n")
cairo_pdf("slike/analizaslo.pdf", width = 9.27, height = 5.69,
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

sleto <-c(2002 ,2003 ,2004 ,2005 ,2006, 2007 ,2008 ,2009, 2010,2011, 2012,2013)
t <- apply(porecja, 1, c)

#SLOVENIJA KOLIČINA PO LETIH PADA
plot(sleto,skupaj, xlab="Leto",ylab="Slovenija - skupaj")
linearna <- lm(skupaj~sleto)
abline(linearna, col="blue")

donava <- t[,2]
skupaj <- t[,1]
plot(donava, skupaj, xlab="Povodje Donave",ylab="Slovenija - skupaj")
linearna <- lm(skupaj~donava)
abline(linearna, col="blue")

sava <- t[,3]
plot(sava,skupaj, xlab="Porečje Save",ylab="Slovenija - skupaj")
kvadratna <- lm(skupaj ~ I(sava^2) + sava)
curve(predict(kvadratna, data.frame(sava=x)), add = TRUE, col = "red")

drava<-t[,14]
plot(drava, skupaj,xlab="Porečje Drave",ylab="Slovenija - skupaj")
linearna <- lm(skupaj~drava)
abline(linearna, col="blue")

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

#Porečje Save
plot(sava,donava,xlab="Porečje Save",ylab="Povodje Donave") 
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





