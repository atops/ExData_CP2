library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 1. Have total emissions decreased from 1999 to 2008?
totdf <- NEI %>% 
        group_by(year) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot1.png")
plot(x=totdf$year, 
     y=totdf$totem, 
     type="l", 
     xlab="Year", 
     ylab="PM2.5 (tons)",
     main="Total PM2.5 Emissions")
dev.off()
