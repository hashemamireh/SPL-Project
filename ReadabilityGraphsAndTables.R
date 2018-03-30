load("SubredditsReadability.RData")
load("SpeechesAndDebates.RData")
load("TweetReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in  "ReadabilityAnalysis.R"
# and then processed further in "SubredditCalcAverage.R"
# It creates graphs in different combinations to to able to view the results easily and make comparisons.

# Correct Spelling
Tweets.Trump.Readability= Tweets.Trump.Readaibility

library(ggplot2)
library(formatR)
library(xtable)

index = The_Donald.Readability[c(1:3,5,9,12:25,27),1]

#Debates

intDebate1.Clinton = cbind(as.numeric(summary(Debate1.Clinton.Readability)[,3]), as.numeric(summary(Debate1.Clinton.Readability)[,4]))
Debate1.Clinton = c(intDebate1.Clinton[1:3,2], intDebate1.Clinton[5,1], intDebate1.Clinton[9,1], intDebate1.Clinton[12:16,2],
                     intDebate1.Clinton[17,1], intDebate1.Clinton[18:21,2], intDebate1.Clinton[22,1], intDebate1.Clinton[23:24,2],
                     intDebate1.Clinton[25,1], intDebate1.Clinton[27,1])

intDebate1.Trump = cbind(as.numeric(summary(Debate1.Trump.Readability)[,3]), as.numeric(summary(Debate1.Trump.Readability)[,4]))
Debate1.Trump = c(intDebate1.Trump[1:3,2], intDebate1.Trump[5,1], intDebate1.Trump[9,1], intDebate1.Trump[12:16,2],
                     intDebate1.Trump[17,1], intDebate1.Trump[18:21,2], intDebate1.Trump[22,1], intDebate1.Trump[23:24,2],
                     intDebate1.Trump[25,1], intDebate1.Trump[27,1])

intDebate2.Clinton = cbind(as.numeric(summary(Debate2.Clinton.Readability)[,3]), as.numeric(summary(Debate2.Clinton.Readability)[,4]))
Debate2.Clinton = c(intDebate2.Clinton[1:3,2], intDebate2.Clinton[5,1], intDebate2.Clinton[9,1], intDebate2.Clinton[12:16,2],
                     intDebate2.Clinton[17,1], intDebate2.Clinton[18:21,2], intDebate2.Clinton[22,1], intDebate2.Clinton[23:24,2],
                     intDebate2.Clinton[25,1], intDebate2.Clinton[27,1])

intDebate2.Trump = cbind(as.numeric(summary(Debate2.Trump.Readability)[,3]), as.numeric(summary(Debate2.Trump.Readability)[,4]))
Debate2.Trump = c(intDebate2.Trump[1:3,2], intDebate2.Trump[5,1], intDebate2.Trump[9,1], intDebate2.Trump[12:16,2],
                   intDebate2.Trump[17,1], intDebate2.Trump[18:21,2], intDebate2.Trump[22,1], intDebate2.Trump[23:24,2],
                   intDebate2.Trump[25,1], intDebate2.Trump[27,1])

intDebate3.Clinton = cbind(as.numeric(summary(Debate3.Clinton.Readability)[,3]), as.numeric(summary(Debate3.Clinton.Readability)[,4]))
Debate3.Clinton = c(intDebate3.Clinton[1:3,2], intDebate3.Clinton[5,1], intDebate3.Clinton[9,1], intDebate3.Clinton[12:16,2],
                     intDebate3.Clinton[17,1], intDebate3.Clinton[18:21,2], intDebate3.Clinton[22,1], intDebate3.Clinton[23:24,2],
                     intDebate3.Clinton[25,1], intDebate3.Clinton[27,1])

intDebate3.Trump = cbind(as.numeric(summary(Debate3.Trump.Readability)[,3]), as.numeric(summary(Debate3.Trump.Readability)[,4]))
Debate3.Trump = c(intDebate3.Trump[1:3,2], intDebate3.Trump[5,1], intDebate3.Trump[9,1], intDebate3.Trump[12:16,2],
                   intDebate3.Trump[17,1], intDebate3.Trump[18:21,2], intDebate3.Trump[22,1], intDebate3.Trump[23:24,2],
                   intDebate3.Trump[25,1], intDebate3.Trump[27,1])

# Speeches

intSpeeches.Clinton = cbind(as.numeric(summary(Speeches.Clinton.Readability)[,3]), as.numeric(summary(Speeches.Clinton.Readability)[,4]))
Speeches.Clinton = c(intSpeeches.Clinton[1:3,2], intSpeeches.Clinton[5,1], intSpeeches.Clinton[9,1], intSpeeches.Clinton[12:16,2],
                     intSpeeches.Clinton[17,1], intSpeeches.Clinton[18:21,2], intSpeeches.Clinton[22,1], intSpeeches.Clinton[23:24,2],
                     intSpeeches.Clinton[25,1], intSpeeches.Clinton[27,1])

intSpeeches.Trump = cbind(as.numeric(summary(Speeches.Trump.Readability)[,3]), as.numeric(summary(Speeches.Trump.Readability)[,4]))
Speeches.Trump = c(intSpeeches.Trump[1:3,2], intSpeeches.Trump[5,1], intSpeeches.Trump[9,1], intSpeeches.Trump[12:16,2],
                   intSpeeches.Trump[17,1], intSpeeches.Trump[18:21,2], intSpeeches.Trump[22,1], intSpeeches.Trump[23:24,2],
                   intSpeeches.Trump[25,1], intSpeeches.Trump[27,1])

intSpeeches.Sanders = cbind(as.numeric(summary(Speeches.Sanders.Readability)[,3]), as.numeric(summary(Speeches.Sanders.Readability)[,4]))
Speeches.Sanders = c(intSpeeches.Sanders[1:3,2], intSpeeches.Sanders[5,1], intSpeeches.Sanders[9,1], intSpeeches.Sanders[12:16,2],
                    intSpeeches.Sanders[17,1], intSpeeches.Sanders[18:21,2], intSpeeches.Sanders[22,1], intSpeeches.Sanders[23:24,2],
                    intSpeeches.Sanders[25,1], intSpeeches.Sanders[27,1])

# Twitter

intTweets.Clinton = cbind(as.numeric(summary(Tweets.Clinton.Readability)[,3]), as.numeric(summary(Tweets.Clinton.Readability)[,4]))
Tweets.Clinton = c(intTweets.Clinton[1:3,2], intTweets.Clinton[5,1], intTweets.Clinton[9,1], intTweets.Clinton[12:16,2],
                      intTweets.Clinton[17,1], intTweets.Clinton[18:21,2], intTweets.Clinton[22,1], intTweets.Clinton[23:24,2],
                      intTweets.Clinton[25,1], intTweets.Clinton[27,1])

intTweets.Trump = cbind(as.numeric(summary(Tweets.Trump.Readability)[,3]), as.numeric(summary(Tweets.Trump.Readability)[,4]))
Tweets.Trump = c(intTweets.Trump[1:3,2], intTweets.Trump[5,1], intTweets.Trump[9,1], intTweets.Trump[12:16,2],
                    intTweets.Trump[17,1], intTweets.Trump[18:21,2], intTweets.Trump[22,1], intTweets.Trump[23:24,2],
                    intTweets.Trump[25,1], intTweets.Trump[27,1])

intTweets.Sanders = cbind(as.numeric(summary(Tweets.Sanders.Readability)[,3]), as.numeric(summary(Tweets.Sanders.Readability)[,4]))
Tweets.Sanders = c(intTweets.Sanders[1:3,2], intTweets.Sanders[5,1], intTweets.Sanders[9,1], intTweets.Sanders[12:16,2],
                      intTweets.Sanders[17,1], intTweets.Sanders[18:21,2], intTweets.Sanders[22,1], intTweets.Sanders[23:24,2],
                      intTweets.Sanders[25,1], intTweets.Sanders[27,1])

intTweets.Obama = cbind(as.numeric(summary(Tweets.Obama.Readability)[,3]), as.numeric(summary(Tweets.Obama.Readability)[,4]))
Tweets.Obama = c(intTweets.Obama[1:3,2], intTweets.Obama[5,1], intTweets.Obama[9,1], intTweets.Obama[12:16,2],
                  intTweets.Obama[17,1], intTweets.Obama[18:21,2], intTweets.Obama[22,1], intTweets.Obama[23:24,2],
                  intTweets.Obama[25,1], intTweets.Obama[27,1])

# Subreddits

# This section is done deifferently since the data has a different structure when it was it initially altered to
# generate the means in "SubredditCalcAverage.R" script

intSubreddit.The_Donald = cbind(The_Donald.Readability[,2], The_Donald.Readability[,3])
Subreddit.The_Donald = c(intSubreddit.The_Donald[1:3,2], intSubreddit.The_Donald[5,1], intSubreddit.The_Donald[9,1], intSubreddit.The_Donald[12:16,2],
                  intSubreddit.The_Donald[17,1], intSubreddit.The_Donald[18:21,2], intSubreddit.The_Donald[22,1], intSubreddit.The_Donald[23:24,2],
                  intSubreddit.The_Donald[25,1], intSubreddit.The_Donald[27,1])

intSubreddit.HillaryClinton = cbind(HillaryClinton.Readability[,2], HillaryClinton.Readability[,3])
Subreddit.HillaryClinton = c(intSubreddit.HillaryClinton[1:3,2], intSubreddit.HillaryClinton[5,1], intSubreddit.HillaryClinton[9,1], intSubreddit.HillaryClinton[12:16,2],
                          intSubreddit.HillaryClinton[17,1], intSubreddit.HillaryClinton[18:21,2], intSubreddit.HillaryClinton[22,1], intSubreddit.HillaryClinton[23:24,2],
                          intSubreddit.HillaryClinton[25,1], intSubreddit.HillaryClinton[27,1])

intSubreddit.SandersForPresident = cbind(SandersForPresident.Readability[,2], SandersForPresident.Readability[,3])
Subreddit.SandersForPresident = c(intSubreddit.SandersForPresident[1:3,2], intSubreddit.SandersForPresident[5,1], intSubreddit.SandersForPresident[9,1], intSubreddit.SandersForPresident[12:16,2],
                          intSubreddit.SandersForPresident[17,1], intSubreddit.SandersForPresident[18:21,2], intSubreddit.SandersForPresident[22,1], intSubreddit.SandersForPresident[23:24,2],
                          intSubreddit.SandersForPresident[25,1], intSubreddit.SandersForPresident[27,1])

intSubreddit.Resist = cbind(Resist.Readability[,2], Resist.Readability[,3])
Subreddit.Resist = c(intSubreddit.Resist[1:3,2], intSubreddit.Resist[5,1], intSubreddit.Resist[9,1], intSubreddit.Resist[12:16,2],
                          intSubreddit.Resist[17,1], intSubreddit.Resist[18:21,2], intSubreddit.Resist[22,1], intSubreddit.Resist[23:24,2],
                          intSubreddit.Resist[25,1], intSubreddit.Resist[27,1])

# Correct Data Types and Rounding
Debate1.Clinton = as.numeric(Debate1.Clinton)
Debate2.Clinton = as.numeric(Debate2.Clinton)
Debate3.Clinton = as.numeric(Debate3.Clinton)
Debate1.Trump = as.numeric(Debate1.Trump)
Debate2.Trump = as.numeric(Debate2.Trump)
Debate3.Trump = as.numeric(Debate3.Trump)
Speeches.Clinton = as.numeric(Speeches.Clinton)
Speeches.Trump = as.numeric(Speeches.Trump)
Speeches.Sanders = as.numeric(Speeches.Sanders)
Tweets.Trump = as.numeric(Tweets.Trump)
Tweets.Clinton = as.numeric(Tweets.Clinton)
Tweets.Sanders = as.numeric(Tweets.Sanders)
Tweets.Obama = as.numeric(Tweets.Obama)

Subreddit.The_Donald = round(as.numeric(Subreddit.The_Donald),2)
Subreddit.HillaryClinton = round(as.numeric(Subreddit.HillaryClinton),2)
Subreddit.SandersForPresident = round(as.numeric(Subreddit.SandersForPresident),2)
Subreddit.Resist = round(as.numeric(Subreddit.Resist),2)


# Generate Numerical Tables to be Used for Graphs

Debate1.Table = data.frame(Algorithm = index, Clinton = Debate1.Clinton, Trump = Debate1.Trump)
Debate2.Table = data.frame(Algorithm = index, Clinton = Debate2.Clinton, Trump = Debate2.Trump)
Debate3.Table = data.frame(Algorithm = index, Clinton = Debate3.Clinton, Trump = Debate3.Trump)
Speeches.Table = data.frame(Algorithm = index, Clinton = Speeches.Clinton, Trump = Speeches.Trump, Sanders = Speeches.Sanders)
Tweets.Table = data.frame(Algorithm = index, Clinton = Tweets.Clinton, Trump = Tweets.Trump, Sanders = Tweets.Sanders, Obama = Tweets.Obama)
Reddit.Table = data.frame(Algorithm = index, HillaryClintonSubreddit = Subreddit.HillaryClinton,
                           The_DonaldSubreddit = Subreddit.The_Donald,
                           SandersForPresidentSubreddit = Subreddit.SandersForPresident,
                           ResistSubreddit = Subreddit.Resist)
Trump.Table = data.frame(Algorithm = index, The_DonaldSubreddit = Subreddit.The_Donald, Speeches = Speeches.Trump,
                          Dabate1 = Debate1.Trump, Dabate2 = Debate2.Trump, Dabate3 = Debate3.Trump)
Clinton.Table = data.frame(Algorithm = index, HillaryClintonSubreddit = Subreddit.HillaryClinton, Speeches = Speeches.Clinton,
                          Dabate1 = Debate1.Clinton, Dabate2 = Debate2.Clinton, Dabate3 = Debate3.Clinton)
Sanders.Table = data.frame(Algorithm = index, SandersForPresidentSubreddit = Subreddit.SandersForPresident, Speeches = Speeches.Sanders)

DebatesSpeeches.Table = data.frame(Algorithm = index, Clinton = Debate1.Clinton, Trump = Debate1.Trump,
                        Clinton = Debate2.Clinton, Trump = Debate2.Trump,
                        Clinton = Debate3.Clinton, Trump = Debate3.Trump,
                        Clinton = Speeches.Clinton, Trump = Speeches.Trump, Sanders = Speeches.Sanders)

# Generate Tables to be Used for Graphs

Debate1.Data = data.frame(Algorithm = c(index,index),
                           Source = c(rep.int("Clinton",20),rep.int("Trump",20)),
                           Score = c(Debate1.Clinton, Debate1.Trump))

Debate2.Data = data.frame(Algorithm = c(index,index),
                           Source = c(rep.int("Clinton",20),rep.int("Trump",20)),
                           Score = c(Debate2.Clinton, Debate2.Trump))

Debate3.Data = data.frame(Algorithm = c(index,index),
                           Source = c(rep.int("Clinton",20),rep.int("Trump",20)),
                           Score = c(Debate3.Clinton, Debate3.Trump))

Speeches.Data = data.frame(Algorithm = c(index,index,index),
                           Source = c(rep.int("Clinton",20),rep.int("Trump",20),rep.int("Sanders",20)),
                           Score = c(Speeches.Clinton, Speeches.Trump,Speeches.Sanders))

Tweets.Data = data.frame(Algorithm = c(index,index,index,index),
                            Source = c(rep.int("Clinton",20),rep.int("Trump",20),rep.int("Sanders",20), rep.int("Obama",20)),
                            Score = c(Tweets.Clinton, Tweets.Trump,Tweets.Sanders,Tweets.Obama))

Reddit.Data = data.frame(Algorithm = c(index,index,index,index),
                         Source = c(rep.int("'HillaryClinton'",20),rep.int("'The_Donald'",20),rep.int("'SandersForPresident'",20), rep.int("'Resist'",20)),
                         Score = c(Subreddit.HillaryClinton, Subreddit.The_Donald,Subreddit.SandersForPresident,Subreddit.Resist))

Trump.Data = data.frame(Algorithm = c(index,index,index, index, index),
                            Source = c(rep.int("'The_Donald' Subreddit",20),rep.int("Speeches",20),rep.int("Debate1",20),
                                       rep.int("Debate2",20), rep.int("Debate3",20)),
                            Score = c(Subreddit.The_Donald, Speeches.Trump,Debate1.Trump,Debate2.Trump,Debate3.Trump))

Clinton.Data = data.frame(Algorithm = c(index,index,index, index, index),
                         Source = c(rep.int("'HillaryClinton' Subreddit",20),rep.int("Speeches",20),rep.int("Debate1",20),
                                    rep.int("Debate2",20), rep.int("Debate3",20)),
                         Score = c(Subreddit.HillaryClinton, Speeches.Clinton,Debate1.Clinton,Debate2.Clinton,Debate3.Clinton))

Sanders.Data = data.frame(Algorithm = c(index,index),
                            Source = c(rep.int("SandersForPresident Subreddit",20),rep.int("Speeches",20)),
                            Score = c(Subreddit.SandersForPresident, Speeches.Sanders))

    
                        
# Generate Graphs


Debate1.Graph = ggplot(Debate1.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('First Debate') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
#theme(panel.background = element_rect(fill = "transparent"))

Debate2.Graph = ggplot(Debate2.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Second Debate') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
#theme(panel.background = element_rect(fill = "transparent"))

Debate3.Graph = ggplot(Debate3.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Third Debate') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
#theme(panel.background = element_rect(fill = "transparent"))

Speeches.Graph = ggplot(Speeches.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Campaign Speeches') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
#theme(panel.background = element_rect(fill = "transparent"))

Tweets.Graph = ggplot(Tweets.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Politicians Twitter Accounts') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
#theme(panel.background = element_rect(fill = "transparent"))

Reddit.Graph = ggplot(Reddit.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Subreddits') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic() +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
#theme(panel.background = element_rect(fill = "transparent"))

Trump.Graph = ggplot(Trump.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Trump Supporters on Reddit and Trumps Speeches/Debates') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic() +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
#theme(panel.background = element_rect(fill = "transparent"))

Clinton.Graph = ggplot(Clinton.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Clinton Supporters on Reddit and Clinton Speeches/Debates') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic() +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
#theme(panel.background = element_rect(fill = "transparent"))
Sanders.Graph = ggplot(Sanders.Data, aes(Source, Score)) +
  geom_bar(stat="identity") + 
  xlab('Sanders Supporters on Reddit and Sanders Speeches') +
  facet_wrap(~Algorithm, ncol=2, scales = "free_y")+
  theme_classic()
  #theme(panel.background = element_rect(fill = "transparent"))

Debate1.Graph
Debate2.Graph
Debate3.Graph
Speeches.Graph
Tweets.Graph
Reddit.Graph
Trump.Graph
Clinton.Graph
Sanders.Graph

# Latex table for apendecies

xtable(DebatesSpeeches.Table, type = "latex", caption = "Readability Scores for Debates and Speeches")
xtable(Tweets.Table, type = "latex", caption = "Readability Scores for Politician's Tweets")
xtable(Reddit.Table, type = "latex", caption = "Readability Scores for Subreddits")
