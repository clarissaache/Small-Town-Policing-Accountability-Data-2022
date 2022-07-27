# load packages
library(tidyverse)
library(stringr)

# Changing the names of files to make sense
# Setting up data directory to grab all files from arrests folder
datapath <- "00 Raw Data/data/"

#creating vector of old file names
oldfiles <- list.files(datapath)
oldfiles

#renaming files to be ex. arrests0000001.pdf
newfiles <- paste0("arrests",(str_pad(1:length(oldfiles), width = 7, 
                                      pad = "0")),".pdf")

#renaming files within the folder
newfiles
file.rename(paste0(datapath, oldfiles),     
            paste0(datapath, newfiles))