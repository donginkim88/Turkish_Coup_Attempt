# This script is based on the tweet data in Turkey from 7/10 to 7/23 geolocated tweets

# Import libraries
library(ggplot2)
library(dplyr)
library(lubridate)
library(reshape2)
library(ggthemes)

# Loading datasets
AKP_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_AKP.csv")
CHP_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_CHP.csv")
MHP_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_MHP.csv")
HDP_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_HDP.csv")

# AKP data
names(AKP_data) <- c("dummy", "tweet_created_at")  # Create column names
AKP_data <- AKP_data["tweet_created_at"]
AKP_data$tweet_created_at <- as.POSIXct(AKP_data$tweet_created_at, format="%H %B %d, %Y")
#New_AKP_data$tweet_created_at <- AKP_data[AKP_data$tweet_created_at %within% int,]
AKP_data$date <- as.Date(AKP_data$tweet_created_at, format="%H %B %d, %Y")
AKP_data$hour <- as.POSIXct(AKP_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
AKP_data$hour <- format(AKP_data$hour, "%R")  # Convert date to date time 
AKP_data$count <- 1
#date1 <- as.POSIXct("2016-01-01 02:00:00")
#date2 <- as.POSIXct("2016-11-01 02:00:00")
#int <- interval(date1, date2)

# Aggregate by date
AKP_agg <- AKP_data %>% group_by(date) %>% summarize(tweets = sum(count))
AKP_agg <- as.data.frame(AKP_agg)


# CHP data
names(CHP_data) <- c("dummy", "tweet_created_at")  # Create column names
CHP_data <- CHP_data["tweet_created_at"]
CHP_data$tweet_created_at <- as.POSIXct(CHP_data$tweet_created_at, format="%H %B %d, %Y")
CHP_data$date <- as.Date(CHP_data$tweet_created_at, format="%H %B %d, %Y")
CHP_data$hour <- as.POSIXct(CHP_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
CHP_data$hour <- format(CHP_data$hour, "%R")  # Convert date to date time 
CHP_data$count <- 1

# Aggregate by date
CHP_agg <- CHP_data %>% group_by(date) %>% summarize(tweets = sum(count))
CHP_agg <- as.data.frame(CHP_agg)

# MHP data
names(MHP_data) <- c("dummy", "tweet_created_at")  # Create column names
MHP_data <- MHP_data["tweet_created_at"]
MHP_data$tweet_created_at <- as.POSIXct(MHP_data$tweet_created_at, format="%H %B %d, %Y")
MHP_data$date <- as.Date(MHP_data$tweet_created_at, format="%H %B %d, %Y")
MHP_data$hour <- as.POSIXct(MHP_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
MHP_data$hour <- format(MHP_data$hour, "%R")  # Convert date to date time 
MHP_data$count <- 1

# Aggregate by date
MHP_agg <- MHP_data %>% group_by(date) %>% summarize(tweets = sum(count))
MHP_agg <- as.data.frame(MHP_agg)


# HDP data
names(HDP_data) <- c("dummy", "tweet_created_at")  # Create column names
HDP_data <- HDP_data["tweet_created_at"]
HDP_data$tweet_created_at <- as.POSIXct(HDP_data$tweet_created_at, format="%H %B %d, %Y")
HDP_data$date <- as.Date(HDP_data$tweet_created_at, format="%H %B %d, %Y")
HDP_data$hour <- as.POSIXct(HDP_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
HDP_data$hour <- format(HDP_data$hour, "%R")  # Convert date to date time 
HDP_data$count <- 1

# Aggregate by date
HDP_agg <- HDP_data %>% group_by(date) %>% summarize(tweets = sum(count))
HDP_agg <- as.data.frame(HDP_agg)


# Melting four dataframes into one
new_agg <- melt(list(p1 = AKP_agg, p2 = CHP_agg, p3 = MHP_agg, p4 = HDP_agg), id.vars = c("date","tweets"))
new_agg <- new_agg[new_agg$date >= as.Date('2016-07-10') & new_agg$date <= as.Date('2016-07-23'),]

# ggplot with legend
censorship <- as.numeric(as.Date(('2016-07-15')))

pdf('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_party.pdf')
png('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_party.png')

ggplot(new_agg, aes(date, tweets, colour = L1)) +
  theme_calc() +
  scale_color_calc() +
  theme(plot.title = element_text(size=15, face="bold", hjust=0.5, margin=margin(8,0,8,0))) +
  labs(title="Figure3: Political Parties", x="July 2016", y="Tweets") + 
  geom_line() +
  geom_point(size=1) +
  geom_vline(xintercept=censorship,linetype=5,lwd=.5) + 
  geom_text(aes(x=(as.Date('2016-07-15')), label="Coup", y=0.8*1600), colour="grey30") +
  scale_x_date(date_labels="%d", date_breaks="1 day") +
  scale_y_continuous(limits=c(0,1600), expand=c(0,0)) +
  scale_colour_manual("Keyword", values = c("p1"="red2","p2"="blue1", "p3"="orange1", "p4"="steelblue2"), labels=c("AKP", "CHP", "MHP", "HDP" ))

dev.off() 


# Summary Statistics

#AKP
AKP_agg <- AKP_agg[AKP_agg$date >= as.Date('2016-07-10') & AKP_agg$date <= as.Date('2016-07-23'),]
describe(AKP_agg$tweets)

# Before-5-days
before_akp_agg <- AKP_agg[AKP_agg$date < as.Date('2016-07-15'),]
describe(before_akp_agg$tweets)
sum(before_akp_agg$tweets)
# After-5-days
after_akp_agg <- AKP_agg[AKP_agg$date >= as.Date('2016-07-15') & AKP_agg$date <= as.Date('2016-07-20'),]
describe(after_akp_agg$tweets)
sum(after_akp_agg$tweets)


#CHP
CHP_agg <- CHP_agg[CHP_agg$date >= as.Date('2016-07-10') & CHP_agg$date <= as.Date('2016-07-23'),]
describe(CHP_agg$tweets)

# Before-5-days
before_chp_agg <- CHP_agg[CHP_agg$date < as.Date('2016-07-15'),]
describe(before_chp_agg$tweets)
sum(before_chp_agg$tweets)
# After-5-days
after_chp_agg <- CHP_agg[CHP_agg$date >= as.Date('2016-07-15') & CHP_agg$date <= as.Date('2016-07-20'),]
describe(after_chp_agg$tweets)
sum(after_chp_agg$tweets)

#MHP
MHP_agg <- MHP_agg[MHP_agg$date >= as.Date('2016-07-10') & MHP_agg$date <= as.Date('2016-07-23'),]
describe(MHP_agg$tweets)

# Before-5-days
before_mhp_agg <- MHP_agg[MHP_agg$date < as.Date('2016-07-15'),]
describe(before_mhp_agg$tweets)
sum(before_mhp_agg$tweets)
# After-5-days
after_mhp_agg <- MHP_agg[MHP_agg$date >= as.Date('2016-07-15') & MHP_agg$date <= as.Date('2016-07-20'),]
describe(after_mhp_agg$tweets)
sum(after_mhp_agg$tweets)

#HDP
HDP_agg <- HDP_agg[HDP_agg$date >= as.Date('2016-07-10') & HDP_agg$date <= as.Date('2016-07-23'),]
describe(HDP_agg$tweets)

# Before-5-days
before_hdp_agg <- HDP_agg[HDP_agg$date < as.Date('2016-07-15'),]
describe(before_hdp_agg$tweets)
sum(before_hdp_agg$tweets)
# After-5-days
after_hdp_agg <- HDP_agg[HDP_agg$date >= as.Date('2016-07-15') & HDP_agg$date <= as.Date('2016-07-20'),]
describe(after_hdp_agg$tweets)
sum(after_hdp_agg$tweets)

