# Load libraries

library(gitcreds)
library(tidyverse)
library(RSelenium)
library(devtools)
library(netstat) # new
library(wdman) # new
library(wdpar) # new

# Set up a download path
# Must be consistent with whatever is in browserProfile
downloadPath <- "incidents"
browserProfile <- getFirefoxProfile("my_browser_profile2/", useBase = TRUE)
last_report_date_we_want <- "06/01/2022"

# Start Selenium
rD <- rsDriver(browser=c("firefox"), version = "latest", port=4573L, verbose=T, extraCapabilities = browserProfile)
remDr <- rD[['client']]


# Set search page URL
searchURL <- "https://durhampdnc.policetocitizen.com/EventSearch"

# Go to search page
remDr$navigate(searchURL)

# If necessary, click ACCEPT
# Then click on "By Report Information"
Sys.sleep(2)
suppressMessages(acceptButton <- tryCatch(last(remDr$findElements(using = "xpath",value = '//*[@id="disclaimerDialog"]/md-dialog-actions/button[2]/span')),error = function(e){NULL}))
if (!is.null(acceptButton)) {
  acceptButton$clickElement()
}

Sys.sleep(2)
suppressMessages(reportinfoButton <- tryCatch(last(remDr$findElements(using = "xpath",value = '//*[@id="byReportInformation-card"]/md-card-title/md-card-title-text/span[1]')),error = function(e){NULL}))
if (!is.null(reportinfoButton)) {
  reportinfoButton$clickElement()
}

# De-select the incidents/arrests button 
# (NEW)
Sys.sleep(2)
suppressMessages(incidentsCheckbox <- tryCatch(last(remDr$findElements(using = "css selector", value ='#arrest-checkbox > div:nth-child(1)')),error = function(e){NULL}))
if (!is.null(incidentsCheckbox)) {
  incidentsCheckbox$clickElement()
}




# Help Selenium get 30 day time periods from the website
getdates <- function(end_date) {
  
  # get the a date 30 days prior
  start_date <- as.Date(end_date,"%m/%d/%Y") - 30
  
  # rebuild the string
  startyear <- format(start_date, "%Y")
  startmonth <- format(start_date, "%m")
  startday <- format(start_date, "%d")
  newstart <- str_replace_all(paste(startmonth, "/", startday, "/", startyear), " ", "")
  
  return(newstart)
}



# If your selenium session stops, you set the last "end date" of the 
# 30 day period that was scrapped here and re-run the next for loop





enddate <-"01/21/2021"





# ______________________________________ all below this line will be in a loop for the dates ______________________________________ #
for (x in 1:12) {
  # lets run this for a whole year, thats 12 times 30 day periods
  # get the start date of the 30 period
  startdate <- getdates(enddate)
  
  # Get date input fields
  Sys.sleep(15)

  datePickers <- remDr$findElements(using = "class", value = "md-datepicker-input")
  startPicker <- datePickers[[1]]
  endPicker <- datePickers[[2]]
  
  # Fill in start and end dates on web form
  # Find search button
  # Click search button
  startPicker$clearElement()
  startPicker$sendKeysToElement(list(startdate))
  endPicker$clearElement()
  endPicker$sendKeysToElement(list(enddate))
  Sys.sleep(2)
  searchButton <- remDr$findElement(using = "id", value = "search-button")
  searchButton$clickElement()
  
  # Find "Load More" button and continue to click until no more can be loaded
  Sys.sleep(10)
  loadFlag <- TRUE
  while (loadFlag == TRUE) {
    suppressMessages(loadmoreButton <- tryCatch(last(remDr$findElements(using = "xpath", value = '//*[@id="event-search-results"]/event-search-results/div/div[2]/div[3]/button/span')),error = function(e){NULL}))
    if (!is.null(loadmoreButton)) {
      loadmoreButton$clickElement()
      Sys.sleep(0.1)
    } else {
      loadFlag <- FALSE
    }
  }
  
  # Get button for each result
  results <- remDr$findElements(using = "css selector", value = "div.p2c-eventSearch-result > md-card:nth-child(1) > md-card-content:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(1) > i:nth-child(1)")
  
  
  # Get files
########## for (i in 1:length(results)) { ##########
  Sys.sleep(10)
  for (i in 1:length(results)) {
    if (i %% 10 == 0) print(i)
    results[[i]]$clickElement()
    Sys.sleep(3)
  }
  
  
  # Update the end date so that periods don't overlap
  enddate <- startdate 
  enddate <- as.Date(enddate,"%m/%d/%Y") - 1
  endyear <- format(enddate, "%Y")
  endmonth <- format(enddate, "%m")
  endday <- format(enddate, "%d")
  enddate <- str_replace_all(paste(endmonth, "/", endday, "/", endyear), " ", "")
  x <- x + 1
  
  
  # Go back to the event search website
  Sys.sleep(10)
  suppressMessages(backButton <- tryCatch(last(remDr$findElements(using = "xpath", value = '//*[@id="back-button"]')),error = function(e){NULL}))
  if (!is.null(backButton)) {
    backButton$clickElement()
  }



  # Rename files
  # Set up filenames
#  idx <- 1:length(results)
#  filenos <- str_pad(idx, width = 7, pad = "0")
#  filenamestart <- str_replace_all(as.Date(startdate,"%m/%d/%Y"),"-","")
#  filenames <- paste0(downloadPath,filenamestart,"-",filenos,".pdf")
#  idx <- rev(idx)
#  origFiles <- paste0(downloadPath,"pdf(",idx,")")
#  rename <- function(i){
#    tryCatch(out <- file.rename(origFiles[i],filenames[i]))
#  }
#  lapply(idx, rename)

}
# ______________________________________ dates loop ends here ______________________________________


# BYEEE Selenium
rD[["server"]]$stop()
