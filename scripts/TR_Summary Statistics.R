install.packages("psych")
library(psych)
library(ggplot2)

data <- read.csv("/Users/DonginKim/Dropbox/Censorship/Data/TR_2014-03-01_2014-04-17_Aggregated.csv")
colnames(data) = c("x","date","tweets")


summary(tweets, na.rm=TRUE)
describe(data$tweets)
sum(tweets)

data$date <- as.Date(data$date)
censorship <- as.numeric(as.Date('2016-07-15'))

ggplot(data, aes(date, tweets)) + 
  theme_calc() +
  scale_color_calc() +
  geom_line() +
  geom_point(size=1) +
  scale_x_date(date_labels="%d", date_breaks="1 day") +
  scale_y_continuous() +
  geom_vline(xintercept=censorship,linetype=5,lwd=.5) + 
  geom_text(aes(x=(as.Date('2016-07-14')), label="Coup", y=150000), colour="black", angle=90)
