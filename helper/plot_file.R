# This script imports some A&E data and plots a very simple bar chart
# data are public 
# November 2023

library(tidyverse)
library(officer)
library(NHSRtheme)

df_ae <- read_csv("data/Monthly-AE-September-2023.csv")

# plot 1 ------------------------------------------------------------------

data1 <- df_ae %>% 
  mutate(region = str_remove_all(`Parent Org`, "NHS ENGLAND ")) %>% 
  summarise(t1_attendances = sum(`A&E attendances Type 1`, na.rm = T),
            .by = region)

plot1 <- data1 %>% 
  filter(region != "TOTAL") %>% 
  ggplot(aes(x = region, y = t1_attendances, fill = region)) + 
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(y = "Type 1 Attendances", 
       title = "September Type 1 attendances by region",
       caption = "Source: public data from https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/ae-attendances-and-emergency-admissions-2023-24/") +
  scale_y_continuous(labels = scales::comma) +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1),
        axis.title.x = element_blank(),
        legend.position = "none") + 
  scale_fill_nhs()

commentary1 <- paste0("There were ", 
                      data1 %>% filter(region == "SOUTH EAST") %>% select(t1_attendances) %>% .[[1]], 
                      " Type 1 attendances in the South East in September 2023.")
