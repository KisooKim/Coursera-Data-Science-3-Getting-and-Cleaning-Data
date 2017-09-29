## Question 1
##
install.packages("httr")
install.packages("jsonlite")
library(httr)
library(jsonlite)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#
myapp <- oauth_app("github",
                   key = "use your own",
                   secret = "use your own")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API and get the data
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))


## Find where is 'datasharing'
where <- function(frame1){
    for(i in 1:length(frame1)){
        if (frame1[i,2] == "datasharing"){
            location <- i
        }
    }
    location
}
location <- where(json2)
## This gives that 12th row is 'datasharing'

## So find what we want
json2[location,]$created_at
## It gives "2013-11-07T13:25:07Z".



## Question 2
##
install.packages("sqldf")
library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
dest <- "Week 2 - Quiz 1 - Problem 2.csv"
download.file(url, dest)
acs <- read.csv(dest)

## So we need:
sqldf("select * from acs where AGEP < 50", drv="SQLite")



## Question 3
##
sqldf("select distinct AGEP from acs")



## Question 4
##
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
code <- htmlCode[c(10,20,30,100)]
lapply(code, nchar)
## so the answer is 45 31 7 25.



## Question 5
##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
dest <- "Week 2 - Quiz 1 - Problem 5.csv"
download.file(url, dest)
data <- read.fwf(dest, widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)
head(data)

# Sum up the V6 column to get 32426.7
sum(data$V6)

