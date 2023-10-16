concrete <- read.csv("ANN/concrete.csv")
str(concrete)
#install.packages("neuralnet")
library(neuralnet)
normalize <- function(x) {
    return((x-min(x))/(max(x)- min(x)))
}

concrete_norm <- as.data.frame(lapply(concrete,normalize))
print(concrete_norm)

concrete_train <- concrete_norm[1:773, ]
concrete_test <- concrete_norm[774:1030,]

concrete_model <- neuralnet(strength ~ ., data=concrete_train, hidden=5)
plot(concrete_model)
model_results <- compute(concrete_model, concrete_test[1:8])
predicted_strength <- model_results$net.result

cor(predicted_strength, concrete_test$strength)

model_results2 <- compute(concrete_model, concrete_test[1:8])
predicted_strength2 <- model_results2$net.result
cor(predicted_strength2, concrete_test$strength)