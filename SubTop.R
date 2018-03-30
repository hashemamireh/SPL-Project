setwd("~/HU-Berlin/WS2017-2018/SPL/Project")

source("RedditFuncs.R")

# This script retrieves (from the internet) the 1000 most highly "upvoted" posts of all time for each 
# subreddits we are intereted in


The_Donald.SubTop = retrievePosts(maxPages = 11, subreddit = "The_Donald", sortBy = "top", timePeriod = "all")
Conservative.SubTop  = retrievePosts(maxPages = 50, subreddit = "conservative", sortBy = "top", timePeriod = "all")
Libertarian.SubTop  = retrievePosts(maxPages = 50, subreddit = "Libertarian", sortBy = "top", timePeriod = "all")
HillaryMeltdown.SubTop  = retrievePosts(maxPages = 50, subreddit = "HillaryMeltdown", sortBy = "top", timePeriod = "all")

Resist.SubTop  = retrievePosts(maxPages = 50, subreddit = "esist", sortBy = "top", timePeriod = "all")
SandersForPresident.SubTop  = retrievePosts(maxPages = 50, subreddit = "SandersForPresident", sortBy = "top", timePeriod = "all")
HillaryClinton.SubTop  = retrievePosts(maxPages = 50, subreddit = "hillaryclinton", sortBy = "top", timePeriod = "all")
Democrats.SubTop  = retrievePosts(maxPages = 50, subreddit = "democrats", sortBy = "top", timePeriod = "all")
Liberal.SubTop = retrievePosts(maxPages = 50, subreddit = "liberal", sortBy = "top", timePeriod = "all")

Politics.SubTop  = retrievePosts(maxPages = 50, subreddit = "politics", sortBy = "top", timePeriod = "all")
PoliticalDiscussion.SubTop  = retrievePosts(maxPages = 50, subreddit = "PoliticalDiscussion", sortBy = "top", timePeriod = "all")
NeutralPolitics.SubTop  = retrievePosts(maxPages = 50, subreddit = "NeutralPolitics", sortBy = "top", timePeriod = "all")