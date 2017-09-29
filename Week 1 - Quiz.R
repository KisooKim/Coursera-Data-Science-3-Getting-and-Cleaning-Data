## Getting and Cleaning Data: Week 1 - Quiz 1


## Problem 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dest <- "Week 1 - Quiz 1 - Problem 1.csv"
download.file(url, dest)
data <- read.csv(dest)
length(which(data$VAL==24))



## Problem 3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
dest <- "Week 1 - Quiz 1 - Problem 3.xlsx"
download.file(url, dest,mode='wb')

library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx(file=dest,sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)



## Problem 4
install.packages("XML")
library(XML)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
dest <- "Week 1 - Quiz 1 - Problem 4.xml"
download.file(url, dest)
xml.data <- xmlTreeParse(dest, useInternalNodes=TRUE)
rootNode <- xmlRoot(xml.data)
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
length(which(zipcodes==21231))



## Problem 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
dest <- "Week 1 - Quiz 1 - Problem 5.xml"
download.file(url, dest)
install.packages("data.table")
library(data.table)
DT <- fread(dest)
DT[, mean(pwgtp15), by=SEX]