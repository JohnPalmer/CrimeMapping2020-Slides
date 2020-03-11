library(tidyverse)

D_individual = read_csv("http://johnpalmer.github.io/CrimeMapping2020-Slides/data/NYPD_Complaint_Map__Year_to_Date.csv")

D = D_individual %>% group_by(ADDR_PCT_CD, OFNS_DESC) %>% count()

