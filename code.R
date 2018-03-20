# Libraries
library(dplyr)     # Data Manipulation
library(zoo)       # Time Series
library(ggplot2)   # Visualising Data
library(gridExtra) # Visulaising multiple plots at a time

# Taking in Input
testdf <- read.table("./SCONES_test.tsv",sep="\t",header=TRUE)

# 2 Different samples seperated by chr attribute
sample1 <- testdf %>% filter(chr==1) %>% select(-1)
sample2 <- testdf %>% filter(chr==2) %>% select(-1)

# Data cleaning (Outlier Removal)
sample1 <- sample1 %>% filter(is.finite(testSample1),is.finite(testSample2))
sample2 <- sample2 %>% filter(is.finite(testSample1),is.finite(testSample2))

# Creating ratios
sample1 <- sample1 %>% mutate(Ratio=testSample2/testSample1)
sample2 <- sample2 %>% mutate(Ratio=testSample2/testSample1)

# Since Most of them generated Negative Values in Ratio considering absolute values for log2()
sample1 <- sample1 %>% mutate(logRatio=log2(abs(Ratio)))
sample2 <- sample2 %>% mutate(logRatio=log2(abs(Ratio)))

# Considering it as a time series (Since start and end was given)
ts1 <- zoo(sample1$logRatio,sample1$start)
ts2 <- zoo(sample2$logRatio,sample2$start)

## Noise Reduction Using Simple Moving Average

# Choosen '3' After some Trial and Errors
ts1_filtered <- rollmean(ts1,3) 
ts2_filtered <- rollmean(ts2,3)

# For the missing values (taking dates from ts1) 
empty <- zoo(,index(ts1))
ts1_filtered <-merge(ts1_filtered,empty,all = TRUE )
empty <- zoo(,index(ts2))
ts2_filtered <- merge(ts2_filtered,empty,all = TRUE )

# Filling them with most recent data Except the first one which does'nt have recent one
ts1_filtered <- na.locf(ts1_filtered,na.rm = F)
ts2_filtered <- na.locf(ts2_filtered,na.rm = F)
ts1_filtered["0"] <- coredata(ts1["0"])
ts2_filtered["0"] <- coredata(ts2["0"])

## Plotting Them together for difference

# Merging them together into dataframes for easing visualisation
sample1_final <- NULL
sample1_final$start <- index(ts1)
sample1_final <- as.data.frame(sample1_final)
sample1_final$logRatio <- coredata(ts1_filtered)

sample2_final <- NULL
sample2_final$start <- index(ts2)
sample2_final <- as.data.frame(sample2_final)
sample2_final$logRatio <- coredata(ts2_filtered)

# Plotting Them
plot1 <- ggplot() +
         geom_point(data=sample1,aes(x=start,y=logRatio),colour="green") +
         geom_point(data=sample1_final,aes(x=start,y=logRatio),colour="red",alpha=0.28)+xlab("Start")+ylab("LogRatio Signal")+ggtitle("Sample 1")

plot2 <- ggplot() +
  geom_point(data=sample2,aes(x=start,y=logRatio),colour="green") +
  geom_point(data=sample2_final,aes(x=start,y=logRatio),colour="red",alpha=0.28)+xlab("Start")+ylab("LogRatio Signal")+ggtitle("Sample 2")

grid.arrange(plot1,plot2) # plots them together

# Saving the filtered Data
write.csv(file="Sample1_filtered.csv",sample1_final,row.names = FALSE)
write.csv(file="Sample2_filtered.csv",sample2_final,row.names = FALSE)
