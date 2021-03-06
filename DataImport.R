library(data.table)
library(magrittr)
library(tidyr)
library(dplyr)

# read in data
HH_file<- file.path('Data/MiD2017_Haushalte.csv')
HH_dt <- fread(HH_file)
head(HH_dt)
HH_dt <- as.data.table(HH_dt)
str(HH_dt)

# Löschen von nicht benötigten Variablen 
HH_dt[, c("H_GEW","H_HOCH"):=NULL]
# Gründe für nicht Besitz, pkw segment, bundesland, andere variablen zu einkommen (71-77), pkw_jahresfl)
HH_dt <- HH_dt[, -c(62:66,86,87,90,91,71:73, 75:77, 88)]
HH_dt[, c("MODE","BASISAUF", "TEILSTP", "H_NEBEN_1","H_NEBEN_2","H_NEBEN_3","H_NEBEN_4","H_NEBEN_5", "H_NEBEN_6", "H_NEBEN_7","H_NEBEN_8", "anzneben", "nebenws", "H_NOCAR_A" ):=NULL]
HH_dt[, "hausnutz":=NULL]
HH_dt[, "wohnlage":=NULL]
HH_dt[, c("RegioStaR2","RegioStaR17"):=NULL]
HH_dt[, "H_MIETE":=NULL]
HH_dt[, "H_ART":=NULL]
# Geschlecht
HH_dt <- HH_dt[, -c(5:12)]

# Überprüfen Haushalts IDs mit PersonenIDs
# zu jedem Haushalt gibt es Personen
ids_HH <- HH_dt[, "H_ID"] # 156240
ids_P <- Person_dt[, "H_ID"]
unique_ids_P <- unique(ids_P) # 156240

# Wie viele Haushalte mit 1,2,3,4 autos gibt es: 
dplyr::count(HH_dt, anzauto_gr1)



#Korrelation: pkw_jahresfl_gr mit haushaltsgrösse?


Person_file <- file.path('Data/MiD2017_Personen.csv')
Person_dt <- fread(Person_file)
head(Person_dt)
typeof(Person_dt)


