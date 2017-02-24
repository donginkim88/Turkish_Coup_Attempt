library(ggplot2)
library(dplyr)
library(lubridate)
library(reshape2)
library(ggthemes)

# based on the tweet data in Turkey from 7/10 to 7/22

football_data <- read.csv("/Users/DonginKim/Desktop/Turkey Project/TR_football.csv")
besiktas_data <- read.csv("/Users/DonginKim/Desktop/Turkey Project/TR_besiktas.csv")
fenerbahce_data <- read.csv("/Users/DonginKim/Desktop/Turkey Project/TR_fenerbahce.csv")
galatasaray_data <- read.csv("/Users/DonginKim/Desktop/Turkey Project/TR_galatasaray.csv")

# football_data
names(football_data) <- c("dummy", "tweet_created_at")  # Create column names
football_data <- football_data["tweet_created_at"]

football_data$tweet_created_at <- as.POSIXct(football_data$tweet_created_at, format="%H %B %d, %Y")
#New_football_data$tweet_created_at <- football_data[football_data$tweet_created_at %within% int,]

football_data$date <- as.Date(football_data$tweet_created_at, format="%H %B %d, %Y")
football_data$hour <- as.POSIXct(football_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
football_data$hour <- format(football_data$hour, "%R")  # Convert date to date time 
football_data$count <- 1

#date1 <- as.POSIXct("2016-01-01 02:00:00")
#date2 <- as.POSIXct("2016-11-01 02:00:00")
#int <- interval(date1, date2)

football_agg <- football_data %>% group_by(date) %>% summarize(tweets = sum(count))
football_agg <- as.data.frame(football_agg)


# besiktas_data 
names(besiktas_data) <- c("dummy", "tweet_created_at")  # Create column names
besiktas_data <- besiktas_data["tweet_created_at"]

besiktas_data$tweet_created_at <- as.POSIXct(besiktas_data$tweet_created_at, format="%H %B %d, %Y")

besiktas_data$date <- as.Date(besiktas_data$tweet_created_at, format="%H %B %d, %Y")
besiktas_data$hour <- as.POSIXct(besiktas_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
besiktas_data$hour <- format(besiktas_data$hour, "%R")  # Convert date to date time 
besiktas_data$count <- 1

besiktas_agg <- besiktas_data %>% group_by(date) %>% summarize(tweets = sum(count))
besiktas_agg <- as.data.frame(besiktas_agg)

# fenerbahce_data

names(fenerbahce_data) <- c("dummy", "tweet_created_at")  # Create column names
fenerbahce_data <- fenerbahce_data["tweet_created_at"]

fenerbahce_data$tweet_created_at <- as.POSIXct(fenerbahce_data$tweet_created_at, format="%H %B %d, %Y")

fenerbahce_data$date <- as.Date(fenerbahce_data$tweet_created_at, format="%H %B %d, %Y")
fenerbahce_data$hour <- as.POSIXct(fenerbahce_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
fenerbahce_data$hour <- format(fenerbahce_data$hour, "%R")  # Convert date to date time 
fenerbahce_data$count <- 1

fenerbahce_agg <- fenerbahce_data %>% group_by(date) %>% summarize(tweets = sum(count))
fenerbahce_agg <- as.data.frame(fenerbahce_agg)


# galatasaray_data

names(galatasaray_data) <- c("dummy", "tweet_created_at")  # Create column names
galatasaray_data <- galatasaray_data["tweet_created_at"]

galatasaray_data$tweet_created_at <- as.POSIXct(galatasaray_data$tweet_created_at, format="%H %B %d, %Y")

galatasaray_data$date <- as.Date(galatasaray_data$tweet_created_at, format="%H %B %d, %Y")
galatasaray_data$hour <- as.POSIXct(galatasaray_data$tweet_created_at, format="%H %B %d, %Y")  # Convert to PoSIXct
galatasaray_data$hour <- format(galatasaray_data$hour, "%R")  # Convert date to date time 
galatasaray_data$count <- 1

galatasaray_agg <- galatasaray_data %>% group_by(date) %>% summarize(tweets = sum(count))
galatasaray_agg <- as.data.frame(galatasaray_agg)


# Melting two dataframe into one
new_agg <- melt(list(p1 = football_agg, p2 = besiktas_agg, p3 = fenerbahce_agg, p4 = galatasaray_agg), id.vars = c("date","tweets"))
new_agg <- new_agg[new_agg$date >= as.Date('2016-07-10') & new_agg$date <= as.Date('2016-07-23'),]



# ggplot with legend
censorship <- as.numeric(as.Date(('2016-07-15')))

pdf('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_Football.pdf')
png('/Users/DonginKim/Desktop/Git/Turkish_Coup_Attempt/figures/TR_Football.png')

ggplot(new_agg, aes(date, tweets, colour = L1)) +
  theme_calc() +
  scale_color_calc() +
  theme(plot.title = element_text(size=15, face="bold", hjust=0.5, margin=margin(8,0,8,0))) +
  labs(title="Figure4: Football", x="July 2016", y="Tweets") + 
  geom_line() +
  geom_point(size=1) +
  geom_vline(xintercept=censorship,linetype=5,lwd=.5) + 
  geom_text(aes(x=(as.Date('2016-07-15')), label="Coup", y=0.8*1600), colour="grey30") +
  scale_x_date(date_labels="%d", date_breaks="1 day") +
  scale_y_continuous(limits=c(0,1600), expand=c(0,0)) +
  scale_colour_manual("Keyword", values = c("p1"="red2","p2"="blue1", "p3"="orange1", "p4"="steelblue2"), labels=c("Football", "Besiktas", "Fenerbahce", "Galatasaray" ))

dev.off() 

# Summary Statistics

# Football
football_agg <- football_agg[football_agg$date >= as.Date('2016-07-10') & football_agg$date <= as.Date('2016-07-23'),]
describe(football_agg$tweets)
# Before-5-days
before_football_agg <- football_agg[football_agg$date < as.Date('2016-07-15'),]
describe(before_football_agg$tweets)
sum(before_football_agg$tweets)
# After-5-days
after_football_agg <- football_agg[football_agg$date >= as.Date('2016-07-15') & football_agg$date <= as.Date('2016-07-20'),]
describe(after_football_agg$tweets)
sum(after_football_agg$tweets)

# Besik
besiktas_agg <- besiktas_agg[besiktas_agg$date >= as.Date('2016-07-10') & besiktas_agg$date <= as.Date('2016-07-23'),]
describe(besiktas_agg$tweets)
# Before-5-days
before_besik_agg <- besiktas_agg[besiktas_agg$date < as.Date('2016-07-15'),]
describe(before_besik_agg$tweets)
sum(before_besik_agg$tweets)
# After-5-days
after_besik_agg <- besiktas_agg[besiktas_agg$date >= as.Date('2016-07-15') & besiktas_agg$date <= as.Date('2016-07-20'),]
describe(after_besik_agg$tweets)
sum(after_besik_agg$tweets)

# Fener
fenerbahce_agg <- fenerbahce_agg[fenerbahce_agg$date >= as.Date('2016-07-10') & fenerbahce_agg$date <= as.Date('2016-07-23'),]
describe(fenerbahce_agg$tweets)
# Before-5-days
before_fener_agg <- fenerbahce_agg[fenerbahce_agg$date < as.Date('2016-07-15'),]
describe(before_fener_agg$tweets)
sum(before_fener_agg$tweets)
# After-5-days
after_fener_agg <- fenerbahce_agg[fenerbahce_agg$date >= as.Date('2016-07-15') & fenerbahce_agg$date <= as.Date('2016-07-20'),]
describe(after_fener_agg$tweets)
sum(after_fener_agg$tweets)

# Gala
galatasaray_agg <- galatasaray_agg[galatasaray_agg$date >= as.Date('2016-07-10') & galatasaray_agg$date <= as.Date('2016-07-23'),]
describe(galatasaray_agg$tweets)
# Before-5-days
before_gala_agg <- galatasaray_agg[galatasaray_agg$date < as.Date('2016-07-15'),]
describe(before_gala_agg$tweets)
sum(galatasaray_agg$tweets)
# After-5-days
after_gala_agg <- galatasaray_agg[galatasaray_agg$date >= as.Date('2016-07-15') & galatasaray_agg$date <= as.Date('2016-07-20'),]
describe(after_gala_agg$tweets)
sum(after_gala_agg$tweets)


# set 5-days after the coup
after_football_agg <- football_agg[football_agg$date >= as.Date('2016-07-15') & football_agg$date <= as.Date('2016-07-19'),]
after_besik_agg <- besiktas_agg[besiktas_agg$date >= as.Date('2016-07-15') & besiktas_agg$date <= as.Date('2016-07-19'),]
after_fener_agg <- fenerbahce_agg[fenerbahce_agg$date >= as.Date('2016-07-15') & fenerbahce_agg$date <= as.Date('2016-07-19'),]
after_gala_agg <- galatasaray_agg[galatasaray_agg$date >= as.Date('2016-07-15') & galatasaray_agg$date <= as.Date('2016-07-19'),]


# normality test
mean(after_gala_agg$tweets) - mean(before_gala_agg$tweets)

boxplot(after_gala_agg$tweets - before_gala_agg$tweets)
hist(after_gala_agg$tweets - before_gala_agg$tweets)
qqnorm(after_gala_agg$tweets - before_gala_agg$tweets)
qqline(after_gala_agg$tweets - before_gala_agg$tweets)

shapiro.test(after_gala_agg$tweets - before_gala_agg$tweets) # larger than 0.05 - follow normal dist.
shapiro.test(after_erdogan_agg$tweets - before_erdogan_agg$tweets) # larger than 0.05 - follow normal dist.
# if smaller than 0.05 - not follow normality/ no t-test

wilcox.test(after_football_agg$tweets, before_football_agg$tweets, paired=TRUE, conf.level = 0.1)
wilcox.test(after_besik_agg$tweets, before_besik_agg$tweets, paired=TRUE, conf.level = 0.1)
wilcox.test(after_fener_agg$tweets, before_fener_agg$tweets, paired=TRUE, conf.level = 0.1)
wilcox.test(after_gala_agg$tweets, before_gala_agg$tweets, paired=TRUE, conf.level = 0.1)
