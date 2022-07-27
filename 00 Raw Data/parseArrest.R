# Load libraries
library(tidyverse)
library(rJava)
library(tabulizer)
library(shiny)
library(miniUI)

# Set data directory
datadir <- "data/arrests0000001.pdf/"

# You're going to need to make sure you go to JUST the arrest .pdfs
# Get a list of them here
# For now, I will set some files manually
files <- dir(datadir)
samplearrests <- str_pad(c(1:4), width = 7, pad = "0")
mymonth <- "arrests"
arrestFiles <- paste0(datadir, mymonth, samplearrests, ".pdf")

datair <- "00 Raw Data/missing/"
files <- dir(datair)
mymonth <- "arrests"
samplearrests <- str_pad(c(1:1576), width = 7, pad = "0")
arrestFiles <- paste0(datair,mymonth,samplearrests,".pdf")

# Set up scraping areas. BELOW SECTION SAVES AREAS TABULIZER COLLECETS TO A VARIABLE.
# IF YOU HAVE arrestAreas.Rdata, you don't need to rerun these scripts because the values are stored in the rdata file

# agencynamearea <- locate_areas(arrestFiles[1])
# namearea <- locate_areas(arrestFiles[1])
# datetimearrestedarea <- locate_areas(arrestFiles[1])
# arrestnumberarea <- locate_areas(arrestFiles[1])
# DOBarea <- locate_areas(arrestFiles[1])
# Agearea <- locate_areas(arrestFiles[1])
# racearea <- locate_areas(arrestFiles[1])
# sexarea <- locate_areas(arrestFiles[1])
# citenzshiparea <- locate_areas(arrestFiles[1])
# casenumberarea <- locate_areas(arrestFiles[1])
# skingtonearea <- locate_areas(arrestFiles[1])
# heightarea <- locate_areas(arrestFiles[1])
# weightarea <- locate_areas(arrestFiles[1])
# haircolorarea <- locate_areas(arrestFiles[1])
# eyecolorarea <- locate_areas(arrestFiles[1])
# armedarea <- locate_areas(arrestFiles[1])
# typeofarrestarea <- locate_areas(arrestFiles[1])
# placeofarrestarea <- locate_areas(arrestFiles[1])
# charge1area <- locate_areas(arrestFiles[1])
# charge1typearea <- locate_areas(arrestFiles[1])
# charge1countsarea <- locate_areas(arrestFiles[1])
# charge1IBRcodearea <- locate_areas(arrestFiles[1])
# charge1statutenumberarea <- locate_areas(arrestFiles[1])
# charge1warrantdatearea <- locate_areas(arrestFiles[1])
# charge2area <- locate_areas(arrestFiles[1])
# charge2typearea <- locate_areas(arrestFiles[1])
# charge2countsarea <- locate_areas(arrestFiles[1])
# charge2IBRcodearea <- locate_areas(arrestFiles[1])
# charge2statutenumberarea <- locate_areas(arrestFiles[1])
# charge2warrantdatearea <- locate_areas(arrestFiles[1])
# charge3area <- locate_areas(arrestFiles[1])
# charge3typearea <- locate_areas(arrestFiles[1])
# charge3countsarea <- locate_areas(arrestFiles[1])
# charge3IBRcodearea <- locate_areas(arrestFiles[1])
# charge3statutenumberarea <- locate_areas(arrestFiles[1])
# charge3warrantdatearea <- locate_areas(arrestFiles[1])
# phonenumberarea <- locate_areas(arrestFiles[1])
# bondconfirmeddatearea <- locate_areas(arrestFiles[1])
# placeconfinedarea <- locate_areas(arrestFiles[1])
# bondtypearea <- locate_areas(arrestFiles[1])
# bondamountarea <- locate_areas(arrestFiles[1])
# trialdatetimearea <- locate_areas(arrestFiles[1])
# courtarea <- locate_areas(arrestFiles[1])
# arrestingofficerarea <- locate_areas(arrestFiles[1])
# releaseofficerarea <- locate_areas(arrestFiles[1])
# drugcode1area <- locate_areas(arrestFiles[1])
# drugstatus1area <- locate_areas(arrestFiles[1])
# drugquantity1area <- locate_areas(arrestFiles[1])
# drugtypemeasure1area <- locate_areas(arrestFiles[1])
# drugtype1area <- locate_areas(arrestFiles[1])
# drugactivity1area <- locate_areas(arrestFiles[1])
# drugcode2area <- locate_areas(arrestFiles[1])
# drugstatus2area <- locate_areas(arrestFiles[1])
# drugquantity2area <- locate_areas(arrestFiles[1])
# drugtypemeasure2area <- locate_areas(arrestFiles[1])
# drugtype2area <- locate_areas(arrestFiles[1])
# drugactivity2area <- locate_areas(arrestFiles[1])
# drugcode3area <- locate_areas(arrestFiles[1])
# drugstatus3area <- locate_areas(arrestFiles[1])
# drugquantity3area <- locate_areas(arrestFiles[1])
# drugtypemeasure3area <- locate_areas(arrestFiles[1])
# drugtype3area <- locate_areas(arrestFiles[1])
# drugactivity3area <- locate_areas(arrestFiles[1])
# drugcode4area <- locate_areas(arrestFiles[1])
# drugstatus4area <- locate_areas(arrestFiles[1])
# drugquantity4area <- locate_areas(arrestFiles[1])
# drugtypemeasure4area <- locate_areas(arrestFiles[1])
# drugtype4area <- locate_areas(arrestFiles[1])
# drugactivity4area <- locate_areas(arrestFiles[1])
# drugcode5area <- locate_areas(arrestFiles[1])
# drugstatus5area <- locate_areas(arrestFiles[1])
# drugquantity5area <- locate_areas(arrestFiles[1])
# drugtypemeasure5area <- locate_areas(arrestFiles[1])
# drugtype5area <- locate_areas(arrestFiles[1])
# drugactivity5area <- locate_areas(arrestFiles[1])
# drugcode6area <- locate_areas(arrestFiles[1])
# drugstatus6area <- locate_areas(arrestFiles[1])
# drugquantity6area <- locate_areas(arrestFiles[1])
# drugtypemeasure6area <- locate_areas(arrestFiles[1])
# drugtype6area <- locate_areas(arrestFiles[1])
# drugactivity6area <- locate_areas(arrestFiles[1])
# drugcode7area <- locate_areas(arrestFiles[1])
# drugstatus7area <- locate_areas(arrestFiles[1])
# drugquantity7area <- locate_areas(arrestFiles[1])
# drugtypemeasure7area <- locate_areas(arrestFiles[1])
# drugtype7area <- locate_areas(arrestFiles[1])
# drugactivity7area <- locate_areas(arrestFiles[1])
# drugcode8area <- locate_areas(arrestFiles[1])
# drugstatus8area <- locate_areas(arrestFiles[1])
# drugquantity8area <- locate_areas(arrestFiles[1])
# drugtypemeasure8area <- locate_areas(arrestFiles[1])
# drugtype8area <- locate_areas(arrestFiles[1])
# drugactivity8area <- locate_areas(arrestFiles[1])
# drugcode9area <- locate_areas(arrestFiles[1])
# drugstatus9area <- locate_areas(arrestFiles[1])
# drugquantity9area <- locate_areas(arrestFiles[1])
# drugtypemeasure9area <- locate_areas(arrestFiles[1])
# drugtype9area <- locate_areas(arrestFiles[1])
# drugactivity9area <- locate_areas(arrestFiles[1])
#scarsarea <- locate_areas(arrestFiles[1])

