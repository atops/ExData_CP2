library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 5. How have emissions from motor vehicle sources
#    changed in Baltimore City from 1999-2008?
mvscc <- SCC %>%
        filter(grepl("Vehicles$", EI.Sector)) %>%
        select(SCC)

mvbaltdf <- NEI %>% 
        filter(SCC %in% unique(mvscc$SCC)) %>%
        filter(fips=="24510") %>%
        group_by(year) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot5.png")
qplot(data=mvbaltdf, 
      x=year, 
      y=totem, 
      geom="line", 
      xlab="Year", 
      ylab=expression(paste(PM[2.5]," (tons)")),
      main=expression(paste("Total ", 
                            PM[2.5], 
                            " Emissions from Motor Vehicles in",
                            " Baltimore City")))
dev.off()
