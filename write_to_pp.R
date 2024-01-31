# This script sources a very simple data import and plot and exports to a powerpoint slide
# The slide is based on a master .pptx file saved in the output folder
# November 2023

# load packages and data --------------------------------------------------
source("helper/plot_file.R")
message("Data Loaded")

# output powerpoint -------------------------------------------------------

team_str <- "South East PAT"
email_str <- "england.datasouth@nhs.net"
latest_data <- "September 2023"

doc <- read_pptx("output/pp_master.pptx")

# add title slide
doc <- add_slide(doc, layout = "Title Slide", master = "Custom Design")
doc <- ph_with(doc, "Example Slides", location = ph_location_label(ph_label = "Title"))
doc <- ph_with(doc, paste("Published ", format(Sys.Date(), "%d %b %y")), location = ph_location_label(ph_label = "Date"))
doc <- ph_with(doc, team_str, location = ph_location_label(ph_label = "Produced by"))
doc <- ph_with(doc, email_str, location = ph_location_label(ph_label = "Email"))

# add chart slide
doc <- add_slide(doc, layout = "Charts", master = "Custom Design")
doc <- ph_with(doc, plot1, location = ph_location_label(ph_label = "Chart"))
doc <- ph_with(doc, "An example plot", location = ph_location_label(ph_label = "Title"))
doc <- ph_with(doc, "An example subtitle", location = ph_location_label(ph_label = "Description"))
doc <- ph_with(doc, 
               "Some example text \n Could be replaced with automated commentary", 
               location = ph_location_label(ph_label = "Narrative"))
doc <- ph_with(doc, paste0("Source: published monthly sitrep data up to ", latest_data), location = ph_location_label(ph_label = "Source"))
doc <- ph_with(doc, paste("Code run on ", format(Sys.Date(), "%d %b %y")), location = ph_location_label(ph_label = "Data up to"))

# Save file
print(doc, target = paste0("output/iterations/", format(Sys.Date(), "%Y%m%d"), " Powerpoint Pack.pptx", sep =""))


