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