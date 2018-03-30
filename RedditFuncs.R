library(RJSONIO)

# This script is an edited and improved version of package RedditExtractoR

# This package adds:
  # "Hot" and top options for sorting
  # Ability to retrieve content without comments
  # Ability to use an exclude filter
  # 100 per interation rather than 25
  # Imprroves use of search rather than new
  # Adds time perdiod for Top sort

retrieveURLs = function(searchPhrase = NA,
                         titleExclude = "",
                         titleMustInclude = "",
                         subreddit = "",
                         minComments = "",
                         maxPages = 1,
                         sortBy = "hot",
                         timePeriod = "",
                         delay = 2,
                         limit = 100){
  if(!grepl("^relevance$|^new$|^comments$|^hot$|^top$", sortBy)){stop(paste0("Function does not recognize '", sortBy, "' as a sorting method. Please use 'relevance', 'new', 'top', 'hot', or'comments'."))}
  if(timePeriod != "" & sortBy != "top"){message("timePeriod arguement will be ignored. It is only required if sortBy arguement is equal to 'top'")}
  if(!grepl("^hour$|^day$|^week$|^month$|^year$|^all", timePeriod) & sortBy == "top"){
    stop("Please specify timePeriod argument from one of (hour, day, week, month, year, all).")
  }
  if(limit < 25 | limit > 100){stop("Limit must be between 25 and 100")}
  
  
  if(!is.na(searchPhrase)){searchPhrase = gsub("\\s","+",searchPhrase)}
  
  URLlist = c()
  restrict = ""
  
  if(subreddit != ""){
    subreddit = paste0("r/",gsub("\\s+","+",subreddit),"/")
    restrict = "&restrict_sr=on&"}
  searchPhrase = ifelse(is.na(searchPhrase),"",paste0("q=",searchPhrase,"&"))
  if(timePeriod != ""){timePeriod = paste0("&t=",timePeriod)}
  
  if(searchPhrase != ""){
    searchType = "search"
  } else{
    if(sortBy =="relevance" | sortBy == "comments"){
      searchType = "new"
    } else{searchType = sortBy
    }
  }
  
  #searchType = ifelse(searchPhrase == "", "new", "search")
  
  JSONprimary = JSONlink = paste0("https://www.reddit.com/", subreddit, searchType, ".json?",searchPhrase,restrict,"sort=",sortBy,timePeriod,"&limit=",limit)
  
  searchIndex = ""
  JSONafterPageID = ""
  pageCount = 0
  commentCount = 999999
  
  message("Pages loaded:")
  while(!is.null(JSONafterPageID) & pageCount < maxPages & length(searchIndex) >0){
    
    JSONraw = tryCatch(fromJSON(readLines(JSONlink, warn = FALSE)), error = function(e) NULL)
    
    if(is.null(JSONraw)){cat("Unable to retrieve, skipping...")
      next
    } else{ #else1
        JSONclean = JSONraw[[2]]$children
        
        JSONpermalinks = paste0("http://www.reddit.com",sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$permalink))
        JSONcommentCount = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$num_comments)
        JSONtitle = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$title)
        JSONsubreddit = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$subreddit)
        
        if(titleExclude == ""){
        searchIndex = which(JSONcommentCount >= minComments &
                               grepl(titleMustInclude, JSONtitle, ignore.case = TRUE, perl = TRUE))
        } else{
          searchIndex = which(JSONcommentCount >= minComments &
                                 grepl(titleMustInclude, JSONtitle, ignore.case = TRUE, perl = TRUE) &
                                 !grepl(titleExclude, JSONtitle,  ignore.case = TRUE, perl = TRUE))
        }
        
        if(length(searchIndex) > 0){
          URLlist = c(URLlist, JSONpermalinks[searchIndex])
          

          JSONafterPageID = JSONraw$data$after
          pageCount = pageCount + 1
          commentCount = tail(JSONcommentCount,1)
          JSONlink = paste0(JSONprimary, "&after=", JSONafterPageID)
        }
        
        Sys.sleep(max(2,delay))
        
        #end of else1
      }
    
    message(pageCount, ".. ", appendLF = FALSE)
    
    #end of while
  }
  
 URLlist = URLlist[!duplicated(URLlist)]
 
 if(length(URLlist) == 0){
   cat("Error: Unable to retrieve, check function arguements")} else{
     blankIndex = which(URLlist=="")
     if(length(blankIndex) >0){URLlist = URLlist[-blankIndex]}
     return(URLlist)
   }
   
