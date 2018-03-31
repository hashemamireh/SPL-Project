library(koRpus)
library(parallel)

# This script uses the package koRpus to calculate the level of language (also called readability)
# used by politicians and reddit users. The level of language is measured by a variety of different
# algorithms provided by koRpus package. 

# Readability Analysis for Past Speeches

# "Tagging" is a step that must be done first before koRpus can analyze the data
tagged.Clinton.Speeches = tokenize("ClintonSpeeches/AllClintonSpeeches.txt", lang = "en")

Speeches.Clinton.Readability = readability(tagged.Clinton.Speeches, index = 
                                             c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                                "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                                "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                                "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                                "TRI", "Tuldava", "Wheeler.Smith"),
                                            word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                              Spache = "Spache.txt"))

tagged.Trump.Speeches = tokenize("TrumpSpeeches/AllTrumpSpeeches.txt", lang = "en")

Speeches.Trump.Readability = readability(tagged.Trump.Speeches, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                            "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                            "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                            "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                            "TRI", "Tuldava", "Wheeler.Smith"),
                                          word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                            Spache = "Spache.txt"))


tagged.Sanders.Speeches = tokenize("SandersSpeeches/AllSandersSpeeches.txt", lang = "en")

Speeches.Sanders.Readability= readability(tagged.Sanders.Speeches, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                                "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                                "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                                "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                                "TRI", "Tuldava", "Wheeler.Smith"),
                                            word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                              Spache = "Spache.txt"))




# Readability Analysis for Debate 1

tagged.Clinton.Debate1 = tokenize("presidential-debates/1st-pres-debate/CLINTON.txt", lang = "en")

Debate1.Clinton.Readability = readability(tagged.Clinton.Debate1, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                              "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                              "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                              "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                              "TRI", "Tuldava", "Wheeler.Smith"),
                                           word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                             Spache = "Spache.txt"))

tagged.Trump.Debate1 = tokenize("presidential-debates/1st-pres-debate/TRUMP.txt", lang = "en")

Debate1.Trump.Readability = readability(tagged.Trump.Debate1, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                          "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                          "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                          "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                          "TRI", "Tuldava", "Wheeler.Smith"),
                                         word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                           Spache = "Spache.txt"))

# Readability Analysis for Debate 2

tagged.Clinton.Debate2 = tokenize("presidential-debates/2nd-pres-debate/CLINTON2.txt", lang = "en")

Debate2.Clinton.Readability = readability(tagged.Clinton.Debate2, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                              "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                              "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                              "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                              "TRI", "Tuldava", "Wheeler.Smith"),
                                           word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                             Spache = "Spache.txt"))

tagged.Trump.Debate2 = tokenize("presidential-debates/2nd-pres-debate/TRUMP2.txt", lang = "en")

Debate2.Trump.Readability = readability(tagged.Trump.Debate2, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                          "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                          "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                          "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                          "TRI", "Tuldava", "Wheeler.Smith"),
                                         word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                           Spache = "Spache.txt"))

# Readability Analysis for Debate 3

tagged.Clinton.Debate3 = tokenize("presidential-debates/3rd-pres-debate/CLINTON3.txt", lang = "en")

Debate3.Clinton.Readability = readability(tagged.Clinton.Debate3, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                              "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                              "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                              "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                              "TRI", "Tuldava", "Wheeler.Smith"),
                                           word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                             Spache = "Spache.txt"))

tagged.Trump.Debate3 = tokenize("presidential-debates/3rd-pres-debate/TRUMP3.txt", lang = "en")

Debate3.Trump.Readability = readability(tagged.Trump.Debate3, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                          "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                          "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                          "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                          "TRI", "Tuldava", "Wheeler.Smith"),
                                         word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                           Spache = "Spache.txt"))


rm(tagged.Clinton.Debate1,tagged.Clinton.Debate2,tagged.Clinton.Debate3,tagged.Clinton.Speeches,
   tagged.Sanders.Speeches,tagged.Trump.Debate1,tagged.Trump.Debate2,tagged.Trump.Debate3,tagged.Trump.Speeches)
save.image("SpeechesAndDebates.RData")

rm(list = ls())


##################################################################################################################
##################################################################################################################

# Readability Analysis for Select Subreddits

# Due to the large amount of data (some subreddits have 400,000+ comments) the following had to
# be done in secions and the results avaeraged. This is due to limits in the koRpus package.

# The_Donald Subreddit

load("SubTopComments.RData")
rm(list=setdiff(ls(), "The_DonaldSubTopComments"))

