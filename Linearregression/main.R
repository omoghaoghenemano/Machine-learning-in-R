insurance <- read.csv("Linearregression/insurance.csv")
#install.packages("psych")
#install.packages("lm")

str(insurance)
summary(insurance$charges)
hist(insurance$charges)
print(table(insurance$region))

##checking the relationship among features
print(cor(insurance[c("age", "bmi", "children", "charges")]))

## visualizing the plot
pairs.panels(insurance[c("age", "bmi","children", "charges")])



insurance$age2 <- insurance$age^2


ins_model <- lm(charges ~ ., data = insurance)
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1,0)
summary(ins_model)
ins_model2 <- lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region, data = insurance)