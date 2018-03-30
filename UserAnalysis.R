library(ggplot2)
library(xtable)

load("SubTop.RData")
load("RedditAuthors.RData")

# This script runs analysis on retrived users (most active of authors on the subreddits we are interested in)
# and calculates the proportion of suspended users on each of the subreddits. It also caluclautes the
# average account age for every post. These measures can be ussed to indicate poor behavior by users and the 
# posibility of bots.

# Merge the post data and the user data by using the common username
Conservative = merge(Conservative.SubTop, Conservative.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
Democrats = merge(Democrats.SubTop, Democrats.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
HillaryClinton = merge(HillaryClinton.SubTop, HillaryClinton.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
HillaryMeltdown = merge(HillaryMeltdown.SubTop, HillaryMeltdown.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
Liberal = merge(Liberal.SubTop, Liberal.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
Libertarian = merge(Libertarian.SubTop, Libertarian.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
NeutralPolitics = merge(NeutralPolitics.SubTop, NeutralPolitics.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
PoliticalDiscussion = merge(PoliticalDiscussion.SubTop, PoliticalDiscussion.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
Politics = merge(Politics.SubTop, Politics.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
Resist = merge(Resist.SubTop, Resist.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
SandersForPresident = merge(SandersForPresident.SubTop, SandersForPresident.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)
The_Donald = merge(The_Donald.SubTop, The_Donald.UserData,by.x = "postAuthor", by.y = "userName", all.x = TRUE)

# Bind all the subreddits into one dataframe
df = rbind(
  Conservative,
  Democrats,
  HillaryClinton,
  HillaryMeltdown,
  Liberal,
  Libertarian,
  NeutralPolitics,
  PoliticalDiscussion,
  Politics,
  Resist,
  SandersForPresident,
  The_Donald
)

# Generate account age for every post by subtracting the account creation date from the post date
df$accountAge = difftime(df$postDateTime, df$userSince, units = "days")

# Calculate the average account age and the suspended user per 100 users for every subreddit
# Dleted users per 1000 users was also created but not used in the paper
results = matrix(nrow = 0, ncol = 4)
for(i in unique(df$subreddit)){
  suspendedPer1000 = sum(df$isSuspended[df$subreddit == i], na.rm = TRUE)*1000/length(df$postAuthor[df$subreddit == i])
  deletedPer1000 = sum((df$postAuthor == "[deleted]")[df$subreddit == i])*1000/length(df$postAuthor[df$subreddit == i])
  avgAccountAge =mean(df$accountAge[df$subreddit == i], na.rm = TRUE)
  results = rbind(results, c(i, suspendedPer1000, deletedPer1000, avgAccountAge))
}

# Matrix to data.frame
re = data.frame("Subreddit" = as.character(results[,1]),
                 "Suspended Per 1000" = as.numeric(results[,2]),
                 "Deleted Per 1000" = as.numeric(results[,3]),
                 "Average Account Age" = as.numeric(results[,4]))
re[,2:4] = round(as.numeric(results[,2:4]), 0)

# Create graphs for suspended users per 1000
suspendedPer.Graph = ggplot(re, aes(reorder(Subreddit, Suspended.Per.1000), Suspended.Per.1000)) +
  geom_bar(stat="identity") + 
  xlab('Subreddit') +
  ylab('Suspended Users per 1000') +
  coord_flip()+
  theme_classic()

# Create graph for average account age
accountAge.Graph = ggplot(re, aes(reorder(Subreddit, Average.Account.Age), Average.Account.Age)) +
  geom_bar(stat="identity") + 
  xlab('Subreddit') +
  ylab('Average Account Age (days)') +
  coord_flip()+
  theme_classic()

# Generate summery table for latex
xtable(re[,c(1,2,4)], type = "latex", caption = "Suspension Rates and Account Ages Amond Top Post Authors")


