load("SpeechesAndDebates.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

library(ggplot2)
library(formatR)
library(xtable)

index = The_Donald.Readability[c(1:3, 5, 9, 12:25, 27), 1]

# Debates

intDebate3.Clinton = cbind(as.numeric(summary(Debate3.Clinton.Readability)[, 3]), as.numeric(summary(Debate3.Clinton.Readability)[, 4]))
Debate3.Clinton = c(intDebate3.Clinton[1:3, 2], intDebate3.Clinton[5, 1], intDebate3.Clinton[9, 1], intDebate3.Clinton[12:16, 2], intDebate3.Clinton[17, 1], intDebate3.Clinton[18:21, 
    2], intDebate3.Clinton[22, 1], intDebate3.Clinton[23:24, 2], intDebate3.Clinton[25, 1], intDebate3.Clinton[27, 1])

intDebate3.Trump = cbind(as.numeric(summary(Debate3.Trump.Readability)[, 3]), as.numeric(summary(Debate3.Trump.Readability)[, 4]))
Debate3.Trump = c(intDebate3.Trump[1:3, 2], intDebate3.Trump[5, 1], intDebate3.Trump[9, 1], intDebate3.Trump[12:16, 2], intDebate3.Trump[17, 1], intDebate3.Trump[18:21, 
    2], intDebate3.Trump[22, 1], intDebate3.Trump[23:24, 2], intDebate3.Trump[25, 1], intDebate3.Trump[27, 1])

# Correct Data Types and Rounding
Debate3.Clinton = as.numeric(Debate3.Clinton)
Debate3.Trump = as.numeric(Debate3.Trump)


# Generate Numerical Tables
Debate3.Table = data.frame(Algorithm = index, Clinton = Debate3.Clinton, Trump = Debate3.Trump)


# Generate Tables to be Used for Graphs
Debate3.Data = data.frame(Algorithm = c(index, index), Source = c(rep.int("Clinton", 20), rep.int("Trump", 20)), Score = c(Debate3.Clinton, Debate3.Trump))

# Generate Graphs
Debate3.Graph = ggplot(Debate3.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("First Debate") + facet_wrap(~Algorithm, ncol = 2, scales = "free_y") + 
    theme_classic()

Debate3.Graph