Comments = The_DonaldSubTopComments$commentText
rm(list=setdiff(ls(), "Comments"))

# Remove non-regilar/non-ASCII characters because they cannot be procces by koRpus 
excludeComments = grep("dat", iconv(Comments, "latin1", "ASCII", sub="dat"))
Comments = Comments[-excludeComments]

splitComments = strsplit(Comments, " ")

# Exclude extremely long continuos strngs (words larger than 190 characters)
# Using the parallel package to increase the speed
cl = makeCluster(7, type = "FORK")
excludeComments = which(parSapply(cl ,splitComments, function(x) max(nchar(x))) >190)
stopCluster(cl)

Comments = Comments[-excludeComments] 

# This for loop runs the algorithm on different subsets of the data
for (i in 1:100) {
  upperlimit = ifelse(15000*i<length(Comments), 15000*i, length(Comments))
  tagged = tokenize(Comments[(15000*(i-1)+1):upperlimit], format = "obj", lang = "en")
  temp = readability(tagged, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                         "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                         "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                         "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                         "TRI", "Tuldava", "Wheeler.Smith"),
                      word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                        Spache = "Spache.txt"))
  if(i ==1){
    readability.The_Donald = summary(temp)
  }else{
    readability.The_Donald = cbind(readability.The_Donald, summary(temp))
  }
  
  
  if(upperlimit == length(Comments)) break
}

save.image("The_DonaldReadability.RData")
rm(list = ls())
gc()


# SandersForPresident Subreddit

load("SubTopComments.RData")
rm(list=setdiff(ls(), "SandersForPresidentSubTopComments"))

Comments = SandersForPresidentSubTopComments$commentText
rm(list=setdiff(ls(), "Comments"))

excludeComments = grep("dat", iconv(Comments, "latin1", "ASCII", sub="dat"))
Comments = Comments[-excludeComments]

splitComments = strsplit(Comments, " ")

# Exclude extremely long continuos strngs (words larger than 190 characters)
# Using the parallel package to increase the speed

cl = makeCluster(7, type = "FORK")
excludeComments = which(parSapply(cl ,splitComments, function(x) max(nchar(x))) >190)
stopCluster(cl)

Comments = Comments[-excludeComments] 

# This for loop runs the algorithm on different subsets of the data

for (i in 1:100) {
  upperlimit = ifelse(15000*i<length(Comments), 15000*i, length(Comments))
  tagged = tokenize(Comments[(15000*(i-1)+1):upperlimit], format = "obj", lang = "en")
  temp = readability(tagged, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                               "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                               "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                               "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                               "TRI", "Tuldava", "Wheeler.Smith"),
                                 word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                   Spache = "Spache.txt"))
  if(i ==1){
    readability.SandersForPresident = summary(temp)
  }else{
    readability.SandersForPresident = cbind(readability.SandersForPresident, summary(temp))
  }
  
  
  if(upperlimit == length(Comments)) break
}

save.image("SandersForPresidentReadability.RData")
rm(list = ls())
gc()

# HillaryClinton Subreddit

load("SubTopComments.RData")
rm(list=setdiff(ls(), "HillaryClintonSubTopComments"))

Comments = HillaryClintonSubTopComments$commentText
rm(list=setdiff(ls(), "Comments"))

excludeComments = grep("dat", iconv(Comments, "latin1", "ASCII", sub="dat"))
Comments = Comments[-excludeComments]

splitComments = strsplit(Comments, " ")

# Exclude extremely long continuos strngs (words larger than 190 characters)
# Using the parallel package to increase the speed

cl = makeCluster(7, type = "FORK")
excludeComments = which(parSapply(cl ,splitComments, function(x) max(nchar(x))) >190)
stopCluster(cl)

Comments = Comments[-excludeComments] 

# This for loop runs the algorithm on different subsets of the data

for (i in 1:100) {
  upperlimit = ifelse(15000*i<length(Comments), 15000*i, length(Comments))
  tagged = tokenize(Comments[(15000*(i-1)+1):upperlimit], format = "obj", lang = "en")
  temp = readability(tagged, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                         "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                         "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                         "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                         "TRI", "Tuldava", "Wheeler.Smith"),
                      word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                        Spache = "Spache.txt"))
  if(i ==1){
    readability.HillaryClinton = summary(temp)
  }else{
    readability.HillaryClinton = cbind(readability.HillaryClinton, summary(temp))
  }
  
  
  if(upperlimit == length(Comments)) break
}