#end of function  
}











retrievePostsComments = function(
  searchPhrase = NA,
  titleExclude = "",
  titleMustInclude = "",
  subreddit = "",
  minComments = "",
  maxPages = 1,
  sortBy = "hot",
  timePeriod = "",
  delay = 2,
  limit = 100){
  
  URLlist = retrieveURLs(searchPhrase,
                          titleExclude,
                          titleMustInclude,
                          subreddit,
                          minComments,
                          maxPages,
                          sortBy,
                          timePeriod,
                          delay,
                          limit)
  
  if(is.null(URLlist) | length(URLlist) == 0 | !is.character(URLlist)){stop("Error: URLlist is invalid")}
  
  # This function is from RedditExtractoR Package
  GetAttribute  = function(node,feature){
    Attribute   = node$data[[feature]]
    replies     = node$data$replies
    reply.nodes = if (is.list(replies)) replies$data$children else NULL
    return(list(Attribute, lapply(reply.nodes,function(x){GetAttribute(x,feature)})))  
  }
  
  # This function is from RedditExtractoR Package
  get.structure = function(node, depth=0) {
    if(is.null(node)) {return(list())}
    filter     = is.null(node$data$author)
    replies     = node$data$replies
    reply.nodes = if (is.list(replies)){
      replies$data$children} else{
        NULL}
    return(list(paste0(filter," ",depth), lapply(1:length(reply.nodes), function(x) get.structure(reply.nodes[[x]], paste0(depth, "_", x)))))
  }

  commentsData = data.frame(
                          id = numeric(),
                          JSONstructure = character(),
                          title = character(),
                          postDateTime = as.POSIXct(character()),
                          postAuthor = character(),
                          subreddit = character(),
                          postScore = numeric(),
                          num_comments = numeric(),
                          upvote_ratio = numeric(),
                          gildedPost = numeric(),
                          spoiler = logical(),
                          over_18 = logical(),
                          postText = character(),
                          domain = character(),
                          postURL = character(),
                          commentDateTime = as.POSIXct(character()),
                          commentAuthor = character(),
                          commentScore = numeric(),
                          commentControversiality = numeric(),
                          commentText = character(),
                          URL = character()
  )
  
  progBar = txtProgressBar(min = 0, max = length(URLlist), style = 3)
  
  
  for(i in seq(URLlist)){
    
    URLlist[i] = paste0("https://www.",gsub("^.*(reddit\\..*$)","\\1",URLlist[i]))
    URL = paste0(URLlist[i],".json?limit=500")
    
    JSONraw = tryCatch(fromJSON(readLines(URL, warn = FALSE)),error = function(e) NULL)
    if(is.null(JSONraw)){
      Sys.sleep(min(1, delay))
      JSONraw = tryCatch(fromJSON(readLines(URL, warn = FALSE)),error = function(e) NULL)
    }
    
    if(!is.null(JSONraw)){
      post.node = JSONraw[[1]]$data$children[[1]]$data
      comments.node = JSONraw[[2]]$data$children
      
      if(length(post.node) > 0 & length(comments.node) > 0){
        
        # From RedditExtractoR package
        JSONstructure = unlist(lapply(1:length(comments.node), function(x) get.structure(comments.node[[x]], x)))
        
        retrievedComments = data.frame(
                                       id = NA,
                                       JSONstructure = gsub("FALSE ","",JSONstructure[!grepl("TRUE",JSONstructure)]),
                                       title = post.node$title,
                                       postDateTime = as.POSIXlt(post.node$created_utc,origin="1970-01-01", tz = "UTC"),
                                       postAuthor = post.node$author,
                                       subreddit = post.node$subreddit,
                                       postScore = post.node$score,
                                       num_comments = post.node$num_comments,
                                       upvote_ratio = post.node$upvote_ratio,
                                       gildedPost = post.node$gilded,
                                       spoiler = as.logical(ifelse(post.node$spoiler == "true",1,0)),
                                       over_18 = as.logical(ifelse(post.node$over_18 == "true",1,0)),
                                       postText = post.node$selftext,
                                       domain = post.node$domain,
                                       postURL = post.node$url,
                                       commentDateTime = as.POSIXlt(unlist(lapply(comments.node, function(x){GetAttribute(x,"created_utc")})),origin="1970-01-01", tz = "UTC"),
                                       commentAuthor = unlist(lapply(comments.node, function(x){GetAttribute(x,"author")})),
                                       commentScore = unlist(lapply(comments.node, function(x){GetAttribute(x,"score")})),
                                       commentControversiality = unlist(lapply(comments.node, function(x){GetAttribute(x,"controversiality")})),
                                       commentText = unlist(lapply(comments.node, function(x){GetAttribute(x,"body")})),
                                       URL = URLlist[i],
                                       stringsAsFactors = FALSE
        )
        #retrievedComments$id = 1:nrow(retrievedComments)
        
        if(dim(retrievedComments)[1] != 0 & dim(retrievedComments)[2] != 0){
          commentsData = rbind(commentsData,retrievedComments)
        } else{print(paste0("missed [", i, "] ", URLlist[i]))}
      }
      
    }
    
    setTxtProgressBar(progBar,i)
    
    Sys.sleep(max(2,delay))
    # end of loop
  }
  
  close(progBar)
  commentsData$id = 1:nrow(commentsData)
  return(commentsData)
  
  #if(!grepl("^https?://(.*)",a)) a = paste0("https://www.",gsub("^.*(reddit\\..*$)","\\1",a))
  #if(!grepl("\\?ref=search_posts$",a)) a = paste0(gsub("/$","",a),"/?ref=search_posts")
  #X        = paste0(gsub("\\?ref=search_posts$","",a),".json?limit=500") # 500 is the maximum
  
  
  
  
  
  #end of function
}









