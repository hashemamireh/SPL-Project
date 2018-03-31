load("SpeechesAndDebates.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

library(ggplot2)
library(formatR)
library(xtable)

index = The_Donald.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Debates

intDebate2.Clinton = cbind(as.numeric(summary(Debate2.Clinton.Readability)[, 3]), as.numeric(summary(Debate2.Clinton.Readability)[, 4]))
Debate2.Clinton = c(intDebate2.Clinton[1:3, 2], intDebate2.Clinton[5, 1], intDebate2.Clinton[9, 1], intDebate2.Clinton[12:16, 2], intDebate2.Clinton[17, 1], intDebate2.Clinton[18:21, 
    2], intDebate2.Clinton[22, 1], intDebate2.Clinton[23:24, 2], intDebate2.Clinton[25, 1], intDebate2.Clinton[27, 1])

intDebate2.Trump = cbind(as.numeric(summary(Debate2.Trump.Readability)[, 3]), as.numeric(summary(Debate2.Trump.Readability)[, 4]))
Debate2.Trump = c(intDebate2.Trump[1:3, 2], intDebate2.Trump[5, 1], intDebate2.Trump[9, 1], intDebate2.Trump[12:16, 2], intDebate2.Trump[17, 1], intDebate2.Trump[18:21, 
    2], intDebate2.Trump[22, 1], intDebate2.Trump[23:24, 2], intDebate2.Trump[25, 1], intDebate2.Trump[27, 1])

# Correct Data Types and Rounding
Debate2.Clinton = as.numeric(Debate2.Clinton)
Debate2.Trump = as.numeric(Debate2.Trump)


# Generate Numerical Tables
Debate2.Table = data.frame(Algorithm = index, Clinton = Debate2.Clinton, Trump = Debate2.Trump)


# Generate Tables to be Used for Graphs
Debate2.Data = data.frame(Algorithm = c(index, index), Source = c(rep.int("Clinton", 20), rep.int("Trump", 20)), Score = c(Debate2.Clinton, Debate2.Trump))

# Generate Graphs
Debate2.Graph = ggplot(Debate2.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("First Debate") + facet_wrap(~Algorithm, ncol = 2, scales = "free_y") + 
    theme_classic()

Debate2.Graph
