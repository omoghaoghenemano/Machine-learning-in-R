
###################################
###	Basics
###################################


###
###	Extension packages
###

#	install.packages("AER")		
	# Install additional package. Therefore, select server and confirm your selection.
	# Alternative: via 'packages'

library(AER)			# Load the installed additional package (alternative: via 'packages').




#	install.packages("pdynmc")	# another very good :) package, but not required for this course







###
###	Load data sets
###

ls()				# Workspace is (still) empty

data(Grunfeld)		# Load a dataset from a package: List all avilable datasets present in all packages useing 'data()'

# Load datasets from disk. 
# Example_dataset	<- read.table(file = "c:/Daten/Beispieldatensatz.txt", header = TRUE, sep = "\t")	# see '?read.table'





###
###	Assignments
###

# '<-' is used for assignments.
1 + 2
a	<- 1 + 2
ls()		# now, object a exists

a

(b	<- 4*2)	# Assign and immediately return the value
ls()
b






###
###	Issuing of data sets 
###

# write.table(x = Grunfeld, file = "c:/Daten/Grunfeld.txt", sep = "\t")

#	alternatively, the workspace can be saved via
# save(list = ls(), file = "Workspace.RData") 
#	and loaded via
# load("Workspace.RData")











###################################
###	Data handling
###################################

###
###	Basics
###

dat	<- Grunfeld
ls()		# Now the dataset is present in the workspace as object 'dat'

dat		# Show object: also helpful for big datasets: 'head()', e.g.
head(dat)	# or 'tail(dat)'

dat[1, 3]	# Show objects from the first row and the third column.
dat[3:5, c(2, 4)]	# Show rows 3 to 5 and columns 2 and 4

dat[, "capital"]	# Show column 'capital'. Alternatively:
dat[, 3]
dat[, c(FALSE, FALSE, TRUE, FALSE, FALSE)]
dat$capital





###
###	Conditions/Conditional evaluation
###

dat$year == 1950
dat$capital <= 100

sum(dat$capital <= 100)

dat[dat$year == 1950, ]
dat[dat$year %in% 1950:1953, 1:4]

# using 'attach(dat)' you can access the columns of a dataset directly 
# (without stating the dataset's name dat$).
year
dat$year

attach(dat)		# reverse: 'detach(dat)'
#	Caution: attach can be dangerous, if you work with more than one data set simultaneously!
year
dat$year  	# still possible



dat[firm == "US Steel" & year %in% 1935:1937, ]		# & means 'and also'
dat[firm == "US Steel" | year %in% 1935:1937, ]		# | means 'or'







###################################
###	Loops and vectorized programming
###################################

###
###	At first: Matrices and matrix operations
###

(A	<- matrix(data = 1:9, ncol = 3))

t(A)	# transpose

A*A	# multiply element-wise

A %*% A	# matrix multiplication

solve(A)	# inverting (here: not possible as the determinant of A is  zero
# check:
det(A)





###
###	Loops
###

for(ro in 1:nrow(A)){
  print(
    sum(A[ro, ])
  )
}


sum(A[1, ])


for(co in 1:ncol(A)){
  print(
    sum(A[, co])
  )
}





###
###	Specialized functions and vectorized programming
###

rowSums(A)
colSums(A)

#	alternatively: rowMeans, colMeans





apply(X = A, MARGIN = 1, FUN = sum)
apply(X = A, MARGIN = 2, FUN = sum)

# see	'?apply'	and the links therein





###	 Useful vor data preparation

tapply(X = capital, INDEX = firm, FUN = mean)

# compare to:
mean(capital[firm == "General Motors"])
mean(capital[firm == "US Steel"])








###################################
###	Statistical analyses
###################################

###
###	Key figures
###

summary(dat)
fivenum(dat$capital)	# Tukey's Five (Min., 1./2./3.Quartile, Max.)
mean(dat$invest)
quantile(x = dat$value, probs = seq(from = 0.1, to = 0.9, by = 0.1))	
#	or short sequence definition:		(1:9)/10

var(dat)
sd(dat$invest)
IQR(dat$value)




###
###	Measures of coherence
###

cov(dat[, -4])
cor(dat[, -4])





###
###	Random numbers and distributions
###

set.seed(42)	# For reproducibility 
rnorm(n = 3, mean = 0, sd = 1)
rnorm(n = 3, mean = 0, sd = 1)

set.seed(42)	
rnorm(n = 3, mean = 0, sd = 1)
rnorm(n = 3, mean = 0, sd = 1)

dnorm		# Density function of a normally distibuted random variable
pnorm		# Distribution function of a normally distibuted random variable
qnorm		# Quantile function of a normally distibuted random variable



