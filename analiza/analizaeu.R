library(impute)

cat("Rišem analizo Evrope - grupiranje...\n")
cairo_pdf("slike/slike-analiza/analizaeu1.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)

#GRUPIRANJE EVROPE
podatki.EU <- world[as.character(EU$sovereignt),]
ma <- match(row.names(podatki.EU), row.names(prebivalci))
povprecno.prebivalstvo <- apply(prebivalci[ma, c("X1980", "X2020")], 1, mean)
analiza.eu <- podatki.EU/povprecno.prebivalstvo #podatki deljeno preb

izbor <- analiza.eu[c("X2002", "X2007", "X2013")]
# dovolimo največ 1 manjkajoč podatek na vrstico
analiza.izbor <- impute.knn(as.matrix(izbor[apply(is.na(izbor), 1, sum) <= 1,]))$data

hh <- hclust(dist(analiza.izbor))
plot(hh, hang=0.1, cex=0.7, main = "Zajem vode v Evropi, na prebivalca",xlab ="Analiza",ylab=NULL,
     sub = "za leta 2002, 2007, 2013")
rect.hclust(hh,k=7,border="green")

dev.off()

#############################

#EVROPA zemljevid
cat("Rišem analizo Evrope - zemljevid grupiranja...\n")
cairo_pdf("slike/slike-analiza/analizaeu2.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)

source("lib/uvozi.zemljevid.r")
analiza.izbor <- scale(analiza.izbor)
k <- kmeans(analiza.izbor, 7)
drzavee <- row.names(analiza.izbor)
m <- match(svet$name_long, drzavee)
barve <- rainbow(7)
plot(svet, col=ifelse(is.na(m), "grey", barve[cutree(hh, k = 7)[m]]),
     xlim=c(-12, 35), ylim=c(34, 70), main="Evropa po skupinah glede na količino zajema vode")


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
koordinate2["Russia",2] <- koordinate2["Russia",2]-3
koordinate2["Moldova",1] <- koordinate2["Moldova",1]+0.4
koordinate2["Portugal",2] <- koordinate2["Portugal",2]+0.3
imena2["United Kingdom"] <- "United\nKingdom"
imena2["Bosnia and Herz."] <- "BiH"
imena2["Luxembourg"]<- "Lux"
imena2["Montenegro"]<-"Mont"
imena2["Macedonia"]<-"Mac"
imena2["Albania"]<-"Alb"
imena2["Slovenia"]<-"SLO"

text(koordinate2,labels=imena2,cex=0.3)
legend("bottomleft", col = barve, lty = "solid", cex = 0.5,
       legend = c("skupina 1", "skupina 2", "skupina 3","skupina 4", "skupina 5", "skupina 6",
                  "skupina 7"))

dev.off()

#k$size koliko je v posamezni skupini držav

###############################################
#GRAF EVROPA
library(impute)

cat("Rišem analizo Evrope - graf po letih...\n")
cairo_pdf("slike/slike-analiza/analizaeu3.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
#za podatke europe
podatki.EU <- world[as.character(EU$sovereignt),]
leta <- c(1987, 1992, 1997, 2002, 2007, 2013)
izbor3 <- podatki.EU[paste0("X", leta)]
analiza.izbor3 <- impute.knn(as.matrix(izbor3[apply(is.na(izbor3), 1, sum) <= 1,]))$data
vsotaeu2 <-colSums(analiza.izbor3)
plot(leta,vsotaeu2, ylab="količina vode", main="Količina zajete vode (poraba + izguba) za Evropo")

lin <- lm(vsotaeu2~leta)
abline(lin, col="darkviolet")

kv<- lm(vsotaeu2 ~ I(leta^2) + leta)
curve(predict(kv, data.frame(leta=x)), add = TRUE, col = "red")

legend("topright",legend=c("Linerana: lm(količina.vode ~ leta)", 
                           "Kvadratna: lm(količina.vode ~ I(leta^2) + leta)")
       ,lty = "solid", cex = 0.8,
       col = c("darkviolet","red"))
dev.off()

#NAPOVED
cat("Rišem analizo Evrope - napoved...\n")
cairo_pdf("slike/slike-analiza/analizaeu4.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
napoved <- function(x, model){predict(model,data.frame(leta=x))}

plot(leta,vsotaeu2,xlim= c(1987,2040),ylim=c(80,180),xlab="Leta",ylab="Količina vode", 
     main="Napoved zajete vode za Evropo do leta 2040")
curve(napoved(x, lin),col="darkviolet",add=TRUE)
curve(napoved(x, kv),col="red",add=TRUE)
legend("bottomleft",legend=c("Linerana napoved", 
                           "Kvadratna napoved")
       ,lty = "solid", cex = 0.8,
       col = c("darkviolet","red"))


#manjši ostanek je bolj natančen
vsota.kv <- sapply(list(linearna, kvadratna), function(x) sum(x$residuals^2))
#8.003063e+02 2.089070e+08 (linearna bolj natančna)
dev.off()
#####################################
# VSAKA SKUPINA POSEBEJ
euroana <- apply(analiza.izbor , 1, c)
leta2 <- c( 2002, 2007, 2013)

#estonia 1
cat("Rišem analizo Evrope - estonija...\n")
cairo_pdf("slike/slike-analiza/analizaeu-est.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
plot(leta2,euroana[,13], xlab="Leta",ylab="Količina zajete vode", main="1.skupina: predstavnica Estonija") #NARAŠČA
lin0 <- lm(euroana[,13]~leta2)
abline(lin0, col="blue")
dev.off()

#2.skupina MEŠANO

#3.skupina - VSE PADAJO, NEKATERE MALO BOL POLOŽNO
#United Kingdom
cat("Rišem analizo Evrope - uk...\n")
cairo_pdf("slike/slike-analiza/analizaeu-uk.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
plot(leta2,euroana[,16], xlab="Leta",ylab="Količina zajete vode", main="3.skupina: predstavnica Združeno Kraljestvo")
lin8 <- lm(euroana[,16]~leta2)
abline(lin8, col="lightblue")
dev.off()

#4.skupina NARAŠČA
#Slovenija
cat("Rišem analizo Evrope - slovenija...\n")
cairo_pdf("slike/slike-analiza/analizaeu-slo.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
plot(leta2,euroana[,34],xlab="Leta",ylab="Količina zajete vode", main="4. skupina: predstavnica Slovenija") #NARAŠČA
lin18 <- lm(euroana[,34]~leta2)
abline(lin18, col="darkviolet")
dev.off()

#5 (vEČINA) PADA
#Germany
cat("Rišem analizo Evrope - nemčija...\n")
cairo_pdf("slike/slike-analiza/analizaeu-ger.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
plot(leta2,euroana[,10],, xlab="Leta",ylab="Količina zajete vode", main="5. skupina: predstavnica Nemčija")# PADA
lin25 <- lm(euroana[,10]~leta2)
abline(lin25, col="violet")
dev.off()

#6.skipina PADA 
#France
cat("Rišem analizo Evrope - francija...\n")
cairo_pdf("slike/slike-analiza/analizaeu-fr.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
plot(leta2,euroana[,15], xlab="Leta",ylab="Količina zajete vode", main="6. skupina: predstavnica Francija")
lin30 <- lm(euroana[,15]~leta2)
abline(lin30, col="darkgreen")
dev.off()


#7.sk MEŠANO


