# load libraries
library(tidyverse)
library(rJava)
library(tabulizer)
library(shiny)
library(miniUI)

# load the original raw data 
rawdata <- read.csv("missing_arrests.csv.csv")

# create new data frame with just the files with second pages
secondpages <- rawdata %>%
  filter(agencyname == "Name\n") %>%
  select(file) %>%
  distinct()
view(secondpages)

#create vector of file paths
datair <- "00 Raw Data/"
vector_of_files <- c()
for (i in 1:nrow(secondpages)) {
  value <-secondpages[i, 1]
  vector_of_files <- append(vector_of_files, value)
}
vector_of_files

small_vector_of_files <- vector_of_files[1:200]
# get areas
#BELOW ARE SCRIPTS TO GET THE AREAS. THEY'RE COMMENTED OUT SO I DON'T RERUN THEM.
#If you have the arrest2ndpageAreas.Rdata file you don't need to run the commented code

# arrestnumberarea <- locate_areas(vector_of_files[195])
# arrestnumberarea[[1]] <- NULL
# arrestnumberarea[[2]] <- NULL
# arrestnumberarea[[2]] <- NULL
# namearea <- locate_areas(vector_of_files[195])
# namearea[[1]] <- NULL
# namearea[[2]] <- NULL
# namearea[[2]] <- NULL
# casenumberarea <- locate_areas(vector_of_files[195])
# casenumberarea[[1]] <- NULL
# casenumberarea [[2]] <- NULL
# casenumberarea [[2]] <- NULL

