library(tidyverse)
library(broom)
library(tidyverse)
library(tidymodels)
library(knitr)

#readingin both necesssary csv files
chargesreal <- read.csv("10 Clean Data/CHARGES.csv") %>%
  select(-"X")
finaldata <- read.csv("10 Clean Data/!FINAL RAW DATA.csv") %>%
  select(-"X", -"X.1")
withbeats <- read.csv("10 Clean Data/with_beats.csv")
  
  
#looking at datasets
view(chargesreal)
view(finaldata)
view(withbeats)

#merging charge data with demographic data to use for regression
all_charges <- chargesreal %>%
  left_join(withbeats, by = "arrestnumber") %>%
  distinct(arrestnumber,page_num,charges,charge_type,charge_counts,
           charge_IBRcode,charge_statutenumber,charge_warrantdate,chargenum, .keep_all = TRUE) %>%
  select(arrestnumber,page_num,charges,charge_type,charge_counts,
         charge_IBRcode,charge_statutenumber,charge_warrantdate,chargenum,agencyname,names,datetimeofarrest,
         file,scars_tattoes_bodymarkings_etc,age,
         race,sex,citizenship,casenumbers,
         skintone,height,weight,haircolor,
         eyecolor,armed,typeofarrest,placeofarrest,dates,time,
         year,month,day,bonddateandtime,
         placeconfined,bondtype,bondamount,trialdate,
         court,arrestingofficer,releaseofficer,LAWDIST,LAWBEAT, narrative
         )
#view(all_charges)

#mutating dataframe to add new columns of categorical variables
all_charges <- all_charges %>%
  mutate(typeofficial = ifelse(charge_type == "Misd", 0, 1)) %>%
  mutate(agecategory = case_when(age <= 25 ~ "Teen", age > 25 & age <= 50 ~ "adult", age > 50 ~ "elderly")) %>%
  mutate(gun = ifelse(armed == "UNARMED", 0, 1)) %>%
  mutate(POC = ifelse(race == "W", 0, 1)) %>%
  mutate(chargesevereity = case_when(charge_IBRcode == "90A" | charge_IBRcode == "90B" | charge_IBRcode == "90C" |
                                    charge_IBRcode == "90D" | charge_IBRcode == "90E" | charge_IBRcode == "90F"
                                    | charge_IBRcode == "90G" | charge_IBRcode == "90H" | charge_IBRcode == "90I"
                                    | charge_IBRcode == "90J" | charge_IBRcode == "90Z" ~ "B",
                                    charge_IBRcode == "200" | charge_IBRcode == "13A" | charge_IBRcode == "09A"
                                    | charge_IBRcode == "09B" | charge_IBRcode == "09C" | charge_IBRcode == "100"
                                    | charge_IBRcode == "11A" | charge_IBRcode == "11B" | charge_IBRcode == "11C"
                                    | charge_IBRcode == "11D"  ~ "A: Violent", TRUE ~ "A: Non-Violent" )) %>%
  mutate(dates  = as.Date(dates, format = "%Y-%m-%d")) %>%
  mutate(beatnumber = as.character(LAWBEAT))


# Exploratory Data Analysis for regressions
all_charges %>%
  group_by(charge_IBRcode) %>%
  count(typeofficial)

severity_test <- all_charges %>%
  filter(chargesevereity == "B") %>%
  group_by(charge_IBRcode) %>%
  count(typeofficial)
view(severity_test)

  
#creating datasets of pre and post George Floyd's death
all_charges_PreGF <- all_charges %>%
  filter(dates <= "2020-06-01")

all_charges_PostGF <- all_charges %>%
  filter(dates > "2020-06-01")

#fitting logistic regression with the type of charge as dependent variable

many_IV <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ POC + chargesevereity + gun + beatnumber, data = all_charges, family = "binomial")

many_IV_model <- many_IV %>%
  tidy()
view(many_IV_model)

# anova test on fit_1

m1<-glm(as.factor(typeofficial)~POC + chargesevereity + gun + beatnumber + sex, family=binomial(link='logit'), data=all_charges)
m2 <- glm(as.factor(typeofficial)~POC + chargesevereity + beatnumber, family=binomial(link='logit'), data=all_charges)
anova(m2, m1)
1 - pchisq(132.9, 2)

#second logistic regression with fewer IV's and test pre George Floyd death
Pre_GF <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ POC + chargesevereity + gun + beatnumber, data = all_charges_PreGF, family = "binomial")

Pre_GF_model <- Pre_GF %>%
  tidy()
view(Pre_GF_model)

#third logistic regression
post_GF <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ POC + chargesevereity + gun + beatnumber, data = all_charges_PostGF, family = "binomial")

post_GF_model <- post_GF %>%
  tidy()
view(post_GF_model)

#getting total number of arrests pre and post George Floyd's death
totalpost <- all_charges_PostGF %>% 
  nrow()

totalpre <- all_charges_PostGF %>% 
  nrow()

#getting total number of POC arrests pre and post George Floyd's death
numpost <- all_charges_PostGF %>% 
  filter(race != "W") %>% 
  nrow()

numpre <- all_charges_PreGF %>% 
  filter(race != "W") %>% 
  nrow()

#significance test on two proportions to see if percent of POC arrests
# are the same both pre and post George Floyd's death
res <- prop.test(x = c(numpre, numpost), n = c(totalpre, totalpost))
res 

# some random tests for now with 1 beat to see how it differs from whole county
beat112 <- all_charges %>%
  filter(beatnumber == "112")
beat112_reg <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ POC + chargesevereity + gun, data = beat112, family = "binomial")

beat112_model <- beat112_reg %>%
  tidy()
view(beat112_model)

# model with only white people measuring the other IVs
white_only <- all_charges %>%
  filter(POC == 0)
white_only_reg <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ chargesevereity + gun + beatnumber, data = white_only, family = "binomial")

white_only_model <- white_only_reg %>%
  tidy()
view(white_only_model)
# model with POC only to compare to white only
POC_only <- all_charges %>%
  filter(POC == 1)
POC_only_reg <- logistic_reg() %>%
  set_engine("glm") %>%
  fit(as.factor(typeofficial) ~ chargesevereity + gun + beatnumber, data = POC_only, family = "binomial")

POC_only_model <- POC_only_reg %>%
  tidy()
view(POC_only_model)

