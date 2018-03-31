load("SpeechesAndDebates.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.


library(ggplot2)
library(formatR)

index = Speeches.Clinton.Readability[c(1:3, 5, 9, 12:25, 27), 1]


# Speeches
intSpeeches.Clinton = cbind(as.numeric(summary(Speeches.Clinton.Readability)[, 3]), as.numeric(summary(Speeches.Clinton.Readability)[, 4]))
Speeches.Clinton = c(intSpeeches.Clinton[1:3, 2], intSpeeches.Clinton[5, 1], intSpeeches.Clinton[9, 1], intSpeeches.Clinton[12:16, 2], intSpeeches.Clinton[17, 
    1], intSpeeches.Clinton[18:21, 2], intSpeeches.Clinton[22, 1], intSpeeches.Clinton[23:24, 2], intSpeeches.Clinton[25, 1], intSpeeches.Clinton[27, 1])

intSpeeches.Trump = cbind(as.numeric(summary(Speeches.Trump.Readability)[, 3]), as.numeric(summary(Speeches.Trump.Readability)[, 4]))
Speeches.Trump = c(intSpeeches.Trump[1:3, 2], intSpeeches.Trump[5, 1], intSpeeches.Trump[9, 1], intSpeeches.Trump[12:16, 2], intSpeeches.Trump[17, 1], intSpeeches.Trump[18:21, 
    2], intSpeeches.Trump[22, 1], intSpeeches.Trump[23:24, 2], intSpeeches.Trump[25, 1], intSpeeches.Trump[27, 1])

intSpeeches.Sanders = cbind(as.numeric(summary(Speeches.Sanders.Readability)[, 3]), as.numeric(summary(Speeches.Sanders.Readability)[, 4]))
Speeches.Sanders = c(intSpeeches.Sanders[1:3, 2], intSpeeches.Sanders[5, 1], intSpeeches.Sanders[9, 1], intSpeeches.Sanders[12:16, 2], intSpeeches.Sanders[17, 
    1], intSpeeches.Sanders[18:21, 2], intSpeeches.Sanders[22, 1], intSpeeches.Sanders[23:24, 2], intSpeeches.Sanders[25, 1], intSpeeches.Sanders[27, 1])



# Correct Data Types and Rounding
Speeches.Clinton = as.numeric(Speeches.Clinton)
Speeches.Trump = as.numeric(Speeches.Trump)
Speeches.Sanders = as.numeric(Speeches.Sanders)


# Generate Numerical Tables to be Used for Graphs
Speeches.Table = data.frame(Algorithm = index, Clinton = Speeches.Clinton, Trump = Speeches.Trump, Sanders = Speeches.Sanders)

# Generate Tables to be Used for Graphs
Speeches.Data = data.frame(Algorithm = c(index, index, index), Source = c(rep.int("Clinton", 20), rep.int("Trump", 20), rep.int("Sanders", 20)), Score = c(Speeches.Clinton, 
    Speeches.Trump, Speeches.Sanders))

# Generate Graphs
Speeches.Graph = ggplot(Speeches.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Campaign Speeches") + facet_wrap(~Algorithm, ncol = 2, scales = "free_y") + 
    theme_classic()

Speeches.Graph
