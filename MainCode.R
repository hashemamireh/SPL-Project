rm(list=ls())
setwd("~/Documents/Humboldt/Statistical Programmin Languange")

require("twitteR")
require("plyr")
require("dplyr")
require("stringr")
require("reshape")
require("ggplot2")
require("wordcloud")
require("tm")
require("Hmisc")
require("dummies")
library("tidytext")
library("tidyr")
library("scales")
library("stargazer")

#When generating data you will get the newest data avaible
#If the reader wants to do an exact repliaction of our paper, use the uploaded data files instead of generating the data from Twitter

#Setup authorization
consumerKey = "OzPjAMbWrU3P9mj2G1IP6uTDo"
consuemrSecret =	"KOc6nB1nuUEYt1OPgkstbs6m7nJjjkFMTXK3GOg1nenPynhavZ"
accessToken = "3032742052-DBynC4JFEChlKnmbnDvTRstaEofU8XoRPdA7lQJ"
accessTokenSecret = "6H8zTIijSqKAnWDVo5YQ0tZnErEJxuTQShQ7pOavEC8ij"
setup_twitter_oauth(consumerKey, consuemrSecret, accessToken, accessTokenSecret)
1

#Geet Trumps Tweets (Max limit 3200: 418 own tweets, the rest is Trumps retweets) - Estracted 20 Feb
trump.tweets=userTimeline("realDonaldTrump", n=3200,excludeReplies=FALSE,includeRts=FALSE)
df = do.call("rbind", lapply(trump.tweets, as.data.frame))

#Cleaning data
df$text = sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)

#Judge if comment is negativ or positiv using Hu and Liu Opinion Lexicon
positive.lexicon = scan("/Users/asbjornk.johannesen/Documents/Humboldt/Statistical Programmin Languange/positive-words.txt", what="character", comment.char=";")
negative.lexicon = scan("/Users/asbjornk.johannesen/Documents/Humboldt/Statistical Programmin Languange/negative-words.txt", what="character", comment.char=";")

# Add "own neg/pos words"
positive.lexicon = c(positive.lexicon,'upgrade')
negative.lexicon = c(negative.lexicon,'crooked', 'fake', 'Fake News','foxandfriends')

#Run sentiment analysis
sentimentAnalysisFunction = function(strings, positive.lexicon, negative.lexicon, .progress="none")
{
  require("plyr")
  require("stringr")
  list=lapply(strings, function(one.string, positive.lexicon, negative.lexicon)
  {
    one.string = gsub("[[:punct:]]"," ",one.string)
    one.string = gsub("[[:cntrl:]]","",one.string)
    one.string = gsub("\\d+","",one.string)
    one.string = gsub("\n","",one.string)
    
    one.string = tolower(one.string)
    word.list = str_split(one.string, "\\s+")
    words = unlist(word.list)
    positive.matches = match(words, positive.lexicon)
    negative.matches = match(words, negative.lexicon)
    positive.matches = !is.na(positive.matches)
    negative.matches = !is.na(negative.matches)
    sum.positive.matches=sum(positive.matches)
    sum.negative.matches = sum(negative.matches)
    score = sum(positive.matches) - sum(negative.matches)
    list1=c(score, sum.positive.matches, sum.negative.matches)
    return (list1)
  }, positive.lexicon, negative.lexicon)
  score_new=lapply(list, "[[", 1)
  sum.positive.matches1=score=lapply(list, "[[", 2)
  sum.negative.matches1=score=lapply(list, "[[", 3)
  
  total.scores.df = data.frame(score=score_new, text=strings)
  total.positive.df = data.frame(Positive=sum.positive.matches1, text=strings)
  total.negative.df = data.frame(Negative=sum.negative.matches1, text=strings)
  
  list_df=list(total.scores.df, total.positive.df, total.negative.df)
  return(list_df)
}

result = sentimentAnalysisFunction(df$text, positive.lexicon, negative.lexicon)
View(result)

result1=result[[1]]
result2=result[[2]]
result3=result[[3]]

#Creating three different data frames for Score, Positive and Negative
#Now the text vector - that is, the vector storing the actual tweets is removed from each data frame
result1$text=NULL
result2$text=NULL
result3$text=NULL

#The first row, which stores the result of the sentiment analysis, is saved in vector senti
senti1=result1[1,]
senti2=result2[1,]
senti3=result3[1,]
score1=melt(senti1, ,var='Score')
positive2=melt(senti2, ,var='Positive')
negative3=melt(senti3, ,var='Negative') 
score1['Score'] = NULL
positive2['Positive'] = NULL
negative3['Negative'] = NULL

#Creating 3 data frames - one for the positive and negative scores, and one for the sum (score)
table1 = data.frame(Text=result[[1]]$text, Score=score1)
table2 = data.frame(Text=result[[2]]$text, Score=positive2)
table3 = data.frame(Text=result[[3]]$text, Score=negative3)

