wbcf <- read.csv("data.csv", stringsAsFactors = FALSE)

info <- str(wbcf)

## exclude data 
wbcd <- wbcf[-1] 

wbcdtable <- table(wbcd$diagnosis)
print(wbcdtable)

##making prediction a factor
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"), labels =c("Benign", "Malignant"))

round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

#s<- summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])


##apply norminalization numeric data
#normalize <- function(x) {
  #  return((x - min(x)/ max(x)-min(x)))
#}


#wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

#check if data has been normalized
####
##s<-summary(wbcd_n$area_mean)

#
#wbcd_train_label <- wbcd[1:469,1 ]
#wbcd_test_label<- wbcd[470:569,1]
#wbcd_train <- wbcd_n[1:469, ]
#wbcd_test <- wbcd_n[470: 569, ]

#k is 21 because i picked the square root of the n data



#CrossTable(x=wbcd_test_label, y= p, prop.chisq=FALSE)


#using zscore to normalize 
wbci <- wbcf[-1] 
wbcd_z <- as.data.frame(scale(wbci[-1]))
summary <- summary(wbcd_z$area_mean)

wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,cl = wbcd_train_labels, k=21)

