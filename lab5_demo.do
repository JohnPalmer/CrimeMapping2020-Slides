// Spatial Dependence
// John Palmer - Spring 2019

version 15
clear *
capture log close
log using lab5_demo, text replace

cd "\\dcloud.local\public\023\u50722\Documents"

// We will use the NYC police data that you aggregated by police precinct in the last lab. To convert this to Stata format, run the spshape2dta command after setting the working directory to the location of your shape files. If your shapefiles are named nyc_crime_precinct_agg, then:
spshape2dta chicago_reg_data, replace

// The output shows you that the command created two new files. Open the main one:
use chicago_reg_data

// To create a contiguity matrix:
spmatrix create contiguity W

// To create an inverse distance matrix:
spmatrix create idistance M

// To see what you have created
spmatrix dir

// We will now fit an OLS regression model of the number of crime reports with no covariates
regress assaults burglaries

// To check for autocorrelation, use the estat moran command, specifying the weights you wish to use
estat moran, errorlag(W)

// Here is the spatial regression version of that model using the contiguity matrix
spregress assaults burglaries, gs2sls dvarlag(W)

spregress assaults burglaries, gs2sls errorlag(W)

spregress assaults burglaries, gs2sls ivarlag(W: burglaries)


spregress assaults burglaries, gs2sls dvarlag(W) ivarlag(W: burglaries)

spregress assaults burglaries, gs2sls dvarlag(W) ivarlag(W: burglaries) errorlag(W)


regress burglaries
estat moran, errorlag(W)


log close