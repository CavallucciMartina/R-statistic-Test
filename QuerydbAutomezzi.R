library(dplyr)
library(dbplyr)
library(readr)
#Connessione
my_db <- DBI::dbConnect(RSQLite::SQLite(), "dbAutomezzi.sqlite")
Automezzo <-tbl(my_db, "Automezzo")
MarcaAuto<-tbl(my_db, "MarcaAuto")
ModelloAuto <-tbl(my_db,"ModelloAuto")
Missione <- tbl(my_db, "Missione")
Manutenzione <- tbl(my_db,"Manutenzione")
RifornimentoCarburante <- tbl(my_db,"RifornimentoCarburante")
TipoCarburante <-tbl(my_db,"TipoCarburante")
TipoManutenzione <- tbl(my_db,"TipoManutenzione")
#
#Query 1) Selezionare le 10 automobili con data di acquisto minore,
#cioè le auto con più anni. Si visualizza anche il loro chilometraggio.
#Tali auto è importante che non siano rottamate, potremmo non avere dati
#aggiornati riguardo ad esse.
#
OldestCar <- paste("SELECT a.AutomezzoID,a.DataDiAcquisto, a.Chilometraggio,
                   2018-(a.DataDiAcquisto/10000) as Anni
                   FROM Automezzo a
                   WHERE a.Rottamato = 0
                   GROUP BY a.AutomezzoID
                   ORDER BY a.DataDiAcquisto ASC
                   LIMIT 10",
                   sep="")
OldestCarResult<-tbl(my_db, sql(OldestCar))
OldestCarResult
#
#Query 2) Selezionare le 10 automobili con chilometraggio maggiore,
#Si visualizza anche la loro data di acquisto.
#Tali auto è importante che non siano rottamate, potremmo non avere dati
#aggiornati riguardo ad esse.
#
BiggestKMCar <- paste("SELECT a.AutomezzoID, a.Chilometraggio, a.DataDiAcquisto
                   FROM Automezzo a
                   WHERE a.Rottamato = 0
                   GROUP BY a.AutomezzoID
                   ORDER BY a.Chilometraggio DESC
                   LIMIT 10",
                   sep="")
BiggestKMCarResult<-tbl(my_db, sql(BiggestKMCar))
BiggestKMCarResult
#
#Query 3) Selezionare le 10 automobili con chilometraggio maggiore,
#Si visualizzi la marca e il modello dell'automobile.
#Tali auto è importante che non siano rottamate, potremmo non avere dati
#aggiornati riguardo ad esse.
#
BrandBiggestKMCar <- paste("SELECT a.AutomezzoID, a.Chilometraggio, m.Descrizione as Marca,
                            mo.Descrizione as Modello
                          FROM Automezzo a
                          JOIN MarcaAuto m
                         ON a.MarcaID = m.MarcaID
                          JOIN ModelloAuto mo
                          ON a.ModelloID = mo.ModelloID
                         WHERE a.Rottamato = 0
                         GROUP BY a.AutomezzoID
                         ORDER BY a.Chilometraggio DESC
                         LIMIT 10",
                         sep="")
BrandBiggestKMCarResult<-tbl(my_db, sql(BrandBiggestKMCar))
BrandBiggestKMCarResult

          
##
##Query 4) Selezionare le 10 automobili che hanno effettuato il maggior
#numero di chilometri in missioni nel 2016.
##
BiggestKMMission16Car <- paste("SELECT DISTINCT m.AutomezzoID,sum(m.Chilometraggio)
               FROM Missione m
               WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                                       FROM Automezzo a 
                                       WHERE a.Rottamato = 0)
               AND  m.DataInizioMissione >  20160101 
               and m.DataInizioMissione < 20170000
               and m.Chilometraggio > 0
               and m.Durata > 1
               and m.DataInizioMissione > 0
               and m.NumeroPasseggeri > 0
               GROUP BY m.AutomezzoID
               ORDER BY SUM(m.Chilometraggio) DESC
               LIMIT(10)")
BiggestKMMission16CarResult<-tbl(my_db, sql(BiggestKMMission16Car))
BiggestKMMission16CarResult
##
##Query 5) Selezionare le 10 automobili con il maggior tempo di missione nel 2016
##
BiggestHourMission16Car <- paste("SELECT DISTINCT m.AutomezzoID,sum(m.Durata)/60
                              FROM Missione m
                               WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                               FROM Automezzo a 
                               WHERE a.Rottamato = 0)
                               AND  m.DataInizioMissione >  20160101 
                               and m.DataInizioMissione < 20170000
                               and m.Chilometraggio > 0
                               and m.Durata > 1
                               and m.DataInizioMissione > 0
                               and m.NumeroPasseggeri > 0
                               GROUP BY m.AutomezzoID
                               ORDER BY SUM(m.Chilometraggio) DESC
                               LIMIT(10)")
BiggestHourMission16CarResult<-tbl(my_db, sql(BiggestHourMission16Car))
BiggestHourMission16CarResult
##
## Query 6) 	Le 10 auto con maggior costo di manutenzione nel 2016
##
BiggestCost16Car <- paste("SELECT DISTINCT m.AutomezzoID,SUM(m.ImportoTotale) 
                                 FROM Manutenzione m
                                 WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                                 FROM Automezzo a 
                                 WHERE a.Rottamato = 0)
                                 AND  m.DataConsegna >  20160101 
                                 and m.DataConsegna < 20170000
                                 GROUP BY m.AutomezzoID
                                 ORDER BY SUM(m.ImportoTotale) DESC
                                 LIMIT(10)")