###	Other distributions

runif		# Draw random variables from the uniform distribution
dt		# t-density
pf		# F-distribution (i.e. cumulative density)
?qchisq		# Chi^2-quantile function

?Distributions







###################################
###	Functions
###################################

###
###	Structure of a function
###

lm	# function code
args(lm)	# arguments (input)
body(lm)	# body  (calculations / output)




###
###	Definition of a function
###

###	Example 1

f1	<- function(
  x
){
  set.seed(42)
  y	<- 10 + 0.5*x + rnorm(n = length(x), mean = 0, sd = 1)
  plot(x, y)
  return(y)		# Attention: return terminates the function
}

f1(5)

f1(5:50)



###	Example 2

save.mean	<- function(
  var.name
){
  mw	<- mean(get(var.name))			# Attention: 'get'
  print(paste("Mean of ", var.name, ": ", mw, sep = ""))	# Attention: 'paste'
  assign(x = paste("Mean", var.name, sep = "_"), value = mw, envir = .GlobalEnv) # Attention: 'assign' and its argument 'envir'
}

ls()
save.mean(var.name = "invest")
ls()

Mean_invest





###
###	Generic functions (Advanced topic!)
###

summary(value)

summary(dat)



class(value)
class(dat)


methods(summary)		# Which sub-functions exist that are called dependent on the object's class

# Visible sub-functions can be accessed directly
summary.default
summary.lm
?summary.lm

# Invisible sub-functions can be accessed via (if they S3-objects):
summary.nls
getS3method("summary", "nls")
?summary.nls
#	you can google S3 vs. S4 objects








###################################
###	Graphics
###################################

###
###	Simple Plots
###

plot(dat)
plot(dat$value, dat$invest)

boxplot(dat$invest)
boxplot(log(dat$invest) ~ dat$firm)





###
###	Configuring graphics ...
###

### ... within the graphics function

plot(dat$value, dat$invest, col = "blue")
plot(dat$value, dat$invest, col = "blue", xlim = c(0, 1000), ylim = c(0, 200))



### ... via par()

?par
par(bg = "yellow")
boxplot(dat$invest)







###
###	High-level graphics functions
###
#	Create a complete plot.
#	e.g. plot, boxplot, pie, ...

pie(firm)		# does not work
pie(table(firm))	# does work
table(firm)
?pie


(firm.sub	<- firm[invest > 100])
pie(table(firm.sub))
pie(table(as.character(firm.sub)), col = 1:5)
pie(table(as.character(firm.sub)), col = rainbow(5))






###
###	Low-level graphics functions
###
#	add these to an existing plot...
#	e.g. lines, points, abline, ...

plot(x = sort(unique(year)), y = value[firm == "General Motors"], col = "blue", ylim = range(value), type = "b", xlab = "Year", ylab = "Value", pch = 20)
points(x = sort(unique(year)), y = value[firm == "US Steel"], col = "red", type = "b", pch = 20)
legend(x = "bottomright", legend = c("GM", "USS"), lty = 1, col = c("blue", "red"))







###
###	Plotting of functions
###

###	Example: Sine and Cosine

curve(sin, from = 0, to = 4*pi)
curve(cos, from = 0, to = 4*pi, col = "red", add = TRUE, lty = 2)



###	Example: Density function and distribution function of a standard normally distributed random variable

curve(dnorm, from = -3, to = 3, ylim = c(0, 1))
curve(pnorm, from = -3, to = 3, add = TRUE, col = "red")
legend(x = "topleft", legend = c("density function", "distr. function"), lty = 1, col = c("black", "red"), bty = "n")







###
###	Displaying graphics
###

###	Several plots in the graphics window

par(mfrow = c(2, 3))	# Separate the graphics window into two rows and three columns
for(ye in 1935:1940){
  plot(value[year == ye], invest[year == ye], main = ye)
}
par(mfrow = c(1, 1))	# Return to default settings, alternative: dev.off()



###	Export graphics from R

# dir.create("H:/CS2_Regression-in-R")
# setwd("H:/CS2_Regression-in-R")
#
# pdf("Test.pdf")
# plot(dat)
# dev.off()		# Return graphics and exit pdf.







###################################
###	Exercises
###################################

# 1. Read Kleiber & Zeileis (2008), chapters 1 and 2.
#
# 2. State in your own words how you can discover specific quartiles from density functions and distribution functions
# (e.g. the 3. quartile).
#
# 3. Plot the quantile function and the distribution function of the standard normal distribution.
#

### DISPLAY STRUTURE OF DATA
##using  the str function can be used to display the structure of R data structures such as data Frames, vectors, or list
##> str(mydata)


