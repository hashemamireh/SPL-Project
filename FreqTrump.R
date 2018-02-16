rm(list = ls())

require("twitteR")

consumerKey = "OzPjAMbWrU3P9mj2G1IP6uTDo"
consuemrSecret = "KOc6nB1nuUEYt1OPgkstbs6m7nJjjkFMTXK3GOg1nenPynhavZ"
accessToken = "3032742052-DBynC4JFEChlKnmbnDvTRstaEofU8XoRPdA7lQJ"
accessTokenSecret = "6H8zTIijSqKAnWDVo5YQ0tZnErEJxuTQShQ7pOavEC8ij"
setup_twitter_oauth(consumerKey, consuemrSecret, accessToken, accessTokenSecret)
1

require("tidyr")
require("tidytext")
require("dplyr")

# Geet Trumps Tweets (Max limit 3200: 418 own tweets, the rest is Trumps retweets)
trump.tweets = userTimeline("realDonaldTrump", n = 3200, excludeReplies = FALSE, includeRts = FALSE)
df = do.call("rbind", lapply(trump.tweets, as.data.frame))
df$text = sapply(df$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)

tf = df %>% unnest_tokens(word, text) %>% anti_join(stop_words)

library("ggplot2")

tf %>% count(word, sort = TRUE) %>% filter(n > 10) %>% mutate(word = reorder(word, n)) %>% ggplot(aes(word, n)) + 
  geom_col() + xlab(NULL) + coord_flip()