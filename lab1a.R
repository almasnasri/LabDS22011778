cat("=== 2.1 Simple R Code ===\n")
print(2 + 3)
print("Hello World!")

cat("\n=== test.R equivalent ===\n")
# My first program in R Programming
myString <- "Hello, World!"
print(myString)

cat("\n=== 2.2 R Variables ===\n")
var.1 <- 5
var_1 <- 7
x <- 1
print(ls())          
print(ls(pattern = "var"))  

cat("\n=== 2.3 Assignment Operations ===\n")
Gender <- "Female"   
print(Gender)

height <<- 152       
print(height)

Weight = 81         
print(Weight)

3 -> f              
print(f)

23.5 ->> x          
print(x)

b <- seq(from = 0, to = 5)  
print(b)

c <- seq(from = 0, to = 10, by = 2)  
print(c)

v = 2L             
print(v)

w <<- 2 + 5i       
print(w)

a <- charToRaw("Hello")  
print(a)

cat("\n=== Class Checks ===\n")
print(class(Gender))  # character 
print(class(height))  # numeric
print(class(f))       # numeric
print(class(x))       # numeric
print(class(b))       # numeric
print(class(v))       # integer 
print(class(w))       # complex 

cat("\n=== 2.4 Arithmetic Operations ===\n")
print(f + 3)         # Addition 
print(height - x)    # Subtraction
print(Weight * 2)    # Multiplication
print(b ** 2)        # Element-wise power (or ^) 
print(c ^ 5)         # Element-wise power
m = height / 100     # Height in meters
print(Weight / (m ** 2))  # BMI calculation 
BMI = Weight / (m ** 2)
print(BMI)
print(b %% 2)        # Modulus (even/odd remainders)
print(c %/% 2)       # Integer division 

cat("\n=== 2.5 User Input ===\n")
name <- readline(prompt = "Enter name: ")
age <- readline(prompt = "Enter age: ")
age <- as.numeric(age)
print(paste("Hi,", name, "this year you are", age, "years old."))

cat("\n=== 2.6 Extra ===\n")
# ?paste  # Uncomment to run in console: shows help for paste() [web:11]
# demo(graphics)  # Runs graphics demo
# demo(image)     # Runs image demo
?paste
demo(graphics)
demo(image)