#narrativearea <- locate_areas(arrestFiles[1])

# Save areas collected above
save(agencynamearea, namearea, datetimearrestedarea, arrestnumberarea, DOBarea, 
     Agearea, racearea, sexarea, citenzshiparea, casenumberarea, heightarea, weightarea,  haircolorarea, 
     eyecolorarea, armedarea, typeofarrestarea, placeofarrestarea, charge1area, charge1typearea, charge1countsarea,
     charge1IBRcodearea, charge1statutenumberarea, charge1warrantdatearea, charge2area, charge2typearea, 
     charge2countsarea, charge2IBRcodearea, charge2statutenumberarea, charge2warrantdatearea, charge3area, 
     charge3typearea, charge3countsarea, charge3IBRcodearea, charge3statutenumberarea, charge3warrantdatearea, 
     skingtonearea, phonenumberarea, bondconfirmeddatearea, placeconfinedarea, bondtypearea, 
     bondamountarea, trialdatetimearea, courtarea, arrestingofficerarea, releaseofficerarea,
     drugcode1area,drugstatus1area,drugquantity1area,drugtypemeasure1area,drugtype1area,drugactivity1area,
     drugcode2area,drugstatus2area,drugquantity2area,drugtypemeasure2area,drugtype2area,drugactivity2area,
     drugcode3area,drugstatus3area,drugquantity3area,drugtypemeasure3area,drugtype3area,drugactivity3area,
     drugcode4area,drugstatus4area,drugquantity4area,drugtypemeasure4area,drugtype4area,drugactivity4area, 
     drugcode5area,drugstatus5area,drugquantity5area,drugtypemeasure5area,drugtype5area,drugactivity5area,
     drugcode6area,drugstatus6area,drugquantity6area,drugtypemeasure6area,drugtype6area,drugactivity6area,
     drugcode7area,drugstatus7area,drugquantity7area,drugtypemeasure7area,drugtype7area,drugactivity7area,
     drugcode8area,drugstatus8area,drugquantity8area,drugtypemeasure8area,drugtype8area,drugactivity8area,
     drugcode9area,drugstatus9area,drugquantity9area,drugtypemeasure9area,drugtype9area,drugactivity9area,
     scarsarea, 
     narrativearea,
     file = "00 Raw Data/arrestAreas.Rdata"
     )

