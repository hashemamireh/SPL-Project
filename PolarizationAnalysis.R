library(ggplot2)
library(reshape2)
library(Hmi)
library(stargazer)

load("SubTop.RData")

# This script uses the reddit data to calculate trends in how many upvotes do posts get over
# time. These trends can be used to see if there are any indications of polarization over time.

# This function generates the UpScore for every single day
generateTimeSeries = function(variable){
  temp = variable
  
  temp$postDateTime = as.Date.POSIXct(temp$postDateTime)
  dateUpScore = c()
  dateCommentScore = c()
  for(i in temp$postDateTime){
    dateUpScore = c(dateUpScore, sum(temp$postScore[temp$postDateTime == i]))
    dateCommentScore = c(dateCommentScore,sum(temp$num_comments[temp$postDateTime == i]))}
  temp = cbind(temp, dateUpScore, dateCommentScore)
  sub = gsub("SubTop","",deparse(substitute(variable)))
  TimeSeries = temp[!duplicated(temp$postDateTime), c(3,5,15,16)]
  colnames(TimeSeries)[c(3, 4)] = paste0(sub, colnames(TimeSeries)[c(3,4)])
  return(TimeSeries)
}


# The function is applied to all the subreddits
Conservative.TimeSeries = generateTimeSeries(   Conservative.SubTop)
Democrats.TimeSeries = generateTimeSeries(   Democrats.SubTop)
HillaryClinton.TimeSeries = generateTimeSeries(   HillaryClinton.SubTop)
HillaryMeltdown.TimeSeries = generateTimeSeries(   HillaryMeltdown.SubTop)
Liberal.TimeSeries = generateTimeSeries(   Liberal.SubTop)
Libertarian.TimeSeries = generateTimeSeries(   Libertarian.SubTop)
NeutralPolitics.TimeSeries = generateTimeSeries(   NeutralPolitics.SubTop)
PoliticalDiscussion.TimeSeries = generateTimeSeries(   PoliticalDiscussion.SubTop)
Politics.TimeSeries = generateTimeSeries(   Politics.SubTop)
Resist.TimeSeries = generateTimeSeries(   Resist.SubTop)
SandersForPresident.TimeSeries  = generateTimeSeries(   SandersForPresident.SubTop)
The_Donald.TimeSeries  = generateTimeSeries(   The_Donald.SubTop)


# Combine all subreddits into one data frame for easier analysis
TimeSeriesUpScore = data.frame(postDateTime = seq(as.Date("2013/1/1"), as.Date("2018/3/25"), "days"))
TimeSeriesUpScore = merge(TimeSeriesUpScore, Conservative.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, Democrats.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, HillaryClinton.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, HillaryMeltdown.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, Liberal.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, Libertarian.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, NeutralPolitics.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, PoliticalDiscussion.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, Politics.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, Resist.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, SandersForPresident.TimeSeries[,c(-2,-4)], all.x = TRUE)
TimeSeriesUpScore = merge(TimeSeriesUpScore, The_Donald.TimeSeries[,c(-2,-4)], all.x = TRUE)

# Formatting
rownames(TimeSeriesUpScore) = seq(length=nrow(TimeSeriesUpScore))
colnames(TimeSeriesUpScore)[1] = "Date"
colnames(TimeSeriesUpScore)[-1] = gsub(".dateUpScore", "", colnames(TimeSeriesUpScore)[-1] )

# "Melt" the data frame to change its structure to become more usable for creating time series
melted.TimeSeriesUpScore = melt(TimeSeriesUpScore, id.vars = 'Date')
melted.TimeSeriesUpScore = na.omit(melted.TimeSeriesUpScore)

# Generate a the natiral logs
log.melted.TimeSeriesUpScore = melted.TimeSeriesUpScore
log.melted.TimeSeriesUpScore$value = log(log.melted.TimeSeriesUpScore$value)

# Run regressions to check if UpScores increase or decrease over time.
NeutralPolitics         = lm(log(NeutralPolitics)~ Date, TimeSeriesUpScore)
PoliticalDiscussion     = lm(log(PoliticalDiscussion)~ Date, TimeSeriesUpScore)
Politics                = lm(log(Politics)~ Date, TimeSeriesUpScore)
Conservative            = lm(log(Conservative)~ Date, TimeSeriesUpScore)
Libertarian             = lm(log(Libertarian)~ Date, TimeSeriesUpScore)
Liberal                 = lm(log(Liberal)~ Date, TimeSeriesUpScore)
Democrats               = lm(log(Democrats)~ Date, TimeSeriesUpScore)
The_Donald              = lm(log(The_Donald)~ Date, TimeSeriesUpScore)
HillaryMeltdown         = lm(log(HillaryMeltdown)~ Date, TimeSeriesUpScore)
HillaryClinton          = lm(log(HillaryClinton)~ Date, TimeSeriesUpScore)
Resist                  = lm(log(Resist)~ Date, TimeSeriesUpScore)
SandersForPresident     = lm(log(SandersForPresident)~ Date, TimeSeriesUpScore)


# Use package Stargazer to create tables for Latex
stargazer(NeutralPolitics, PoliticalDiscussion, Politics,
          title = "Neutral Subreddits",
          omit = "Constant",
          omit.stat = c("adj.rsq", "f", "rsq","ser"))

stargazer(Conservative, Libertarian, 
          title = "Neutral Subreddits",
          omit = "Constant",
          omit.stat = c("adj.rsq", "f", "rsq","ser"))

stargazer(Liberal, Democrats, Resist,
          title = "Neutral Subreddits",
          omit = "Constant",
          omit.stat = c("adj.rsq", "f", "rsq","ser"))

stargazer(HillaryClinton, The_Donald,SandersForPresident,
          title = "Neutral Subreddits",
          omit = "Constant",
          omit.stat = c("adj.rsq", "f", "rsq","ser"))

# Generate log plot for all the subreddits
ggplot(log.melted.TimeSeriesUpScore, aes(Date,value, color = variable)) +
  stat_summary(fun.data=mean_cl_normal) +
  geom_smooth(method='lm',formula=y~x+x^2+x^3) +
  ylab = "Upvote Scores"
  theme_classic()

