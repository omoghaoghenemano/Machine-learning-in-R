sms_data <- read.table("/Users/mano/rcomp/spam/SMSSpamCollection.txt", header = FALSE , sep = "\t", quote = "")
colnames(sms_data) <- c("Label", "Message")

# Print the data frame


#write.csv(sms_data, "sms_data.csv", row.names = FALSE)

sms_raw <- read.csv("spam/sms_data.csv", stringsAsFactors = FALSE)
str(sms_raw)

#create a factor

sms_raw$Label <- factor(sms_raw$Label)
table(sms_raw$Label)

sms_corpus <- Corpus(VectorSource(sms_raw$Message))


corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)

## tokenization

sms_dtm <- DocumentTermMatrix(corpus_clean)


###Training Data preparation split data in to 75%
sms_raw_train <- sms_raw[1:4181, ]
sms_raw_test <- sms_raw[4182: 5574,]

sms_dtm_train <- sms_dtm[1:4181, ]
sms_dtm_test <- sms_dtm[4182: 5574,]

sms_corpus_train <- corpus_clean[1:4181]
sms_corpus_test <- corpus_clean[4182: 5574]

###visualizing text data using word cloud
spam <- subset(sms_raw_train, Label == "spam")
ham <- subset(sms_raw_train, Label == "ham") 

wordcloud(sms_corpus_train, min.freq = 50, random.order = FALSE)

wordcloud(spam$Message, max.words = 40 , scale = c(3,0.5))
wordcloud(ham$Message, max.words = 40 , scale = c(3,0.5))

freq_terms <- findFreqTerms(sms_dtm_train, 5)


sms_dict <- c(freq_terms)

sms_train <- DocumentTermMatrix(sms_corpus_train, list(dictionary = sms_dict))
sms_test <- DocumentTermMatrix(sms_corpus_test, list(dictionary = sms_dict))


convert_counts <- function(x){
    x <- ifelse(x > 0, 1, 0)
    x <- factor(x, levels = c(0,1), labels = c("No", "Yes"))
    return(x)
}

sms_train <- apply(sms_train, MARGIN = 2, convert_counts )
sms_test <- apply(sms_test, MARGIN = 2, convert_counts )



#train model on the data
sms_classifier <- naiveBayes(sms_train, sms_raw_train$Label)
sms_predictions <- predict(sms_classifier, sms_test)
CrossTable(sms_predictions, sms_raw_test$Label, prop.chisq =FALSE, prop.t = FALSE, dnn=(c('predicted', 'actual')))

##adding lplace estimator 
sms_classifier2 <- naiveBayes(sms_train, sms_raw_train$Label, laplace = 1)
sms_test_pred2  <- predict(sms_classifier2, sms_test)

CrossTable(sms_test_pred2, sms_raw_test$Label, prop.chisq =FALSE, prop.t = FALSE, dnn=(c('predicted', 'actual')))