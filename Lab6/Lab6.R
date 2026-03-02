# 1. Create df data.frame
df <- data.frame(
  name = c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jas"),
  score = c(12.5, 9.0, 16.5, 12.5, 12.0, 9.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)
print(df)

# 2. Add qualify column
df$qualify <- c("yes", "no", "yes", "no", "no", "no", "yes")
print(df)

# 3. Create newrow and rbind
newrow <- data.frame(
  name = "Emily",
  score = 14.5,
  attempts = 1,
  qualify = "yes"
)
df <- rbind(df, newrow)
print(df)

# 4. Display structure
str(df)

# Display summary
summary(df)

# Number of rows and columns
cat("Number of rows:", nrow(df), "\n")
cat("Number of columns:", ncol(df), "\n")

# TITLE Number of rows and columns (lab demo)
print(df)

# TITLE View the updated data frame
View(df)


