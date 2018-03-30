load("SubTop.RData")
source("RedditFuncs.R")

# This Script retrieves and downloads the UserData of the authors who made the top posts retrieved
# in "SubTop.R"

#### Must be done in two batches since it uses up all of R's possible connections. ####

# Batch 1
Liberal.UserData = retrieveUserData(Liberal.SubTop$postAuthor)
NeutralPolitics.UserData = retrieveUserData(NeutralPolitics.SubTop$postAuthor)
Conservative.UserData = retrieveUserData(Conservative.SubTop$postAuthor)
Democrats.UserData = retrieveUserData(Democrats.SubTop$postAuthor)
HillaryClinton.UserData = retrieveUserData(HillaryClinton.SubTop$postAuthor)
HillaryMeltdown.UserData = retrieveUserData(HillaryMeltdown.SubTop$postAuthor)


rm(list=setdiff(ls(), c("Liberal.UserData", "NeutralPolitics.UserData","Conservative.UserData","Democrats.UserData",
                        "HillaryClinton.UserData","HillaryMeltdown.UserData")))
save.image("RedditAuthors.RData")

rm(list = ls())
gc()
closeAllConnections()

# Batch 2

load("SubTop.RData")
source("RedditFuncs.R")

Libertarian.UserData = retrieveUserData(Libertarian.SubTop$postAuthor)
PoliticalDiscussion.UserData = retrieveUserData(PoliticalDiscussion.SubTop$postAuthor)
Politics.UserData = retrieveUserData(Politics.SubTop$postAuthor)
Resist.UserData = retrieveUserData(Resist.SubTop$postAuthor)
SandersForPresident.UserData = retrieveUserData(SandersForPresident.SubTop$postAuthor)
The_Donald.UserData = retrieveUserData(The_Donald.SubTop$postAuthor)


rm(list=setdiff(ls(), c("Libertarian.UserData","PoliticalDiscussion.UserData",
                "Politics.UserData","Resist.UserData","SandersForPresident.UserData","The_Donald.UserData")))
# Combine the ones data downloaded in the first stage with the data downloaded in the second stage
load("RedditAuthors.RData")

# Save data to be used by other scripts
save.image("RedditAuthors.RData")