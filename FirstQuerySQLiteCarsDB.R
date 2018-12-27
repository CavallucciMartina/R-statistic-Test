Automezzo <- read_csv2("Automezzo.csv",col_types = list(
  AutomezzoID=col_integer(),
  DataDiAcquisto = col_date(),
  Chilometraggio = col_integer(),
  ModelloId = col_integer(), 
  MarcaId = col_integer(),
  Rottamato = col_integer(),
  DataRottamazione=col_date(), 
  TipoVeicolo= col_integer(),
  TipiCarburante_TipoCarburanteID= col_integer()))

Manutenzione <- read_csv2("CAR/Manutenzione.csv",
                          col_types = list(ManutenzioneID = col_integer(),
                                           TipoManutenzioneID = col_integer(),
                                           AutomezzoID = col_integer(),
                                           Descrizione = col_character(),
                                           ImportoTotale = col_double(),
                                           DataConsegna = col_date(),
                                           DataRitiro = col_date()))
RifornimentoCarburante <- read_csv2("CAR/RifornimentiCarburante.csv", col_types = list(
                                RifornimentoID = col_integer(),
                                Data = col_date(), 
                                Quantita = col_double(),
                                PrezzoLitro =col_double(),
                                Sconto = col_double(), 
                                TotaleImponibile = col_double(),
                                Iva = col_integer(),
                                Totale = col_double(),
                                Contachilometri = col_double(),
                                AutomezzoID = col_integer()))
TipoVeicolo <- read_csv2("CAR/TipoVeicolo.csv", col_types = list( TipoVeicoloID = col_integer(),
                                                              Descrizione = col_character()))

MarcaAuto <- read_csv2("CAR/MarcaAuto.csv", col_types = list ( MarcaID <- col_integer(), 
                                                            Descrizione <- col_character()))
Missione <- read_csv2("CAR/Missione.csv", col_types = list( MissioneID = col_integer(),
                                                        AutomezzoID= col_integer(),
                                                        Chilometraggio = col_double(),
                                                        NumeroPasseggeri= col_integer(),
                                                        DataTempoInizioMissione= col_datetime(format = ""),
                                                        DataTempoFineMissione = col_datetime(format = "")))
TipoCarburante <- read_csv2("CAR/TipoCarburante.csv", col_types = list(TipoCarburanteID = col_integer(),
                                                                   Descrizione = col_character(),
                                                                   Valore = col_integer()))
TipoManutenzione <- read_csv2("CAR/TipoManutenzione.csv", col_types = list(
                                                                           TipoManutenzioneID = col_integer(),
                                                                           
                                                                           Descrizione = col_character()
                                                                           ))
ModelloAuto <- read_csv2("CAR/ModelloAuto.csv", col_types = list( ModelloID = col_integer(),
                                                              Descrizione = col_character(),
                                                              ChilometriTagliando = col_double(),
                                                              ConsumoMedio = col_double()))


my_db_file <- "test-database.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
copy_to(my_db, Automezzo, temporary = FALSE)
 copy_to(my_db, Manutenzione, temporary = FALSE)
 copy_to(my_db, MarcaAuto, temporary = FALSE)
 copy_to(my_db, Missione, temporary = FALSE)
 copy_to(my_db, ModelloAuto, temporary = FALSE)
 copy_to(my_db, RifornimentoCarburante, temporary = FALSE)
 copy_to(my_db, TipoCarburante, temporary = FALSE)
 copy_to(my_db, TipoManutenzione, temporary = FALSE)
 copy_to(my_db, TipoVeicolo, temporary = FALSE)
 
 my_db
 Automezzo <-tbl(my_db, "Automezzo")
 Manutenzione <-tbl(my_db, "Manutenzione")
 Automezzo %>% filter(AutomezzoID == 3) %>% inner_join(Manutenzione) %>% collect()