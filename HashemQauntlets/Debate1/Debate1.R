load("SpeechesAndDebates.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

library(ggplot2)
library(formatR)
library(xtable)

index = The_Donald.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Debates

intDebate1.Clinton = cbind(as.numeric(summary(Debate1.Clinton.Readability)[, 3]), as.numeric(summary(Debate1.Clinton.Readability)[, 4]))
Debate1.Clinton = c(intDebate1.Clinton[1:3, 2], intDebate1.Clinton[5, 1], intDebate1.Clinton[9, 1], intDebate1.Clinton[12:16, 2], intDebate1.Clinton[17, 1], intDebate1.Clinton[18:21, 
    2], intDebate1.Clinton[22, 1], intDebate1.Clinton[23:24, 2], intDebate1.Clinton[25, 1], intDebate1.Clinton[27, 1])

intDebate1.Trump = cbind(as.numeric(summary(Debate1.Trump.Readability)[, 3]), as.numeric(summary(Debate1.Trump.Readability)[, 4]))
Debate1.Trump = c(intDebate1.Trump[1:3, 2], intDebate1.Trump[5, 1], intDebate1.Trump[9, 1], intDebate1.Trump[12:16, 2], intDebate1.Trump[17, 1], intDebate1.Trump[18:21, 
    2], intDebate1.Trump[22, 1], intDebate1.Trump[23:24, 2], intDebate1.Trump[25, 1], intDebate1.Trump[27, 1])

# Correct Data Types and Rounding
Debate1.Clinton = as.numeric(Debate1.Clinton)
Debate1.Trump = as.numeric(Debate1.Trump)


# Generate Numerical Tables
Debate1.Table = data.frame(Algorithm = index, Clinton = Debate1.Clinton, Trump = Debate1.Trump)


# Generate Tables to be Used for Graphs
Debate1.Data = data.frame(Algorithm = c(index, index), Source = c(rep.int("Clinton", 20), rep.int("Trump", 20)), Score = c(Debate1.Clinton, Debate1.Trump))

# Generate Graphs
Debate1.Graph = ggplot(Debate1.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("First Debate") + facet_wrap(~Algorithm, ncol = 2, scales = "free_y") + 
    theme_classic()

Debate1.Graph
