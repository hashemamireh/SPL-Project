
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SPL_WordCloud** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet : SPL_WordCloudTrump

Published in : SPL

Description : 'A word cloud on the most recent tweets of President Donald Trump from the 8th of March and 5 months back'

Keywords : 
- text mining
- word cloud
- student
- visualisation
- amazing

Author : Jakob Lyngsø Jørgensen

Submitted : Thu, March 8 2018 by Jakob Lyngsø Jørgensen

Datafile : 'Trump.Tweets.WC.Rdata'

```

![Picture1](SPL_WordCloud.png)


### R Code:
```r

rm(list = ls())

#Download packages
library(twitteR)
library(wordcloud)
library(tm)

#API keys and tokens are generated here: https://apps.twitter.com/
consumerKey = "MwfIc4YZdGtFFylMUVFKYoGmE"
consuemrSecret =	"sTZ41t2jWhuI9LyGr8NjXMoK4gvGvJrhsmj5m8s4wVPznBVCY7"
accessToken = "2189862760-0bLvEQgo4nPQIptGTfc4LQPBCP6b8W219cSvwWS"
accessTokenSecret = "rP0r1S0zism7tRnqNJwGSPN6Js3p5snEKAfEAmIiqCQ5I"

#Setup authorization
setup_twitter_oauth(consumerKey, consuemrSecret, accessToken, accessTokenSecret)

#Get Trump Tweets
trump.tweets=userTimeline("realDonaldTrump", n=3200,excludeReplies=FALSE,includeRts=FALSE)
df = do.call("rbind", lapply(trump.tweets, as.data.frame))

Trump.Tweets.WC <- df
save(Trump.Tweets.WC,file="Trump.Tweets.WC.Rdata")


#Clean Data
df_text = sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))

#Turns the tweets into class "documents"
df_corpusClass = Corpus(VectorSource(df_text))

#Clean text
df_cleaned = tm_map(df_corpusClass, removeNumbers) #Remvove numbers
df_cleaned = tm_map(df_cleaned, removePunctuation) #Remove punctuation
df_cleaned = tm_map(df_cleaned, content_transformer(tolower)) #Make capitalized letters lower case
df_cleaned = tm_map(df_cleaned, removeWords, stopwords("english")) #Remove most common english words
df_cleaned = tm_map(df_cleaned, stripWhitespace) #Remove white spaces

#produce word cloud
wordcloud(df_cleaned, random.order=F,max.words=300, col=rainbow(50), scale=c(4,0.5))
