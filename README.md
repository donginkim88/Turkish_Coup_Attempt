# Turkish_Coup_Attempt

## Intro
On July 15, 2016, a group of Turkish military officers attempted to overthrow the incumbent Erdogan administration which they accused of going against “the democratic and secular rule of law”. This coup attempt ended in failure as President Erdogan strategically occupied most of the major strategic facilities and streets in Ankara and Istanbul and public protestors promptly responded against the coup. This research examines how the military coup affected public interest in politics through quantitative text analysis. It conducts text mining and statistical analysis on a large-scale dataset using programming interface R and Python.

## Data and Methodology
The data used in this research is a subset of 1,582,778 geo-located tweets in Turkey from July 10 to July 23, 2016, extracted by using Twitter streaming API. Each of the tweets contains a set of information which includes textual contents, hashtags, geo-coordinates and a timestamp of when that tweets were posted. 
Within this dataset, political and non-political keywords were searched, and the results were aggregated by date to detect day-to-day changes in the frequency of the keywords. 
The frequencies of political keywords before and after the coup d’état were measured as a way to predict public interest in politics. 
The frequencies of non-political keywords were tested as controlled variables in which political elements were minimized, hence differentiating the predictor variables from other non-political interests.

## Figures
![TR_erdogan_kemal](/figures/TR_erdogan_kemal.pdf)
![TR_party](/figures/TR_party.pdf)
![TR_Football](/figures/TR_Football.pdf)