# At this point, load the area coordinates
load("00 Raw Data/arrestAreas.Rdata")

# As a test, loop over files to parse agency name and aresstee name
extractData <- function(arrestFile) {
  agencyname <- extract_text(arrestFile, area = agencynamearea)
  name <- extract_text(arrestFile, area = namearea)
  datetimearrestedextract <- extract_text(arrestFile, area = datetimearrestedarea)
  arrestnumberextract <- extract_text(arrestFile, area = arrestnumberarea)
  dobextract <- extract_text(arrestFile, area = DOBarea)
  ageextract <- extract_text(arrestFile, area = Agearea)
  raceextract <- extract_text(arrestFile, area = racearea)
  sexextract <- extract_text(arrestFile, area = sexarea)
  citenzshipextract <- extract_text(arrestFile, area = citenzshiparea)
  casenumberextract <- extract_text(arrestFile, area = casenumberarea)
  skintoneextract <- extract_text(arrestFile, area = skingtonearea)  
  heightextract <- extract_text(arrestFile, area = heightarea)
  weightextract <- extract_text(arrestFile, area = weightarea)
  haircolorextract <- extract_text(arrestFile, area = haircolorarea)
  eyecolorextract <- extract_text(arrestFile, area = eyecolorarea)
  armedextract <- extract_text(arrestFile, area = armedarea)
  typeofarrestextract <- extract_text(arrestFile, area = typeofarrestarea)
  placeofarrestextract <- extract_text(arrestFile, area = placeofarrestarea)
  charge1extract <- extract_text(arrestFile, area = charge1area)
  charge1typeextract <- extract_text(arrestFile, area = charge1typearea)
  charge1countsextract <- extract_text(arrestFile, area = charge1countsarea)
  charge1IBRcodeextract <- extract_text(arrestFile, area = charge1IBRcodearea)
  charge1statutenumberextract <- extract_text(arrestFile, area = charge1statutenumberarea)
  charge1warrantdateextract <- extract_text(arrestFile, area = charge1warrantdatearea)
  charge2extract <- extract_text(arrestFile, area = charge2area)
  charge2typeextract <- extract_text(arrestFile, area = charge2typearea)
  charge2countsextract <- extract_text(arrestFile, area = charge2countsarea)
  charge2IBRcodeextract <- extract_text(arrestFile, area = charge2IBRcodearea)
  charge2statutenumberextract <- extract_text(arrestFile, area = charge2statutenumberarea)
  charge2warrantdateextract <- extract_text(arrestFile, area = charge2warrantdatearea)
  charge3extract <- extract_text(arrestFile, area = charge3area)
  charge3typeextract <- extract_text(arrestFile, area = charge3typearea)
  charge3countsextract <-extract_text(arrestFile, area = charge3countsarea)
  charge3IBRcodeextract <- extract_text(arrestFile, area = charge3IBRcodearea)
  charge3statutenumberextract <- extract_text(arrestFile, area = charge3statutenumberarea)
  charge3warrantdateextract <- extract_text(arrestFile, area = charge3warrantdatearea)
  phonenumberextract <- extract_text(arrestFile, area = phonenumberarea)
  bondconfirmeddateextract <- extract_text(arrestFile, area = bondconfirmeddatearea)
  placeconfinedextract <- extract_text(arrestFile, area = placeconfinedarea)
  bondtypeextract <- extract_text(arrestFile, area = bondtypearea)
  bondamountextract <- extract_text(arrestFile, area = bondamountarea)
  trialdatetimeextract <- extract_text(arrestFile, area = trialdatetimearea)
  courtextract <- extract_text(arrestFile, area = courtarea)
  arrestingofficerextract <- extract_text(arrestFile, area = arrestingofficerarea)
  releaseofficerextract <- extract_text(arrestFile, area = releaseofficerarea)
  drugcode1extract <- extract_text(arrestFile, area = drugcode1area)
  drugstatus1extract <- extract_text(arrestFile, area = drugstatus1area)
  drugquantity1extract <- extract_text(arrestFile, area = drugquantity1area)
  drugtypemeasure1extract <- extract_text(arrestFile, area = drugtypemeasure1area)
  drugtype1extract <- extract_text(arrestFile, area = drugtype1area)
  drugactivity1extract <- extract_text(arrestFile, area = drugactivity1area)
  drugcode2extract <- extract_text(arrestFile, area = drugcode2area)
  drugstatus2extract <- extract_text(arrestFile, area = drugstatus2area)
  drugquantity2extract <- extract_text(arrestFile, area = drugquantity2area)
  drugtypemeasure2extract <- extract_text(arrestFile, area = drugtypemeasure2area)
  drugtype2extract <- extract_text(arrestFile, area = drugtype2area)
  drugactivity2extract <- extract_text(arrestFile, area = drugactivity2area)
  drugcode3extract <- extract_text(arrestFile, area = drugcode3area)
  drugstatus3extract <- extract_text(arrestFile, area = drugstatus3area)
  drugquantity3extract <- extract_text(arrestFile, area = drugquantity3area)
  drugtypemeasure3extract <- extract_text(arrestFile, area = drugtypemeasure3area)
  drugtype3extract <- extract_text(arrestFile, area = drugtype3area)
  drugactivity3extract <- extract_text(arrestFile, area = drugactivity3area)
  drugcode4extract <- extract_text(arrestFile, area = drugcode4area)
  drugstatus4extract <- extract_text(arrestFile, area = drugstatus4area)
  drugquantity4extract <- extract_text(arrestFile, area = drugquantity4area)
  drugtypemeasure4extract <- extract_text(arrestFile, area = drugtypemeasure4area)
  drugtype4extract <- extract_text(arrestFile, area = drugtype4area)
  drugactivity4extract <- extract_text(arrestFile, area = drugactivity4area)
  drugcode5extract <- extract_text(arrestFile, area = drugcode5area)
  drugstatus5extract <- extract_text(arrestFile, area = drugstatus5area)
  drugquantity5extract <- extract_text(arrestFile, area = drugquantity5area)
  drugtypemeasure5extract <- extract_text(arrestFile, area = drugtypemeasure5area)
  drugtype5extract <- extract_text(arrestFile, area = drugtype5area)
  drugactivity5extract <- extract_text(arrestFile, area = drugactivity5area)
  drugcode6extract <- extract_text(arrestFile, area = drugcode6area)
  drugstatus6extract <- extract_text(arrestFile, area = drugstatus6area)
  drugquantity6extract <- extract_text(arrestFile, area = drugquantity6area)
  drugtypemeasure6extract <- extract_text(arrestFile, area = drugtypemeasure6area)
  drugtype6extract <- extract_text(arrestFile, area = drugtype6area)
  drugactivity6extract <- extract_text(arrestFile, area = drugactivity6area)
  drugcode7extract <- extract_text(arrestFile, area = drugcode7area)
  drugstatus7extract <- extract_text(arrestFile, area = drugstatus7area)
  drugquantity7extract <- extract_text(arrestFile, area = drugquantity7area)
  drugtypemeasure7extract <- extract_text(arrestFile, area = drugtypemeasure7area)
  drugtype7extract <- extract_text(arrestFile, area = drugtype7area)
  drugactivity7extract <- extract_text(arrestFile, area = drugactivity7area)
  drugcode8extract <- extract_text(arrestFile, area = drugcode8area)
  drugstatus8extract <- extract_text(arrestFile, area = drugstatus8area)
  drugquantity8extract <- extract_text(arrestFile, area = drugquantity8area)
  drugtypemeasure8extract <- extract_text(arrestFile, area = drugtypemeasure8area)
  drugtype8extract <- extract_text(arrestFile, area = drugtype8area)
  drugactivity8extract <- extract_text(arrestFile, area = drugactivity8area)
  drugcode9extract <- extract_text(arrestFile, area = drugcode9area)
  drugstatus9extract <- extract_text(arrestFile, area = drugstatus9area)
  drugquantity9extract <- extract_text(arrestFile, area = drugquantity9area)
  drugtypemeasure9extract <- extract_text(arrestFile, area = drugtypemeasure9area)
  drugtype9extract <- extract_text(arrestFile, area = drugtype9area)
  drugactivity9extract <- extract_text(arrestFile, area = drugactivity9area)
  scarsextract <- extract_text(arrestFile, area = scarsarea)
  narrativeextract <- extract_text(arrestFile, area = narrativearea)
#saves extracted text to a dataframe
  
  data.frame(agencyname = agencyname, name = name, datetimeofarrest = datetimearrestedextract, file = arrestFile,
             arrestnumber = arrestnumberextract, scars_tattoes_bodymarkings_etc = scarsextract, birthday = dobextract, age = ageextract, race = raceextract,
             sex = sexextract, citzenship = citenzshipextract, casenumber = casenumberextract, 
             skintone = skintoneextract, height = heightextract, weight = weightextract, 
             haircolor = haircolorextract, eyecolor = eyecolorextract, armed = armedextract, 
             typeofarrest = typeofarrestextract, placeofarrest = placeofarrestextract, charge1 = charge1extract,
             charge1type = charge1typeextract, charge1counts = charge1countsextract, 
             charge1IBRcode = charge1IBRcodeextract, charge1statutenumber = charge1statutenumberextract,
             charge1warrantdate = charge1warrantdateextract, charge2 = charge2extract,
             charge2type = charge2typeextract, charge2counts = charge2countsextract, 
             charge2IBRcode = charge2IBRcodeextract, charge2statutenumber = charge2statutenumberextract,
             charge2warrantdate = charge2warrantdateextract, charge3 = charge3extract,
             charge3type = charge3typeextract, charge3counts = charge3countsextract, 
             charge3IBRcode = charge3IBRcodeextract, charge3statutenumber = charge3statutenumberextract,
             charge3warrantdate = charge3warrantdateextract, phonenumber = phonenumberextract, 
             bonddateandtime = bondconfirmeddateextract, placeconfined = placeconfinedextract,
             bondtype = bondtypeextract, bondamount = bondamountextract, trialdate = trialdatetimeextract, 
             court = courtextract, arrestingofficer = arrestingofficerextract, 
             releaseofficer = releaseofficerextract,
             drugcode1 = drugcode1extract,drugstatus1 = drugstatus1extract,
             drugquantity1 = drugquantity1extract,drugtypemeasure1 = drugtypemeasure1extract,drugtype1 = drugtype1extract,
             drugactivity1 = drugactivity1extract,drugcode2 = drugcode2extract,drugstatus2 = drugstatus2extract,
             drugquantity2 = drugquantity2extract,drugtypemeasure2 = drugtypemeasure2extract,drugtype2 = drugtype2extract,
             drugactivity2 = drugactivity2extract,drugcode3 = drugcode3extract,drugstatus3 = drugstatus3extract,
             drugquantity3 = drugquantity3extract,drugtypemeasure3 = drugtypemeasure3extract,drugtype3 = drugtype3extract,
             drugactivity3 = drugactivity3extract,drugcode4 = drugcode4extract,drugstatus4 = drugstatus4extract,
             drugquantity4 = drugquantity4extract,drugtypemeasure4 = drugtypemeasure4extract,drugtype4 = drugtype4extract,
             drugactivity4 = drugactivity4extract,drugcode5 = drugcode5extract,drugstatus5 = drugstatus5extract,
             drugquantity5 = drugquantity5extract,drugtypemeasure5 = drugtypemeasure5extract,drugtype5 = drugtype5extract,
             drugactivity5 = drugactivity5extract,drugcode6 = drugcode6extract,drugstatus6 = drugstatus6extract,
             drugquantity6 = drugquantity6extract,drugtypemeasure6 = drugtypemeasure6extract,drugtype6 = drugtype6extract,
             drugactivity6 = drugactivity6extract,drugcode7 = drugcode7extract,drugstatus7 = drugstatus7extract,
             drugquantity7 = drugquantity7extract,drugtypemeasure7 = drugtypemeasure7extract,drugtype7 = drugtype7extract,
             drugactivity7 = drugactivity7extract,drugcode8 = drugcode8extract,drugstatus8 = drugstatus8extract,
             drugquantity8 = drugquantity8extract,drugtypemeasure8 = drugtypemeasure8extract,drugtype8 = drugtype8extract,
             drugactivity8 = drugactivity8extract,drugcode9 = drugcode9extract,drugstatus9 = drugstatus9extract,
             drugquantity9 = drugquantity9extract,drugtypemeasure9 = drugtypemeasure9extract,drugtype9 = drugtype9extract,
             drugactivity9 = drugactivity9extract, narrative = narrativeextract
             )
  
}
#applies the function to every file in the file naming convention from the files collected by selenium
data <- lapply(arrestFiles, extractData) %>%
  bind_rows()
#writes data to a csv file
write.csv(data, "missing_arrests.csv")
view(test)

