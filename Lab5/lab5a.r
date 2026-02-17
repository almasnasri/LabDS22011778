year <- as.integer(readline("Input year: "))

if ((year %% 400 == 0) || (year %% 4 == 0 && year %% 100 != 0)) {
  cat(year, "is a leap year.\n")
} else {
  cat(year, "is a not leap year.\n")
}