retrievePosts = function(searchPhrase = NA,
                          titleExclude = "",
                          titleMustInclude = "",
                          subreddit = "",
                          minComments = "",
                          maxPages = 1,
                          sortBy = "hot",
                          timePeriod = "",
                          delay = 2,
                          limit = 100,
                          loadVoteRatio = F){
  if(loadVoteRatio == T){
    
    message("Attention: Loading upvote ratios for posts slows down retrieval process due to reddit API design.")
    postsData = retrievePostsComments(searchPhrase,
                          titleExclude,
                          titleMustInclude,
                          subreddit,
                          minComments,
                          maxPages,
                          sortBy,
                          timePeriod,
                          delay,
                          limit)[,-c(16,17,18,19,20)]
    postsData = postsData[!duplicated(postsData),]
    
    
    } else{
  if(!grepl("^relevance$|^new$|^comments$|^hot$|^top$", sortBy)){stop(paste0("Function does not recognize '", sortBy, "' as a sorting method. Please use 'relevance', 'new', 'top', 'hot', or'comments'."))}
  if(timePeriod != "" & sortBy != "top"){message("timePeriod arguement will be ignored. It is only required if sortBy arguement is equal to 'top'")}
  if(!grepl("^hour$|^day$|^week$|^month$|^year$|^all", timePeriod) & sortBy == "top"){
    stop("Please specify timePeriod argument from one of (hour, day, week, month, year, all).")
  }
      if(subreddit != "" & maxPages>10){
        maxPages =10
        message("Maximum possible value for maxPages is 10")
      }
  
  if(limit < 25 | limit > 100){stop("Limit must be between 25 and 100")}
  
  
  if(!is.na(searchPhrase)){searchPhrase = gsub("\\s","+",searchPhrase)}
  
  postsData = data.frame(
                        #id = numeric(),
                        title = character(),
                        postDateTime = as.POSIXct(character()),
                        postAuthor = character(),
                        subreddit = character(),
                        postScore = numeric(),
                        num_comments = numeric(),
                        #upvote_ratio = numeric(),
                        gildedPost = numeric(),
                        spoiler = logical(),
                        over_18 = logical(),
                        postText = character(),
                        domain = character(),
                        postURL = character(),
                        URL = character()
  )
  restrict = ""
  
  if(subreddit != ""){
    subreddit = paste0("r/",gsub("\\s+","+",subreddit),"/")
    restrict = "&restrict_sr=on&"
    
      }
  searchPhrase = ifelse(is.na(searchPhrase),"",paste0("q=",searchPhrase,"&"))
  if(timePeriod != ""){timePeriod = paste0("&t=",timePeriod)}
  
  if(searchPhrase != ""){
    searchType = "search"
  } else{
    if(sortBy =="relevance" | sortBy == "comments"){
      searchType = "new"
    } else{
      searchType = sortBy
    }
  }
  
  #searchType = ifelse(searchPhrase == "", "new", "search")
  
  JSONprimary = JSONlink = paste0("https://www.reddit.com/", subreddit, searchType, ".json?",searchPhrase,restrict,"sort=",sortBy,timePeriod,"&limit=",limit)
  
  searchIndex = ""
  JSONafterPageID = ""
  pageCount = 0
  commentCount = 999999
  
  message("Pages loaded:")
  while(!is.null(JSONafterPageID) & pageCount < maxPages & length(searchIndex) >0){
    
    JSONraw = tryCatch(fromJSON(readLines(JSONlink, warn = FALSE)), error = function(e) NULL)
    
    if(is.null(JSONraw)){cat("Unable to retrieve, skipping...")
      next
    } else{ #else1
      JSONclean = JSONraw[[2]]$children
      
      JSONpermalinks = paste0("http://www.reddit.com",sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$permalink))
      JSONcommentCount = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$num_comments)
      JSONtitle = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$title)
      JSONsubreddit = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$subreddit)
      
      #post.node = JSONclean[[1]]$data
      if(titleExclude == ""){
        searchIndex = which(JSONcommentCount >= minComments &
                               grepl(titleMustInclude, JSONtitle, ignore.case = TRUE, perl = TRUE))
      } else{
        searchIndex = which(JSONcommentCount >= minComments &
                               grepl(titleMustInclude, JSONtitle, ignore.case = TRUE, perl = TRUE) &
                               !grepl(titleExclude, JSONtitle,  ignore.case = TRUE, perl = TRUE))
      }
      
      retrievedPosts = data.frame(
        #id = NA,
        title = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$title),
        postDateTime = as.character(as.POSIXlt(sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$created_utc),origin="1970-01-01", tz = "UTC")),
        postAuthor = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$author),
        subreddit = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$subreddit),
        postScore = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$score),
        num_comments = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$num_comments),
        #upvote_ratio = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$upvote_ratio),
        gildedPost = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$gilded),
        spoiler = as.logical(ifelse(sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$spoiler) == "true",1,0)),
        over_18 = as.logical(ifelse(sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$over_18) == "true",1,0)),
        postText = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$selftext),
        domain = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$domain),
        postURL = sapply(seq(JSONclean),function(x)JSONclean[[x]]$data$url),
        URL = JSONpermalinks,
        stringsAsFactors = FALSE
      )[searchIndex,]
      
      
      
      if(dim(retrievedPosts)[1] != 0 & dim(retrievedPosts)[2] != 0){
        postsData = rbind(postsData, retrievedPosts)
        
        
        JSONafterPageID = JSONraw$data$after
        pageCount = pageCount + 1
        commentCount = tail(JSONcommentCount,1)
        JSONlink = paste0(JSONprimary, "&after=", JSONafterPageID)
      }
      
      Sys.sleep(max(2,delay))
      
      #end of else1
    }
    
    message(pageCount, ".. ", appendLF = FALSE)
    
    #end of while
  }
  
  postsData = postsData[!duplicated(postsData),]
  
  if(dim(postsData)[1] == 0){
    cat("Error: Unable to retrieve, check function arguements")} else{
      blankIndex = which(postsData[,2]=="")
      if(length(blankIndex) >0){postsData = postsData[-blankIndex]}
      
    }
  
  #postsData$id = 1:nrow(postsData)
  postsData = cbind(data.frame(id =1:nrow(postsData)), postsData)
  postsData$postDateTime = as.POSIXct(postsData$postDateTime)
  return(postsData)
  
  }
  #end of function  
}






