cat("=== Student Records List ===\n")

# Store records in named list
students <- list(
  "Roberts" = 51,
  "Scarlett" = 68,
  "Larson" = 65,
  "Paul" = 92,
  "Renner" = 99
)

print("Student records:")
print(students)

# Highest score
max_score <- max(unlist(students))
cat("\nHighest score:", max_score, "\n")

# Student with highest score
highest_student <- names(students)[which.max(students)]
cat("Student with highest score:", highest_student, "\n")

# Lowest score
min_score <- min(unlist(students))
cat("Lowest score:", min_score, "\n")

# Student with lowest score
lowest_student <- names(students)[which.min(students)]
cat("Student with lowest score:", lowest_student, "\n")

# Average score
avg_score <- mean(unlist(students))
cat("Average score:", round(avg_score, 2), "\n")

