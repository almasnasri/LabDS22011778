# 1. Create the data frame
df <- data.frame(
  name = c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jonas"),
  score = c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)

print(df)

# 2. Add new column
df$qualify <- c("yes", "no", "yes", "no", "no", "no", "yes")
print(df)

# 3. Add new row
new_row <- data.frame(
  name = "Emily",
  score = 14.5,
  attempts = 1,
  qualify = "yes"
)

df <- rbind(df, new_row)
print(df)

# 4. Display structure, summary, rows and columns
str(df)

df$qualify <- as.factor(df$qualify)
summary(df)

cat("Number of rows:", nrow(df), "\n")
cat("Number of columns:", ncol(df), "\n")
