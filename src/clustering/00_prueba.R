library(dplyr)
library(tidyr) # sane data munging
library(ggplot2) # needs no introduction
library(ggfortify) # super-helpful for plotting non-"standard" stats objects
library(ggbiplot)

setwd("C:/Users/Usuario/Documents/Maestria en Mineria de datos - UTN/8 - Aplicaciones de MDD a la Economía y Finanzas/DescargaBucket/ST7620")
dataset <- read.table("cluster_de_bajas.txt", header = TRUE, sep = "\t", dec = ".")

campos_buenos  <- c( "ctrx_quarter", "cpayroll_trx", "mcaja_ahorro", "mtarjeta_visa_consumo", "ctarjeta_visa_trx",
                     "mcuentas_saldo", "mrentabilidad_annual", "mprestamos_personales", "mactivos_margen", "mpayroll",
                     "Visa_mpagominimo", "Master_fechaalta", "cliente_edad", "chomebanking_trx", "Visa_msaldopesos",
                     "Visa_Fvencimiento", "mrentabilidad", "Visa_msaldototal", "Master_Fvencimiento", "mcuenta_corriente",
                     "Visa_mpagospesos", "Visa_fechaalta", "mcomisiones_mantenimiento", "Visa_mfinanciacion_limite",
                     "mtransferencias_recibidas", "cliente_antiguedad", "Visa_mconsumospesos", "Master_mfinanciacion_limite",
                     "mcaja_ahorro_dolares", "cproductos", "mcomisiones_otras", "thomebanking", "mcuenta_debitos_automaticos",
                     "mcomisiones", "Visa_cconsumos", "ccomisiones_otras", "Master_status", "mtransferencias_emitidas",
                     "mpagomiscuentas", "cluster2")

dataset2 <- dataset[-876,campos_buenos]

pca <- prcomp(dataset2[,-40], scale=TRUE) #principle component analysis
pca <- pca$x
pca_data <- mutate(fortify(pca))
#We want to examine the cluster memberships for each #observation - see last column

ggplot(pca_data) + geom_point(aes(x=PC1, y=PC2, fill=factor(col)),
                              size=3, col="#7f7f7f", shape=21) + theme_bw(base_family="Helvetica")

biplot(pca, scale=0)

biplot(x, y, var.axes = TRUE, col, cex = rep(par("cex"), 2),
       xlabs = NULL, ylabs = NULL, expand = 1,
       xlim  = NULL, ylim  = NULL, arrow.len = 0.1,
       main = NULL, sub = NULL, xlab = NULL, ylab = NULL, ...)



###############################
data.pc = prcomp(dataset2[,-40], center = T, scale. = T)

ggbiplot(data.pc, choices = c(1,2), alpha = 0, var.scale = 0, varname.size=4, varname.abbrev=F) + xlim(-0.75, 0.75) + ylim(-0.75, 0.75)# + geom_point(color=dataset2$cluster2)

PC <- data.pc$rotation[,1]

PC <- data.pc$rotation[order(data.pc$rotation[,1]), ]

pca.var=pca$sdev^2
pve=pca.var/sum(pca.var)
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1),type='b')
