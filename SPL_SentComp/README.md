
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MSMasymptoticnormality2** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet : SPL_SentComp

Published in : SPL

Description : 'A comparison between sentiment analysis of Trumps Tweets in the period of the 7th of septemper 2017 to the 2nd of February 2018. The figure shows 4 Sentiment analysis which have ben ran with different sentiment lexicons. Each plot represents total scores of Tweets (sum of positive and negative words for each Tweet) for each day. Note that one day can contain several Tweets why it both can take positive and negative values.'

Keywords : 
- sentiment analysis
- text mining
- ggplot2
- student
- visualisation
- statistics

Author : Asbjoern Kamp Johannesen

Submitted : Wed, February 21 2018 by Asbjoern Kamp Johannesen

Datafile : 'Hu_and_Liu.Rdata, TrumpTweets.Rdata'

```

![Picture1](SentComp.png)


### R Code:
```r

rm(list = ls())

load("Hu_and_Liu.csv")

# Get data
library("twitteR")
consumerKey = "OzPjAMbWrU3P9mj2G1IP6uTDo"
consuemrSecret = "KOc6nB1nuUEYt1OPgkstbs6m7nJjjkFMTXK3GOg1nenPynhavZ"
accessToken = "3032742052-DBynC4JFEChlKnmbnDvTRstaEofU8XoRPdA7lQJ"
accessTokenSecret = "6H8zTIijSqKAnWDVo5YQ0tZnErEJxuTQShQ7pOavEC8ij"
setup_twitter_oauth(consumerKey, consuemrSecret, accessToken, accessTokenSecret)
1
trump.tweets = userTimeline("realDonaldTrump", n = 3200, excludeReplies = FALSE, includeRts = FALSE)
df = do.call("rbind", lapply(trump.tweets, as.data.frame))

#The command above contains the newest Tweets. For exact repliacation of the figure, one needs to use same time span as we did. It this is the case, load this dataframe. If not, skip this part.
load("TrumpTweets.Rdata")

#Clean data 
library("tidytext")
library("dplyr")
df$text = sapply(df$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)
df$date = format(as.Date(df$created), "%y-%m-%d")
df$time = format(df$created, "%H:%M:%S")
tf = df %>% unnest_tokens(word, text, drop = FALSE) %>% anti_join(stop_words)

# Get Lexicons and combine them
library("tidyr")

afinn = tf %>% inner_join(get_sentiments("afinn")) %>% group_by(index = text) %>% summarise(afisent = sum(score))

bing = tf %>% inner_join(get_sentiments("bing")) %>% count(index = text, sentiment) %>% spread(sentiment, n, fill = 0) %>% 
    mutate(binsent = positive - negative) %>% select(-positive) %>% select(-negative)

nrc = tf %>% inner_join(get_sentiments("nrc")) %>% filter(sentiment %in% c("positive", "negative")) %>% count(index = text, 
    sentiment) %>% spread(sentiment, n, fill = 0) %>% mutate(nrcsent = positive - negative) %>% select(-positive) %>% select(-negative)

# Merge these into a dateframe and add time
SentFrame = merge(afinn, bing, all = TRUE, by = c("index"))
SentFrame = merge(SentFrame, nrc, all = TRUE, by = c("index"))
SentFrame = merge(SentFrame, Hu_and_Liu, all = TRUE, by = c("index"))
a = df
a$index = a$text
a = a[, -c(1:16)]
a = a[, -2]
SentFrame = merge(SentFrame, a, by = c("index"))
SentFrame[is.na(SentFrame)] = 0

# Plot these together
library("ggplot2")
library("ggpubr")
Afinn = ggplot(data = SentFrame, aes(x = date, y = afisent)) + theme_classic() + geom_col() + theme(axis.title.x = element_blank()) + labs(y = "Afinn")
Bing = ggplot(data = SentFrame, aes(x = date, y = binsent)) + theme_classic() + geom_col() + theme(axis.title.x = element_blank()) + labs(y = "Bing et al.")
NRC = ggplot(data = SentFrame, aes(x = date, y = nrcsent)) + theme_classic() + geom_col() + theme(axis.title.x = element_blank()) + labs(y = "NRC")
HuLiu = ggplot(data = SentFrame, aes(x = date, y = hulsent)) + theme_classic() + geom_col() + theme(axis.text.x = element_text(angle = 90)) + 
    labs(y = "Hu and Liu", x = "Date")
ggarrange(Afinn + rremove("x.text"), Bing + rremove("x.text"), NRC + rremove("x.text"), HuLiu, ncol = 1, nrow = 4)

```
