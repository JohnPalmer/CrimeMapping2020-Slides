// Spatial Dependence
// John Palmer - Spring 2019

version 15
clear *
capture log close
log using lab5, text replace

cd "Z:\chicago"
spshape2dta chicago_reg_data, replace

use chicago_reg_data

spset, modify coordsys(latlong, kilometers)

spmatrix create contiguity W

spmatrix create idistance M

spmatrix dir

regress assaults burglaries

estat moran, errorlag(W)

estat moran, errorlag(M)

spregress assaults burglaries, gs2sls dvarlag(W)

estat impact

spregress assaults burglaries, gs2sls errorlag(W)

estat impact

spregress assaults burglaries, gs2sls ivarlag(W: burglaries)

estat impact

spregress assaults burglaries, gs2sls dvarlag(W) ivarlag(W: burglaries) errorlag(W)

estat impact


log close