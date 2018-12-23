# http://r.789695.n4.nabble.com/How-to-Read-a-Large-CSV-into-a-Database-with-R-td3043209.html

library(sqldf) 
if (file.exists("mydb")) file.remove("mydb") 
sqldf("attach 'mydb' as new") 
write.table(BOD, file = "si.csv", quote = FALSE, sep = ",") 
read.csv.sql("si.csv", sql = "create table mytab as select * from file",
                           dbname = "mydb") 

# Error in connection_import_file(conn@ptr, name, value, sep, eol, skip) : 
#RS_sqlite_import: si.csv line 2 expected 2 columns of data but found 3
#In addition: Warning message:
#  closing unused connection 3 (si.csv) 
#Error in result_create(conn@ptr, statement) : no such table: file