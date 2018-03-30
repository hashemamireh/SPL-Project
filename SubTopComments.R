setwd("~/HU-Berlin/WS2017-2018/SPL/Project")

source("RedditFuncs.R")

# This script downloads and retrieves all the comments for the 1000 tops posts of all time for the subreddits of interest

The_DonaldSubTopComments = retrievePostsComments(maxPages = 11, subreddit = "The_Donald", sortBy = "top", timePeriod = "all")

ResistSubTopComments  = retrievePostsComments(maxPages = 50, subreddit = "esist", sortBy = "top", timePeriod = "all")

HillaryClintonSubTopComments  = retrievePostsComments(maxPages = 50, subreddit = "hillaryclinton", sortBy = "top", timePeriod = "all")

SandersForPresidentTopComments  = retrievePostsComments(maxPages = 50, subreddit = "SandersForPresident", sortBy = "top", timePeriod = "all")
