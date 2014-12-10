# 2. faza: Uvoz podatkov

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
                  row.names = 1,
                  na.strings=c("-","z","..."),
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

#TABELA 4
uvozi4 <- function() {
  r <- read.csv2("podatki/eurotabela.csv", sep = ";", as.is = TRUE,
                 row.names = 1, na.strings=c("-", "z",":"),
                 fileEncoding = "Windows-1250")
  ro <-row.names(r)
  ro[34] <- "Macedonia"
  row.names(r) <- ro
  return(r)
}

cat("Uvažam podatke o euro(tabela 4)\n")
euro <- uvozi4()

#TABELA 5
source("lib/xml.r", encoding="UTF-8")
cat("Uvažam podatke o stopnjah(tabela 5)\n")
stopnje <- uvozi.voda()
