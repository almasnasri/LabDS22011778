cat("=== Activity 1: Sequence of 20 numbers and squares ===\n")
numbers <- 1:20  # or seq(1, 20)
squares <- numbers ^ 2
print(numbers)
print(squares)

cat("\n=== Activity 2: Rounding numbers ===\n")
num1 <- 0.956786
num2 <- 7.8345901
print(round(num1, 2))   # 0.96
print(round(num2, 3))   # 7.835

cat("\n=== Activity 3: Circle Area Calculator ===\n")
radius <- as.numeric(readline(prompt = "Enter radius: "))
area <- pi * radius ^ 2
print(paste("Circle's area:", round(area, 2)))

