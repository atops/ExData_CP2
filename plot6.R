library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 6. How have emissions from motor vehicle sources
#    changed in Baltimore City from 1999-2008
#    compared to Los Angeles?
mvscc <- SCC %>%
        filter(grepl("Vehicles$", EI.Sector)) %>%
        select(SCC)

mvbaltladf <- NEI %>% 
        filter(SCC %in% unique(mvscc$SCC)) %>%
        filter(fips=="24510"|fips=="06037") %>%
        mutate(fips = ifelse(fips=="24510", 
                             "Baltimore City", 
                             "Los Angeles")) %>%
        group_by(fips, year) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot6.png")
qplot(data=mvbaltladf, 
      x=year, 
      y=totem, 
      geom="line", 
      xlab="Year", 
      ylab=expression(paste(PM[2.5]," (tons)")),
      main=expression(paste("Total ", 
                            PM[2.5], 
                            " Emissions from Motor Vehicles in",
                            " Baltimore City and LA"))) +
        facet_wrap(~fips, nrow=1)
dev.off()