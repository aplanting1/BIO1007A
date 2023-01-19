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
    