library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 2. Have total emissions in Balimore City
#    decreased from 1999 to 2008?
baltdf <- NEI %>% 
        filter(fips=="24510") %>%
        group_by(year) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot2.png")
plot(x=baltdf$year, 
     y=baltdf$totem, 
     type="l", 
     xlab="Year", 
     ylab="PM2.5 (tons)",
     main="Total PM2.5 Emissions in Baltimore City")
dev.off()
