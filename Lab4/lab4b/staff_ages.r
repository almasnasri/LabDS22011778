cat("=== Staff Ages Factor Analysis ===\n")

# Age vector from image
ages <- c(57,52,51,58,59,56,60,65,52,54,56,57,46,48,79)
print("Age vector:")
print(ages)

# Create factor (auto levels: unique sorted 46,48,51,52,54,56,57,58,59,60,65,79 → 12 levels)
age_factor <- factor(ages)
print("Factor levels:")
print(levels(age_factor))  # 12 levels as shown
print("Number of levels:")
print(nlevels(age_factor)) # 12

# Count total staff
total_staff <- length(ages)
cat("\nTotal number of staff:", total_staff, "\n")  # 15

# Define age ranges as ordered factor for grouping
age_ranges <- cut(ages, 
                  breaks = c(0, 50, 55, 58, 60, 65, Inf), 
                  labels = c("<=50", "50-54", "55-57", "58-59", "60-64", ">=65"),
                  right = FALSE)
range_factor <- factor(age_ranges, ordered = TRUE)
print("\nAge range factor levels:")
print(levels(range_factor))

# Count staff per range (matches table ? → counts)
range_table <- table(range_factor)
print("\nStaff by Age Range | Total:")
print(range_table)

cat("\nInsights:\n")
cat("- Factor levels: 12 unique ages (46 to 79), shows distinct values.[web:30]\n")
cat("- Most staff 50-59 (majority in 51-59 range).\n")
cat("- 1 staff >=65 (age 79 outlier).\n")
cat("- Useful for categorical analysis despite numeric data.[web:33]\n")

cat("\nActivity complete!\n")