# charge4area <- locate_areas(vector_of_files[765])
# charge4area[[1]] <- NULL
# charge4area[[2]] <- NULL
# charge4typearea <- locate_areas(vector_of_files[765])
# charge4typearea[[1]] <- NULL
# charge4typearea[[2]] <- NULL
# charge4countsarea <- locate_areas(vector_of_files[765])
# charge4countsarea[[1]] <- NULL
# charge4countsarea[[2]] <- NULL
# charge4IBRcodearea <- locate_areas(vector_of_files[765])
# charge4IBRcodearea[[1]] <- NULL
# charge4IBRcodearea[[2]] <- NULL
# charge4statutenumberarea <- locate_areas(vector_of_files[765])
# charge4statutenumberarea[[1]] <- NULL
# charge4statutenumberarea[[2]] <- NULL
# charge4warrantdatearea <- locate_areas(vector_of_files[765])
# charge4warrantdatearea[[1]] <- NULL
# charge4warrantdatearea[[2]] <- NULL
# 
# charge5area <- locate_areas(vector_of_files[765])
# charge5area[[1]] <- NULL
# charge5area[[2]] <- NULL
# charge5typearea <- locate_areas(vector_of_files[765])
# charge5typearea[[1]] <- NULL
# charge5typearea[[2]] <- NULL
# charge5countsarea <- locate_areas(vector_of_files[765])
# charge5countsarea[[1]] <- NULL
# charge5countsarea[[2]] <- NULL
# charge5IBRcodearea <- locate_areas(vector_of_files[765])
# charge5IBRcodearea[[1]] <- NULL
# charge5IBRcodearea[[2]] <- NULL
# charge5statutenumberarea <- locate_areas(vector_of_files[765])
# charge5statutenumberarea[[1]] <- NULL
# charge5statutenumberarea[[2]] <- NULL
# charge5warrantdatearea <- locate_areas(vector_of_files[765])
# charge5warrantdatearea[[1]] <- NULL
# charge5warrantdatearea[[2]] <- NULL
# 
# charge6area <- locate_areas(vector_of_files[765])
# charge6area[[1]] <- NULL
# charge6area[[2]] <- NULL
# charge6typearea <- locate_areas(vector_of_files[765])
# charge6typearea[[1]] <- NULL
# charge6typearea[[2]] <- NULL
# charge6countsarea <- locate_areas(vector_of_files[765])
# charge6countsarea[[1]] <- NULL
# charge6countsarea[[2]] <- NULL
# charge6IBRcodearea <- locate_areas(vector_of_files[765])
# charge6IBRcodearea[[1]] <- NULL
# charge6IBRcodearea[[2]] <- NULL
# charge6statutenumberarea <- locate_areas(vector_of_files[765])
# charge6statutenumberarea[[1]] <- NULL
# charge6statutenumberarea[[2]] <- NULL
# charge6warrantdatearea <- locate_areas(vector_of_files[765])
# charge6warrantdatearea[[1]] <- NULL
# charge6warrantdatearea[[2]] <- NULL
# 
# charge7area <- locate_areas(vector_of_files[765])
# charge7area[[1]] <- NULL
# charge7area[[2]] <- NULL
# charge7typearea <- locate_areas(vector_of_files[765])
# charge7typearea[[1]] <- NULL
# charge7typearea[[2]] <- NULL
# charge7countsarea <- locate_areas(vector_of_files[765])
# charge7countsarea[[1]] <- NULL
# charge7countsarea[[2]] <- NULL
# charge7IBRcodearea <- locate_areas(vector_of_files[765])
# charge7IBRcodearea[[1]] <- NULL
# charge7IBRcodearea[[2]] <- NULL
# charge7statutenumberarea <- locate_areas(vector_of_files[765])
# charge7statutenumberarea[[1]] <- NULL
# charge7statutenumberarea[[2]] <- NULL
# charge7warrantdatearea <- locate_areas(vector_of_files[765])
# charge7warrantdatearea[[1]] <- NULL
# charge7warrantdatearea[[2]] <- NULL
# 
# charge8area <- locate_areas(vector_of_files[765])
# charge8area[[1]] <- NULL
# charge8area[[2]] <- NULL
# charge8typearea <- locate_areas(vector_of_files[765])
# charge8typearea[[1]] <- NULL
# charge8typearea[[2]] <- NULL
# charge8countsarea <- locate_areas(vector_of_files[765])
# charge8countsarea[[1]] <- NULL
# charge8countsarea[[2]] <- NULL
# charge8IBRcodearea <- locate_areas(vector_of_files[765])
# charge8IBRcodearea[[1]] <- NULL
# charge8IBRcodearea[[2]] <- NULL
# charge8statutenumberarea <- locate_areas(vector_of_files[765])
# charge8statutenumberarea[[1]] <- NULL
# charge8statutenumberarea[[2]] <- NULL
# charge8warrantdatearea <- locate_areas(vector_of_files[765])
# charge8warrantdatearea[[1]] <- NULL
# charge8warrantdatearea[[2]] <- NULL
# 
# charge9area <- locate_areas(vector_of_files[765])
# charge9area[[1]] <- NULL
# charge9area[[2]] <- NULL
# charge9typearea <- locate_areas(vector_of_files[765])
# charge9typearea[[1]] <- NULL
# charge9typearea[[2]] <- NULL
# charge9countsarea <- locate_areas(vector_of_files[765])
# charge9countsarea[[1]] <- NULL
# charge9countsarea[[2]] <- NULL
# charge9IBRcodearea <- locate_areas(vector_of_files[765])
# charge9IBRcodearea[[1]] <- NULL
# charge9IBRcodearea[[2]] <- NULL
# charge9statutenumberarea <- locate_areas(vector_of_files[765])
# charge9statutenumberarea[[1]] <- NULL
# charge9statutenumberarea[[2]] <- NULL
# charge9warrantdatearea <- locate_areas(vector_of_files[765])
# charge9warrantdatearea[[1]] <- NULL
# charge9warrantdatearea[[2]] <- NULL
# 
# charge10area <- locate_areas(vector_of_files[765])
# charge10area[[1]] <- NULL
# charge10area[[2]] <- NULL
# charge10typearea <- locate_areas(vector_of_files[765])
# charge10typearea[[1]] <- NULL
# charge10typearea[[2]] <- NULL
# charge10countsarea <- locate_areas(vector_of_files[765])
# charge10countsarea[[1]] <- NULL
# charge10countsarea[[2]] <- NULL
# charge10IBRcodearea <- locate_areas(vector_of_files[765])
# charge10IBRcodearea[[1]] <- NULL
# charge10IBRcodearea[[2]] <- NULL
# charge10statutenumberarea <- locate_areas(vector_of_files[765])
# charge10statutenumberarea[[1]] <- NULL
# charge10statutenumberarea[[2]] <- NULL
# charge10warrantdatearea <- locate_areas(vector_of_files[765])
# charge10warrantdatearea[[1]] <- NULL
# charge10warrantdatearea[[2]] <- NULL
# 
# charge11area <- locate_areas(vector_of_files[765])
# charge11area[[1]] <- NULL
# charge11area[[2]] <- NULL
# charge11typearea <- locate_areas(vector_of_files[765])
# charge11typearea[[1]] <- NULL
# charge11typearea[[2]] <- NULL
# charge11countsarea <- locate_areas(vector_of_files[765])
# charge11countsarea[[1]] <- NULL
# charge11countsarea[[2]] <- NULL
# charge11IBRcodearea <- locate_areas(vector_of_files[765])
# charge11IBRcodearea[[1]] <- NULL
# charge11IBRcodearea[[2]] <- NULL
# charge11statutenumberarea <- locate_areas(vector_of_files[765])
# charge11statutenumberarea[[1]] <- NULL
# charge11statutenumberarea[[2]] <- NULL
# charge11warrantdatearea <- locate_areas(vector_of_files[765])
# charge11warrantdatearea[[1]] <- NULL
# charge11warrantdatearea[[2]] <- NULL
# 
# charge12area <- locate_areas(vector_of_files[765])
# charge12area[[1]] <- NULL
# charge12area[[2]] <- NULL
# charge12typearea <- locate_areas(vector_of_files[765])
# charge12typearea[[1]] <- NULL
# charge12typearea[[2]] <- NULL
# charge12countsarea <- locate_areas(vector_of_files[765])
# charge12countsarea[[1]] <- NULL
# charge12countsarea[[2]] <- NULL
# charge12IBRcodearea <- locate_areas(vector_of_files[765])
# charge12IBRcodearea[[1]] <- NULL
# charge12IBRcodearea[[2]] <- NULL
# charge12statutenumberarea <- locate_areas(vector_of_files[765])
# charge12statutenumberarea[[1]] <- NULL
# charge12statutenumberarea[[2]] <- NULL
# charge12warrantdatearea <- locate_areas(vector_of_files[765])
# charge12warrantdatearea[[1]] <- NULL
# charge12warrantdatearea[[2]] <- NULL
# 
# charge13area <- locate_areas(vector_of_files[765])
# charge13area[[1]] <- NULL
# charge13area[[2]] <- NULL
# charge13typearea <- locate_areas(vector_of_files[765])
# charge13typearea[[1]] <- NULL
# charge13typearea[[2]] <- NULL
# charge13countsarea <- locate_areas(vector_of_files[765])
# charge13countsarea[[1]] <- NULL
# charge13countsarea[[2]] <- NULL
# charge13IBRcodearea <- locate_areas(vector_of_files[765])
# charge13IBRcodearea[[1]] <- NULL
# charge13IBRcodearea[[2]] <- NULL
# charge13statutenumberarea <- locate_areas(vector_of_files[765])
# charge13statutenumberarea[[1]] <- NULL
# charge13statutenumberarea[[2]] <- NULL
# charge13warrantdatearea <- locate_areas(vector_of_files[765])
# charge13warrantdatearea[[1]] <- NULL
# charge13warrantdatearea[[2]] <- NULL
# 
# charge14area <- locate_areas(vector_of_files[765])
# charge14area[[1]] <- NULL
# charge14area[[2]] <- NULL
# charge14typearea <- locate_areas(vector_of_files[765])
# charge14typearea[[1]] <- NULL
# charge14typearea[[2]] <- NULL
# charge14countsarea <- locate_areas(vector_of_files[765])
# charge14countsarea[[1]] <- NULL
# charge14countsarea[[2]] <- NULL
# charge14IBRcodearea <- locate_areas(vector_of_files[765])
# charge14IBRcodearea[[1]] <- NULL
# charge14IBRcodearea[[2]] <- NULL
# charge14statutenumberarea <- locate_areas(vector_of_files[765])
# charge14statutenumberarea[[1]] <- NULL
# charge14statutenumberarea[[2]] <- NULL
# charge14warrantdatearea <- locate_areas(vector_of_files[765])
# charge14warrantdatearea[[1]] <- NULL
# charge14warrantdatearea[[2]] <- NULL
# 
# charge15area <- locate_areas(vector_of_files[765])
# charge15area[[1]] <- NULL
# charge15area[[2]] <- NULL
# charge15typearea <- locate_areas(vector_of_files[765])
# charge15typearea[[1]] <- NULL
# charge15typearea[[2]] <- NULL
# charge15countsarea <- locate_areas(vector_of_files[765])
# charge15countsarea[[1]] <- NULL
# charge15countsarea[[2]] <- NULL
# charge15IBRcodearea <- locate_areas(vector_of_files[765])
# charge15IBRcodearea[[1]] <- NULL
# charge15IBRcodearea[[2]] <- NULL
# charge15statutenumberarea <- locate_areas(vector_of_files[765])
# charge15statutenumberarea[[1]] <- NULL
# charge15statutenumberarea[[2]] <- NULL
# charge15warrantdatearea <- locate_areas(vector_of_files[765])
# charge15warrantdatearea[[1]] <- NULL
# charge15warrantdatearea[[2]] <- NULL
# 
# charge16area <- locate_areas(vector_of_files[765])
# charge16area[[1]] <- NULL
# charge16area[[2]] <- NULL
# charge16typearea <- locate_areas(vector_of_files[765])
# charge16typearea[[1]] <- NULL
# charge16typearea[[2]] <- NULL
# charge16countsarea <- locate_areas(vector_of_files[765])
# charge16countsarea[[1]] <- NULL
# charge16countsarea[[2]] <- NULL
# charge16IBRcodearea <- locate_areas(vector_of_files[765])
# charge16IBRcodearea[[1]] <- NULL
# charge16IBRcodearea[[2]] <- NULL
# charge16statutenumberarea <- locate_areas(vector_of_files[765])
# charge16statutenumberarea[[1]] <- NULL
# charge16statutenumberarea[[2]] <- NULL
# charge16warrantdatearea <- locate_areas(vector_of_files[765])
# charge16warrantdatearea[[1]] <- NULL
# charge16warrantdatearea[[2]] <- NULL
# 
# charge17area <- locate_areas(vector_of_files[765])
# charge17area[[1]] <- NULL
# charge17area[[2]] <- NULL
# charge17typearea <- locate_areas(vector_of_files[765])
# charge17typearea[[1]] <- NULL
# charge17typearea[[2]] <- NULL
# charge17countsarea <- locate_areas(vector_of_files[765])
# charge17countsarea[[1]] <- NULL
# charge17countsarea[[2]] <- NULL
# charge17IBRcodearea <- locate_areas(vector_of_files[765])
# charge17IBRcodearea[[1]] <- NULL
# charge17IBRcodearea[[2]] <- NULL
# charge17statutenumberarea <- locate_areas(vector_of_files[765])
# charge17statutenumberarea[[1]] <- NULL
# charge17statutenumberarea[[2]] <- NULL
# charge17warrantdatearea <- locate_areas(vector_of_files[765])
# charge17warrantdatearea[[1]] <- NULL
# charge17warrantdatearea[[2]] <- NULL
# 
# charge18area <- locate_areas(vector_of_files[765])
# charge18area[[1]] <- NULL
# charge18area[[2]] <- NULL
# charge18typearea <- locate_areas(vector_of_files[765])
# charge18typearea[[1]] <- NULL
# charge18typearea[[2]] <- NULL
# charge18countsarea <- locate_areas(vector_of_files[765])
# charge18countsarea[[1]] <- NULL
# charge18countsarea[[2]] <- NULL
# charge18IBRcodearea <- locate_areas(vector_of_files[765])
# charge18IBRcodearea[[1]] <- NULL
# charge18IBRcodearea[[2]] <- NULL
# charge18statutenumberarea <- locate_areas(vector_of_files[765])
# charge18statutenumberarea[[1]] <- NULL
# charge18statutenumberarea[[2]] <- NULL
# charge18warrantdatearea <- locate_areas(vector_of_files[765])
# charge18warrantdatearea[[1]] <- NULL
# charge18warrantdatearea[[2]] <- NULL
# 
# charge19area <- locate_areas(vector_of_files[765])
# charge19area[[1]] <- NULL
# charge19area[[2]] <- NULL
# charge19typearea <- locate_areas(vector_of_files[765])
# charge19typearea[[1]] <- NULL
# charge19typearea[[2]] <- NULL
# charge19countsarea <- locate_areas(vector_of_files[765])
# charge19countsarea[[1]] <- NULL
# charge19countsarea[[2]] <- NULL
# charge19IBRcodearea <- locate_areas(vector_of_files[765])
# charge19IBRcodearea[[1]] <- NULL
# charge19IBRcodearea[[2]] <- NULL
# charge19statutenumberarea <- locate_areas(vector_of_files[765])
# charge19statutenumberarea[[1]] <- NULL
# charge19statutenumberarea[[2]] <- NULL
# charge19warrantdatearea <- locate_areas(vector_of_files[765])
# charge19warrantdatearea[[1]] <- NULL
# charge19warrantdatearea[[2]] <- NULL
# 
# charge20area <- locate_areas(vector_of_files[765])
# charge20area[[1]] <- NULL
# charge20area[[2]] <- NULL
# charge20typearea <- locate_areas(vector_of_files[765])
# charge20typearea[[1]] <- NULL
# charge20typearea[[2]] <- NULL
# charge20countsarea <- locate_areas(vector_of_files[765])
# charge20countsarea[[1]] <- NULL
# charge20countsarea[[2]] <- NULL
# charge20IBRcodearea <- locate_areas(vector_of_files[765])
# charge20IBRcodearea[[1]] <- NULL
# charge20IBRcodearea[[2]] <- NULL
# charge20statutenumberarea <- locate_areas(vector_of_files[765])
# charge20statutenumberarea[[1]] <- NULL
# charge20statutenumberarea[[2]] <- NULL
# charge20warrantdatearea <- locate_areas(vector_of_files[765])
# charge20warrantdatearea[[1]] <- NULL
# charge20warrantdatearea[[2]] <- NULL
# 
# charge21area <- locate_areas(vector_of_files[765])
# charge21area[[1]] <- NULL
# charge21area[[2]] <- NULL
# charge21typearea <- locate_areas(vector_of_files[765])
# charge21typearea[[1]] <- NULL
# charge21typearea[[2]] <- NULL
# charge21countsarea <- locate_areas(vector_of_files[765])
# charge21countsarea[[1]] <- NULL
# charge21countsarea[[2]] <- NULL
# charge21IBRcodearea <- locate_areas(vector_of_files[765])
# charge21IBRcodearea[[1]] <- NULL
# charge21IBRcodearea[[2]] <- NULL
# charge21statutenumberarea <- locate_areas(vector_of_files[765])
# charge21statutenumberarea[[1]] <- NULL
# charge21statutenumberarea[[2]] <- NULL
# charge21warrantdatearea <- locate_areas(vector_of_files[765])
# charge21warrantdatearea[[1]] <- NULL
# charge21warrantdatearea[[2]] <- NULL
# 
# charge22area <- locate_areas(vector_of_files[765])
# charge22area[[1]] <- NULL
# charge22area[[2]] <- NULL
# charge22typearea <- locate_areas(vector_of_files[765])
# charge22typearea[[1]] <- NULL
# charge22typearea[[2]] <- NULL
# charge22countsarea <- locate_areas(vector_of_files[765])
# charge22countsarea[[1]] <- NULL
# charge22countsarea[[2]] <- NULL
# charge22IBRcodearea <- locate_areas(vector_of_files[765])
# charge22IBRcodearea[[1]] <- NULL
# charge22IBRcodearea[[2]] <- NULL
# charge22statutenumberarea <- locate_areas(vector_of_files[765])
# charge22statutenumberarea[[1]] <- NULL
# charge22statutenumberarea[[2]] <- NULL
# charge22warrantdatearea <- locate_areas(vector_of_files[765])
# charge22warrantdatearea[[1]] <- NULL
# charge22warrantdatearea[[2]] <- NULL
# 
# charge23area <- locate_areas(vector_of_files[765])
# charge23area[[1]] <- NULL
# charge23area[[2]] <- NULL
# charge23typearea <- locate_areas(vector_of_files[765])
# charge23typearea[[1]] <- NULL
# charge23typearea[[2]] <- NULL
# charge23countsarea <- locate_areas(vector_of_files[765])
# charge23countsarea[[1]] <- NULL
# charge23countsarea[[2]] <- NULL
# charge23IBRcodearea <- locate_areas(vector_of_files[765])
# charge23IBRcodearea[[1]] <- NULL
# charge23IBRcodearea[[2]] <- NULL
# charge23statutenumberarea <- locate_areas(vector_of_files[765])
# charge23statutenumberarea[[1]] <- NULL
# charge23statutenumberarea[[2]] <- NULL
# charge23warrantdatearea <- locate_areas(vector_of_files[765])
# charge23warrantdatearea[[1]] <- NULL
# charge23warrantdatearea[[2]] <- NULL
# 
# charge24area <- locate_areas(vector_of_files[765])
# charge24area[[1]] <- NULL
# charge24area[[2]] <- NULL
# charge24typearea <- locate_areas(vector_of_files[765])
# charge24typearea[[1]] <- NULL
# charge24typearea[[2]] <- NULL
# charge24countsarea <- locate_areas(vector_of_files[765])
# charge24countsarea[[1]] <- NULL
# charge24countsarea[[2]] <- NULL
# charge24IBRcodearea <- locate_areas(vector_of_files[765])
# charge24IBRcodearea[[1]] <- NULL
# charge24IBRcodearea[[2]] <- NULL
# charge24statutenumberarea <- locate_areas(vector_of_files[765])
# charge24statutenumberarea[[1]] <- NULL
# charge24statutenumberarea[[2]] <- NULL
# charge24warrantdatearea <- locate_areas(vector_of_files[765])
# charge24warrantdatearea[[1]] <- NULL
# charge24warrantdatearea[[2]] <- NULL
# 
# charge25area <- locate_areas(vector_of_files[765])
# charge25area[[1]] <- NULL
# charge25area[[2]] <- NULL
# charge25typearea <- locate_areas(vector_of_files[765])
# charge25typearea[[1]] <- NULL
# charge25typearea[[2]] <- NULL
# charge25countsarea <- locate_areas(vector_of_files[765])
# charge25countsarea[[1]] <- NULL
# charge25countsarea[[2]] <- NULL
# charge25IBRcodearea <- locate_areas(vector_of_files[765])
# charge25IBRcodearea[[1]] <- NULL
# charge25IBRcodearea[[2]] <- NULL
# charge25statutenumberarea <- locate_areas(vector_of_files[765])
# charge25statutenumberarea[[1]] <- NULL
# charge25statutenumberarea[[2]] <- NULL
# charge25warrantdatearea <- locate_areas(vector_of_files[765])
# charge25warrantdatearea[[1]] <- NULL
# charge25warrantdatearea[[2]] <- NULL


