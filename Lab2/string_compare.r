cat("Enter string 1: \n")
str1 <- readline()

cat("Enter string 2: \n")
str2 <- readline()

# Compare case-insensitive
similar <- tolower(str1) == tolower(str2)

cat("This program compare 2 strings. Both inputs are similar: ", similar, "\n")

###############################################################################
# Test cases (uncomment to run automatically)
###############################################################################

cat("\n=== Test Case 1 ===\n")
# Enter string 1: test
# Enter string 2: exam
str1_test1 <- "test"
str2_test1 <- "exam"
similar1 <- tolower(str1_test1) == tolower(str2_test1)
cat("Enter string 1: test\n")
cat("Enter string 2: exam\n")
cat("This program compare 2 strings. Both inputs are similar: ", similar1, "\n")  # FALSE

cat("\n=== Test Case 2 ===\n")
# Enter string 1: test
# Enter string 2: TEST
str1_test2 <- "test"
str2_test2 <- "TEST"
similar2 <- tolower(str1_test2) == tolower(str2_test2)
cat("Enter string 1: test\n")
cat("Enter string 2: TEST\n")
cat("This program compare 2 strings. Both inputs are similar: ", similar2, "\n")  # TRUE

cat("\n=== Test Case 3 ===\n")
# Enter string 1: Test
# Enter string 2: TEST
str1_test3 <- "Test"
str2_test3 <- "TEST"
similar3 <- tolower(str1_test3) == tolower(str2_test3)
cat("Enter string 1: Test\n")
cat("Enter string 2: TEST\n")
cat("This program compare 2 strings. Both inputs are similar: ", similar3, "\n")  # TRUE


