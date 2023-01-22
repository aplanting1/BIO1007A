# Functions in R
  # technically, everything in R is a function 
  sum(3,2)
  3 + 2 # + is a function 
  
#user defined functions
 # functionName <- function(argumentX=defaultX, argumentY=defaultY){desired code}
  # return(z)
  
  #local variables 
    # variables created within a function, unaccesible outside of function
  
  myFunc <- function(a=3, b=4){z <- a + b 
  return(z)
  }
myFunc() # runs defaults

myFunc(a=100, b=3.4)\

# Multiple return statements
  # FUNCTION: HardyWeinberg
  # input: an allele frequency p (0,1)
  # output: p and the frequencies of 3 genotypes AA AB BB
#-----------
HardyWeinberg <- function(p = runif(1)){
  if(p>1.0 | p < 0.0){
    return("Function failure: p must be betweeon 0 and 1")
  }
  
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p, AA=fAA, AB=fAB, BB=fBB), digits=3)
  return(vecOut)
  
}
}
    
HardyWeinberg()

HardyWeinberg(p=3)


# Create a complex default value 
#-------
# Function: fittlinear2
# fits simple regression line
# input: numeric list of predictor (x) and response (y)
#outputs: slope and p-value

fittlinear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
             pvalue=summary(myMod
)$coefficients[2,4])
  plot(x=p$x, y=p$y)
  return(myOut)
  
}
fittlinear2()