# HH - Fragebogen alle erklärt:
### h_id: einzigartige ID des haushalts
# m_car : modul fahrzeugmerkmale und besitz, 0 nicht erhalten, 1 erhalten
# h_gr: personen im haushalt: 1 bis 21
  # h_art : 1: 1 personen HH, 2 Mehrpersonen hh, 3 kein privat hh (wohnheim etc)
  # hhgr_gr:hhgr in gruppen: 1 - 4 personen, 5 personen und mehr
  # h_miete: 1 miete, 2 eigentum, 3 anderes, 9 keine angabe
  # hp_sex_1 - 8:geschlechter der personen 1 männlich , 2 weiblich, 9 keine angabe
  # hp_alter_ 1 - 8:wertebereich, 999 keine angabe, 3302-3308 person x nicht vorhanden
  # hp_taet_1 -8:
  # 302 - 308: person x im hh nicht enthalten
  # 1 - 15:
  # Vollzeit berufstätig
  # Teilzeit berufstatig, d.h. 18 bis unter 35 Stunden pro Woche geringfügig berufstätig, d.h. 11 bis unter 18 Stunden pro Woche berufstätig als Nebentätigkeit oder im Praktikum
  # berufstätig ohne Angabe zum Umfang
  # Kind wird zu Hause betreut
  # Kind wird betreut im Kindergarten, Krippe, Tagesmutter etc. Schüler(in) einschließlich Vorschule
  # Auszubildende(r)
  # Student(in)
  # Hausfrau/-mann
  # Rentner(in)/Pensionär(in)
  # zurzeit arbeitslos
  # andere Tätigkeit
  # nicht berufstätig ohne Details
  # 
  # h_anzauto: anzahl autos im haushalt : 0 bis 30, 99 keine angabe
 #  anzauto_gr1 - gr3: anzahl autos in gruppen:
 #    gr_1 : 4+, gr2 3+, gr3 2+,  
 #  0kein Auto 1 Auto
 #  2 Autos
 #  3 Autos
 #  4 Autos und mehr
 #  9 keine Angabe
 #  auto: auto im hh ja/nein 0 nein, 1 ja, 9 keine angabe
 #  h_anzmot: anzahl motorräder
 #  h_anzmop: mopeds
 #  h_anzmotmop: anz motorräder mopeds mofas
 #  ! anzmotmop_gr: anzahl noch gruppen 0 - 4 4 motorräder und mehr
 #  motmop:ja nein 0 nein, 1 ja 
 #  h_anzped:anzahl pedelecs
 #  anzped_gr: in gruppen 9 keine angabe
 #  h_anzrad:anzahl fahrrad
 #  anzrad_gr: in gruppen 1 bis 4
 #  anzpedrad:zusammen
 #  anzpedrad_gr:zusammen
 #  pedrad:ja nein 
 #  nocar: priorisierung gründe kein auto 
 #  hp_anzfs: anzalh pkw führerschein besitzer, 99 keine angabe, 94 unplausibel
 #  anzfs_gr: führerschein in gruppen , 3 = 3 FS und mehr usw.
 #  h_cs: carsharing mitgliedschaft im haushalt: 9 keine angabe, 3 nein, 2, ja mehrere, 1 eine
 #  -hheink_gr2: einkommen in gruppen 1-15(1) und 1-10(2)
 #  anzkind06: anzahl kinder unter 6
 #  anzkind14: unter 14
 #  anzkind18: unter 18
 #  anzerw14: anz erw ab 14
 #  anzerw18: anz erw ab 18
 # ? hhtyp: 
 #    1 bis 11: 
 #    1 personen hh : person 18-29:
 #    1 personen hh: person 30-59 Jahre 
 #  1-Personen-HH: Person 60 Jahre und alter 
 #  2-Personen-HH: jüngste Person 18-29 Jahre 
 #  2-Personen-HH: jüngste Person 30-59 Jahre 
 #  2-Personen-HH: jüngste Person 60 Jahre und älter
 #  HH mit mind. 3 Erwachsenen
 #  HH mit mind. einem Kind unter 6 Jahren 
 #  HH mit mind. einem Kind unter 14 Jahren 
 #  HH mit mind. einem Kind unter 18 Jahren 
 #  Alleinerziehende(r)
 #  95 nicht zuzuordnen

 #  ? hhtyp2: differenz nach alter, 1 jung unter 35, 2 familen, 3 hh it erwachsenen, 4 hh mit personen ab 65, 95 nicht zuzuordnen
 #  mobtyp: ausstatting mit mobilität
 #  pkw_jahresfl: summer der fahrleistung
 #  ! pkw_jahresfl_gr: fahrleistung in gruppen (bis so und so viel km)
 #  !GEMTYP: gemeindetyp
 #  SKTYP: siedlungstruktureller kreistyp
 #  POLGK: politische gemiendegrössenklasse (nacheinwohnern)
 #  RegioStaR17: regionalstatische raumtypen, je nach differenzierung
 #  RegioStaR7 
 #  RegioStaR4 
 #  RegioStaR2 
 #  RegioStaRGem7 regionalstatische gemeindetypen
 #  RegioStaRGem5 
 #  bus28: luftlinie zur nächsten bushaltestelle mit 28 abfahrten am werktag 
 #  tram28 : strassenbahn, u-bahn
 #  bahn28: bahnhof
 #  min_ozmz: fahrzeit pkw zum nächsten ober- oder mittel zentrum
 #  ! haustyp : gebäudetyp, einfamilienhaus, mehrfamilien, etc.
 #  hausnutz: gebäudenutzung
 #  garage: 0 nein, 1 ja 
 #  wohnlage : qualität der wohnlage, einfach bis sehr gut
 #  quali_nv: qualität der nahversorgung 
 #  quali_opnv: qualität des öpnv
  
  
# Personenfragebogen interessante: 

#Bildungsabschluss 
#Fahrkartenart! (in allen vorhanden?)
#Zufriedenheit ÖPNV
#Zufriedenheit Fahrrad
#Zufriedenheit Auto
#Zufriedenheit Fuß
#Einstellungen : fahre gerne auto, fahrrad, öpnv ...
#anzwege3_gr anzahl wege insgesamt
#anzkm: tagesstrecke
#anzkm_gr: 
#anzahl weiterer wege 
#multimodale personen (nutzung nicht nur besitz)





