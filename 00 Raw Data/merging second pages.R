#load libraries
library(tidyverse)
library(stringr)


#load in files you want to merge
first_pages <- read.csv("10 Clean Data/clean_missing_1stpages.csv")
second_pages <- read.csv("10 Clean Data/clean_missing_2ndpages.csv")

# filters out index column, which is different for every row so can't use distinct()
second <- second_pages %>%
  select(-"X") %>%
# turns arrest and case number into characters so they are same data type in first column as second and
  # they can be merged correctly
  mutate(arrestnumber  = as.character(arrestnumber), casenumber = as.character(casenumber)) %>%
  distinct()

view(second)

#filters out index and file columns to get distinct rows

first <- first_pages %>%
  select(-"X") %>%
  filter(agencyname == "Durham Police Department") %>%
  distinct(agencyname,name,datetimeofarrest,arrestnumber,scars_tattoes_bodymarkings_etc,birthday,age,
           race,sex,citzenship,casenumber,skintone,height,weight,haircolor,eyecolor,armed,typeofarrest,
           placeofarrest,charge1,charge1type,charge1counts,charge1IBRcode,charge1statutenumber,
           charge1warrantdate,charge2,charge2type,charge2counts,charge2IBRcode,charge2statutenumber,
           charge2warrantdate,charge3,charge3type,charge3counts, charge3IBRcode,charge3statutenumber,
           charge3warrantdate,phonenumber,bonddateandtime,placeconfined,bondtype,bondamount,trialdate,court,
           arrestingofficer,releaseofficer,drugcode1,drugstatus1,drugquantity1,drugtypemeasure1,drugtype1,
           drugactivity1,drugcode2,drugstatus2,drugquantity2,drugtypemeasure2,drugtype2,drugactivity2,drugcode3,
           drugstatus3,drugquantity3,drugtypemeasure3,drugtype3,drugactivity3,drugcode4,drugstatus4,drugquantity4,
           drugtypemeasure4,drugtype4,drugactivity4,drugcode5,drugstatus5,drugquantity5,drugtypemeasure5,
           drugtype5,drugactivity5,drugcode6,drugstatus6,drugquantity6,drugtypemeasure6,drugtype6,drugactivity6,
           drugcode7,drugstatus7,drugquantity7,drugtypemeasure7,drugtype7,drugactivity7,drugcode8,drugstatus8,
           drugquantity8,drugtypemeasure8,drugtype8,drugactivity8,drugcode9,drugstatus9,drugquantity9,
           drugtypemeasure9,drugtype9,drugactivity9,narrative, .keep_all = TRUE)

view(first)
view(first_pages)

#joins data frames
full <- full_join(first, second, by = c("casenumber" = "casenumber", "arrestnumber" = "arrestnumber", "name" = "name")) %>%
  distinct()  #%>%
  #select(name, casenumber, arrestnumber, charge25)
view(full)

# Write merged file to a CSV

finalreal <- test <- write.csv(full, "00 Raw Data/merged_missing_arrests_table_new.csv")