# saves above areas to the arrestAreas.Rdata file. Don't run this if you have that file
save(arrestnumberarea, namearea, casenumberarea, 
     charge4area, charge4typearea, charge4countsarea, charge4IBRcodearea,
     charge5area, charge5typearea, charge5countsarea, charge5IBRcodearea,
     charge6area, charge6typearea, charge6countsarea, charge6IBRcodearea,
     charge7area, charge7typearea, charge7countsarea, charge7IBRcodearea,
     charge8area, charge8typearea, charge8countsarea, charge8IBRcodearea,
     charge9area, charge9typearea, charge9countsarea, charge9IBRcodearea,
     charge10area, charge10typearea, charge10countsarea, charge10IBRcodearea,
     charge11area, charge11typearea, charge11countsarea, charge11IBRcodearea,
     charge12area, charge12typearea, charge12countsarea, charge12IBRcodearea,
     charge13area, charge13typearea, charge13countsarea, charge13IBRcodearea,
     charge14area, charge14typearea, charge14countsarea, charge14IBRcodearea,
     charge15area, charge15typearea, charge15countsarea, charge15IBRcodearea,
     charge16area, charge16typearea, charge16countsarea, charge16IBRcodearea,
     charge17area, charge17typearea, charge17countsarea, charge17IBRcodearea,
     charge18area, charge18typearea, charge18countsarea, charge18IBRcodearea,
     charge19area, charge19typearea, charge19countsarea, charge19IBRcodearea,
     charge20area, charge20typearea, charge20countsarea, charge20IBRcodearea,
     charge21area, charge21typearea, charge21countsarea, charge21IBRcodearea,
     charge22area, charge22typearea, charge22countsarea, charge22IBRcodearea,
     charge23area, charge23typearea, charge23countsarea, charge23IBRcodearea,
     charge24area, charge24typearea, charge24countsarea, charge24IBRcodearea,
     charge25area, charge25typearea, charge25countsarea, charge25IBRcodearea,
     file = "arrest2ndpageAreas.Rdata"
)