BiggestCost16CarResult<-tbl(my_db, sql(BiggestCost16Car))
BiggestCost16CarResult

##
##Query 7)	Le 10 auto con maggior quantità di carburante effettuato nel 2016
##
BiggestFuel16Car <- paste("SELECT DISTINCT r.AutomezzoID,SUM(r.Quantita) 
                                 FROM RifornimentoCarburante r
                          WHERE r.AutomezzoID IN (SELECT a.AutomezzoID 
                          FROM Automezzo a 
                          WHERE a.Rottamato = 0)
                          AND  r.Data >  20160101 
                          and r.Data < 20170000
                          GROUP BY r.AutomezzoID
                          ORDER BY SUM(r.Quantita) DESC
                          LIMIT(10)")
BiggestFuel16CarResult<-tbl(my_db, sql(BiggestFuel16Car))
BiggestFuel16CarResult
##
## Query 8)	Media del prezzo al litro delle 10 auto con quantità di carburante
#maggiore nel 2016
##
BiggestAVGFuel16Car <- paste("SELECT DISTINCT r.AutomezzoID,SUM(r.Quantita), AVG(PrezzoLitro)/10 
                                 FROM RifornimentoCarburante r
                          WHERE r.AutomezzoID IN (SELECT a.AutomezzoID 
                          FROM Automezzo a 
                          WHERE a.Rottamato = 0)
                          AND  r.Data >  20160101 
                          and r.Data < 20170000
                          GROUP BY r.AutomezzoID
                          ORDER BY SUM(r.Quantita) DESC
                          LIMIT(10)")
BiggestAVGFuel16CarResult<-tbl(my_db, sql(BiggestAVGFuel16Car))
BiggestAVGFuel16CarResult
##
## Query 9)	La media di tutti i chilometri effettuati dal parco auto delle 10 auto con media più alta
##
TotalAVG16Car <- paste("SELECT m.AutomezzoID, AVG(m.Chilometraggio)
                       FROM Missione m
                       WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                                               FROM Automezzo a 
                                               WHERE a.Rottamato = 0)
                       AND  m.DataInizioMissione >  20160101 
                       and m.DataInizioMissione < 20170000
                       and m.Chilometraggio > 0
                       and m.Durata > 1
                       and m.DataInizioMissione > 0
                       and m.NumeroPasseggeri > 0
                       GROUP BY m.AutomezzoID
                       ORDER BY AVG(m.Chilometraggio) DESC")
TotalAVG16CarResult<-tbl(my_db, sql(TotalAVG16Car))
TotalAVG16CarResult
##
## Query 10) Numero di auto attive nel 2016
##
NumberCar <- paste("SELECT  COUNT(a.AutomezzoID)
                   FROM Automezzo a
                   
                   WHERE a.Rottamato is NULL
                   or a.Rottamato = 0
                   or a.DataRottamazione is NULL
                   ")
NumberCarResult<-tbl(my_db, sql(NumberCar))
NumberCarResult
##
##Query 11) 	Numero auto divise per carburante
##
NumberOfTypeFuelCar <- paste("SELECT t.Descrizione, COUNT(a.AutomezzoID)
                             FROM Automezzo a
                             JOIN TipoCarburante t
                             ON t.TipoCarburanteID = a.TipoCarburanteID
                              WHERE a.Rottamato is NULL
                              or a.Rottamato = 0
                             GROUP BY t.Descrizione")
NumberOfTypeFuelCarResult<-tbl(my_db, sql(NumberOfTypeFuelCar))
NumberOfTypeFuelCarResult
##
## Query 12) Le 10 auto con il maggior numero di manutenzioni 
## eseguite nel 2016
##
MaxNumberOfMCar <- paste("SELECT DISTINCT m.AutomezzoID,COUNT(m.ManutenzioneID) 
                                 FROM Manutenzione m
                                 JOIN TipoManutenzione t
                                 ON t.TipoManutenzioneID = m.TipoManutenzioneID
                                  WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                                 FROM Automezzo a 
                                 WHERE a.Rottamato = 0)
                                 AND t.Descrizione LIKE '%Straordinaria%'
                                 AND  m.DataConsegna >  20160101 
                                 and m.DataConsegna < 20170000
                                 GROUP BY m.AutomezzoID
                                  ORDER BY COUNT(m.ManutenzioneID)  DESC
                                 LIMIT(10)")
MaxNumberOfMCarResult<-tbl(my_db, sql(MaxNumberOfMCar))
MaxNumberOfMCarResult
##
## Query 13) Passeggeri medi delle missioni del 2016 su tutto il parco auto.
##
AVGPerson16Car <- paste("SELECT  AVG(m.NumeroPasseggeri)
                       FROM Missione m
                       WHERE m.AutomezzoID IN (SELECT a.AutomezzoID 
                       FROM Automezzo a 
                       WHERE a.Rottamato = 0)
                       AND  m.DataInizioMissione >  20160101 
                       and m.DataInizioMissione < 20170000
                       and m.Chilometraggio > 0
                       and m.Durata > 1
                       and m.DataInizioMissione > 0
                       and m.NumeroPasseggeri > 0
                      
                       ORDER BY AVG(m.NumeroPasseggeri) DESC")
AVGPerson16CarResult<-tbl(my_db, sql(AVGPerson16Car))
AVGPerson16CarResult


