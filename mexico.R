#Code to download map from official website and read it to R
#as an sf object


if (!require('sf')) install.packages('sf'); library('sf')

# Download map
# 
urltot<-"https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/marcogeo/889463849568/mg2021_integrado.zip"

temp <- tempdir()
getOption('timeout')
options(timeout=500)
download.file(urltot, "temporal.zip")


# Expand zip file in another directory
unzip("temporal.zip", exdir="temp")

# Read files at state level 
mapamex <-st_read("temp/conjunto_de_datos/00ent.shp")


# Erase files that were downloaded (optional)
# If the user wants to work in another scale (municipality etc)
#the files can be kept. 
#Needs uncommenting to run


# unlink("temp", recursive = T)

#Erase zip file
unlink("temporal.zip")


