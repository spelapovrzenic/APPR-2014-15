# 4. faza: Analiza podatkov
# 
# # Uvozimo funkcijo za uvoz spletne strani.
# source("lib/xml.r")
# 
# # Preberemo spletno stran v razpredelnico.
# cat("Uvažam spletno stran...\n")
# tabela <- preuredi(uvozi.obcine(), obcine)
# 
# # Narišemo graf v datoteko PDF.
# cat("Rišem graf...\n")
# pdf("slike/naselja.pdf", width=6, height=4)
# plot(tabela[[1]], tabela[[4]],
#      main = "Število naselij glede na površino občine",
#      xlab = "Površina (km^2)",
#      ylab = "Št. naselij")
# dev.off()

t <- apply(porecja, 1, c)
plot(t[,2], t[,1])
plot(t[,3], t[,1])
#plot(t[,4], t[,1])
plot(t[,5], t[,1])
plot(t[,10], t[,1])
plot(t[,11], t[,1])
plot(t[,14], t[,1])
plot(t[,35], t[,1])
plot(t[,33], t[,28]) #povodje soče & povodje jadranskega morja

#sava drava mura se zlivajo v donavo
plot(t[,2], t[,14])
plot(t[,2], t[,3])
plot(t[,2], t[,23])

pairs(porecja[2:12])
#PARI
#save
pairs(t[,c(3,4,6,8,10,12)])
#drave
pairs(t[,c(2,14,15,17,18,20,22)])


h <- hclust(dist(scale(porecja[1:20,])))
plot(h, hang=-1)


colnames(t)[c(2,1)]