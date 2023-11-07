# output charts into powerpoint slides

# load packages and data --------------------------------------------------
source("helper/plot_file.R")
message("Data Loaded")

# output powerpoint -------------------------------------------------------

team_str <- "South East PAT"
email_str <- "england.datasouth@nhs.net"

doc <- read_pptx("output/pp_master.pptx")

# add title slide
doc <- add_slide(doc, layout = "Title Slide", master = "Custom Design")
doc <- ph_with(doc, "Example Slides", location = ph_location_label(ph_label = "Title"))
doc <- ph_with(doc, paste("Published ", format(Sys.Date(), "%d %b %y")), location = ph_location_label(ph_label = "Date"))
doc <- ph_with(doc, team_str, location = ph_location_label(ph_label = "Produced by"))
doc <- ph_with(doc, email_str, location = ph_location_label(ph_label = "Email"))

# add region slide
doc <- add_slide(doc, layout = "Charts", master = "Custom Design")
doc <- ph_with(doc, plot1, location = ph_location_label(ph_label = "Chart"))
doc <- ph_with(doc, "An example plot", location = ph_location_label(ph_label = "Title"))
doc <- ph_with(doc, "An example subtitle", location = ph_location_label(ph_label = "Description"))
doc <- ph_with(doc, 
               "Some example text \n Could be replaced with automated commentary", 
               location = ph_location_label(ph_label = "Narrative"))
doc <- ph_with(doc, "Source: published monthly sitrep data", location = ph_location_label(ph_label = "Source"))
doc <- ph_with(doc, paste("Code run on ", format(Sys.Date(), "%d %b %y")), location = ph_location_label(ph_label = "Data up to"))

# Save file
print(doc, target = paste0("output/iterations/", format(Sys.Date(), "%Y%m%d"), " Powerpoint Pack.pptx", sep =""))
