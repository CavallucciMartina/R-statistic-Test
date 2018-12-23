#https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html#creating_a_new_sqlite_database
library(dplyr)
library(dbplyr)
species <- read.csv("data/species.csv")
surveys <- read.csv("data/surveys.csv")
plots <- read.csv("data/plots.csv")
my_db_file <- "portal-database.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
my_db
copy_to(my_db, surveys)
copy_to(my_db, plots)
my_db
