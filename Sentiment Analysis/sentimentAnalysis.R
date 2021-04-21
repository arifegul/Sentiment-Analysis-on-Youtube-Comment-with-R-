# social media package
library(vosonSML)
library(dplyr)
library(magrittr)
#emotion sentiment package
library(syuzhet)
library(SentimentAnalysis)

#getting the comments from youtube
API_key <-"---------------------------"  #Enter your API_key

youtubeAuth  <- Authenticate("youtube", apiKey = API_key)

#Collect data 
videos <- c('wMpqCRF7TKg', 'Ur_wAcYDnuA')
youtubeData <- youtubeAuth %>% 
  Collect(videos, writeToFile = FALSE, verbose = FALSE, maxComments = 1500)
str(youtubeData)

# write csv
write.csv(youtubeData, file = "youtubecomments.csv", row.names = FALSE)

#read youtube csv data file

data <- read.csv(file.choose(), header = T)
str(data)
comments <- iconv(data$Comment ,to = 'UTF-8')

#obtain sentiment scores
s <- get_nrc_sentiment(comments)
head(s)
s$neutral <-ifelse(s$negative+s$positive==0,1,0)

#bar plot

barplot(150*colSums(s)/sum(s),
        las =2,
        col=rainbow(10),
        ylab = "percentage",
        main="sentiment scores of youtube comments")




