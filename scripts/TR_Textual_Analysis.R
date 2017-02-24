library(ggplot2)
library(dplyr)
library(lubridate)
library(reshape2)
library(ggthemes)
library(psych)

# based on the tweet data in Turkey from 7/10 to 7/23
# geolocated tweets


erdogan_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_erdogan.csv")
kemal_data <- read.csv("/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/keywords/TR_kemal.csv")


# Erdogan 
names(erdogan_data) <- c("dummy", "tweet_created_at")  # Create column names
erdogan_data <- erdogan_data["tweet_created_at"]

erdogan_data$tweet_created_at <- as.POSIXct(erdogan_data$tweet_created_at, format="%H %B %d, %Y")
#New_erdogan_data$tweet_created_at <- erdogan_data[erdogan_data$tweet_created_at %within% int,]

erdogan_data$date <- as.Date(erdogan_data$tweet_created_at, format="%H %B %d, %Y")
erdogan_data$hour <- as.POSIXct(erdogan_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
erdogan_data$hour <- format(erdogan_data$hour, "%R")  # Convert date to date time 
erdogan_data$count <- 1

#date1 <- as.POSIXct("2016-01-01 02:00:00")
#date2 <- as.POSIXct("2016-11-01 02:00:00")
#int <- interval(date1, date2)

erdogan_agg <- erdogan_data %>% group_by(date) %>% summarize(tweets = sum(count))
erdogan_agg <- as.data.frame(erdogan_agg)


# Kemal 
names(kemal_data) <- c("dummy", "tweet_created_at")  # Create column names
kemal_data <- kemal_data["tweet_created_at"]

kemal_data$tweet_created_at <- as.POSIXct(kemal_data$tweet_created_at, format="%H %B %d, %Y")

kemal_data$date <- as.Date(kemal_data$tweet_created_at, format="%H %B %d, %Y")
kemal_data$hour <- as.POSIXct(kemal_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
kemal_data$hour <- format(kemal_data$hour, "%R")  # Convert date to date time 
kemal_data$count <- 1

kemal_agg <- kemal_data %>% group_by(date) %>% summarize(tweets = sum(count))
kemal_agg <- as.data.frame(kemal_agg)

# Melting two dataframe into one
new_agg <- melt(list(p1 = erdogan_agg, p2 = kemal_agg), id.vars = c("date","tweets"))
new_agg <- new_agg[new_agg$date >= as.Date('2016-07-10') & new_agg$date <= as.Date('2016-07-23'),]

# ggplot with legend
censorship <- as.numeric(as.Date(('2016-07-15')))

pdf('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_erdogan_kemal.pdf')
png('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_erdogan_kemal.png')

ggplot(new_agg, aes(date, tweets, colour = L1)) + 
  theme_calc() +
  scale_color_calc() +
  theme(plot.title = element_text(size=15, face="bold", hjust=0.5, margin=margin(8,0,8,0))) +
  labs(title="Figure1: Erdogan vs. Kemal", x="July 2016", y="Tweets") + 
  geom_line() +
  geom_point(size=1) +
  geom_vline(xintercept=censorship,linetype=5,lwd=.5) + 
  geom_text(aes(x=(as.Date('2016-07-15')), label="Coup", y=0.8*1600), colour="black") +
  scale_x_date(date_labels="%d", date_breaks="1 day") +
  scale_y_continuous(limits=c(0,1600)) +
  scale_colour_manual("Keyword", values = c("p1"="red","p2"="blue"), labels=c("Erdogan", "Kemal"))

dev.off() 




# Odds Ratio

  h_agg <- data %>%
  group_by(hour) %>%
  summarize(tweets = sum(count), retweets = sum(retweet), mentions = sum(mention), hashtags = sum(hashtag), followers = mean(user_followers_count))

five_before <- new_agg[new_agg$date == as.Date('2016-07-10'),]
erdogan_before <- five_before[five_before$L1=="p1","tweets"]
kemal_before <- five_before[five_before$L1=="p2","tweets"]

after15 <- new_agg[new_agg$date == as.Date('2016-07-15'),]
erdogan_after15 <- after15[five_before$L1=="p1","tweets"]
kemal_after15 <- after15[five_before$L1=="p2","tweets"]

after16 <- new_agg[new_agg$date == as.Date('2016-07-16'),]
erdogan_after16 <- after16[five_before$L1=="p1","tweets"]
kemal_after16 <- after16[five_before$L1=="p2","tweets"]

after17 <- new_agg[new_agg$date == as.Date('2016-07-17'),]
erdogan_after17 <- after17[five_before$L1=="p1","tweets"]
kemal_after17 <- after17[five_before$L1=="p2","tweets"]

after18 <- new_agg[new_agg$date == as.Date('2016-07-18'),]
erdogan_after18 <- after18[five_before$L1=="p1","tweets"]
kemal_after18 <- after18[five_before$L1=="p2","tweets"]

after19 <- new_agg[new_agg$date == as.Date('2016-07-19'),]
erdogan_after19 <- after19[five_before$L1=="p1","tweets"]
kemal_after19 <- after19[five_before$L1=="p2","tweets"]

after20 <- new_agg[new_agg$date == as.Date('2016-07-20'),]
erdogan_after20 <- after20[five_before$L1=="p1","tweets"]
kemal_after20 <- after20[five_before$L1=="p2","tweets"]

after21 <- new_agg[new_agg$date == as.Date('2016-07-21'),]
erdogan_after21 <- after21[five_before$L1=="p1","tweets"]
kemal_after21 <- after21[five_before$L1=="p2","tweets"]

after22 <- new_agg[new_agg$date == as.Date('2016-07-22'),]
erdogan_after22 <- after22[five_before$L1=="p1","tweets"]
kemal_after22 <- after22[five_before$L1=="p2","tweets"]

after23 <- new_agg[new_agg$date == as.Date('2016-07-23'),]
erdogan_after23 <- after23[five_before$L1=="p1","tweets"]
kemal_after23 <- after23[five_before$L1=="p2","tweets"]


erdogan_after_data <- data.frame(tweets=c(erdogan_before, erdogan_after15, erdogan_after16, 
                                          erdogan_after17, erdogan_after18, erdogan_after19,
                                          erdogan_after20, erdogan_after21, erdogan_after22, 
                                          erdogan_after23))
erdogan_after_data <- t(erdogan_after_data)
d0 = erdogan_after_data[2]/erdogan_after_data[1]
d1 = erdogan_after_data[3]/erdogan_after_data[1]
d2 = erdogan_after_data[4]/erdogan_after_data[1]
d3 = erdogan_after_data[5]/erdogan_after_data[1]
d4 = erdogan_after_data[6]/erdogan_after_data[1]
d5 = erdogan_after_data[7]/erdogan_after_data[1]
d6 = erdogan_after_data[8]/erdogan_after_data[1] #############
d7 = erdogan_after_data[9]/erdogan_after_data[1] #
d8 = erdogan_after_data[10]/erdogan_after_data[1] #
er_odds_df <- data.frame(odds=c(d0,d1,d2,d3,d4,d5,d6,d7,d8))
x = seq(0,8,1)
g_range = range(0,er_odds_df$odds)


kemal_after_data <- data.frame(tweets=c(kemal_before, kemal_after15, kemal_after16, 
                                        kemal_after17, kemal_after18, kemal_after19,
                                        kemal_after20, kemal_after21, kemal_after22, 
                                        kemal_after23))
kemal_after_data <- t(kemal_after_data)
k0 = kemal_after_data[2]/kemal_after_data[1]
k1 = kemal_after_data[3]/kemal_after_data[1]
k2 = kemal_after_data[4]/kemal_after_data[1]
k3 = kemal_after_data[5]/kemal_after_data[1]
k4 = kemal_after_data[6]/kemal_after_data[1]
k5 = kemal_after_data[7]/kemal_after_data[1]
k6 = kemal_after_data[8]/kemal_after_data[1]
k7 = kemal_after_data[9]/kemal_after_data[1]
k8 = kemal_after_data[10]/kemal_after_data[1]
k_odds_df <- data.frame(odds=c(k0,k1,k2,k3,k4,k5,k6,k7,k8))
#x = seq(0,8,1)
#g_range = range(0,k_odds_df$odds)

odds_df <- cbind(er_odds_df, k_odds_df)
colnames(odds_df) <- c("Erdogan","Kemal")
rownames(odds_df) <- c("Day_0","Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7","Day_8")

frequency_data <- rbind(erdogan_after_data, kemal_after_data)
rownames(frequency_data) <- c("Erdogan", "Kemal")
colnames(frequency_data) <- c("10","15","16","17","18","19","20","21","22","23")


# Melting Erdogan and Kemal DF for Odds Ratio Plot
# Erdogan DF
days <- c(0,1,2,3,4,5,6,7,8)
days <- data.frame(days)
er_odds_df <- cbind(er_odds_df,days)
colnames(er_odds_df) <- c("Odds", "Date")
# Kemal DF
k_odds_df <- cbind(k_odds_df,days)
colnames(k_odds_df) <- c("Odds", "Date")

new_odds <- melt(list(p1 = er_odds_df, p2 = k_odds_df), id.vars = c("Odds","Date"))

# Odds Ratio ggplot with legend

pdf('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_Odds_Ratio.pdf')
png('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_Odds_Ratio.png')

ggplot(new_odds, aes(Date, Odds, colour = L1)) + 
  theme_calc() +
  scale_color_calc() +
  theme(plot.title = element_text(size=15, face="bold", hjust=0.5, margin=margin(8,0,8,0))) +
  labs(title="Figure2: Odds Ratio", x="July 2016", y="Odds") + 
  geom_point(size=1) +
  geom_line() +
  scale_x_continuous(breaks = 0:8, labels = c("15","16","17","18","19","20","21","22","23")) +
  scale_y_continuous() +
  geom_vline(xintercept=0,linetype=5,lwd=.5) + 
  geom_text(aes(x=0.1, label="Coup", y=0.8*22), colour="black") +
  scale_colour_manual("Keyword", values = c("p1"="red","p2"="blue"), labels=c("Erdogan", "Kemal"))

dev.off() 




# Summary Statistics

# Erdogan
erdogan_agg <- erdogan_agg[erdogan_agg$date >= as.Date('2016-07-10') & erdogan_agg$date <= as.Date('2016-07-23'),]
describe(erdogan_agg$tweets)
# Before-5-days
before_erdogan_agg <- erdogan_agg[erdogan_agg$date < as.Date('2016-07-15'),]
describe(before_erdogan_agg$tweets)
sum(before_erdogan_agg$tweets)
# After-5-days
after_erdogan_agg <- erdogan_agg[erdogan_agg$date >= as.Date('2016-07-15') & erdogan_agg$date <= as.Date('2016-07-19'),]
describe(after_erdogan_agg$tweets)
sum(after_erdogan_agg$tweets)


t.test(before_erdogan_agg$tweets, after_erdogan_agg$tweets, paired=TRUE, conf.level = 0.1)

# Kemal
kemal_agg <- kemal_agg[kemal_agg$date >= as.Date('2016-07-10') & kemal_agg$date <= as.Date('2016-07-23'),]
describe(kemal_agg$tweets)
# Before-5-days
before_kemal_agg <- kemal_agg[kemal_agg$date < as.Date('2016-07-15'),]
describe(before_kemal_agg$tweets)
sum(before_kemal_agg$tweets)
# After-5-days
after_kemal_agg <- kemal_agg[kemal_agg$date >= as.Date('2016-07-15') & kemal_agg$date <= as.Date('2016-07-19'),]
describe(after_kemal_agg$tweets)
sum(after_kemal_agg$tweets)

t.test(after_erdogan_agg$tweets, before_erdogan_agg$tweets, paired=TRUE, conf.level = 0.1)
t.test(after_kemal_agg$tweets, before_kemal_agg$tweets, paired=TRUE, conf.level = 0.1)

?t.test()
?wilcox.test()



# normality test
mean(after_erdogan_agg$tweets) - mean(before_erdogan_agg$tweets)

mean(after_kemal_agg$tweets) - mean(before_kemal_agg$tweets)
boxplot(after_kemal_agg$tweets - before_kemal_agg$tweets)
hist(after_kemal_agg$tweets - before_kemal_agg$tweets)
qqnorm(after_kemal_agg$tweets - before_kemal_agg$tweets)
qqline(after_kemal_agg$tweets - before_kemal_agg$tweets)

shapiro.test(after_kemal_agg$tweets - before_kemal_agg$tweets) # larger than 0.05 - follow normal dist.
shapiro.test(after_erdogan_agg$tweets - before_erdogan_agg$tweets) # larger than 0.05 - follow normal dist.
# if smaller than 0.05 - not follow normality/ no t-test

wilcox.test(after_erdogan_agg$tweets, before_erdogan_agg$tweets, paired=TRUE, conf.level = 0.1)
wilcox.test(after_kemal_agg$tweets, before_kemal_agg$tweets, paired=TRUE, conf.level = 0.1)
