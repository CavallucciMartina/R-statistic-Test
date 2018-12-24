library(dplyr)
library(dbplyr)
library(readr)
Automezzo <- read_csv2("new/Automezzo.csv")
#Using ',' as decimal and '.' as grouping mark. Use read_delim() for more control.
##Parsed with column specification:
#  cols(
#    AutomezzoID = col_double(),
#    DataDiAcquisto = col_character(),
#    Chilometraggio = col_character(),
#    ModelloID = col_double(),
#    MarcaID = col_double(),
#    Rottamato = col_character(),
#    DataRottamazione = col_character(),
#    TipoVeicolo = col_double(),
#    TipiCarburante_TipoCarburanteID = col_double()
#  )

#How to change data type? only character and double?
#TODO

#

my_db_file <- "car-database.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
my_db
copy_to(my_db, Automezzi, temporary = FALSE)
my_db