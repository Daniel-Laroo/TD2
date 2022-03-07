#importation des donnée
datapath <- "C:\\Users\\Lenovo\\Desktop\\New folder\\Cours_ISEP2\\Cours R\\Travailler sur les bases\\Base_etudiant"
install.packages("haven", dependencies = TRUE)
library("haven")
cereal <- read_dta(file = paste0(datapath,"\\cereales.dta"))
legum <- read_dta(file = paste0(datapath,"\\legumes.dta"))
ehcvm <- read_dta(file = paste0(datapath,"\\Ehcvm21.dta"))
table<- read_dta(file = paste0(datapath,"\\table_conversion.dta"))
#ehcvmcsv <- read.csv(datapath,"\\ehcvm21_conso_red.csv", header = TRUE, sep = ";",stringsAsFactors = TRUE )
library(readr)
ehcvm21_conso_red <- read_delim("C:/Users/Lenovo/Desktop/New folder/Cours_ISEP2/Cours R/Travailler sur les bases/Base_etudiant/ehcvm21_conso_red.csv", 
                                delim = ";", escape_double = FALSE, trim_ws = TRUE)

#dim(cereal),  #str(cereal)
names(cereal)
names(table)
cereal_df <- data.frame(cereal)
table_df <- data.frame(table)

#table de conversion
tableconversion <- "C:/Users/Lenovo/Desktop/New folder/Cours_ISEP2/Cours R/Travailler sur les bases/Base_etudiant"
library(readxl)
Sys.setenv(TZ='GMT') # set time zone
base_table <- read_excel(paste0(tableconversion,"\\table_conversion_2021.xlsx"))
str(base_table)
base_table <- data.frame(base_table)
#View(table)
#View(base_table)

#changer de noms
colnames(cereal_df) <- c(colnames(cereal_df)[1],colnames(cereal_df)[2],colnames(cereal_df)[3],"autre_cereales", "quanite_cons", 
                         "unites_cons","taille_cons","provenance_auto","provenance_other",
                         "freq_achat","quatite_achat", 
                         "unite_achat","taille_achat","value_lastachat")

#unité standards
library(dplyr)
glimpse(cereal)
library(lessR)

produit <- subset(base_table, select = c("produitID","produitNom"))
uniteCons <- subset(base_table, select = c("uniteID", "uniteNom"))
tailleCons <- subset(base_table, select = c("tailleID", "tailleNom"))
## supression de doublons
produit_df <- distinct(produit)
uniteCons_df <- distinct(uniteCons)
tailleCons_df <- distinct(tailleCons)
cereal_df$produit <-factor(cereal_df$cereales_id1,
                           levels = produit_df$produitID, 
                           labels = produit_df$produitNom) 
cereal_df$unites <- factor(cereal_df$unites_cons, 
                           levels = uniteCons_df$uniteID, 
                           labels = uniteCons_df$uniteNom)
cereal_df$tailles <- factor(cereal_df$taille_cons,
                            levels = tailleCons_df$tailleID,
                            labels = tailleCons_df$tailleNom)
label(unites,"UnitÃ©s de consommation",data = cereal_df)
label(tailles, "tailles des unitÃ©s de consommation",data = cereal_df)
label(produit, "Produit de consommations",data = cereal_df)
glimpse(cereal_df)
