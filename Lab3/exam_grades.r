cat("=== Exam Scores Analysis ===\n")

# Input vector: 20 records
scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61, 13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

print("Input scores:")
print(scores)

# Count grades
grade_A <- sum(scores >= 90 & scores <= 100)  # 90-100 A
grade_B <- sum(scores >= 80 & scores <= 89)  # 80-89 B
grade_C <- sum(scores >= 70 & scores <= 79)  # 70-79 C
grade_D <- sum(scores >= 60 & scores <= 69)  # 60-69 D
grade_E <- sum(scores >= 50 & scores <= 59)  # 50-59 E
grade_F <- sum(scores <= 49)                 # <=49 F

cat("\nScore  Grade  Number of students\n")
cat(sprintf("%3s-%3s  %s     %d\n", "90", "100", "A", grade_A))
cat(sprintf("%3s-%3s  %s     %d\n", "80", "89",  "B", grade_B))
cat(sprintf("%3s-%3s  %s     %d\n", "70", "79",  "C", grade_C))
cat(sprintf("%3s-%3s  %s     %d\n", "60", "69",  "D", grade_D))
cat(sprintf("%3s-%3s  %s     %d\n", "50", "59",  "E", grade_E))
cat(sprintf("%2s     %s     %d\n", "<=49", "F", grade_F))

# Pass check (>49)
passed <- scores > 49
cat("\nPass status (TRUE if >49):\n")
print(passed)

cat("\nNumber passed:", sum(passed), "\n")
cat("Number failed:", sum(!passed), "\n")


