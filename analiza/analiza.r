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
plot(t[,4], t[,1])

pairs(porecja[2:12])
pairs(t[,c(3,5,10,20)])
h <- hclust(dist(scale(porecja[1:12,])))
plot(h, hang=-1)

colnames(t)[c(2,1)]