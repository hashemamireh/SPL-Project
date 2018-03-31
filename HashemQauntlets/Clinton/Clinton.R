load("SubredditsReadability.RData")
load("SpeechesAndDebates.RData")
load("TweetReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

# Correct Spelling
Tweets.Clinton.Readability = Tweets.Clinton.Readaibility

library(ggplot2)
library(formatR)
library(xtable)

index = HillaryClinton.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Debates

intDebate1.Clinton = cbind(as.numeric(summary(Debate1.Clinton.Readability)[, 3]), as.numeric(summary(Debate1.Clinton.Readability)[, 4]))
Debate1.Clinton = c(intDebate1.Clinton[1:3, 2], intDebate1.Clinton[5, 1], intDebate1.Clinton[9, 1], intDebate1.Clinton[12:16, 2], intDebate1.Clinton[17, 1], intDebate1.Clinton[18:21, 
    2], intDebate1.Clinton[22, 1], intDebate1.Clinton[23:24, 2], intDebate1.Clinton[25, 1], intDebate1.Clinton[27, 1])


intDebate2.Clinton = cbind(as.numeric(summary(Debate2.Clinton.Readability)[, 3]), as.numeric(summary(Debate2.Clinton.Readability)[, 4]))
Debate2.Clinton = c(intDebate2.Clinton[1:3, 2], intDebate2.Clinton[5, 1], intDebate2.Clinton[9, 1], intDebate2.Clinton[12:16, 2], intDebate2.Clinton[17, 1], intDebate2.Clinton[18:21, 
    2], intDebate2.Clinton[22, 1], intDebate2.Clinton[23:24, 2], intDebate2.Clinton[25, 1], intDebate2.Clinton[27, 1])


intDebate3.Clinton = cbind(as.numeric(summary(Debate3.Clinton.Readability)[, 3]), as.numeric(summary(Debate3.Clinton.Readability)[, 4]))
Debate3.Clinton = c(intDebate3.Clinton[1:3, 2], intDebate3.Clinton[5, 1], intDebate3.Clinton[9, 1], intDebate3.Clinton[12:16, 2], intDebate3.Clinton[17, 1], intDebate3.Clinton[18:21, 
    2], intDebate3.Clinton[22, 1], intDebate3.Clinton[23:24, 2], intDebate3.Clinton[25, 1], intDebate3.Clinton[27, 1])

# Speeches

intSpeeches.Clinton = cbind(as.numeric(summary(Speeches.Clinton.Readability)[, 3]), as.numeric(summary(Speeches.Clinton.Readability)[, 4]))
Speeches.Clinton = c(intSpeeches.Clinton[1:3, 2], intSpeeches.Clinton[5, 1], intSpeeches.Clinton[9, 1], intSpeeches.Clinton[12:16, 2], intSpeeches.Clinton[17, 
    1], intSpeeches.Clinton[18:21, 2], intSpeeches.Clinton[22, 1], intSpeeches.Clinton[23:24, 2], intSpeeches.Clinton[25, 1], intSpeeches.Clinton[27, 1])


# Twitter

intTweets.Clinton = cbind(as.numeric(summary(Tweets.Clinton.Readability)[, 3]), as.numeric(summary(Tweets.Clinton.Readability)[, 4]))
Tweets.Clinton = c(intTweets.Clinton[1:3, 2], intTweets.Clinton[5, 1], intTweets.Clinton[9, 1], intTweets.Clinton[12:16, 2], intTweets.Clinton[17, 1], intTweets.Clinton[18:21, 
    2], intTweets.Clinton[22, 1], intTweets.Clinton[23:24, 2], intTweets.Clinton[25, 1], intTweets.Clinton[27, 1])

# Subreddits

# This section is done deifferently since the data has a different structure when it was it initially altered to generate the means in 'SubredditCalcAverage.R'
# script

intSubreddit.HillaryClinton = cbind(HillaryClinton.Readability[, 2], HillaryClinton.Readability[, 3])
Subreddit.HillaryClinton = c(intSubreddit.HillaryClinton[1:3, 2], intSubreddit.HillaryClinton[5, 1], intSubreddit.HillaryClinton[9, 1], intSubreddit.HillaryClinton[12:16, 
    2], intSubreddit.HillaryClinton[17, 1], intSubreddit.HillaryClinton[18:21, 2], intSubreddit.HillaryClinton[22, 1], intSubreddit.HillaryClinton[23:24, 2], intSubreddit.HillaryClinton[25, 
    1], intSubreddit.HillaryClinton[27, 1])


# Correct Data Types and Rounding
Debate1.Clinton = as.numeric(Debate1.Clinton)
Debate2.Clinton = as.numeric(Debate2.Clinton)
Debate3.Clinton = as.numeric(Debate3.Clinton)
Speeches.Clinton = as.numeric(Speeches.Clinton)
Tweets.Clinton = as.numeric(Tweets.Clinton)

Subreddit.HillaryClinton = round(as.numeric(Subreddit.HillaryClinton), 2)


# Generate Numerical Tables to be Used for Graphs

Clinton.Table = data.frame(Algorithm = index, HillaryClintonSubreddit = Subreddit.HillaryClinton, Speeches = Speeches.Clinton, Dabate1 = Debate1.Clinton, Dabate2 = Debate2.Clinton, 
    Dabate3 = Debate3.Clinton)

# Generate Tables to be Used for Graphs

Clinton.Data = data.frame(Algorithm = c(index, index, index, index, index), Source = c(rep.int("'HillaryClinton' Subreddit", 20), rep.int("Speeches", 20), rep.int("Debate1", 
    20), rep.int("Debate2", 20), rep.int("Debate3", 20)), Score = c(Subreddit.HillaryClinton, Speeches.Clinton, Debate1.Clinton, Debate2.Clinton, Debate3.Clinton))

# Generate Graphs
Clinton.Graph = ggplot(Clinton.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Clinton Supporters on Reddit and Clintons Speeches/Debates") + facet_wrap(~Algorithm, 
    ncol = 2, scales = "free_y") + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

Clinton.Graph
