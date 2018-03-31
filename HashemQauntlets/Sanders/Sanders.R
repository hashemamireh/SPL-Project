load("SubredditsReadability.RData")
load("SpeechesAndDebates.RData")
load("TweetReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.


library(ggplot2)
library(formatR)

index = Sanders.Speeches.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Speeches

intSpeeches.Sanders = cbind(as.numeric(summary(Speeches.Sanders.Readability)[, 3]), as.numeric(summary(Speeches.Sanders.Readability)[, 4]))
Speeches.Sanders = c(intSpeeches.Sanders[1:3, 2], intSpeeches.Sanders[5, 1], intSpeeches.Sanders[9, 1], intSpeeches.Sanders[12:16, 2], intSpeeches.Sanders[17, 
    1], intSpeeches.Sanders[18:21, 2], intSpeeches.Sanders[22, 1], intSpeeches.Sanders[23:24, 2], intSpeeches.Sanders[25, 1], intSpeeches.Sanders[27, 1])

# Twitter

intTweets.Sanders = cbind(as.numeric(summary(Tweets.Sanders.Readability)[, 3]), as.numeric(summary(Tweets.Sanders.Readability)[, 4]))
Tweets.Sanders = c(intTweets.Sanders[1:3, 2], intTweets.Sanders[5, 1], intTweets.Sanders[9, 1], intTweets.Sanders[12:16, 2], intTweets.Sanders[17, 1], intTweets.Sanders[18:21, 
    2], intTweets.Sanders[22, 1], intTweets.Sanders[23:24, 2], intTweets.Sanders[25, 1], intTweets.Sanders[27, 1])


# Subreddits

# This section is done deifferently since the data has a different structure when it was it initially altered to generate the means in 'SubredditCalcAverage.R'
# script


intSubreddit.SandersForPresident = cbind(SandersForPresident.Readability[, 2], SandersForPresident.Readability[, 3])
Subreddit.SandersForPresident = c(intSubreddit.SandersForPresident[1:3, 2], intSubreddit.SandersForPresident[5, 1], intSubreddit.SandersForPresident[9, 1], intSubreddit.SandersForPresident[12:16, 
    2], intSubreddit.SandersForPresident[17, 1], intSubreddit.SandersForPresident[18:21, 2], intSubreddit.SandersForPresident[22, 1], intSubreddit.SandersForPresident[23:24, 
    2], intSubreddit.SandersForPresident[25, 1], intSubreddit.SandersForPresident[27, 1])

# Correct Data Types and Rounding
Speeches.Sanders = as.numeric(Speeches.Sanders)
Tweets.Sanders = as.numeric(Tweets.Sanders)

Subreddit.SandersForPresident = round(as.numeric(Subreddit.SandersForPresident), 2)


# Generate Numerical Tables to be Used for Graphs

Sanders.Table = data.frame(Algorithm = index, SandersForPresidentSubreddit = Subreddit.SandersForPresident, Speeches = Speeches.Sanders)


# Generate Tables to be Used for Graphs

Sanders.Data = data.frame(Algorithm = c(index, index), Source = c(rep.int("SandersForPresident Subreddit", 20), rep.int("Speeches", 20)), Score = c(Subreddit.SandersForPresident, 
    Speeches.Sanders))



# Generate Graphs
Sanders.Graph = ggplot(Sanders.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Sanders Supporters on Reddit and Sanders Speeches") + facet_wrap(~Algorithm, 
    ncol = 2, scales = "free_y") + theme_classic()

Sanders.Graph
