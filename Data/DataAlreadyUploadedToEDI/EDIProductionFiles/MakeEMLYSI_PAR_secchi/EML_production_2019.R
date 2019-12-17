# Steps for setting up EML metadata ####
library(devtools)
install_github("EDIorg/EMLassemblyline", force=T)
library(EMLassemblyline)

# Import templates for dataset licensed under CCBY, with 2 tables.
template_core_metadata(path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                 license = "CCBY",
                 file.type = ".txt",
                 write.file = TRUE)

template_table_attributes(path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                          data.path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                          data.table = c("Secchi_depth_2013-2019.csv",
                                         "YSI_PAR_profiles_2013-2019.csv"))
              
template_categorical_variables(path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                               data.path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                               write.file = TRUE)

template_geographic_coverage(path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                             data.path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
                             data.table = c("Secchi_depth_2013-2019.csv",
                                            "YSI_PAR_profiles_2013-2019.csv"),
                             empty = TRUE,
                             write.file = TRUE)

################################


# Run this function
make_eml(path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
         dataset.title = "Secchi depth data and discrete depth profiles of photosynthetically active radiation, temperature, dissolved oxygen, and pH for Beaverdam Reservoir, Carvins Cove Reservoir, Falling Creek Reservoir, Gatewood Reservoir, and Spring Hollow Reservoir in southwestern Virginia, USA 2013-2018",
         data.path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
         eml.path = "/Users/heatherwander/Documents/VirginiaTech/research/Field data/MakeEMLYSI",
         data.table = c("Secchi_depth_2013-2019.csv",
                        "YSI_PAR_profiles_2013-2019.csv"),
         data.table.description = c("Secchi depth data from five reservoirs in southwestern Virginia", 
                                    "Discrete depths of water temperature, dissolved oxygen, conductivity, photosynthetically active radiation, redox potential, and pH in five southwestern Virginia reservoirs"),
         temporal.coverage = c("2013-08-30", "2019-12-06"),
         maintenance.description = "ongoing", 
         user.domain = "EDI",
         user.id = "ccarey",
         package.id = "edi.198.7")

