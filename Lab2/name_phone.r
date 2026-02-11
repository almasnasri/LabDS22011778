cat("Enter name: ")
name <- readline()
cat("Enter phone number: ")
phone <- readline()

# Convert name to uppercase
name_upper <- toupper(name)

# Extract first 3 and last 4 digits from phone (assume 11-digit Malaysian format)
first3 <- substr(phone, 1, 3)
last4 <- substr(phone, 8, 11)  # Positions 8-11 for 01X-XXXXXXX

# Display message
message <- paste("Hi,", name_upper, ". A verification code has been sent to", first3, "-XXXX", last4)
print(message)

###############################################################################
# Test Case (matches sample)
###############################################################################
cat("\n=== Sample Test ===\n")
name_test <- "hi, charles"
phone_test <- "01412345678"  # Example Malaysian number

name_test_upper <- toupper(name_test)
first3_test <- substr(phone_test, 1, 3)
last4_test <- substr(phone_test, 8, 11)

sample_message <- paste("Hi,", name_test_upper, ". A verification code has been sent to", 
                       first3_test, "-XXXX", last4_test)
print(sample_message)  # Hi, HI, CHARLES . A verification code has been sent to 014 -XXXX 5678


