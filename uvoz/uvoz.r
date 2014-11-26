# 2. faza: Uvoz podatkov

# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvoziDruzine <- function() {
#   return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
#                       row.names = 1,
#                       col.names = c("obcina", "en", "dva", "tri", "stiri"),
#                       fileEncoding = "Windows-1250"))
# }
# 
# # Zapišimo podatke v razpredelnico druzine.
# cat("Uvažam podatke o družinah...\n")
# druzine <- uvoziDruzine()

# Če bi imeli  več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.

#TABELA 1
uvozi1 <- function() {
  return(read.csv("podatki/1tabela.csv", sep = ";", as.is = TRUE,
                    row.names = 1, na.strings=c("-", "z") ,
                    fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o porečjih (tabela 1)\n")
porecja <- uvozi1()

#TABELA 2
uvozi2 <- function() {
  return(read.csv("podatki/2tabela.csv", sep = ";", as.is = TRUE,
                  row.names = 1, na.strings=c("-", "z","..."),
                  fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o porabi(tabela2)\n")
poraba <- uvozi2()

#TABELA 3
uvozi3 <- function() {
  return(read.csv("podatki/3tabela.csv", sep = ";", as.is = TRUE,
                  row.names = 1, na.strings=c("-", "z"),
                  fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o regijah(tabela 3)\n")
regije <- uvozi3()