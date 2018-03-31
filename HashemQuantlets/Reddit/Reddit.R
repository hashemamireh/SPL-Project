load("SubredditsReadability.RData")

# This script summarizes and presents the data calculated by the koRpus package in 'ReadabilityAnalysis.R' and then processed further in
# 'SubredditCalcAverage.R' It creates graphs in different combinations to to able to view the results easily and make comparisons.

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

# Subreddits

# This section is done deifferently since the data has a different structure when it was it initially altered to generate the means in 'SubredditCalcAverage.R'
# script

intSubreddit.The_Donald = cbind(The_Donald.Readability[, 2], The_Donald.Readability[, 3])
Subreddit.The_Donald = c(intSubreddit.The_Donald[1:3, 2], intSubreddit.The_Donald[5, 1], intSubreddit.The_Donald[9, 1], intSubreddit.The_Donald[12:16, 2], intSubreddit.The_Donald[17, 
    1], intSubreddit.The_Donald[18:21, 2], intSubreddit.The_Donald[22, 1], intSubreddit.The_Donald[23:24, 2], intSubreddit.The_Donald[25, 1], intSubreddit.The_Donald[27, 
    1])

intSubreddit.HillaryClinton = cbind(HillaryClinton.Readability[, 2], HillaryClinton.Readability[, 3])
Subreddit.HillaryClinton = c(intSubreddit.HillaryClinton[1:3, 2], intSubreddit.HillaryClinton[5, 1], intSubreddit.HillaryClinton[9, 1], intSubreddit.HillaryClinton[12:16, 
    2], intSubreddit.HillaryClinton[17, 1], intSubreddit.HillaryClinton[18:21, 2], intSubreddit.HillaryClinton[22, 1], intSubreddit.HillaryClinton[23:24, 2], intSubreddit.HillaryClinton[25, 
    1], intSubreddit.HillaryClinton[27, 1])

intSubreddit.SandersForPresident = cbind(SandersForPresident.Readability[, 2], SandersForPresident.Readability[, 3])
Subreddit.SandersForPresident = c(intSubreddit.SandersForPresident[1:3, 2], intSubreddit.SandersForPresident[5, 1], intSubreddit.SandersForPresident[9, 1], intSubreddit.SandersForPresident[12:16, 
    2], intSubreddit.SandersForPresident[17, 1], intSubreddit.SandersForPresident[18:21, 2], intSubreddit.SandersForPresident[22, 1], intSubreddit.SandersForPresident[23:24, 
    2], intSubreddit.SandersForPresident[25, 1], intSubreddit.SandersForPresident[27, 1])

intSubreddit.Resist = cbind(Resist.Readability[, 2], Resist.Readability[, 3])
Subreddit.Resist = c(intSubreddit.Resist[1:3, 2], intSubreddit.Resist[5, 1], intSubreddit.Resist[9, 1], intSubreddit.Resist[12:16, 2], intSubreddit.Resist[17, 
    1], intSubreddit.Resist[18:21, 2], intSubreddit.Resist[22, 1], intSubreddit.Resist[23:24, 2], intSubreddit.Resist[25, 1], intSubreddit.Resist[27, 1])

# Correct Data Types and Rounding
Subreddit.The_Donald = round(as.numeric(Subreddit.The_Donald), 2)
Subreddit.HillaryClinton = round(as.numeric(Subreddit.HillaryClinton), 2)
Subreddit.SandersForPresident = round(as.numeric(Subreddit.SandersForPresident), 2)
Subreddit.Resist = round(as.numeric(Subreddit.Resist), 2)


# Generate Numerical Tables to be Used for Graphs

Reddit.Table = data.frame(Algorithm = index, HillaryClintonSubreddit = Subreddit.HillaryClinton, The_DonaldSubreddit = Subreddit.The_Donald, SandersForPresidentSubreddit = Subreddit.SandersForPresident, 
    ResistSubreddit = Subreddit.Resist)

# Generate Tables to be Used for Graphs
Reddit.Data = data.frame(Algorithm = c(index, index, index, index), Source = c(rep.int("'HillaryClinton'", 20), rep.int("'The_Donald'", 20), rep.int("'SandersForPresident'", 
    20), rep.int("'Resist'", 20)), Score = c(Subreddit.HillaryClinton, Subreddit.The_Donald, Subreddit.SandersForPresident, Subreddit.Resist))


# Generate Graphs
Reddit.Graph = ggplot(Reddit.Data, aes(Source, Score)) + geom_bar(stat = "identity") + xlab("Subreddits") + facet_wrap(~Algorithm, ncol = 2, scales = "free_y") + 
    theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

Reddit.Graph
