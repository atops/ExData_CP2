library(dplyr)
library(tidyr)
library(ggplot2)
library(graphics)

setwd("~/Dropbox/Coursera/Expl_Data_Anal_CP2")
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df
SCC <- readRDS("Source_Classification_Code.rds") %>% tbl_df

# 4. Across the US, how have emissions from coal
#    combustion-related sources changed from 1999-2008?
coalscc <- SCC %>%
        filter(grepl("Coal", EI.Sector)) %>%
        select(SCC)

coaldf2 <- NEI %>% 
        filter(SCC %in% unique(coalscc$SCC)) %>%
        group_by(year) %>% 
        summarize(totem = sum(Emissions)) %>%
        arrange(year)

png(filename = "plot4.png")
qplot(data=coaldf2, 
      x=year, 
      y=totem, 
      geom="line", 
      xlab="Year", 
      ylab=expression(paste(PM[2.5]," (tons)")),
      main=expression(paste("Total ", 
                            PM[2.5], 
                            " Emissions from Coal")))
dev.off()
