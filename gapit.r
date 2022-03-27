library(multtest)
library(gplots)
library(LDheatmap)
library(genetics)
library(ape)
library(EMMREML)
library(compiler)
library("scatterplot3d")
source("/data/pub/shehb/sex/12-GWAS/output/gwas/gapit/gapit_functions.txt")
source("/data/pub/shehb/sex/12-GWAS/output/gwas/gapit/emma.txt")
setwd("/data/pub/shehb/sex/12-GWAS/output/gwas/gapit")
myY <- read.table("XY", head = TRUE)
myG <- read.table("gwas.hmp.flt.hmp.hapmap", head = FALSE)
myGAPIT <- GAPIT(
Y=myY,
G=myG,
PCA.total=3,
)

