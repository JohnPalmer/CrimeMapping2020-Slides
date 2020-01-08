// Spatial Dependence
// John Palmer - Spring 2019

version 15
clear
capture log close
log using chicago_analysis, text replace

search shp2dta
search sg162
search sppack
search spatgsa


// Open the Chicago police data that you aggregated by police precinct in the last lab.
shp2dta using nyc_crime_precinct_agg, data(nyc_crime_xy) coordinates(nyc_cr_xy) genid(precinct) gencentroids(c)

use nyc_crime

spmat contiguity CONT using nyc_crime_xy, id(id) norm(row)

spmat summarize CONT

spmat idistance IDISTVAL200 using nyc_crime_xy, id(_ID) norm(row) vtruncate(1/200)


log close