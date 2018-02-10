# 2016 Turkish Coup D’état Attempt and Its Effects on Public Interest in Politics 

## Intro
On July 15, 2016, a group of Turkish military officers attempted to overthrow the incumbent Erdogan administration which they accused of going against “the democratic and secular rule of law”. This coup attempt ended in failure as President Erdogan strategically occupied most of the major strategic facilities and streets in Ankara and Istanbul and public protestors promptly responded against the coup. This research examines how the military coup affected public interest in politics through quantitative text analysis. It conducts text mining and statistical analysis on a large-scale dataset using programming interface R and Python.

* Please read [Wikipedia: 2016 Turkish coup d'état attempt](https://en.wikipedia.org/wiki/2016_Turkish_coup_d%27%C3%A9tat_attempt) for details on the Coup.

## Data and Methodology
The data used in this research is a subset of 1,582,778 geo-located tweets in Turkey from July 10 to July 23, 2016, extracted by using Twitter streaming API. Each of the tweets contains a set of information which includes textual contents, hashtags, geo-coordinates and a timestamp of when that tweets were posted. 
Within this dataset, political and non-political keywords were searched, and the results were aggregated by date to detect day-to-day changes in the frequency of the keywords. 
The frequencies of political keywords before and after the coup d’état were measured as a way to predict public interest in politics. 
The frequencies of non-political keywords were tested as controlled variables in which political elements were minimized, hence differentiating the predictor variables from other non-political interests.

## Summary Statistics
Summary statistics of the data employed in this research:
![Summary Statistics](/Figures/Summary_statistics.png)


## Figures
Figure 1 shows the number of Tweets mentioning the two keywords ‘Erdogan’ and ‘Kemal’ on a timeline with the vertical dotted line indicating the date of the coup attempt
![TR_erdogan_kemal](/figures/TR_erdogan_kemal.png)


In Table 3 and Figure 2, the number of Tweets for Erdogan and Kemal after the coup were compared with the equivalent of July 10th. By dividing each of the after- frequency data by the before-frequency data (July 10th), it shows how many more times the words were shared on Twitter in the days after the coup compared to their usual frequency.

![Odds Ratio](/Figures/Odds_ratio.png) 


![TR_odds_ratio](/figures/TR_Odds_Ratio.png)


In Figure 3, the significant effect of the coup d’état on the Tweets is observed and graphed, which shows that Twitter users shared more Tweets about the Turkish political parties on the date of and following the coup than on other days.
![TR_party](/figures/TR_party.png)


Figure 4 shows that the number of Tweets mentioning the four major football teams in Turkey on a timeline to test the validity of exclusive influence of the coup attempt on people’s interest in political subjects on Twitter. 
![TR_Football](/figures/TR_Football.png)