#loads data of cordinates saves above

load("00 Raw Data/arrest2ndpageAreas.Rdata")
agencyname <- extract_text(vector_of_files[1], area = arrestnumber)


# function to extract the information from each file
extractData <- function(secondpage) {
  arrestnumber <- extract_text(secondpage, area = arrestnumberarea)
  name <- extract_text(secondpage, area = namearea)
  casenumber <- extract_text(secondpage, area = casenumberarea)
  charge4extract <- extract_text(secondpage, area = charge4area)
  charge4typeextract <- extract_text(secondpage, area = charge4typearea)
  charge4countsextract <- extract_text(secondpage, area = charge4countsarea)
  charge4IBRcodeextract <- extract_text(secondpage, area = charge4IBRcodearea)
  charge4statutenumberextract <- extract_text(secondpage, area = charge4statutenumberarea)
  charge4warrantdateextract <- extract_text(secondpage, area = charge4warrantdatearea)
  charge5extract <- extract_text(secondpage, area = charge5area)
  charge5typeextract <- extract_text(secondpage, area = charge5typearea)
  charge5countsextract <- extract_text(secondpage, area = charge5countsarea)
  charge5IBRcodeextract <- extract_text(secondpage, area = charge5IBRcodearea)
  charge5statutenumberextract <- extract_text(secondpage, area = charge5statutenumberarea)
  charge5warrantdateextract <- extract_text(secondpage, area = charge5warrantdatearea)
  charge6extract <- extract_text(secondpage, area = charge6area)
  charge6typeextract <- extract_text(secondpage, area = charge6typearea)
  charge6countsextract <- extract_text(secondpage, area = charge6countsarea)
  charge6IBRcodeextract <- extract_text(secondpage, area = charge6IBRcodearea)
  charge6statutenumberextract <- extract_text(secondpage, area = charge6statutenumberarea)
  charge6warrantdateextract <- extract_text(secondpage, area = charge6warrantdatearea)
  charge7extract <- extract_text(secondpage, area = charge7area)
  charge7typeextract <- extract_text(secondpage, area = charge7typearea)
  charge7countsextract <- extract_text(secondpage, area = charge7countsarea)
  charge7IBRcodeextract <- extract_text(secondpage, area = charge7IBRcodearea)
  charge7statutenumberextract <- extract_text(secondpage, area = charge7statutenumberarea)
  charge7warrantdateextract <- extract_text(secondpage, area = charge7warrantdatearea)
  charge8extract <- extract_text(secondpage, area = charge8area)
  charge8typeextract <- extract_text(secondpage, area = charge8typearea)
  charge8countsextract <- extract_text(secondpage, area = charge8countsarea)
  charge8IBRcodeextract <- extract_text(secondpage, area = charge8IBRcodearea)
  charge8statutenumberextract <- extract_text(secondpage, area = charge8statutenumberarea)
  charge8warrantdateextract <- extract_text(secondpage, area = charge8warrantdatearea)
  charge9extract <- extract_text(secondpage, area = charge9area)
  charge9typeextract <- extract_text(secondpage, area = charge9typearea)
  charge9countsextract <- extract_text(secondpage, area = charge9countsarea)
  charge9IBRcodeextract <- extract_text(secondpage, area = charge9IBRcodearea)
  charge9statutenumberextract <- extract_text(secondpage, area = charge9statutenumberarea)
  charge9warrantdateextract <- extract_text(secondpage, area = charge9warrantdatearea)
  charge10extract <- extract_text(secondpage, area = charge10area)
  charge10typeextract <- extract_text(secondpage, area = charge10typearea)
  charge10countsextract <- extract_text(secondpage, area = charge10countsarea)
  charge10IBRcodeextract <- extract_text(secondpage, area = charge10IBRcodearea)
  charge10statutenumberextract <- extract_text(secondpage, area = charge10statutenumberarea)
  charge10warrantdateextract <- extract_text(secondpage, area = charge10warrantdatearea)
  charge11extract <- extract_text(secondpage, area = charge11area)
  charge11typeextract <- extract_text(secondpage, area = charge11typearea)
  charge11countsextract <- extract_text(secondpage, area = charge11countsarea)
  charge11IBRcodeextract <- extract_text(secondpage, area = charge11IBRcodearea)
  charge11statutenumberextract <- extract_text(secondpage, area = charge11statutenumberarea)
  charge11warrantdateextract <- extract_text(secondpage, area = charge11warrantdatearea)
  charge12extract <- extract_text(secondpage, area = charge12area)
  charge12typeextract <- extract_text(secondpage, area = charge12typearea)
  charge12countsextract <- extract_text(secondpage, area = charge12countsarea)
  charge12IBRcodeextract <- extract_text(secondpage, area = charge12IBRcodearea)
  charge12statutenumberextract <- extract_text(secondpage, area = charge12statutenumberarea)
  charge12warrantdateextract <- extract_text(secondpage, area = charge12warrantdatearea)
  charge13extract <- extract_text(secondpage, area = charge13area)
  charge13typeextract <- extract_text(secondpage, area = charge13typearea)
  charge13countsextract <- extract_text(secondpage, area = charge13countsarea)
  charge13IBRcodeextract <- extract_text(secondpage, area = charge13IBRcodearea)
  charge13statutenumberextract <- extract_text(secondpage, area = charge13statutenumberarea)
  charge13warrantdateextract <- extract_text(secondpage, area = charge13warrantdatearea)
  charge14extract <- extract_text(secondpage, area = charge14area)
  charge14typeextract <- extract_text(secondpage, area = charge14typearea)
  charge14countsextract <- extract_text(secondpage, area = charge14countsarea)
  charge14IBRcodeextract <- extract_text(secondpage, area = charge14IBRcodearea)
  charge14statutenumberextract <- extract_text(secondpage, area = charge14statutenumberarea)
  charge14warrantdateextract <- extract_text(secondpage, area = charge14warrantdatearea)
  charge15extract <- extract_text(secondpage, area = charge15area)
  charge15typeextract <- extract_text(secondpage, area = charge15typearea)
  charge15countsextract <- extract_text(secondpage, area = charge15countsarea)
  charge15IBRcodeextract <- extract_text(secondpage, area = charge15IBRcodearea)
  charge15statutenumberextract <- extract_text(secondpage, area = charge15statutenumberarea)
  charge15warrantdateextract <- extract_text(secondpage, area = charge15warrantdatearea)
  charge16extract <- extract_text(secondpage, area = charge16area)
  charge16typeextract <- extract_text(secondpage, area = charge16typearea)
  charge16countsextract <- extract_text(secondpage, area = charge16countsarea)
  charge16IBRcodeextract <- extract_text(secondpage, area = charge16IBRcodearea)
  charge16statutenumberextract <- extract_text(secondpage, area = charge16statutenumberarea)
  charge16warrantdateextract <- extract_text(secondpage, area = charge16warrantdatearea)
  charge17extract <- extract_text(secondpage, area = charge17area)
  charge17typeextract <- extract_text(secondpage, area = charge17typearea)
  charge17countsextract <- extract_text(secondpage, area = charge17countsarea)
  charge17IBRcodeextract <- extract_text(secondpage, area = charge17IBRcodearea)
  charge17statutenumberextract <- extract_text(secondpage, area = charge17statutenumberarea)
  charge17warrantdateextract <- extract_text(secondpage, area = charge17warrantdatearea)
  charge18extract <- extract_text(secondpage, area = charge18area)
  charge18typeextract <- extract_text(secondpage, area = charge18typearea)
  charge18countsextract <- extract_text(secondpage, area = charge18countsarea)
  charge18IBRcodeextract <- extract_text(secondpage, area = charge18IBRcodearea)
  charge18statutenumberextract <- extract_text(secondpage, area = charge18statutenumberarea)
  charge18warrantdateextract <- extract_text(secondpage, area = charge18warrantdatearea)
  charge19extract <- extract_text(secondpage, area = charge19area)
  charge19typeextract <- extract_text(secondpage, area = charge19typearea)
  charge19countsextract <- extract_text(secondpage, area = charge19countsarea)
  charge19IBRcodeextract <- extract_text(secondpage, area = charge19IBRcodearea)
  charge19statutenumberextract <- extract_text(secondpage, area = charge19statutenumberarea)
  charge19warrantdateextract <- extract_text(secondpage, area = charge19warrantdatearea)
  charge20extract <- extract_text(secondpage, area = charge20area)
  charge20typeextract <- extract_text(secondpage, area = charge20typearea)
  charge20countsextract <- extract_text(secondpage, area = charge20countsarea)
  charge20IBRcodeextract <- extract_text(secondpage, area = charge20IBRcodearea)
  charge20statutenumberextract <- extract_text(secondpage, area = charge20statutenumberarea)
  charge20warrantdateextract <- extract_text(secondpage, area = charge20warrantdatearea)
  charge21extract <- extract_text(secondpage, area = charge21area)
  charge21typeextract <- extract_text(secondpage, area = charge21typearea)
  charge21countsextract <- extract_text(secondpage, area = charge21countsarea)
  charge21IBRcodeextract <- extract_text(secondpage, area = charge21IBRcodearea)
  charge21statutenumberextract <- extract_text(secondpage, area = charge21statutenumberarea)
  charge21warrantdateextract <- extract_text(secondpage, area = charge21warrantdatearea)
  charge22extract <- extract_text(secondpage, area = charge22area)
  charge22typeextract <- extract_text(secondpage, area = charge22typearea)
  charge22countsextract <- extract_text(secondpage, area = charge22countsarea)
  charge22IBRcodeextract <- extract_text(secondpage, area = charge22IBRcodearea)
  charge22statutenumberextract <- extract_text(secondpage, area = charge22statutenumberarea)
  charge22warrantdateextract <- extract_text(secondpage, area = charge22warrantdatearea)
  charge23extract <- extract_text(secondpage, area = charge23area)
  charge23typeextract <- extract_text(secondpage, area = charge23typearea)
  charge23countsextract <- extract_text(secondpage, area = charge23countsarea)
  charge23IBRcodeextract <- extract_text(secondpage, area = charge23IBRcodearea)
  charge23statutenumberextract <- extract_text(secondpage, area = charge23statutenumberarea)
  charge23warrantdateextract <- extract_text(secondpage, area = charge23warrantdatearea)
  charge24extract <- extract_text(secondpage, area = charge24area)
  charge24typeextract <- extract_text(secondpage, area = charge24typearea)
  charge24countsextract <- extract_text(secondpage, area = charge24countsarea)
  charge24IBRcodeextract <- extract_text(secondpage, area = charge24IBRcodearea)
  charge24statutenumberextract <- extract_text(secondpage, area = charge24statutenumberarea)
  charge24warrantdateextract <- extract_text(secondpage, area = charge24warrantdatearea)
  charge25extract <- extract_text(secondpage, area = charge25area)
  charge25typeextract <- extract_text(secondpage, area = charge25typearea)
  charge25countsextract <- extract_text(secondpage, area = charge25countsarea)
  charge25IBRcodeextract <- extract_text(secondpage, area = charge25IBRcodearea)
  charge25statutenumberextract <- extract_text(secondpage, area = charge25statutenumberarea)
  charge25warrantdateextract <- extract_text(secondpage, area = charge25warrantdatearea)
  
  data.frame(
    arrestnumber = arrestnumber, name = name, casenumber = casenumber, 
    charge4 = charge4extract, charge4type = charge4typeextract, charge4counts = charge4countsextract, charge4IBRcode = charge4IBRcodeextract, 
    charge4statutenumber = charge4statutenumberextract, charge4warrantdate = charge4warrantdateextract,
    charge5 = charge5extract, charge5type = charge5typeextract, charge5counts = charge5countsextract, charge5IBRcode = charge5IBRcodeextract, 
    charge5statutenumber = charge5statutenumberextract, charge5warrantdate = charge5warrantdateextract,
    charge6 = charge6extract, charge6type = charge6typeextract, charge6counts = charge6countsextract, charge6IBRcode = charge6IBRcodeextract, 
    charge6statutenumber = charge6statutenumberextract, charge6warrantdate = charge6warrantdateextract,
    charge7 = charge7extract, charge7type = charge7typeextract, charge7counts = charge7countsextract, charge7IBRcode = charge7IBRcodeextract, 
    charge7statutenumber = charge7statutenumberextract, charge7warrantdate = charge7warrantdateextract,
    charge8 = charge8extract, charge8type = charge8typeextract, charge8counts = charge8countsextract, charge8IBRcode = charge8IBRcodeextract, 
    charge8statutenumber = charge8statutenumberextract, charge8warrantdate = charge8warrantdateextract,
    charge9 = charge9extract, charge9type = charge9typeextract, charge9counts = charge9countsextract, charge9IBRcode = charge9IBRcodeextract, 
    charge9statutenumber = charge9statutenumberextract, charge9warrantdate = charge9warrantdateextract,
    charge10 = charge10extract, charge10type = charge10typeextract, charge10counts = charge10countsextract, charge10IBRcode = charge10IBRcodeextract, 
    charge10statutenumber = charge10statutenumberextract, charge10warrantdate = charge10warrantdateextract,
    charge11 = charge11extract, charge11type = charge11typeextract, charge11counts = charge11countsextract, charge11IBRcode = charge11IBRcodeextract, 
    charge11statutenumber = charge11statutenumberextract, charge11warrantdate = charge11warrantdateextract,
    charge12 = charge12extract, charge12type = charge12typeextract, charge12counts = charge12countsextract, charge12IBRcode = charge12IBRcodeextract, 
    charge12statutenumber = charge12statutenumberextract, charge12warrantdate = charge12warrantdateextract,
    charge13 = charge13extract, charge13type = charge13typeextract, charge13counts = charge13countsextract, charge13IBRcode = charge13IBRcodeextract, 
    charge13statutenumber = charge13statutenumberextract, charge13warrantdate = charge13warrantdateextract,
    charge14 = charge14extract, charge14type = charge14typeextract, charge14counts = charge14countsextract, charge14IBRcode = charge14IBRcodeextract, 
    charge14statutenumber = charge14statutenumberextract, charge14warrantdate = charge14warrantdateextract,
    charge15 = charge15extract, charge15type = charge15typeextract, charge15counts = charge15countsextract, charge15IBRcode = charge15IBRcodeextract, 
    charge15statutenumber = charge15statutenumberextract, charge15warrantdate = charge15warrantdateextract,
    charge16 = charge16extract, charge16type = charge16typeextract, charge16counts = charge16countsextract, charge16IBRcode = charge16IBRcodeextract, 
    charge16statutenumber = charge16statutenumberextract, charge16warrantdate = charge16warrantdateextract,
    charge17 = charge17extract, charge17type = charge17typeextract, charge17counts = charge17countsextract, charge17IBRcode = charge17IBRcodeextract, 
    charge17statutenumber = charge17statutenumberextract, charge17warrantdate = charge17warrantdateextract,
    charge18 = charge18extract, charge18type = charge18typeextract, charge18counts = charge18countsextract, charge18IBRcode = charge18IBRcodeextract, 
    charge18statutenumber = charge18statutenumberextract, charge18warrantdate = charge18warrantdateextract,
    charge19 = charge19extract, charge19type = charge19typeextract, charge19counts = charge19countsextract, charge19IBRcode = charge19IBRcodeextract, 
    charge19statutenumber = charge19statutenumberextract, charge19warrantdate = charge19warrantdateextract,
    charge20 = charge20extract, charge20type = charge20typeextract, charge20counts = charge20countsextract, charge20IBRcode = charge20IBRcodeextract, 
    charge20statutenumber = charge20statutenumberextract, charge20warrantdate = charge20warrantdateextract,
    charge21 = charge21extract, charge21type = charge21typeextract, charge21counts = charge21countsextract, charge21IBRcode = charge21IBRcodeextract, 
    charge21statutenumber = charge21statutenumberextract, charge21warrantdate = charge21warrantdateextract,
    charge22 = charge22extract, charge22type = charge22typeextract, charge22counts = charge22countsextract, charge22IBRcode = charge22IBRcodeextract, 
    charge22statutenumber = charge22statutenumberextract, charge22warrantdate = charge22warrantdateextract,
    charge23 = charge23extract, charge23type = charge23typeextract, charge23counts = charge23countsextract, charge23IBRcode = charge23IBRcodeextract, 
    charge23statutenumber = charge23statutenumberextract, charge23warrantdate = charge23warrantdateextract,
    charge24 = charge24extract, charge24type = charge24typeextract, charge24counts = charge24countsextract, charge24IBRcode = charge24IBRcodeextract, 
    charge24statutenumber = charge24statutenumberextract, charge24warrantdate = charge24warrantdateextract,
    charge25 = charge25extract, charge25type = charge25typeextract, charge25counts = charge25countsextract, charge25IBRcode = charge25IBRcodeextract, 
    charge25statutenumber = charge25statutenumberextract, charge25warrantdate = charge25warrantdateextract
             )
}
# apply runs function on every file to create a table with the extracted data
data <- lapply(vector_of_files, extractData) %>%
  bind_rows() %>%
  filter(arrestnumber != "Place of Birth Citizenship\r\n")
view(data)

#writes data to a csv file
write.csv(data, "00 Raw Data/2ndpagearrests_missing_table.csv")