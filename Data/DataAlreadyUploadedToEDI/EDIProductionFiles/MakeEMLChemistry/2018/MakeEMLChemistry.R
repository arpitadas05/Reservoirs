##MakeEMLChemistry
##Author: Mary Lofton
##Date: 07SEP19

#good site for step-by-step instructions
#https://ediorg.github.io/EMLassemblyline/articles/overview.html
#and links therein

#append this year's chemistry to last year's published data
library(tidyverse)

old <- read_csv("./Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018/chemistry_old.csv")
new <- read_csv("./Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018/chemistry_2018_working.csv")

chem <- bind_rows(old, new) %>%
  select(Reservoir, Site, DateTime, Depth_m, TN_ugL, TP_ugL, NH4_ugL, NO3NO2_ugL, SRP_ugL, DOC_mgL, DIC_mgL, DC_mgL, DN_mgL, Flag_TN, Flag_TP, Flag_NH4, Flag_NO3NO2, Flag_SRP, Flag_DOC, Flag_DIC, Flag_DC, Flag_DN)

write.csv(chem, "./Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018/chemistry.csv",row.names = FALSE)

# (install and) Load EMLassemblyline #####
# install.packages('devtools')

devtools::install_github("EDIorg/EMLassemblyline")
#note that EMLassemblyline has an absurd number of dependencies and you
#may exceed your API rate limit; if this happens, you will have to wait an
#hour and try again or get a personal authentification token (?? I think)
#for github which allows you to submit more than 60 API requests in an hour
library(EMLassemblyline)


#Step 1: Create a directory for your dataset
#in this case, our directory is Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018

#Step 2: Move your dataset to the directory

#Step 3: Identify an intellectual rights license
#ours is CCBY

#Step 4: Identify the types of data in your dataset
#right now the only supported option is "table"; happily, this is what 
#we have!

#Step 5: Import the core metadata templates

#for our application, we will need to generate all types of metadata
#files except for taxonomic coverage, as we have both continuous and
#categorical variables and want to report our geographic location

# View documentation for these functions
?template_core_metadata
?template_table_attributes
?template_categorical_variables #don't run this till later
?template_geographic_coverage

# Import templates for our dataset licensed under CCBY, with 1 table.
template_core_metadata(path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                 license = "CCBY",
                 file.type = ".txt",
                 write.file = TRUE)

template_table_attributes(path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                       data.path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                       data.table = "chemistry.csv",
                       write.file = TRUE)


#we want empty to be true for this because we don't include lat/long
#as columns within our dataset but would like to provide them
template_geographic_coverage(path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                          data.path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                          data.table = "chemistry.csv",
                          empty = TRUE,
                          write.file = TRUE)

#Step 6: Script your workflow
#that's what this is, silly!

#Step 7: Abstract
#copy-paste the abstract from your Microsoft Word document into abstract.txt
#if you want to check your abstract for non-allowed characters, go to:
#https://pteo.paranoiaworks.mobi/diacriticsremover/
#paste text and click remove diacritics

#Step 8: Methods
#copy-paste the methods from your Microsoft Word document into abstract.txt
#if you want to check your abstract for non-allowed characters, go to:
#https://pteo.paranoiaworks.mobi/diacriticsremover/
#paste text and click remove diacritics

#Step 9: Additional information
#I put the notes about FCR manipulations and pubs documenting it in this file

#Step 10: Keywords
#DO NOT EDIT KEYWORDS FILE USING A TEXT EDITOR!! USE EXCEL!!
#not sure if this is still true...let's find out! :-)
#see the LabKeywords.txt file for keywords that are mandatory for all Carey Lab data products

#Step 11: Personnel
#copy-paste this information in from your metadata document
#Cayelan needs to be listed several times; she has to be listed separately for her roles as
#PI, creator, and contact, and also separately for each separate funding source (!!)

#Step 12: Attributes
#grab attribute names and definitions from your metadata word document
#for units....
# View and search the standard units dictionary
view_unit_dictionary()
#put flag codes and site codes in the definitions cell
#force reservoir to categorical

#Step 13: Close files
#if all your files aren't closed, sometimes functions don't work

#Step 14: Categorical variables
# Run this function for your dataset
#THIS WILL ONLY WORK once you have filled out the attributes_chemistry.txt and
#identified which variables are categorical
template_categorical_variables(path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                               data.path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
                               write.file = TRUE)

#open the created value IN A SPREADSHEET EDITOR and add a definition for each category

#Step 15: Geographic coverage
#copy-paste the bounding_boxes.txt file (or geographic_coverage.txt file) that is Carey Lab specific into your working directory

## Step 16: Obtain a package.id. ####
# Go to the EDI staging environment (https://portal-s.edirepository.org/nis/home.jsp),
# then login using one of the Carey Lab usernames and passwords.
#Mine is: carylab6 p&NYsih9Ja0@T1R6 Mary Lofton

# Select Tools --> Data Package Identifier Reservations and click 
# "Reserve Next Available Identifier"
# A new value will appear in the "Current data package identifier reservations" 
# table (e.g., edi.123)
# Make note of this value, as it will be your package.id below

#Step 17: Make EML
# View documentation for this function
?make_eml

# Run this function
make_eml(path = "C:/Users/Mary Lofton/Documents/RProjects/Reservoirs/Formatted_Data/MakeEMLChemistry",
         dataset.title = "Water chemistry time series for Beaverdam Reservoir, Carvins Cove Reservoir, Falling Creek Reservoir, Gatewood Reservoir, and Spring Hollow Reservoir in southwestern Virginia, USA 2013-2017",
         data.files = c("chemistry"),
         data.files.description = c("Reservoir water chemistry dataset."),
         #data.files.quote.character = c("\"", "\""),
         temporal.coverage = c("2013-04-04", "2017-12-11"),
         geographic.description = "Southwestern Virginia, USA, North America",
         #geographic.coordinates = c("69.0", "28.53", "28.38", "-119.95"),
         maintenance.description = "ongoing", 
         user.id = "carylab6",
         package.id = "edi.199.3")

make_eml(
  path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
  data.path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
  eml.path = "C:/Users/Mary Lofton/Documents/Github/Reservoirs/Data/DataAlreadyUploadedToEDI/EDIProductionFiles/MakeEMLChemistry/2018",
  dataset.title = "Water chemistry time series for Beaverdam Reservoir, Carvins Cove Reservoir, Falling Creek Reservoir, Gatewood Reservoir, and Spring Hollow Reservoir in southwestern Virginia, USA 2013-2018",
  temporal.coverage = c("2013-04-04", "2018-12-17"),
  maintenance.description = 'completed',
  data.table = c('decomp.csv', 'nitrogen.csv'),
  data.table.description = c('Decomposition data', 'Nitrogen data'),
  user.id = 'csmith',
  user.domain = 'EDI',
  package.id = 'edi.267'
)
