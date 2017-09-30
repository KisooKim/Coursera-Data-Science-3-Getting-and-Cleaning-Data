## Getting and Cleaning Data: Week 3 - Quiz


## Problem 1
##

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dest <- "Week 3 - Quiz - Problem 1.csv"
download.file(url, dest)
data <- data.table(read.csv(dest))
agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)[1:3]
## Then we get 125 238 262.



## Problem 2
##

install.packages("jpeg")
library(jpeg)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
dest <- "Week 3 - Quiz - Problem 2.jpg"
download.file(url, dest, mode="wb")
img <- readJPEG(dest, native = TRUE)
quantile(img, probs = c(0.3, 0.8))
## Then we get -15259150 -10575416



## Problem 3
##

# Load first data
library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "Week 3 - Quiz - Problem 3-1.csv"
download.file(url, dest)
data1 <- read.csv(dest, skip = 4, nrows = 215)
setnames(data1, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP","Long.Name", "gdp"))

# Load second data
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
dest2 <- "Week 3 - Quiz - Problem 3-2.csv"
download.file(url2, dest2)
data2 <- read.csv(dest2)

# Merge the two and count to have 189.
data_merged <- merge(data1, data2, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(data_merged$rankingGDP)))

# Sort in desc and get the 13th country,  St. Kitts and Nevis.
sorted <- arrange(data_merged, desc(rankingGDP))
sorted[13,]$Short.Name



## Problem 4
##
selected <- select(sorted,Income.Group, rankingGDP)
group_by <- group_by(selected, Income.Group)
summarize(group_by, mean(rankingGDP,na.rm=TRUE))

## From the result we have 32.96667 for "High income: OECE"
## and 91.91304 for "High income: nonOECD."



## Problem 5
##

## Make a table.
table(data_merged$rankingGDP, data_merged$Income.Group)

## Count quantile
quant <- quantile(data_merged$rankingGDP, na.rm=TRUE)
upper <- quant[3] # = 95.5
lower <- quant[4] # = 142.75

## Count the intersection of the two groups and get 5.
top38 <- data.frame(sorted[1:38,][,1])
names(top38)[1] <- "CountryCode"
lowermiddle <-  data.frame(subset(data_merged, Income.Group=='Lower middle income'))
common <- intersect(top38$CountryCode, lowermiddle$CountryCode) 
length(common)
