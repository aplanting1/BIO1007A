# This lecture covers how to input your own data into R rather than using built in data

# write.table ()
  # better for reading in comments 
  # allows you to create a data set

#   write.table(x=my_data
  #     file="Path/To/OutputFileName.csv",
  #     HEADER=TRUE,
  #     sep=",") separation index 
  

# read functions read in a data set from your computer

#   read.table(
#     file="Path/To/OutputFileName.csv",
#     HEADER=TRUE,
#     sep=",") separation index 


#   read.csv()
  #   read.csv(file=)


# Use rds objects when only working in R (saves whatever variable you want in R, can convert large file into R file for easier sharing and storing)
#   saveRDS()
#     saveRDS(my_data, file="Path/To/FileName.RDS")

#   readRDS()
#     readRDS("fileName.RDS)
#     p <-


# Long vs. Wide format
#   A wide format contains values that DO NOT repeat in the ID column. A long format contains values that DO        repeat in the ID column.

#   Sometimes data is collected and entered one way, but needed in a different format for analysis and plotting


# Changing certain columns from wide to long, helps with analyzing/plotting data

  library(tidyverse)

# billboard rank of songs in the year 2000
  head(billboard)
  b1 <- billboard %>%
   pivot_longer(
     cols = starts_with("wk"), #specify which columns you want to make 'longer'
      names_to = "week", #name of new column of header names
      values_to = "rank", #name of new column of cell values
      values_drop_na = TRUE # removes any rows where the values are NA
  )
  
# Pivot wider, best for making occupancy matrix, increasing num cols decreases num rows
  head(fish_encounters) 
  table(fish_encounters$seen) 
  # create an occupancy matrix  
  head(fish_encounters)
  fish_encounters %>%
    pivot_wider(names_from = station, #which column would you like to turn into multiple columns
                values_from = seen) #which column contains the values for the new columns
  # Fill in missing values with 0s
  fish_encounters %>%
    pivot_wider(names_from = station, values_from = seen, values_fill = 0) # fills NA's with 0's
  
  #-------------
  
# Dryad: makes research data freely reusable, citable, and discoverable https://datadryad.org/search 
  
dryadData <- read.table("BIO1007A_Data/veysey-babbitt_data_amphibians.csv", header=TRUE, sep=",", stringsAsFactors = TRUE) # first part is the folder in which the file is stored
  glimpse(dryadData)
  head(dryadData)
  table(dryadData$species) # good way to see what the different groupings of character column 
  summary(dryadData$mean.hydro)
  
dryadData$species<-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot using "factor"

dryadData$treatment <- factor(dryadData$treatment, # creating labels to use for the plot (treatment label), also ensures that the specified labels come first 
                              levels=c("Reference",
                                       "100m", "30m"))


p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), # interaction groups treatment and wetlands
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") +
  ylab("Number of breeding adults") +
  xlab("") +
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) +
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) +
  facet_wrap(~species, nrow=2, strip.position="right") +
  theme_few() + scale_fill_grey() + 
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), legend.position="top",  legend.title= element_blank(), axis.title.y = element_text(size=12, face="bold", colour = "black"), strip.text.y = element_text(size = 10, face="bold", colour = "black")) + 
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p
