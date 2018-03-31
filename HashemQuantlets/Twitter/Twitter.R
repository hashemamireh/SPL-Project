load("TweetReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

# Correct Spelling
Tweets.Trump.Readability = Tweets.Trump.Readaibility

library(ggplot2)
library(formatR)

index = Trump.Tweets.Readability[c(1:3, 5, 9, 12:25, 27), 1]


# Twitter

intTweets.Clinton = cbind(as.numeric(summary(Tweets.Clinton.Readability)[, 3]), as.numeric(summary(Tweets.Clinton.Readability)[, 4]))
Tweets.Clinton = c(intTweets.Clinton[1:3, 2], intTweets.Clinton[5, 1], intTweets.Clinton[9, 1], intTweets.Clinton[12:16, 2], intTweets.Clinton[17, 1], intTweets.Clinton[18:21, 
    2], intTweets.Clinton[22, 1], intTweets.Clinton[23:24, 2], intTweets.Clinton[25, 1], intTweets.Clinton[27, 1])

intTweets.Trump = cbind(as.numeric(summary(Tweets.Trump.Readability)[, 3]), as.numeric(summary(Tweets.Trump.Readability)[, 4]))
Tweets.Trump = c(intTweets.Trump[1:3, 2], intTweets.Trump[5, 1], intTweets.Trump[9, 1], intTweets.Trump[12:16, 2], intTweets.Trump[17, 1], intTweets.Trump[18:21, 
    2], intTweets.Trump[22, 1], intTweets.Trump[23:24, 2], intTweets.Trump[25, 1], intTweets.Trump[27, 1])

intTweets.Sanders = cbind(as.numeric(summary(Tweets.Sanders.Readability)[, 3]), as.numeric(summary(Tweets.Sanders.Readability)[, 4]))
Tweets.Sanders = c(intTweets.Sanders[1:3, 2], intTweets.Sanders[5, 1], intTweets.Sanders[9, 1], intTweets.Sanders[12:16, 2], intTweets.Sanders[17, 1], intTweets.Sanders[18:21, 
    2], intTweets.Sanders[22, 1], intTweets.Sanders[23:24, 2], intTweets.Sanders[25, 1], intTweets.Sanders[27, 1])

intTweets.Obama = cbind(as.numeric(summary(Tweets.Obama.Readability)[, 3]), as.numeric(summary(Tweets.Obama.Readability)[, 4]))
Tweets.Obama = c(intTweets.Obama[1:3, 2], intTweets.Obama[5, 1], intTweets.Obama[9, 1], intTweets.Obama[12:16, 2], intTweets.Obama[17, 1], intTweets.Obama[18:21, 
    2], intTweets.Obama[22, 1], intTweets.Obama[23:24, 2], intTweets.Obama[25, 1], intTweets.Obama[27, 1])

# Correct Data Types and Rounding
Tweets.Trump = as.numeric(Tweets.Trump)
Tweets.Clinton = as.numeric(Tweets.Clinton)
Tweets.Sanders = as.numeric(Tweets.Sanders)
Tweets.Obama = as.numeric(Tweets.Obama)


# Generate Numerical Tables to be Used for Graphs
Tweets.Table = data.frame(Algorithm = index, Clinton = Tweets.Clinton, Trump = Tweets.Trump, Sanders = Tweets.Sanders, Obama = Tweets.Obama)

# Generate Tables to be Used for Graphs
Tweets.Data = data.frame(Algorithm = c(index, index, index, index), Source = c(rep.int("Clinton", 20), rep.int("Trump", 20), rep.int("Sanders", 20), rep.int("Obama", 
    20)), Score = c(Tweets.Clinton, Tweets.Trump, Tweets.Sanders, Tweets.Obama))

# Generate Graphs
Tweets.Graph = ggplot(Tweets.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Politicians Twitter Accounts") + facet_wrap(~Algorithm, ncol = 2, 
    scales = "free_y") + theme_classic()

Tweets.Graph
