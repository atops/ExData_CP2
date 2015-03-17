library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 3. For which sources have emissions in Balimore City
#    decreased from 1999 to 2008?
baltdf2 <- NEI %>% 
        filter(fips=="24510") %>%
        group_by(year, type) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot3.png")
qplot(data=baltdf2, 
      x=year, 
      y=totem, 
      geom="line", 
      xlab="Year", 
      ylab=expression(paste(PM[2.5]," (tons)")),
      main=expression(paste("Total ", 
                            PM[2.5], 
                            " Emissions in Baltimore City",
                            " by Source Type"))) + 
        facet_wrap(~type, nrow=2)
dev.off()
