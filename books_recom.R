library(arules)
library(car)
library(carData)
library(mvinfluence)
install.packages("recommenderlab")
library(recommenderlab)
library(ggplot2)
library(data.table)
library(reshape2)
library(caTools)

#
books<-read.csv(choose.files())
View(books)

#meta data
str(books)

books$User.ID <- as.factor(books$User.ID)

books$Book.Rating <- as.factor(books$Book.Rating)

booksnew <- as(books,"transactions")

# rating distribustion
itemFrequencyPlot(booksnew,topN=26)
View(books)

## the datatype should be relating matrix inoreder to build recommendation engin
books_matrix<- as(booksnew, "binaryRatingMatrix")

# Popularity based
model1<- Recommender(books_matrix, method = "POPULAR")
model1

# predict for other user
recomended_items <- predict(model1,books_matrix[110:120],n=3)
as(recomended_items,"list")

##User based collabrative filtering
model2 <-Recommender(books_matrix,method = "UBCF")
model2
#predict for user
recomended_items2<-predict(model2,books_matrix[101:103],n=3)
as(recomended_items2,"list")

## Item based collaborative filtering
model3<-Recommender(books_matrix,method = "IBCF")
model3
#predict for user
recomended_items3<-predict(model3,books_matrix[110:115])
as(recomended_items3,"list")
