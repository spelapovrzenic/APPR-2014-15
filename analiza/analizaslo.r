# 4. faza: Analiza podatkov

#POREČJA PO GRUPAH (tree) pogrupirane so po velikosti
cat("Rišem analizo Slovenije -grupiranje ...\n")
cairo_pdf("slike/slike-analiza/analizaslo1.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)

naporecja <- is.na(porecja[,11])
por <- porecja[!naporecja,]
porec<- por[c(-31,-30,-19, -24),]
h <- hclust(dist(scale(porec)),method="ward.D2")
plot(h, hang=0.1, cex=0.7, main = "Porečja v Sloveniji",xlab ="Porečja",
     ylab=NULL,sub = "od leta 2002 do 2012")
rect.hclust(h,k=6,border="violet")

dev.off()
############################################################################

#SLOVENIJA KOLIČINA PO LETIH PADA

cat("Rišem analizo Slovenije - graf po letih ...\n")
cairo_pdf("slike/slike-analiza/analizaslo2.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)
sleto <-c(2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013)
t <- apply(porecja, 1, c)

skupaj <- t[,1]
plot(sleto,skupaj, xlab="Leto",ylab="Slovenija - skupaj (tisoč m^3)", 
     main="Količina vode dobljena po porečjih, 2002-2013")
linearna <- lm(skupaj~sleto)
abline(linearna, col="blue")

kvadratna <- lm(skupaj ~ I(sleto^2) + sleto)
curve(predict(kvadratna, data.frame(sleto=x)), add = TRUE, col = "red")

library(mgcv)
loess <- loess(skupaj~sleto) #za lokalno prilagajanje;NAPOVEDNI MODEL
curve(predict(loess, data.frame(sleto=x)), add = TRUE, col = "green")

legend("topright",legend=c("Loess: loess(skupaj~leto)",
                           "Linerana: lm(skupaj ~ leto)", 
                    "Kvadratna: lm(skupaj ~ I(leto^2) + leto)"),lty = "solid", cex = 0.8,
       col = c("green","blue","red"))

#manjši ostanek je bolj natančen
vsota.kvadratov <- sapply(list(linearna, kvadratna, loess), function(x) sum(x$residuals^2))
#249937183 208907001  74889334 (najbolj natančen loess)

dev.off()
###############################################################################

#PARI
cat("Rišem analizo Slovenije -pari ...\n")
cairo_pdf("slike/slike-analiza/analizaslo3.pdf", width = 9.27, height = 5.69,
          family = "Arial", onefile = TRUE)

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

reke <- t[,c(1,2,14,3,23,28,33)]
pairs(reke, lower.panel = panel.smooth, upper.panel = panel.cor, 
      main="Korelacije med največjimi povodji, 2002-2013")


##################################################


dev.off()

