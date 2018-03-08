
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SPL_SentAnalysis** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet : SPL_SentAnalysis

Published in : SPL

Description : 'A Sentiment Analysis used to score tweets (but potentially any other kind of text string), with inspiration from https://github.com/Twitter-Sentiment-Analysis/R'

Keywords : 
- text mining
- frequency
- sentiment analysis
- student
- quantifying text
- statistics

Author : Jakob Lyngsø Jørgensen

Submitted : Thu, March 8 2018 by Jakob Lyngsø Jørgensen

Datafile : 'Trump.Tweets.WC.Rdata'

```

### R Code:
```r

rm(list = ls())

#Download packages
library(twitteR)

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

##-----Analytical Work------

##Data Cleaning - Removing odd characters
df$text = sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)

##Define Lexicons Used
positive.lexicon = scan("C:/Users/jakob/Documents/Humboldt/SPL/positive-words.txt", what="character", comment.char=";")
negative.lexicon = scan("C:/Users/jakob/Documents/Humboldt/SPL/negative-words.txt", what="character", comment.char=";")

# Add own neg/pos words
positive.lexicon =c(positive.lexicon,'upgrade')
negative.lexicon = c(negative.lexicon,"WTF", 'FAKE NEWS', 'douchebag')

##Sentiment Score Function
require("plyr")
require("stringr")

sentimentAnalysisFunction = function(strings, positive.lexicon, negative.lexicon, .progress="none")
{
  list=lapply(strings, function(one.string, positive.lexicon, negative.lexicon)
  {
    #Remove punctuation
    one.string = gsub("[[:punct:]]"," ",one.string)
    #Remove control characters
    one.string = gsub("[[:cntrl:]]","",one.string)
    #Remove numbers (\d+ is regEx)
    one.string = gsub("\\d+","",one.string)
    #Remove linebreaks (\n is regEx)
    one.string = gsub("\n","",one.string)                     
    
    #Data transformation
    #Changing to all lowercase letters
    one.string = tolower(one.string)
    #Step 1/2: Taking each word and make list
    word.list = str_split(one.string, "\\s+")
    #Step 2/2: Transform to character vector
    words = unlist(word.list)                                 
     
    #Word Matching and sentiment scoring
    #Match positive (vector and pos.lexicon)
    positive.matches = match(words, positive.lexicon)
    #Match negative (vector and neg.lexicon)
    negative.matches = match(words, negative.lexicon)
    #Change to match=TRUE, NA=FALSE
    positive.matches = !is.na(positive.matches)               
    negative.matches = !is.na(negative.matches)
    #Sum up matches
    sum.positive.matches = sum(positive.matches)              
    sum.negative.matches = sum(negative.matches)
    #Calculate sentiment score
    score = sum(positive.matches) - sum(negative.matches)
    #Make vector of score and mathces
    list1=c(score, sum.positive.matches, sum.negative.matches)
    return (list1)
  }, positive.lexicon, negative.lexicon)
   
  #Data transformation to output format
  #Take first coloumn from list
  score_new=lapply(list, "[[", 1)
  #Take second coloumn from list
  sum.positive.matches1=score=lapply(list, "[[", 2)
  #Take Third coloumn from list
  sum.negative.matches1=score=lapply(list, "[[", 3)           
  
  #Make dataframe of score and tweets
  total.scores.df = data.frame(score=score_new, text=strings) 
  #Make df of positive matches and tweets
  total.positive.df = data.frame(Positive=sum.positive.matches1, text=strings)
  #make df of negative matches and tweets
  total.negative.df = data.frame(Negative=sum.negative.matches1, text=strings)
  
  #Combine above dataframe into a list of three elements
  list_df=list(total.scores.df, total.positive.df, total.negative.df)
  return(list_df)
}
```
