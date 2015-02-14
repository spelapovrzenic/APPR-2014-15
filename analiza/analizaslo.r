# 4. faza: Analiza podatkov

#POREČJA PO GRUPAH (tree) pogrupirane so po velikosti
cat("Rišem analizo Slovenije ...\n")
cairo_pdf("slike/analizaslo.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)

naporecja <- is.na(porecja[,11])
por <- porecja[!naporecja,]
porec<- por[c(-31,-30,-19, -24),]
h <- hclust(dist(scale(porec)),method="ward.D2")
plot(h, hang=0.1, cex=0.7, main = "Porečja v Sloveniji",xlab ="Porečja",
     ylab=NULL,sub = "od leta 2002 do 2012")
rect.hclust(h,k=6,border="violet")

############################################################################

#SLOVENIJA KOLIČINA PO LETIH PADA
#regresijska premica krivulj ki bi se podatkom najboljše prilegala.
#Če je linearna regresija iščemo premico. y = k*x+n

sleto <-c(2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013)
t <- apply(porecja, 1, c)

skupaj <- t[,1]
plot(sleto,skupaj, xlab="Leto",ylab="Slovenija - skupaj", 
     main="Količina vode dobljena po porečjih, 2002-2013")
linearna <- lm(skupaj~sleto)
abline(linearna, col="blue")

kvadratna <- lm(skupaj ~ I(sleto^2) + sleto)
curve(predict(kvadratna, data.frame(sleto=x)), add = TRUE, col = "red")

library(mgcv)
loess <- loess(skupaj~sleto) #za lokalno prilagajanje;NAPOVEDNI MODEL
curve(predict(loess, data.frame(sleto=x)), add = TRUE, col = "green")

legend("topright",legend=c("Linerana: lm(skupaj ~ leto)", 
                    "Kvadratna: lm(skupaj ~ I(leto^2) + leto)",
                    "Loess: loess(skupaj~leto)"),lty = "solid", cex = 0.7,
       col = c("blue","red", "green"))

#manjši ostanek je bolj natančen
vsota.kvadratov <- sapply(list(linearna, kvadratna, loess), function(x) sum(x$residuals^2))
#249937183 208907001  74889334 (najbolj natančen loess)

###############################################################################

#PARI

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, na.rm = TRUE, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

#NAJVEČJA - povodja porečja
#Korelacija ali korelacijski koeficient je številska mera, ki predstavlja moč 
#linearne povezanosti dveh spremenljivk. 

reke <- t[,c(1,2,14,3,23,28,33)]
pairs(reke, lower.panel = panel.smooth, upper.panel = panel.cor, 
      main="Korelacije med največjimi povodji, 2002-2013")

# #save
# vsesave<-t[,c(3,4,6,8,10,12)]
# pairs(vsesave, lower.panel = panel.smooth, upper.panel = panel.cor)

# #drave
# vsedrave<-t[,c(14,16,17,18,19,20,22)]
# analiza.drave <- impute.knn(as.matrix(vsedrave[apply(is.na(vsedrave), 1, sum) <= 1,]))$data
# pairs(analiza.drave, lower.panel = panel.smooth, upper.panel = panel.cor)

##################################################


dev.off()


#KAR NEBOM UPORABILA:
# donava <- t[,2]
# plot(donava, skupaj, xlab="Povodje Donave",ylab="Slovenija - skupaj")
# linearna <- lm(skupaj~donava)
# abline(linearna, col="blue")
# 
# sava <- t[,3]
# plot(sava,skupaj, xlab="Porečje Save",ylab="Slovenija - skupaj")
# kvadratna <- lm(skupaj ~ I(sava^2) + sava)
# curve(predict(kvadratna, data.frame(sava=x)), add = TRUE, col = "red")
# 
# drava<-t[,14]
# plot(drava, skupaj,xlab="Porečje Drave",ylab="Slovenija - skupaj")
# linearna <- lm(skupaj~drava)
# abline(linearna, col="blue")

# soca<-t[,33]
# morje <- t[,28]
# plot(soca,morje ,xlab="Povodje Soče",ylab="Povodje Jadranskega morja")
# linearna <- lm(morje~soca)
# abline(linearna, col="blue")


# #sava drava mura se zlivajo v povodje donavo[2]
# #Porečje Drave
# plot(drava, donava, xlab="Porečje Drave",ylab="Povodje Donave")
# linearna <- lm(donava~drava)
# abline(linearna, col="blue")
# 
# #Porečje Save
# plot(sava,donava,xlab="Porečje Save",ylab="Povodje Donave") 
# kvadratna <- lm(donava ~ I(sava^2) + sava)
# curve(predict(kvadratna, data.frame(sava=x)), add = TRUE, col = "red")