retrieveUserData = function(
  userList, makeUnique = TRUE, progressBar = TRUE){
  
  if(makeUnique == TRUE)userList = unique(userList)
  
  userData = data.frame(
    userName = character(),
    isSuspended = logical(),
    userSince = as.POSIXct(character()),
    postKarma = numeric(),
    commentKarma = numeric(),
    isEmployee = logical(),
    isMod = logical(),
    goldMember = logical(),
    verifiedEmail = logical(),
    hasSubscribed = logical())
  
  if(progressBar == TRUE)progBar = txtProgressBar(min = 0, max = length(userList), style = 3)
  
  j = 1
  
  for(i in userList){
  
    JSONlink = paste0("https://www.reddit.com/user/", i, "/about.json")
    JSONraw = tryCatch(fromJSON(readLines(JSONlink, warn = FALSE)), error = function(e) NULL)
    
    if(is.null(JSONraw)){message("Unable to retrieve, skipping...")
      next
    } else{
      JSONclean = JSONraw[[2]]
      
      retrievedUsers = retrieveSingleUser(JSONclean)
      
      userData = rbind(userData, retrievedUsers)
  
    }
    if(progressBar == TRUE)setTxtProgressBar(progBar,j)
    j = j + 1
    #end of loop
  } 
  if(progressBar == TRUE)close(progBar)
  return(userData)
  #end of function
}

retrieveSingleUser = function(JSONclean){
  if(as.logical(is.null(JSONclean$is_suspended) == FALSE)){
    retrievedUser = data.frame(
      userName = as.character(JSONclean$name),
      isSuspended = TRUE,
      userSince = NA,
      postKarma = NA,
      commentKarma = NA,
      isEmployee = NA,
      isMod = NA,
      goldMember = NA,
      verifiedEmail = NA,
      hasSubscribed = NA)
    }else{
  retrievedUser = data.frame(
    userName = as.character(JSONclean$name),
    isSuspended = FALSE,
    userSince = as.POSIXct(JSONclean$created_utc, origin="1970-01-01", tz = "UTC"),
    postKarma = as.numeric(JSONclean$link_karma),
    commentKarma = as.numeric(JSONclean$comment_karma),
    isEmployee = as.logical(JSONclean$is_employee),
    isMod = as.logical(JSONclean$is_mod),
    goldMember = as.logical(JSONclean$is_gold),
    verifiedEmail = ifelse(is.null(as.logical(JSONclean$has_verified_email)),"NULL",as.logical(JSONclean$has_verified_email)),
    hasSubscribed = as.logical(JSONclean$has_subscribed))
  }
  return(retrievedUser)
  
}
  

