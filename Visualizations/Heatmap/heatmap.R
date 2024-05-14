library(ggplot2)
library(dplyr) 
library(viridis) 
library(lubridate) 
library(ggExtra)
library(tidyr)

setwd("~/Documents/Portfolio")

df <- read.csv("test1.csv")

data <- df %>%
  filter(YEAR %in% c(1993, 2023))

data$MO[data$MO == "1"] <- "Jan"
data$MO[data$MO == "2"] <- "Feb"
data$MO[data$MO == "3"] <- "Mar"
data$MO[data$MO == "4"] <- "Apr"
data$MO[data$MO == "5"] <- "May"
data$MO[data$MO == "6"] <- "Jun"
data$MO[data$MO == "7"] <- "Jul"
data$MO[data$MO == "8"] <- "Aug"
data$MO[data$MO == "9"] <- "Sep"
data$MO[data$MO == "10"] <- "Oct"
data$MO[data$MO == "11"] <- "Nov"
data$MO[data$MO == "12"] <- "Dec"

data$MO <- factor(data$MO, levels = month.abb)

statno <-unique(data$stationid)

p <-ggplot(data,aes(MO,DY, fill=T2M))+
  geom_tile(color= "white",size=0.1) + 
  scale_fill_viridis(name="Daily Temps in °C",option ="C")
p <-p + facet_wrap(~YEAR, ncol = 1)
p <-p + scale_y_continuous(breaks =c(1,10,20,31))
p <-p + scale_x_continuous(breaks = 1:12, labels = month.abb,)
p <-p + theme_minimal(base_size = 8)
p <-p + labs(title= paste("Average Daily Temparature of Dhaka",statno), x="Month", y="Day",
             subtitle = paste("Author:", author_name, "\nData Source:", data_source))
p <-p + theme(legend.position = "bottom")+
  theme(plot.title=element_text(size = 14))+
  theme(axis.text.y=element_text(size=6)) +
  theme(strip.background = element_rect(colour="white"))+
  theme(plot.title=element_text(hjust=0))+
  theme(axis.ticks=element_blank())+
  theme(axis.text=element_text(size=7))+
  theme(legend.title=element_text(size=8))+
  theme(legend.text=element_text(size=6))+
  removeGridX()
p




author_name <- "Niamul Hasan Saad"
data_source <- "NASA/POWER CERES/MERRA2 Native Resolution Daily Data"


