## Getting and Cleaning Data: Week 4 - Quiz


## Problem 1
##
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dest <- "Week 4 - Quiz - Problem 1.csv"
download.file(url, dest)
data <- data.table(read.csv(dest))
data_names <- names(data)
data_names_split <- strsplit(data_names, "wgtp")
data_names_split[[123]]

## Then we get ""   "15".



## Problem 2
##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "Week 4 - Quiz - Problem 2.csv"
download.file(url, dest)
data <- data.table(read.csv(dest, skip = 4, nrows = 215, stringsAsFactors = FALSE))
data <- data[X != ""]
data <- data[, list(X, X.1, X.3, X.4)]
setnames(data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp_numeric <- as.numeric(gsub(",", "", data$gdp))
mean(gdp_numeric, na.rm=TRUE)

## Then we have 377652.4.



## Problem 3
##
isUnited <- grepl("^United", data$Long.Name)
summary(isUnited)
## We have 3 that start wiith "United."



## Problem 4
##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "Week 4 - Quiz - Problem 4-1.csv"
download.file(url, dest)
gdp <- data.table(read.csv(dest, skip = 4, nrows = 215, stringsAsFactors = FALSE))
gdp <- gdp[X != ""]
gdp <- gdp[, list(X, X.1, X.3, X.4)]
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
dest <- "Week 4 - Quiz - Problem 4-2.csv"
download.file(url, dest)
edu <- data.table(read.csv(dest))
data_merged <- merge(gdp, edu, all=TRUE, by=c("CountryCode"))
fiscal_year_end <- grepl("fiscal year end", tolower(data_merged$Special.Notes))
sum(fiscal_year_end)
june <- grepl("june", tolower(data_merged$Special.Notes))
table(fiscal_year_end, june)
# Then we have 13.



## Problem 5
##
install.packages("quantmod")
library("quantmod")
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))

# Then we have 252 from the resulting table.