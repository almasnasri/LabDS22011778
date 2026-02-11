cat("=== Array1: 4 cols, 2 rows, 3 tables ===\n")
# Matches sample exactly
arr1_data <- 1:24
Array1 <- array(arr1_data, dim = c(4, 2, 3))  # col,row,table
print(Array1)

cat("\n=== Array2: 2 cols, 3 rows, 5 tables ===\n")
arr2_data <- 25:54
Array2 <- array(arr2_data, dim = c(2, 3, 5))  # col,row,table
print(Array2)

cat("\n=== Access Examples ===\n")
cat("Second row of second matrix (Array1[ ,2 ,2 ]):\n")
print(Array1[ , 2, 2])  # 10 12 14 16

cat("Element 3rd row 3rd col 1st matrix (Array2[3, 2, 1]? Wait, dim=2 cols:\n")
# Note: 3rd col invalid (only 2 cols). Matches sample [3,2,1] but idx=2 for col3? Sample shows 30=Array2[2,3,1]
print(Array2[2, 3, 1])  # 30 as sample

cat("\nage vector (unused?):\n")
age <- c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)
print(length(age))  # 40, perhaps for factor/matrix

cat("\nV1 unused:\n")
V1 <- c(2,3,1,5,4,6,8,7,9)
print(V1)