#The 3 data frames are now merged into one
Hu_and_Liu=data.frame(index=table1$Text, hulsent=table1$value)

################### MOST FREQUENT WORDS  ##########################
#Split date and time
df$date=format(as.Date(df$created),"%y-%m-%d")
df$time=format(df$created,"%H:%M:%S")

#%>%? related to dplyr - pass the LHS to the first argument of the RHS (in this case, include next code)
#edit data
tf=df %>%
  #Set up tidy format
  unnest_tokens(word, text,drop=FALSE) %>%
  #remove stopwords (exstremely common words not interesting for a text analysis: (the,a,and,...)
  anti_join(stop_words)

#now, make the graph with ggplot2 ()
library(ggplot2)
tf %>%
  count(word, sort = TRUE)        %>%
  filter(n > 10)                  %>%
  filter(!word=="amp")            %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  ylab(label="Frequency")+
  coord_flip()+
  theme_classic()

######################### FREQUENCY AND COMPARISON TO OTHER PRESIDENTS/CANDIDATES ################################
#Get data on Obama, Clinton and Bernie sanders and clean them (same apprach as explained earlier)
obama.tweets=userTimeline("BarackObama", n=3200,excludeReplies=FALSE,includeRts=FALSE)
dfo = do.call("rbind", lapply(obama.tweets, as.data.frame))
dfo$text = sapply(dfo$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
dfo$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", dfo$text)
tfo=dfo %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

clinton.tweets=userTimeline("HillaryClinton", n=3200,excludeReplies=FALSE,includeRts=FALSE)
dfc = do.call("rbind", lapply(clinton.tweets, as.data.frame))
dfc$text = sapply(dfc$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
dfc$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", dfc$text)
tfc=dfc %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

sanders.tweets=userTimeline("BernieSanders", n=3200,excludeReplies=FALSE,includeRts=FALSE)
dfs = do.call("rbind", lapply(sanders.tweets, as.data.frame))
dfs$text = sapply(dfs$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
dfs$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", dfs$text)
tfs=dfs %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

#Get frequency info
  frequency = bind_rows(                            #1
    mutate(tf, president = "Donald Trump"),
    mutate(tfc, president = "Hillary Clinton"), 
    mutate(tfo, president = "Barack Obama"),
    mutate(tfs, president = "Bernie Sanders"),) %>%
  count(president, word)                        %>% #3                                     
  filter(!n<2)                                  %>% #4
  filter(!word=="amp")                          %>% #5
  group_by(president)                           %>% #6
  mutate(proportion = n / sum(n))               %>% #7 
  select(-n)                                    %>% #8
  spread(president, proportion)                 

#Corralation matrix
freq_data = frequency[,2:length(frequency)]
stargazer(cor(freq_data, use = "pairwise.complete.obs"),type = "latex",title="Correlation Matrix For Presidents/Presedential Candidates",no.space=TRUE,align=TRUE,digits=2)

######################### SENTIMENT COMPARISON ################################ 
afinn =tf %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = text) %>% 
  summarise(afisent = sum(score))

bing=tf %>%
  inner_join(get_sentiments("bing")) %>%
  count(index = text, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(binsent = positive - negative)%>%
  select(-positive) %>%
  select(-negative)

nrc=tf %>% 
  inner_join(get_sentiments("nrc")) %>% 
  filter(sentiment %in% c("positive","negative")) %>%
  count(index = text, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(nrcsent = positive - negative)%>%
  select(-positive)%>%
  select(-negative)

#Merge these into a dateframe and add time
SentFrame=merge(afinn,bing,all=TRUE, by=c("index"))
SentFrame=merge(SentFrame,nrc,all=TRUE, by=c("index"))
SentFrame=merge(SentFrame,Hu_and_Liu,all=TRUE, by=c("index"))
a=df
a$index=a$text
a=a[, -c(1:16)] 
a=a[, -2] 
SentFrame=merge(SentFrame,a, by=c("index"))
SentFrame[is.na(SentFrame)]=0

#Descriptive statististics
stargazer(SentFrame[,c("afisent","binsent","nrcsent","hulsent")],type="latex",title="Describtive Statistics: different lexicons",
          no.space=TRUE,align=TRUE,digits=2,float=TRUE)

#Count positive and negative wordsand add these manually to the table above
get_sentiments("nrc") %>% 
  filter(sentiment %in% c("positive","negative")) %>% 
  count(sentiment)
get_sentiments("bing") %>% 
  count(sentiment)
get_sentiments("afinn") %>% 
  count(score>0)
NROW(positive.lexicon)
NROW(negative.lexicon)

#Plot these together
library("ggplot2")
library("ggpubr")
Afinn=ggplot(data = SentFrame, aes(x = date, y = afisent)) +geom_col()+theme_classic()+theme(axis.title.x=element_blank())+labs(y="Afinn")
Bing=ggplot(data = SentFrame, aes(x = date, y = binsent)) +geom_col()+theme_classic()+theme(axis.title.x=element_blank())+labs(y="Bing et al.")
NRC=ggplot(data = SentFrame, aes(x = date, y = nrcsent)) +geom_col()+theme_classic()+theme(axis.title.x=element_blank())+labs(y="NRC")
HuLiu=ggplot(data = SentFrame, aes(x = date, y = hulsent))+geom_col()+theme_classic()+theme(axis.text.x  = element_text(angle=90))+labs(y="Hu and Liu",x="Date")
ggarrange(Afinn+rremove("x.text"), Bing + rremove("x.text"),NRC+rremove("x.text"),HuLiu,ncol = 1, nrow = 4)


ggplot(data = SentFrame, aes(x = date, y = hulsent))+geom_col()+theme_classic()+theme(axis.text.x  = element_text(angle=90))+labs(y="Hu and Liu",x="Date")


###############################  ECONEMETRIC ANALYSIS ##############################
#MAKING DUMMIES
#Merge data
df$index=df$text
MainData=merge(SentFrame,df,by="index")

#to get a better overview, remove unused dataframes
rm(negative3,positive2, result1, result2,result3,score1,senti1,senti2,senti3,table1,table2,table3,tf,tfc, tfo, tfs,nrc,Hu_and_Liu,dfs,dfo,dfc,bing,afinn,a)
$ner=as.numeric(MainData$time >= "09:00:00" & MainData$time <="11:59:59")
MainData$afternoon=as.numeric(MainData$time >= "12:00:00" & MainData$time <="17:59:59")
MainData$evening=as.numeric(MainData$time >= "18:00:00" & MainData$time <="23:59:59")

#Generate time of day variable
MainData$time.of.the.day[MainData$night=="1"]="night"
MainData$time.of.the.day[MainData$morning=="1"]="morning"
MainData$time.of.the.day[MainData$before.dinner=="1"]="before.dinner"
MainData$time.of.the.day[MainData$afternoon=="1"]="afternoon"
MainData$time.of.the.day[MainData$evening=="1"]="evening"

#Generate data of which advice the tweet was written on
MainData$source[MainData$statusSource=="<a href=\"http://twitter.com/#!/download/ipad\" rel=\"nofollow\">Twitter for iPad</a>"]="ipad"
MainData$source[MainData$statusSource=="<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>"]="iphone"
MainData$source[MainData$statusSource=="<a href=\"http://twitter.com\" rel=\"nofollow\">Twitter Web Client</a>"]="twitter.web.client"
MainData$source[MainData$statusSource=="<a href=\"https://studio.twitter.com\" rel=\"nofollow\">Media Studio</a>"]="media.studio"

#Making dummies presenting on which advice the tweet was written on
MainData$ipad=as.numeric(MainData$source=="ipad")
MainData$iphone=as.numeric(MainData$source=="iphone")
MainData$twitter.web.client=as.numeric(MainData$source=="twitter.web.client")
MainData$media.studio=as.numeric(MainData$source=="media.studio")

#Regression:
library("stargazer")

#Iphone as refference
afisent1=lm(afisent ~ ipad + media.studio + twitter.web.client, data=MainData)
binsent1=lm(nrcsent ~ ipad + media.studio + twitter.web.client, data=MainData)
nrcsent1=lm(nrcsent ~ ipad + media.studio + twitter.web.client, data=MainData)
hulsent1=lm(hulsent ~ ipad + media.studio + twitter.web.client, data=MainData)
stargazer(afisent1,binsent1,nrcsent1,hulsent1, data=MainData,type="text")

stargazer(afisent1,binsent1,nrcsent1,hulsent1,
          title="Device regression analysis - iphone as refference cathegory",type="text",no.space=TRUE,align=TRUE,
          digits=2,float=TRUE,covariate.labels=c("Ipad","Media Studio","Web Client","Constant"),omit.stat=c("f","ser"),column.labels=c("Sentiment","Sentiment","Sentiment","Sentiment"),
          dep.var.labels=c("Afinn","Bing et al.","NRC","Hu and Liu"))

#evening as refference
afisent2=lm(afisent ~ night+ morning + evening + afternoon, data=MainData)
binsent2=lm(binsent ~ night+ morning + evening + afternoon, data=MainData)
nrcsent2=lm(nrcsent ~ night+ morning + evening + afternoon, data=MainData)
hulsent2=lm(hulsent ~ night+ morning + evening + afternoon, data=MainData)
stargazer(afisent2,binsent2,nrcsent2,hulsent2, data=MainData,type="text")

stargazer(afisent2,binsent2,nrcsent2,hulsent2,
          title="Time of the day regression analysis - before dinner as refference cathegory",type="latex",no.space=TRUE,align=TRUE,
          digits=2,float=TRUE,omit.stat=c("f","ser"),covariate.labels=c("Night","Morning","Evening","Afternoon","Constant"),column.labels=c("Sentiment","Sentiment","Sentiment","Sentiment")
          ,dep.var.labels=c("Afinn","Bing et al.","NRC","Hu and Liu"))

