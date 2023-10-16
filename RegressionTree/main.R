wine <- read.csv("RegressionTree/whitewines.csv")
print(str(wine))
hist(wine$quality)

wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]

#install.packages("rpart")

#for visualizing the plot
#install.packages("rpart.plot")
#install.packages("RWeka")
library(rpart)
library(rpart.plot)
library(RWeka)

m.rpart <-rpart(quality ~ ., data = wine_train )
rpart.plot(m.rpart,digits = 3)

p.rpart <- predict(m.rpart, wine_test)

#cor(p.rpart, wine_test$quality)

MAE <- function(actual, predicted) {
    mean(abs(actual - predicted))
}

MAE(p.rpart, wine_test$quality)