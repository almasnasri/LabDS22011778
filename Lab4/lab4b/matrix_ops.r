cat("=== 3x3 Matrix Operations ===\n")

# Vector V1 (9 elements for 3x3)
V1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
print("V1:")
print(V1)

# Matrix-1: 3x3 row-major
Matrix1 <- matrix(V1, nrow = 3, byrow = TRUE)
rownames(Matrix1) <- c("R1", "R2", "R3")
colnames(Matrix1) <- c("C1", "C2", "C3")
cat("\nMatrix-1:\n")
print(Matrix1)

# Matrix-2: Transpose of Matrix-1
Matrix2 <- t(Matrix1)
rownames(Matrix2) <- colnames(Matrix1)  # Rename rows to old cols
colnames(Matrix2) <- rownames(Matrix1)  # Rename cols to old rows
cat("\nMatrix-2 (Transpose):\n")
print(Matrix2)

# Operations (element-wise)
cat("\nAddition:\n")
print(Matrix1 + Matrix2)

cat("\nSubtraction:\n")
print(Matrix1 - Matrix2)

cat("\nMultiplication (element-wise):\n")
print(Matrix1 * Matrix2)

cat("\nDivision (element-wise):\n")
print(Matrix1 / Matrix2)

cat("\nMatrix product (%*%):\n")
print(Matrix1 %*% Matrix2)  # Proper transpose product


