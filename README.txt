SubTop.R
# This script retrieves (from the internet) the 1000 most highly "upvoted" posts of all time for each 
# subreddits we are intereted in


SubTopComments.R
# This script downloads and retrieves all the comments for the 1000 tops posts of all time for the
# subreddits of interest


RetrieveUserData.R
# This Script retrieves and downloads the UserData of the authors who made the top posts retrieved
# in "SubTop.R"


ReadabilityAnalysis.R
# This script uses the package koRpus to calculate the level of language (also called readability)
# used by politicians and reddit users. The level of language is measured by a variety of different
# algorithms provided by koRpus package. 


SubredditsCalcAverages.R
# This script is used to calculate the averages of the readability data for the four
# subreddits since they had to be processed in chunks due to limitations in the
# package koRpus


ReadabilityGraphsAndTables.R
# This script summarizes and presents the data calculated by the koRpus package in  "ReadabilityAnalysis.R"
# and then processed further in "SubredditCalcAverage.R"
# It creates graphs in different combinations to to able to view the results easily and make comparisons.


PolarizationAnalysis.R
# This script uses the reddit data to calculate trends in how many upvotes do posts get over
# time. These trends can be used to see if there are any indications of polarization over time.


UserAnalysis.R
# This script runs analysis on retrived users (most active of authors on the subreddits we are interested in)
# and calculates the proportion of suspended users on each of the subreddits. It also caluclautes the
# average account age for every post. These measures can be ussed to indicate poor behavior by users and the 
# posibility of bots.


RedditFuncs.R
# This script is an edited and improved version of package RedditExtractoR


