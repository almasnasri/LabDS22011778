num <- as.integer(readline("Input an integer: "))

temp <- num
sum_val <- 0

while (temp > 0) {
  digit <- temp %% 10
  sum_val <- sum_val + digit^3   # for 3-digit Armstrong definition in question
  temp <- temp %/% 10
}

if (sum_val == num) {
  cat(num, "is an Armstrong number.\n")
} else {
  cat(num, "is not an Armstrong number.\n")
}
