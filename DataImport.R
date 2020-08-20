library(data.table)
library(magrittr)
library(tidyr)

HH_file<- file.path('MiD2017_Haushalte.csv')
HH_dt <- fread(HH_file)
head(HH_dt)

Person_file <- file.path('MiD2017_Haushalte.csv')
Person_dt <- fread(Person_file)
head(Person_file)