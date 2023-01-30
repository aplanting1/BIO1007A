# The tidyverse

#tidyverse: collection of packages that share philosophy, grammar (or how the code is structured), and data structures

# Operators: symbols that tell R to preform diff operations (between variables, functions, etc)
  # Arithmetic operators: + - * / ^
  # Assignment operator: <- 
  # Logical operators: ! & or 
      ## not, and, or
  # Relational: ==, !=, >,...
  # Miscellaneous operators: %>% (forward pipe operator) %in%

# Library function to load in packages (ones that aren't in base R)

#dplyr: new(er) packages that provides a tool set for manipulating data sets 
  # written to be fast 
  # indiv functions that correspond to common operations 

# The 5 core verbs
  # filter ()
  # arrange ()
  # select ()
  # group_by() and summarize ()
  # mutate ()

## Examples of dyplar
  data(starwars)
  class(starwars)
    # tbl: modern take on data frames (eliminates annoying aspects of dataframes)
  glimpse (starwars) # gives summary of starwars structure, much cleaner than printing out entire structure
  
# Cleaning up data
    # check for NA's
      anyNA(starwars)
      
  starwarsClean <- starwars[complete.cases(starwars[,1:10]),] # complete cases of star wars, all rows, first ten     coloumns
    anyNA(starwarsClean[,1:10])
    
# Filter (): picks/subsets observations (rows) by their values
    filter(starwarsClean, gender == "masculine" & height < 180 & height >100) # multiple conditions for same var
    
# %in% operator (matching operator)
    # similar to == but you can compare vectors of different lengths
      a <- LETTERS[1:10]
      length(a)

      b <- LETTERS[4:10]
      length(b)  
      
      # output of %in% operator depends on first vector
        a %in% b # is a in b/what elements of a are in b?
        b %in% a # is b in a?
        
    # use %in% to subset
        filter(starwars, eye_color %in% c("blue", "brown")) #what elements of starwars have blue or brown               colored eyes
        
# arrange (): reorders rows 
      arrange(starwarsClean, by=height) # organized based on height 
      # can organize in descending order 
      arrange(starwarsClean, by=desc(height))
      
      arrange(starwarsClean, height, desc (mass)) # second variable used to break any ties between first             ariable
      
      sw <- arrange(starwars, by=height); tail(sw) #missing values are at the end 
      
# select (): chooses variables (columns) by their names 
      select(starwarsClean, 1:10)
      select(starwarsClean, name:species)
      select(starwarsClean, -(films:starships)) # everything except films to starships 
      
# rearrange columns
      select(starwarsClean, name, gender, species, everything()) #everything() is a helper function that is           useful if you have a few variables you want to move to the front 
      
      # contains function
        select(starwarsClean, contains("color")) #show me column names that have "color" in it 
        
      # others include
         # ends_with(), starts_with (), num_range()
      
# select can rename columns
      select(starwarsClean, haircolor =hair_color)
      rename(starwarsClean, haircolor = hair_color) #returns whole df 
      
# mutate(): creates new variables using functions of exissting variables
      # create new colum that is height/mass 
          mutate(starwarsClean, ratio= height/mass)

          starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)  
          starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything())          
            glimpse(starwars_lbs)          

# Want new data frame with mutated variable (transmute)
      transmute(mutate(starwarsClean, mass_lbs=mass*2.2)) # returns mutated columns  
      
# group_by and summarize functions 
      summarize(starwarsClean, meanHeight=mean(height)) # assign new column name, spits out value for column
      
      summarize(starwarsClean, meanHeight=mean(height), TotalNumber=n())
    
      # use group_by for maximum usefulness, spits out desired grouping
        starwarsGenders <- group_by(starwars, gender)
        head(starwarsGenders)                
        summarize(starwarsGenders, meanHeight=mean(height, na.rm=T), TotalNumber=n())      
        
        
#Piping %>% taking output of one function and using it as input of next function 
      # used to emphasize a sequnce of actions
      # allows you to pass an intermediate result onto next function 
      #avoid if you need to manipulate more than one object at once or if you meaningful intermediate var's
      # formatting: space before the pipe (%>%) followed by a new line 
          starwarsClean %>%
            group_by(gender) %>%
            summarize(meanHeight=mean(height, na.rm=T), TotalNumber=n())

# case_when() is useful for mult if or if.else statements
      starwarsClean %>%
        mutate(sp = case_when
               (species=="Human" ~ "Human", T ~ "Non-Human")) #put something here if its true, put the other in                 the other column if it is not true. Human if true in sp column, non-human if false
    