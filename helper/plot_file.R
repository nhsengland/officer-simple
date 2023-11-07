# data are public from https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/ae-attendances-and-emergency-admissions-2023-24/

library(tidyverse)
library(officer)

df_ae <- read_csv("data/Monthly-AE-September-2023.csv")

plot1 <- df_ae %>% 
  mutate(region = str_remove_all(`Parent Org`, "NHS ENGLAND ")) %>% 
  summarise(t1_attendances = sum(`A&E attendances Type 1`, na.rm = T),
            .by = region) %>% 
  ggplot(aes(x = region, y = t1_attendances)) + 
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(y = "Type 1 Attendances", 
       title = "September Type 1 attendances by region",
       caption = "Source: public data from https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/ae-attendances-and-emergency-admissions-2023-24/") +
  scale_y_continuous(labels = scales::comma) +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1),
        axis.title.x = element_blank())
