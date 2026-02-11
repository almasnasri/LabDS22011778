cat("=== BMI Calculator ===\n")

# User inputs
weight <- as.numeric(readline(prompt = "Enter weight (kg): "))
height <- as.numeric(readline(prompt = "Enter height (cm): ")) / 100  # Convert to meters

# Calculate BMI
bmi <- weight / (height ^ 2)
cat("BMI:", round(bmi, 2), "\n")

# Determine status
underweight <- bmi <= 18.4
normal <- bmi >= 18.5 & bmi <= 24.9
overweight <- bmi >= 25.0 & bmi <= 39.9
obese <- bmi >= 40.0

# Sample expected output format
cat("\nSample expected output:\n")
cat("Underweight  :", underweight, "\n")
cat("Normal       :", normal, "\n")
cat("Overweight   :", overweight, "\n")
cat("Obese        :", obese, "\n")

# Status message
if (underweight) {
  status <- "Underweight"
} else if (normal) {
  status <- "Normal"
} else if (overweight) {
  status <- "Overweight"
} else {
  status <- "Obese"
}
cat("Status:", status, "\n")

