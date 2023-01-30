# ggplot2

library(ggplot2)
library(ggthemes)
library(patchwork)

# ggplot code template
  # plus <- ggplot(data= <DATA>,mapping=aes(<x = xVar, y=yVar>) + <GEOM_FUNCTION> ## +geom_bloxplot()
    # print(plus)
    # aes=aesthetics
  d <- mpg
  str(mpg)  
    library(dplyr)  
    glimpse(d)  
  # quick plots (qplot): quick plotting 
      qplot(x=d$hwy) # basic histogram
      qplot(x=d$hwy,fill=I("purple"),color=I("pink")) # I function must come before color
      
      qplot(x=d$displ,y=d$hwy,geom=c("smooth", "point")) # scatter plot
          # method=lm after point), will make linear model
      
      qplot(x=d$fl, y=d$cty,geom="boxplot",fill="pink")  # box plot

  # bar plot with specified counts or means
      x_treatment <- c("Control","Low","High")
      y_response <- c(12,2.5,22.9)
      qplot(x=x_treatment,y=y_response,geom="col",fill=I(c("paleturquoise","palegreen","plum")))
          # google "colors in r" to find all available colors
      
      
# ggplot: uses dataframes instead of vectors
      p1 <- ggplot(data=d, mapping=aes(x=displ,y=cty, color=cyl)) + geom_point() # don't need $ bc specified          data is from variable d, need geom_point to make points instead of empty plot
      print(p1)
      
      p1 + theme_bw() # can add + then function to edit plot
      p1 + theme_bw()
      p1 + theme_classic()
      p1 + theme_dark()
      p1 + theme_minimal()
      
      p1 + theme_classic(base_size=20,base_family="serif") # alters font size and font type
      
      p2 <- ggplot(data=d, aes(x=fl,fill=fl)) + geom_bar()
      print(p2)
      
      p2 + coord_flip() # flips coordinates
      p2 + coord_flip() + theme_classic(base_size=20,base_family="sans")

      # minor theme mods
      p3 <- ggplot(data=d, aes(x=displ,y=cty)) +
        geom_point(size=2,
                   shape=21,
                   color="plum",
                   fill="steelblue") 
      labs(title="My graph title here",
           subtitle="An extended subtitle that will print below the main title",
           x="My x axis label",
           y="My y axis label") 
      # p3 + xlim(0,4) + ylim(0,20)
      print(p3)
      
      library(viridis)
      col <- viridis(7, option = "magma") # magma is a theme
      ggplot(data=d, aes(x = class, y = hwy, fill=class)) +
        geom_boxplot() +
        scale_fill_manual(values = col)  
# creating multipanel figure
      library (patchwork)
      p1 + p2 + p3 # puts them side by side
      p1 / p2 / p3 # puts them on top of each other
      (p1 + p2) / p3 # puts p1 and p2 over p3
      