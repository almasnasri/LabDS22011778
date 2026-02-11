cat("=== 1.1 Factor Construction ===\n")
data <- c("East","West","East","North","North","East","West","West","West","East","North")
print(data)
print(is.factor(data))  # FALSE - character vector
factor_data <- factor(data)
print(factor_data)      # Factor with levels East North West (alphabetical)
print(is.factor(factor_data))  # TRUE
print(length(factor_data))     # 11
cat("Conclusion: factor() converts vector to factor w/ alphabetical levels.[web:30]\n\n")

cat("=== 1.2 Accessing Factor Elements ===\n")
data <- factor(c("East","West","East","North","North","East","West","West","West","East","North"))
print(data[3])  # [1] East - 3rd element
cat("Conclusion: [] indexing accesses specific elements.[web:33]\n\n")

cat("=== 1.3 Factor Elements Manipulation ===\n")
data <- factor(c("East","West","East","North","North","East","West","West","West","East","North"))
print(data[3])  # East
data[3] <- "NorthWest"  # Adds new level if not exist
print(data[3])  # NorthWest
cat("Conclusion: Assignment adds new levels dynamically.[web:30]\n\n")

cat("=== 1.4 Changing Order of Levels ===\n")
data <- c("East","West","East","North","North","East","West","West","West","East","North")
factor_data <- factor(data)
print(factor_data)  # Default alphabetical: East North West
new_order_data <- factor(factor_data, levels = c("East","West","North"))
print(new_order_data)  # Custom order: East West North
cat("Conclusion: levels= arg sets custom order.[web:31]\n\n")

cat("=== 1.5 Factor Level Generation ===\n")
v <- gl(3, 4, labels = c("Tampa", "Seattle","Boston"))  # 3 levels, each repeated 4x
print(v)
cat("Conclusion: gl() generates balanced factors.[web:30]\n\n")

cat("=== 2.1 Matrix Construction ===\n")
M <- matrix(c(3:14), nrow = 4, byrow = TRUE)
print(M)  # Row-major fill
N <- matrix(c(3:14), nrow = 4, byrow = FALSE)
print(N)  # Column-major fill (default)
rownames = c("row1", "row2", "row3", "row4")
colnames = c("col1", "col2", "col3")
P <- matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames = list(rownames, colnames))
print(P)
cat("Conclusion: byrow=TRUE fills rows first; dimnames adds labels.[web:35][web:36]\n\n")

cat("=== 2.2 Accessing Matrix Elements ===\n")
P <- matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames = list(rownames, colnames))
print(P[1,3])  # row1 col3: 11
print(P[4,2])  # row4 col2: 10
print(P[2,])   # row2: 6 7 8
print(P[,3])   # col3: 11 8 5 12
cat("Conclusion: [row,col]; omit for row/col slices.[web:39]\n\n")

cat("=== 2.3 Matrix Addition & Subtraction ===\n")
matrix1 <- matrix(c(3, 9, -1, 4, 2, 6), nrow = 2)
print(matrix1)
matrix2 <- matrix(c(5, 2, 0, 9, 3, 4), nrow = 2)
print(matrix2)
result <- matrix1 + matrix2
cat("Addition:\n"); print(result)
result <- matrix1 - matrix2
cat("Subtraction:\n"); print(result)
cat("Conclusion: Element-wise +/-.[web:13]\n\n")

cat("=== 2.4 Matrix Multiplication & Division ===\n")
matrix1 <- matrix(c(3, 9, -1, 4, 2, 6), nrow = 2)
print(matrix1)
matrix2 <- matrix(c(5, 2, 0, 9, 3, 4), nrow = 2)
print(matrix2)
result <- matrix1 * matrix2
cat("Multiplication (element-wise):\n"); print(result)
result <- matrix1 / matrix2
cat("Division (element-wise):\n"); print(result)
cat("Conclusion: * / are element-wise (* for Hadamard).[web:13]\n\n")

cat("=== 3.1 Array Construction ===\n")
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)
result <- array(c(vector1,vector2), dim = c(3,3,2))
print(result)  # 3x3x2 array
cat("Conclusion: array() creates multi-dim from vectors.[web:44]\n\n")

cat("=== 3.2 Naming Columns/Rows ===\n")
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)
column.names <- c("COL1","COL2","COL3")
row.names <- c("ROW1","ROW2","ROW3")
matrix.names <- c("Matrix1","Matrix2")
result <- array(c(vector1,vector2), dim = c(3,3,2), 
                dimnames = list(row.names, column.names, matrix.names))
print(result)
cat("Conclusion: dimnames=list(rows,cols,slices).[web:36]\n\n")

cat("=== 3.3 Accessing Array Elements ===\n")
result <- array(c(vector1,vector2), dim = c(3,3,2), 
                dimnames = list(row.names, column.names, matrix.names))
print(result[3,,2])    # ROW3 of Matrix2
print(result[1,3,1])   # ROW1 COL3 Matrix1: 3
print(result[,,2])     # Full Matrix2
cat("Conclusion: [row,col,slice]; omit for margins.[web:44]\n\n")

cat("=== 3.4 Array Manipulation ===\n")
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)
array1 <- array(c(vector1,vector2), dim = c(3,3,2))
vector3 <- c(9,1,0)
vector4 <- c(6,0,11,3,14,1,2,6,9)
array2 <- array(c(vector3,vector4), dim = c(3,3,2))
matrix1 <- array1[,,2]
matrix2 <- array2[,,2]
result <- matrix1 + matrix2
print(result)
cat("Conclusion: Extract slices, operate element-wise.[web:13]\n\n")

cat("=== 3.5 apply() on Array ===\n")
new.array <- array(c(vector1,vector2), dim = c(3,3,2))
print(new.array)
result <- apply(new.array, 1, sum)  # Sum rows across matrices
print(result)
cat("Conclusion: apply(array, margin=1 rows, FUN=sum).[web:37]\n\n")


