# Map_of_mexico_R
Instructions to display data on a map of Mexico, at state level with R, including instructions on how to download the map.

English version of Mapademexico repository. A very informal tutorial on how to create vector maps
of Mexico with R using the tmap library. It includes instructions on how to download the geographical
data from INEGI and load it into R. 

List of files:

- Mapasmex_eng.pdf: Manual in English
- mexico.R: Code to download the geographical data.
- shapes_intro.R Code to learn to generate "simple features", the building blocks of the maps. It helps
understand better how the maps are built, but can be skipped.
- mapamex-eng.R Code to generate maps using the tmap library. It includes explanations on how to add data
and basic instructions on how to display the data on a map.
- mapamex_simple.RData R data with the simplified version of the sf object of the map of the states of Mexico.
It is explained in the manual what it is meant by "simplified" and how to do that. It is included in case the user
can't download the map or doesn't want to.
- mapamex_simple_data.DRata Same as above but with added made up data to have something to display. The mechanism
to generate the fake data is explained in the manual, but the user can go directly to this file.

Be careful not to load both mapamex_simple.RData and mapamex_simple_data.RData, as the R object contained in
both files has the same name.
