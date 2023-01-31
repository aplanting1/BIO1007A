## Simple Data Analyses and More Complex Control Structures

library(ggthemes)
library(tidyverse)

dryadData <- read.table("BIO1007A_Data/veysey-babbitt_data_amphibians.csv", header=TRUE, sep=",")


# Diff analyses 
  # Experimental Designs
    #  independent versus dependent variables
    #  discrete versus continuous variables (range of numbers is cont, discrete is categorical)
      # cont on both axes is regression via scatterplot 
      # x is cat y is cont is t-test/standard ANOVA via box plot or bar graph 
      # cat on both axes is chi-squared via table, mosaic
      # x is cont y is cat is logistic regression via logistic curve 
    #  continuous variables (integer and real)
    #  direction of cause and effect, x axis is independent
    #  continuous versus discrete (natural or arbitrary or statistical bins)

# Basic linear regression 
  # Is there a relationship between mean pool hydroperiod and number of breeding frogs caught?

regModel <- lm(count.total.adults~mean.hydro,data=dryadData) #function lm(), y comes first then x
summary(regModel)
hist(regModel$residuals) 

summary(regModel)$"r.squared")km
summary(regModel)[["r.squared"]

regPlot <- ggplot(data=dryadData,aes(x=mean.hydro,y=count.total.adults)) +
 geom_point() + stat_smooth(method=lm,se=0.99) # default se=0.95 
 regPlot + theme_few()                  

 # Basic ANOVA
  # Was there a statisticallyANOmodel <- aov(count.total.adults~factor(wetland),data=dryadData)
 ANOmodel <- aov(count.total.adults~factor(wetland),data=dryadData)
 print(ANOmodel)
 summary(ANOmodel)
 
 dryadData %>%
   group_by(wetland) %>%
   summarise(avgHydro = mean(count.total.adults, na.rm=T), N=n())

# Box plot 
  dryadData$wetland <- factor(dryadData$wetland)
  class(dryadData$wetland)
  
  ANOplot <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults, fill=species)) + 
    geom_boxplot() + scale_fill_grey()
  ANOplot  

# Logistic regression using a data frame
  
  xVar <- sort(rgamma(n=200,shape=5,scale=5)) # gamma distribution for all positive values and normal ditribution 
  yVar <- sample(rep(c(1,0),each=100),prob=seq_len(200)) 
  logRegData <- data.frame(xVar,yVar)

  logRegModel <- glm(yVar ~ xVar, #glm is generalized linear model 
                   data=logRegData,
                   family=binomial(link=logit))
  summary(logRegModel)
  
  logRegPlot <- ggplot(data=logRegData, aes(x=xVar,y=yVar)) +
    geom_point() +
    stat_smooth(method=glm, method.args=list(family=binomial))
  print(logRegPlot)

# Contingency tables  (chi-squared analysis)              
  # Are there differneces in counts of males and females between species
  
  countData<- dryadData %>%
    group_by(species) %>%
    summarize(Males=sum(No.males, na.rm=T), Females=sum(No.females, na.rm=T)) %>%
    select(-species) %>% # removing species column 
    as.matrix() 
  countData
  row.names(countData)=c("SS","WF")
  countData    

  # chi-squared
  chisq.test(countData)$residuals
  
  # mosaic plot
  mosaicplot(x=countData,
             col=c("goldenrod","grey"),
             shade=FALSE)
  
  countDataLong <- countData %>%
    as_tibble() %>% # needs to be tibble and not matrix to pivot longer
    mutate(Species=c(rownames(countData))) %>%
    pivot_longer(cols=Males:Females, # specifying the columns we want longer
                 names_to = "Sex",
                 values_to = "Count")
  ggplot(countDataLong, aes(x=Species, y=Count, fill=Sex)) +
    geom_bar(stat="identity", position="dodge") + # dodge plots bars next to each other 
    scale_fill_manual(values=c("black", "darkslateblue"))
  
  
##############################

# if and ifelse statements
  # if (condition) {expression1}
  # if (condition) {expression1} else {expression2}
  # can connect multiple ifelse statements 
  #  if (condition1) {expression1} else
  #  if (condition2) {expression2} else
  
  # use for single values, else must appear on same line as the expression 
  
  z <- signif(runif(1),digits=2)
  if (z>0.8) {cat(z, "is a largne number", "\n")} else
    if (z < 0.2) {cat(z,"is a small number","\n")} else
    {cat(z,"is a number of typical size","\n") # anything between the above specifications 
      cat("z^2 =",z^2,"\n")} # if it is of a typical size, square it 

# ifelse to fill vectors
#  Suppose we have an insect population in which each female lays, on average, 10.2 eggs, following a Poisson distribution (discrete probability distribution showing the likely number of times an event will occur) with λ=10.2. However, there is a 35% chance of parasitism, in which case no eggs are laid
  
  tester <- runif(1000) # start with random uniform elements
  eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0) # if the value is >0.35, make rand pois integer. if the value is <0.35 then make a value of 0
  hist(eggs)
  
# Suppose we have a vector of p values (say from a simulation), and we want to create a vector to highlight the significant ones for plotting purposes.
  pVals <- runif(1000)
  z <- ifelse(pVals<=0.025,"lowerTail","nonSig") # if lower say lowerTail, if not then say nonSig
  z[pVals>=0.975] <- "upperTail"
  table(z)

#-----------------------
# for loops: workhous for repetitive tasks
  #Controversial in R
    #often not necessary (use vectorized operations!)
    #very slow with binding operations (c,rbind,cbind,list)
    #many operations can be handled by special family of apply functions
  
 # for (var in seq) { start of for loop
    # body of for loop 
 # }  end of for loop
#  var is a counter variable that will hold the current value of the loop
 # seq is an integer vector (or a vector of character strings) that defines the starting and ending values of the loop
  
  for (i in 1:5) { # counter variable and how many times we want it to loop
    cat("stuck in a loop",i,"\n") # stuck in a loop, display counter, insert break     
    cat(3 + 2,"\n")
    cat(3+i,"\n") 
  }
  
  my_dogs <- c("chow","akita","malamute","husky","samoyed") # counter variable, single for loop
  for (i in 1:length(my_dogs)){
    cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
  } 
  
# double for loops
  m <- matrix(round(runif(20),digits=2),nrow=5)
  # loop over rows
  for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
    m[i,] <- m[i,] + i # loop through each row, take the value that is there and add it to i
  } 
  print(m)
  
  # Loop over columns
  m <- matrix(round(runif(20),digits=2),nrow=5)
  for (j in 1:ncol(m)) {
    m[,j] <- m[,j] + j # go to the jth column and add j to those columns (j is convention for columns)
  }
  print(m)
  
  # Loop over rows and columns
  m <- matrix(round(runif(20),digits=2),nrow=5)
  for (i in 1:nrow(m)) {
    for (j in 1:ncol(m)) {
      m[i,j] <- m[i,j] + i + j
    } # end of column j loop
  } # end or row i loop
  print(m) 
  