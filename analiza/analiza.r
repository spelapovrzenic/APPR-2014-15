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
dev.off()

#PARI
#save
pairs(t[,c(3,4,6,8,10,12)])
#drave
pairs(t[,c(2,14,15,17,18,20,22)])

##################################################


#GRUPIRANJE EVROPE
library(impute)

podatki.EU <- world[as.character(EU$sovereignt),]
ma <- match(row.names(podatki.EU), row.names(prebivalci))
povprecno.prebivalstvo <- apply(prebivalci[ma, c("X1980", "X2020")], 1, mean)
analiza.eu <- podatki.EU/povprecno.prebivalstvo #podatki deljeno preb

izbor <- analiza.eu[c("X2002", "X2007", "X2013")]
# dovolimo največ 1 manjkajoč podatek na vrstico
analiza.izbor <- impute.knn(as.matrix(izbor[apply(is.na(izbor), 1, sum) <= 1,]))$data

hh <- hclust(dist(analiza.izbor))
plot(hh, hang=0.1, cex=0.7, main = "Evropa",xlab ="Analiza evrope",ylab=NULL,
     sub = "za leta 2002, 2007, 2013")
rect.hclust(hh,k=6,border="green")

#####################################

#EVROPA zemljevid

source("lib/uvozi.zemljevid.r")
EUU <- svet[svet$name_long %in% drzavee,]
koordinate2 <- coordinates(EUU)
imena2 <- as.character(EUU$name)
rownames(koordinate2) <- imena2
names(imena2) <- imena2
koordinate2["Norway",1] <- koordinate2["Norway",1] - 2
koordinate2["Cyprus",2] <- koordinate2["Cyprus",2] - 1
koordinate2["United Kingdom",1] <- koordinate2["United Kingdom",1]+1
koordinate2["United Kingdom",2] <- koordinate2["United Kingdom",2]-1
koordinate2["Sweden",1] <- koordinate2["Sweden",1]-1
koordinate2["Greece",1] <- koordinate2["Greece",1]-0.8
koordinate2["Russia",1] <- koordinate2["Russia",1]-65
koordinate2["Croatia", 2]<- koordinate2["Croatia",2]+0.7
koordinate2["Croatia", 1]<- koordinate2["Croatia",1]+0.2
imena2["United Kingdom"] <- "United\nKingdom"
imena2["Bosnia and Herz."] <- "BiH"
imena2["Luxembourg"]<- "Lux"
imena2["Montenegro"]<-"Mont"
imena2["Macedonia"]<-"Mac"
imena2["Albania"]<-"Alb"
imena2["Slovenia"]<-"SLO"
imena2["Croatia"]<-"HR"


analiza.izbor <- scale(analiza.izbor)
k <- kmeans(analiza.izbor, 6)
drzavee <- row.names(analiza.izbor)
m <- match(svet$name_long, drzavee)
barve <- rainbow(6)
plot(svet, col=ifelse(is.na(m), "grey", barve[k$cluster[m]]),
     xlim=c(-22, 40), ylim=c(36, 70))

text(koordinate2,labels=imena2,cex=0.3)



#k$size koliko je v posamezni skupini držav


#################
#nepomembni podatki zaenkrat
podatki.EU <- world[as.character(EU$sovereignt),]
euroana <- apply(podatki.EU , 1, c) #transponiran world
ma <- match(row.names(podatki.EU), row.names(prebivalci))
povprecno.prebivalstvo <- apply(prebivalci[m, c("X1980", "X2020")], 1, mean)
analiza.eu <- podatki.EU/povprecno.prebivalstvo #podatki deljeno preb
#EU$analiza <- podatki.EU/povprecno.prebivalstvo  #za zemljevid
#m <- match(row.names(eeuro), row.names(prebivalci))
#colnames(t)[c(2,1)]

###########################################
#netoliko zanimivi grafi
#plot(t[,23], t[,2],xlab="Porečje Mure",ylab="Povodje Donave") #orečje Mure
#plot(t[,11], t[,1],xlab="Krka",ylab="Slovenija - skupaj") # Krka
#plot(t[,4], t[,1])
#plot(t[,5], t[,1], xlab="Sora",ylab="Slovenija - skupaj")  #Sora

#pairs(porecja[2:12]) #težko primerjet