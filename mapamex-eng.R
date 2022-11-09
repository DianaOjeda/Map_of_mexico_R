##### ###########################
#### Code to generate the maps of Mexico as explained in the tutorial
####  Mapaspex_eng.pdf



# Libraries used in this code
#Libraries are isntalled with the function install.packages("package")

# where "package" is the name of the library

#Load libraries
library(tidyverse)
library(sf)
library(tmap)
library(rmapshaper)
library(RColorBrewer)
library(gridExtra)

#Simplify map
mex_simple <- st_simplify(mapamex, dTolerance=2000)

#Simplify map with rmapshaper

mapamex_simple <-  ms_simplify(mapamex, keep = 0.01, keep_shapes = TRUE)
mapamex_muysimple <- ms_simplify(mapamex, keep = 0.002, keep_shapes = TRUE)


# Plot the three simplified maps
mex_simple %>%tm_shape(mex_simpl) +
    tm_borders()

mapamex_simple %>% tm_shape() +
    tm_borders() +
    tm_layout(title = "Simplified",
              title.position = c('center', 'top'))




mapamex_muysimple %>% tm_shape() +
    tm_borders() +
    tm_layout(title = "Very simplified.",
              title.position = c('center', 'top'))

#save map in a file
save(mapamex_simple, file = "mapamex_simple.RData")

## Plot maps. We use mapamex_simple, the object with the simplified map

# To show how to graph data on the map, two columns of made-up "data" are created.
# One is numerical and the other one categorical

set.seed(100)
categorica <- sample(c("cat", "dog", "rabbit"), 32, replace = T)
numerica <- round(runif(32,30,80),2)
numerica2 <- round(rnorm(32, 40, 40))^2

# Add data to the sf object
# Several ways to do it

#With dplyr

mapamex_simple <-mapamex_simple %>%
    mutate(categorica = categorica, 
           numerica = numerica,
           numerica2 = numerica2)

# Can be added with rbase in several ways

#Binding columns
# mapamex_simple <- cbind(mapamex_simple, categorica, numerica)

# adding the column

# mapamex_simple$numerica <- numerica
# mapamex_simple$categorica  <- categorica


# Basic map. Only the state borders

tm_shape(mex_simple) +
    tm_borders()


# Map plotting categorical variable. Each state is filled with a color corresponding
# to each category

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", style = "cat")


# Same as above. tm_polygons() is equivalent to tm_borders() + tm_fill()


tm_shape(mapamex_simple) +
    tm_polygons("categorica", style = "cat")

#  Map plotting numerical value Default.

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica",  title="Mexico")


#  Plotting map with numerical variable's range divided into intervals of
# same length. Default number of intervals is 5

tm_shape(mapamex_simple) +
    tm_fill("numerica",   style ="equal") +
    tm_borders()

# Plotting map with numerical variable's range divided into intervals of 
# same length. Setting number of intervals to 7

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("numerica", style= "equal", n=7) 

# Plotting map setting the style to continouos

mapamex_simple %>% 
    tm_shape() +
    tm_borders() +
    tm_fill("numerica", style= "cont") 


############################
## Setting colors manually
#Specify colors with RColorBrewer
# Show all RColorBrewer palettes and their names

display.brewer.all()

#Specify palette and assign it to an object
mypal <- brewer.pal(5,"GnBu")

#Plot a map with the palette specified
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("numerica",  
            style = "equal",
            #Pass the palette we assigned as an argument
            palette = mypal)




# Choosing colors manually
# Specify colors with color name. (Doing it with hexadecimal code is the same)

#make vector object with color names
mypal = c("pink1", "lemonchiffon2", "skyblue")


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica",  
            style = "cat",
            #Pass the vector of colors as an argument
            palette = mypal)



# Choose the colors specifically for each  category


mypal <- c("rabbit" = "lightblue", "cat" = "green", "dog"= "orange")

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = mypal,   style ="cat") 


# Customize legend


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col = "categorica", #fill with variable "categorica"
            palette = pal,      #color palette from mypal
            style ="cat", 
            title = "Animal"    # Title of legend
    ) +
    
    tm_legend(position = c("left", "bottom"), #Legend position in map panel
              title.size = 2,                #Size of title 
              # de leyenda
              title.color = "blue",          #Color of legend title
              text.size = 1.5,               #size of category font in legend
              text.color = "red",            # colof of category font in legend
              title.fontfamily = "serif")    # font family 


## The position of the legend can be chosen with two coordinates between 0 and 1
## (0,0) is the lower left portion and (1,1) is the upper right

tm_shape(mapamex_simple) +
    tm_borders() +
    
    tm_fill(col = "categorica", 
            palette = pal,     
            style ="cat", 
            title = "Animal"    
    ) +
    tm_legend(position = c(0.15, 0.25))



#Add and customize title
# Customize


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = pal,   style ="cat", title = "Animal") +
    tm_layout(main.title = "Mascotas en México",  #add outside title
              #add customizations, position and letter size and color
              main.title.size = 3,                
              main.title.color = "slateblue",
              main.title.position = "center")



##Title can be placed inside the panel
# Position has to be specified with a vector.
#

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = pal,   style ="cat", title = "Animal") +
    tm_layout(title = "Mascotas en México",  #add outside title
              #add customizations, position and letter size and color
              title.size = 2,                
              title.color = "darkgreen",
              title.position = c("center", "top")
    )

#Inside title be placed anywhere in the panel
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = pal,   style ="cat", title = "Animal") +
    tm_layout(title = "Mascotas en México",  #add outside title
              #customize, position and letter size and color
              title.size = 2,                
              title.color = "darkgreen",
              title.position = c(0.1, 0.15)
    )

# Plotting variables with other graphical elements
#Fill states with categorical and add circles sized with numerical variable

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="categorica",   
            style ="cat", 
            title = "Animal") +
    tm_bubbles(size= "numerica2", #size of circle determined by variable numerica2
               legend.size.is.portrait = TRUE, 
               title.size = "Cantidad",
               col= "red"    # All circles same color
    ) 


#Numerical variable fills states and categorical variable plotted with circles
# Color indicates category


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica",   
            style ="equal" ) +
    tm_bubbles(col= "categorica", #color determines category
               legend.size.is.portrait = TRUE, 
               title.size = "Animal",
               size = 2  #size for ALL can be customized
    ) 



# Category can be defined with different shapes of symbols

tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica", 
            style ="equal" ) +
    tm_symbols(shape= "categorica", 
               legend.size.is.portrait = TRUE, 
               col = "blue",
               size = 1.5    ) 


