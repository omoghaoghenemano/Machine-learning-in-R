credit <- read.csv("Decisiontree/german_credit_data.csv")
str(credit)


table(credit$Checking.account)

table(credit$Saving.accounts)

set.seed(12345)
credit_rand <- credit[order(runif(1000)),]

credit_train <- credit_rand[1:900, ]
credit_test <- credit_rand[901:1000, ]

#training a model on the data
credit_model <- C5.0(credit_train[-17], credit_train$Housing, trials = 10)
