##### Diamonds FrontDoor Assessment #####

# Set directory
Majestic_Dir <- 'C:/Users/Matt/Desktop/R_Stuff'
setwd(Majestic_Dir)

# Read text file in 
diamonds_data <- read.table("diamonds.txt", 
                            sep="\t", 
                            col.names=c("price", "cut","color","clarity","depth","table","x","y","z"), 
                            fill=FALSE, 
                            strip.white=TRUE,
                            header = TRUE)
str(diamonds_data)
# Reassign the variable types to numeric where it is appropriate
diamonds_data$price <- as.numeric(diamonds_data$price)
diamonds_data$depth <- as.numeric(diamonds_data$depth)
diamonds_data$table <- as.numeric(diamonds_data$table)
diamonds_data$x <- as.numeric(diamonds_data$x)
diamonds_data$y <- as.numeric(diamonds_data$y)
diamonds_data$z <- as.numeric(diamonds_data$z)

# The size dimensions of the diamond probably plays a large part in the price (according to my gf) so lets take a look at x, y, z
## As the poster child (diamonds) of veblen goods are primarily showing status, I would guess the size is what matters as that is easily seen.  The cuts and stuff not so much 

diamonds_lm <- lm(price ~ x + y + z, data = diamonds_data)
plot(diamonds_lm)
summary(diamonds_lm)
predict(diamonds_lm)

table(diamonds_data$clarity)
head(diamonds_data)

# Just want to take a look at a couple things graphically

library(ggplot2)
library(plotly)

ggplotly(ggplot(diamonds_data,aes(color,price)) + geom_boxplot())
ggplotly(ggplot(diamonds_data,aes(clarity,price)) + geom_boxplot())
ggplotly(ggplot(diamonds_data,aes(x,price,color = clarity)) + geom_point())
ggplotly(ggplot(diamonds_data,aes(x,y,color = price)) + geom_point())
plot_ly(diamonds_data, x = ~x, y = ~y, z = ~z,marker = list(color = ~price, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>% add_markers()

# Get a subset of 1000 to test the regression of x, y, z (size) on the price
## Just choosing n = 1000
library(dplyr)
diamonds_test <- sample_n(diamonds_data,1000)

# Write this input file for Brian and attach 
## (commenting next line so doesn't run)
#write.csv(diamonds_test,"diamonds_test(input_file).csv")

# Pipe the new subset of 1000 into our model
diamonds_predictions <- as.data.frame(predict(object = diamonds_lm,newdata = diamonds_test))
names(diamonds_predictions) <- 'predicted_price_from_size'

# Create a new df to see how our predictions look compared to actual 
diamonds_test_with_predictions <- cbind.data.frame(diamonds_test,diamonds_predictions$predicted_price_from_size)
diamonds_test_with_predictions$actual_predicted_diff <- diamonds_test_with_predictions$price - diamonds_test_with_predictions$`diamonds_predictions$predicted_price_from_size`
##(commenting next line so doesn't run)
#write.csv(diamonds_test_with_predictions,"diamonds_test_with_predictions.csv")

# Just curious to see how it looks graphically
ggplotly(ggplot(diamonds_test_with_predictions,aes(clarity,actual_predicted_diff)) + geom_boxplot())
ggplotly(ggplot(diamonds_test_with_predictions,aes(color,actual_predicted_diff)) + geom_boxplot())

# *Please excuse any spelling mistakes* #

install.packages('caret')
library(caret)
lmFit<-train(price ~ x + y + z, data = diamonds_data, method = lm)
