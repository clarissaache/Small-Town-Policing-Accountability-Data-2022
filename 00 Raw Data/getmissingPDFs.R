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
downloadPath <- "missing/"
#browserProfile <- getFirefoxProfile("/Users/clarissaache/Documents/Data+/SToPAGetDurhamData/my_browser_profile3/", useBase = TRUE)


# Start Selenium
rD <- rsDriver(browser=c("firefox"), version = "latest", port=4575L, verbose=T, extraCapabilities = browserProfile)
remDr <- rD[['client']]


# Set search page URL
searchURL <- "https://durhampdnc.policetocitizen.com/EventSearch"

# Go to search page
remDr$navigate(searchURL)

# If necessary, click ACCEPT
Sys.sleep(2)
suppressMessages(acceptButton <- tryCatch(last(remDr$findElements(using = "xpath",value = '//*[@id="disclaimerDialog"]/md-dialog-actions/button[2]/span')),error = function(e){NULL}))
if (!is.null(acceptButton)) {
  acceptButton$clickElement()
}


# Then click on "By Case Number"
Sys.sleep(2)
suppressMessages(reportinfoButton <- tryCatch(last(remDr$findElements(using = "xpath",value = '/html/body/div/div/main/md-content/div/div[2]/div/div/event-search-selection/md-card[3]/md-card-title')),error = function(e){NULL}))
if (!is.null(reportinfoButton)) {
  reportinfoButton$clickElement()
}


library(readr)
df <- read_csv("~/Documents/Data+/SToPAGetDurhamData/secondlistofmissing.csv")
df <- df[,c(2,3)]

# /Users/clarissaache/Documents/Data+/SToPAGetDurhamData/00 Raw Data/missing⁩

# ______________________________________ case number loop ______________________________________ #

for (j in 78:nrow(df)) {
  
  p = unlist(df[j,2])
  p = substring(p,0, nchar(p))
  print(p)

  #find input field
  Sys.sleep(1)
  inputfield <- remDr$findElement(using = "xpath", value = '//*[@id="caseNumber-input"]') 
  inputfield$clearElement()
  
  # send the case number
  Sys.sleep(1)
  inputfield$sendKeysToElement(list(p))
  
  # click search button
  Sys.sleep(1)
  searchButton <- remDr$findElement(using = 'id', value = 'search-button')
  searchButton$clickElement()
  
  # download it
  Sys.sleep(5)
  #downloadButton <- remDr$findElement(using = 'css selector', value = 'i.ng-scope')
  #downloadButton$clickElement()
  
  results <- remDr$findElements(using = "css selector", value = "div.p2c-eventSearch-result > md-card:nth-child(1) > md-card-content:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(1) > i:nth-child(1)")
  # Get files
  if (length(results) != 0)
  {
    Sys.sleep(2)
    for (i in 1:length(results)) {
      results[[i]]$clickElement()
      Sys.sleep(0.5)
  }} else
  { print('empty list')}
  
  # go back
  Sys.sleep(10)
  backButton <- remDr$findElement(using = "id", value = 'back-button')
  backButton$clickElement()
  
}

# ______________________________________ case # loop ends here ___________________________________ #


# BYEEE Selenium
rD[["server"]]$stop()
