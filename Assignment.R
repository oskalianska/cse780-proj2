#install.packages("GGally")
#install.packages("caret") 

library(datasets)
library(ggplot2) 
library(GGally)
library(readxl)
library(ggplot2)
library(lattice)
library(caret)


#clear global workspace
rm(list = ls())

# load data
data(iris)

#display the first rows
head(iris)

# display the internal structure
str(iris)

levels(iris$Species)

# check NA values in the dataset
sum(is.na(iris))

iris <- iris[-c(51:100), ]

# split data into training/testing sets
smp_size <- floor(0.75 * nrow(iris))

## set the seed to make reproducible results
set.seed(1)
sample <- sample(seq_len(nrow(iris)), size = smp_size)

train<-iris[sample,]
test<-iris[-sample,]

# explore the dataset with the help of plots
ggpairs(train)

# model fitting
y<-train$Species
x<-train$Sepal.Width

model<-glm(y~x, family = binomial(logit), data=train)
summary(model)

newdata<- data.frame(x=test$Sepal.Width)
pr <- predict(model, newdata, type="response")
prediction<-data.frame(test$Sepal.Width, test$Species,pr)
prediction

qplot(prediction[,1], round(prediction[,3]), col=prediction[,2], xlab = 'Sepal Width', ylab = 'Prediction')

