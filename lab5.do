// Spatial Dependence
// John Palmer - Spring 2019

version 15
clear *
capture log close
log using lab5, text replace

// We will use the NYC police data that you aggregated by police precinct in the last lab. To convert this to Stata format, run the spshape2dta command after setting the working directory to the location of your shape files. If your shapefiles are named nyc_crime_precinct_agg, then:
spshape2dta nyc_crime_precinct_agg, replace

// The output shows you that the command created two new files. Open the main one:
use nyc_crime_precinct_agg

// If your shape file uses latitude and longitude and you want to express distances in km, set this as follows:
spset, modify coordsys(latlong, kilometers)

// To create a contiguity matrix:
spmatrix create contiguity W

// To create an inverse distance matrix:
spmatrix create idistance M

// To see what you have created
spmatrix dir

// We will now fit an OLS regression model of the number of crime reports with no covariates
regress NUMPOINTS

// To check for autocorrelation, use the estat moran command, specifying the weights you wish to use
estat moran, errorlag(W)

// Here is the spatial regression version of that model using the contiguity matrix
spregress NUMPOINTS, gs2sls dvarlag(W)


log close