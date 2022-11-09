library(tidyverse)
library(sf)
library(tmap)
library(rmapshaper)


### Formas geográficas básicas. (Simple shapes, objetos sfg)

# point (punto) 
st_point(c(5, 2)) 

#Muchos puntos (con una matriz)
multipoint_matrix = rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)

# line (línea)
linestring_matrix = rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)

# polígono (polygon), se crea con una lista cuyo primer elemento es
# una matriz con los vértices. El primer y último renglon tienen que ser iguales.

polygon_list = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))

# sfc "simple feature column")

# Crear un sfc con tres polígonos

#Poligono 1
polygon_list1 = list(rbind(c(0,3), c(0,4), c(1,3), c(0,3)))
polygon1 = st_polygon(polygon_list1)
# Poligono 2
polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)

polygon_list3 = list(rbind(c(1,3), c(0,4), c(1,5), c(2,5), c(1,3)))
polygon3 = st_polygon(polygon_list3)

#Columna con dos poligonos (objeto sfc)
polygon_sfc = st_sfc(polygon1, polygon2, polygon3)

plot(polygon_sfc)



# Añadirle otros datos y convertirlo en un objeto sf

poly_attrib <- data.frame(color= c("blue", "green", "red"), valor= c(1,2, 2))
poly_sf <- st_sf(polygon_sfc, poly_attrib)
poly_sf

## al objeto poly_sf se le pueden añadir otros datos.

sabor = c("vainilla", "chocolate", "fresa")

# con dplyr
poly_sf %>% mutate(sabor = sabor)

# o con rbase

poly_sf$sabor = sabor

cbind(poly_sf, sabor) 


