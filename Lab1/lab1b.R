# Activity 1
numbers <- seq(1, 20)
squares <- numbers^2
print(numbers)
print(squares)

# Activity 2
num1 <- 0.956786
num2 <- 7.8345901
num1_rounded <- round(num1, 2)
num2_rounded <- round(num2, 3)
print(paste("num1:", num1_rounded))
print(paste("num2:", num2_rounded))

# Activity 3
radius <- as.numeric(readline("Enter radius: "))
area <- pi * radius^2
print(paste("Area:", round(area, 2)))
