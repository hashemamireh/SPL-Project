load("SubredditsReadability.RData")
load("SpeechesAndDebates.RData")
load("TweetReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

# Correct Spelling
Tweets.Trump.Readability = Tweets.Trump.Readaibility

library(ggplot2)
library(formatR)
library(xtable)

index = The_Donald.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Debates

intDebate1.Trump = cbind(as.numeric(summary(Debate1.Trump.Readability)[, 3]), as.numeric(summary(Debate1.Trump.Readability)[, 4]))
Debate1.Trump = c(intDebate1.Trump[1:3, 2], intDebate1.Trump[5, 1], intDebate1.Trump[9, 1], intDebate1.Trump[12:16, 2], intDebate1.Trump[17, 1], intDebate1.Trump[18:21, 
    2], intDebate1.Trump[22, 1], intDebate1.Trump[23:24, 2], intDebate1.Trump[25, 1], intDebate1.Trump[27, 1])


intDebate2.Trump = cbind(as.numeric(summary(Debate2.Trump.Readability)[, 3]), as.numeric(summary(Debate2.Trump.Readability)[, 4]))
Debate2.Trump = c(intDebate2.Trump[1:3, 2], intDebate2.Trump[5, 1], intDebate2.Trump[9, 1], intDebate2.Trump[12:16, 2], intDebate2.Trump[17, 1], intDebate2.Trump[18:21, 
    2], intDebate2.Trump[22, 1], intDebate2.Trump[23:24, 2], intDebate2.Trump[25, 1], intDebate2.Trump[27, 1])


intDebate3.Trump = cbind(as.numeric(summary(Debate3.Trump.Readability)[, 3]), as.numeric(summary(Debate3.Trump.Readability)[, 4]))
Debate3.Trump = c(intDebate3.Trump[1:3, 2], intDebate3.Trump[5, 1], intDebate3.Trump[9, 1], intDebate3.Trump[12:16, 2], intDebate3.Trump[17, 1], intDebate3.Trump[18:21, 
    2], intDebate3.Trump[22, 1], intDebate3.Trump[23:24, 2], intDebate3.Trump[25, 1], intDebate3.Trump[27, 1])

# Speeches

intSpeeches.Trump = cbind(as.numeric(summary(Speeches.Trump.Readability)[, 3]), as.numeric(summary(Speeches.Trump.Readability)[, 4]))
Speeches.Trump = c(intSpeeches.Trump[1:3, 2], intSpeeches.Trump[5, 1], intSpeeches.Trump[9, 1], intSpeeches.Trump[12:16, 2], intSpeeches.Trump[17, 1], intSpeeches.Trump[18:21, 
    2], intSpeeches.Trump[22, 1], intSpeeches.Trump[23:24, 2], intSpeeches.Trump[25, 1], intSpeeches.Trump[27, 1])


# Twitter

intTweets.Trump = cbind(as.numeric(summary(Tweets.Trump.Readability)[, 3]), as.numeric(summary(Tweets.Trump.Readability)[, 4]))
Tweets.Trump = c(intTweets.Trump[1:3, 2], intTweets.Trump[5, 1], intTweets.Trump[9, 1], intTweets.Trump[12:16, 2], intTweets.Trump[17, 1], intTweets.Trump[18:21, 
    2], intTweets.Trump[22, 1], intTweets.Trump[23:24, 2], intTweets.Trump[25, 1], intTweets.Trump[27, 1])

# Subreddits

# This section is done deifferently since the data has a different structure when it was it initially altered to generate the means in 'SubredditCalcAverage.R'
# script

intSubreddit.The_Donald = cbind(The_Donald.Readability[, 2], The_Donald.Readability[, 3])
Subreddit.The_Donald = c(intSubreddit.The_Donald[1:3, 2], intSubreddit.The_Donald[5, 1], intSubreddit.The_Donald[9, 1], intSubreddit.The_Donald[12:16, 2], intSubreddit.The_Donald[17, 
    1], intSubreddit.The_Donald[18:21, 2], intSubreddit.The_Donald[22, 1], intSubreddit.The_Donald[23:24, 2], intSubreddit.The_Donald[25, 1], intSubreddit.The_Donald[27, 
    1])


# Correct Data Types and Rounding
Debate1.Trump = as.numeric(Debate1.Trump)
Debate2.Trump = as.numeric(Debate2.Trump)
Debate3.Trump = as.numeric(Debate3.Trump)
Speeches.Trump = as.numeric(Speeches.Trump)
Tweets.Trump = as.numeric(Tweets.Trump)

Subreddit.The_Donald = round(as.numeric(Subreddit.The_Donald), 2)


# Generate Numerical Tables to be Used for Graphs

Trump.Table = data.frame(Algorithm = index, The_DonaldSubreddit = Subreddit.The_Donald, Speeches = Speeches.Trump, Dabate1 = Debate1.Trump, Dabate2 = Debate2.Trump, 
    Dabate3 = Debate3.Trump)

# Generate Tables to be Used for Graphs

Trump.Data = data.frame(Algorithm = c(index, index, index, index, index), Source = c(rep.int("'The_Donald' Subreddit", 20), rep.int("Speeches", 20), rep.int("Debate1", 
    20), rep.int("Debate2", 20), rep.int("Debate3", 20)), Score = c(Subreddit.The_Donald, Speeches.Trump, Debate1.Trump, Debate2.Trump, Debate3.Trump))

# Generate Graphs
Trump.Graph = ggplot(Trump.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Trump Supporters on Reddit and Trumps Speeches/Debates") + facet_wrap(~Algorithm, 
    ncol = 2, scales = "free_y") + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

Trump.Graph