save.image("HillaryCintonReadability.RData")
rm(list = ls())
gc()




# Resist Subreddit

load("SubTopComments.RData")
rm(list=setdiff(ls(), "ResistSubTopComments"))

Comments = ResistSubTopComments$commentText
rm(list=setdiff(ls(), "Comments"))

excludeComments = grep("dat", iconv(Comments, "latin1", "ASCII", sub="dat"))
Comments = Comments[-excludeComments]

splitComments = strsplit(Comments, " ")

# Exclude extremely long continuos strngs (words larger than 190 characters)
# Using the parallel package to increase the speed

cl = makeCluster(7, type = "FORK")
excludeComments = which(parSapply(cl ,splitComments, function(x) max(nchar(x))) >190)
stopCluster(cl)

Comments = Comments[-excludeComments] 

# This for loop runs the algorithm on different subsets of the data

for (i in 1:100) {
  upperlimit = ifelse(15000*i<length(Comments), 15000*i, length(Comments))
  tagged = tokenize(Comments[(15000*(i-1)+1):upperlimit], format = "obj", lang = "en")
  temp = readability(tagged, index =
         c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
         "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
         "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
         "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
         "TRI", "Tuldava", "Wheeler.Smith"),
         word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
         Spache = "Spache.txt"))
  if(i ==1){
    readability.Resist = summary(temp)
  }else{
    readability.Resist = cbind(readability.Resist, summary(temp))
  }
  
  
  if(upperlimit == length(Comments)) break
}

save.image("ResisttReadability.RData")
rm(list = ls())
gc()

#########################################################################################################################
#########################################################################################################################

# Readability Analysis for Tweets

lapply(c("TrumpTweets.Rdata","ClintonTweets.Rdata","SandersTweets.Rdata","ObamaTweets.Rdata"),load,.GlobalEnv)

TrumpTweets = df$text
ClintonTweets = dfc$text
SandersTweets = dfs$text
ObamaTweets = dfo$text

# Remove non-regilar/non-ASCII characters because they cannot be procces by koRpus 
TrumpTweets = iconv(TrumpTweets, "latin1", "ASCII", sub="")
ClintonTweets = iconv(ClintonTweets, "latin1", "ASCII", sub="")
SandersTweets = iconv(SandersTweets, "latin1", "ASCII", sub="")
ObamaTweets = iconv(ObamaTweets, "latin1", "ASCII", sub="")


tagged.TrumpTweets = tokenize(TrumpTweets, format = "obj", lang = "en")
Tweets.Trump.Readaibility = readability(tagged.TrumpTweets, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                      "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                      "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                      "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                      "TRI", "Tuldava", "Wheeler.Smith"),
                                       word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                         Spache = "Spache.txt"))

tagged.ClintonTweets = tokenize(ClintonTweets, format = "obj", lang = "en")
Tweets.Clinton.Readability = readability(tagged.ClintonTweets, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                      "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                      "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                      "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                      "TRI", "Tuldava", "Wheeler.Smith"),
                                       word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                         Spache = "Spache.txt"))

tagged.SandersTweets = tokenize(SandersTweets, format = "obj", lang = "en")
Tweets.Sanders.Readability = readability(tagged.SandersTweets, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                      "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                      "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                      "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                      "TRI", "Tuldava", "Wheeler.Smith"),
                                       word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                         Spache = "Spache.txt"))

tagged.ObamaTweets = tokenize(ObamaTweets, format = "obj", lang = "en")
Tweets.Obama.Readability = readability(tagged.ObamaTweets, index =  c("ARI", "Bormuth", "Coleman.Liau", "Dale.Chall",
                                                                      "Danielson.Bryan", "Dickes.Steiwer", "DRP", "ELF", "Farr.Jenkins.Paterson",
                                                                      "Flesch", "Flesch.Kincaid", "FOG", "FORCAST", "Fucks",
                                                                      "Linsear.Write", "LIX", "nWS", "RIX", "SMOG", "Spache", "Strain",
                                                                      "TRI", "Tuldava", "Wheeler.Smith"),
                                       word.lists = list(Bormuth = "Dale-Chall.txt", Dale.Chall = "Dale-Chall.txt", Harris.Jacobson = NULL,
                                                         Spache = "Spache.txt"))

rm(list=setdiff(ls(), c("Tweets.Trump.Readaibility", "Tweets.Clinton.Readability", "Tweets.Obama.Readability","Tweets.Sanders.Readability")))
save.image("TweetReadability.RData")
