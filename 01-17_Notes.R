#### Vectors, Matrices, Data Frames, Lists

# Vetors (properties)

# Coercion 
## All atomic vectors are of the same data type. If you use c() to assemble diff types, R coerces them 
  # logical -> integer -> double -> character 
  a <- c(2, 2.0) # integer and double, will coerce to double 
  
  b <- c("purple", "green")
  typeof(b)
  
  d <- c(a,b)
 typeof(d) # character
 
 a <- runif(10)
print(a)  
  a > 0.5 # picks which are over and under 0.5, conditional statement yields a logical result

# How many eleemtns in the vector are >0.5?
    sum(a > 0.5) # sums up the true statements 
    mean(a > 0.5) #proportion of vector this is greater than 0.5, not a mean of the actual values 

# Vectorization
  # adds a constant to a vector 
  z <- c(10,  20, 30)
  print (z)  
  z + 1 # adds 1 to each element in the vector
  
  # What happens when vectors are added together
  y <- c(1, 2, 3)
  z + y  #adds 1 to 10, 2 to 22, 3 to 33, etc, eleemnt by element operation
  
# Recycling
  # what if vecotr lengths are unequal 
  x <- c(1, 2)
  z + x #adds 1 then 2 then 1 again (it recycles...), issues warning, shorter vector is recycled 

# Simulating Data: runif and rnorm()
  runif(5)
    runif(n=5, min=5, max=10) #specifies min and max
  set.seed(123) # random numbers but other people can reproduce them, specifies the random numbers generated                      once the seed is set. Seed can be any number
    runif(n=5, min=5, max=10)
  
  rnorm # random normal values with mean 0 and std 1
  randomNormalNumbers <- rnorm(6) # give me 6 random numbers with mean 0 and std 1
  mean(randomNormalNumbers) # no condition specified so the mean is the mean of the numbers
  
# Matrices 
    # 2 dimensional (rows and columns), still homogenous data type (only 1 data type allowed)
    # matrix is an atomic vector organized into rows and columns 
        my_vec <- 1:12
        
        m <- matrix(data = my_vec, nrow = 4)
        m
        m <- matrix(data = my_vec, ncol = 3, byrow=T) # organizes vector across columns as opposed to by row
        m 
        
# Lists
  # are atomic vectors BUT each element can hold diff data types (and different sizes)
  myList <- list(1:10, matrix(1:8, nrow=4, byrow=T), letters[1:3], pi)
    class(myList)    
    str(myList) # glimpse of what myList looks like
    myList
    
  # subsetting lists: gives you a single item BUT not the elements
    myList[4] #gives us pi, the fourth element in myList
    myList[4] - 3 # gives you only elements in slot which is always type list, must use double brackets to grab                     object itself 
    myList[[4]]
      myList[[4]] -3 
    
    myList[[2]][4,1] # I want the 4th row and 1st column of my matrix
  
  # name list items when they are created
    myList2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow=3))
    myList2$Tester # $ accesses named elements
    myList2$littleM[2,3] # pulls 2nd row, 3rd column of littleM
    myList2$littleM[2,] #leaving blank to pull entire second row of matrix
    
  # unlist to string everything back to vector form
      unRolled <- unlist(myList2)
      unRolled

    data(iris)    
    head(iris)    
    plot(Sepal.Length ~ Petal.Length, data=iris)    
    model <- lm(Sepal.Length ~ Petal.Length, data=iris)   
      results <- summary(model)
      results
      str(results)
        results$coefficients
      results$coefficients[8] #pulls petal length p value
      unRolled2 <- unlist(results)
      unRolled2
        unRolled2[["coefficients8"]] #could just do unlist(results)$coefficents8
  
# Data Frames
  # (list of) equal length vectors, each of which is a column
  varA <- 1:12
  varB <- rep(c("con", "lowN", "highN"), each=4)      
  varC <- runif(12)
  
  dFrame <- data.frame(varA, varB, varC, stringsAsFactors=FALSE)
  print(dFrame)  

  #adding another row
    newData <- list(varA=13, varB="highN", varC=0.668)
    #use rbind
      dFrame <- rbind(dFrame, newData) #adds new data to dFrame, we can't use c() b/c it will coerce data type                                         into character only
  #adding a column
      newVar <- runif(13)
      #use cbind 
        dFrame <- cbind(dFrame, newVar)
        
# Data Frames vs Matrices
  zMat <- matrix(data=1:30, ncol=3, byrow=T)
  zdFrame <- as.data.frame(zMat) # as functions will coerce something into a diff structure if possible
  
  zMat[3,3]
  zdFrame[3,3]      
  
  #column referencing
  zMat[,3]
  zdFrame[,3]  
  zdFrame$V3 #can't do this with matrix b/c no automatic names
  
  #row referencing
  zMat[3,]
  zdFrame[3,]

  zMat[3] #give me the 3rd element
  zdFrame[3] #gives the 3rd element, but the 3rd element in dFrame is the entire column

# Eliminating NA's 
  # complete.cases() function 
  zD <- c(NA, rnorm(10), NA, rnorm(3))
  complete.cases(zD) #gives logical output of vector
  zD[complete.cases(zD)] #cleans out NA's
  which(!complete.cases(zD)) #which is not an NA? 
    which(is.na(zD)) #same as above
  
  #use with matrix
    m <- matrix(1:20, nrow=5)
    m[1,1] <- NA
    m[5,4] <- NA
    complete.cases(m) #gives T/F as to whether whole row is complete (no NA's)
    m[complete.cases(m),] #gives rows without NA's in entire matrix
    
    m[complete.cases(m[,c(1:2)]),] #only look at first two columns of matrix to give rows w/o NA's
  
  # Finshing up matrices and data frames (1/9/23)
    
    m10 <- matrix(data = 1:12, nrow=3)
    
    #subsetting based on elements  (eliminates whoe=le row/column)
    m10[1:2, ]
    m10 [, 2:4]
    
    #sugestting with logical statemnents. Select all columns for which totals > 15
    colSumsm10 > 15
    m1[colSums(m10) > 15]
    
    #row sums
      # all rows that sum up to 22
      m10[rowSums(m10)==22]
  
    # Logical operators
       # == != < >
      
    # subsetting to a vector changes the data type!
        z2 <- m10[1, , drop=FALSE] # subset a matrix but keep it was a 
      
    # simulate new matrix
        m12 <- matrix(data=runif(9), nrow=1)
        m12
        m12 [3.2]
        
    
    
    
  