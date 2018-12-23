#http://homepages.ecs.vuw.ac.nz/~adam/scie201/lec_R_SQLite.html
library(DBI)
test_conn <- dbConnect(RSQLite::SQLite(), "db.sqlite")
dbListTables(test_conn)
#[1] "db-per-r"
dbListFields(test_conn, "db-per-r")
#[1] "anni"    "kmTot"   "km16"    "ore16"   "Spese16" "oreTot"  "Carb" 
dbGetQuery(test_conn, "SELECT * FROM db-per-r")
#Error in result_create(conn@ptr, statement) : near "-": syntax error
#ERROR BUT THE NAME OF THE TABLE IS db-per-r