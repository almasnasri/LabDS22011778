cat("=== Chemistry & Physics Exam Analysis ===\n")

# Chemistry scores (named vector)
chem_scores <- c("Robert" = 59, "Hemsworth" = 71, "Scarlett" = 83, 
                 "Evans" = 68, "Pratt" = 65, "Larson" = 57, 
                 "Holland" = 62, "Paul" = 92, "Simu" = 92, "Renner" = 59)

# Physics scores (named vector)
phys_scores <- c("Robert" = 89, "Hemsworth" = 86, "Scarlett" = 65, 
                 "Evans" = 52, "Pratt" = 60, "Larson" = 67, 
                 "Holland" = 40, "Paul" = 77, "Simu" = 90, "Renner" = 61)

print("Chemistry scores:")
print(chem_scores)
print("Physics scores:")
print(phys_scores)

# Count fails (<=49)
chem_fails <- sum(chem_scores <= 49)
phys_fails <- sum(phys_scores <= 49)

cat("\nChemistry fails (<=49):", chem_fails, "\n")
cat("Physics fails (<=49):", phys_fails, "\n")

# Highest scores & students
chem_max <- max(chem_scores)
chem_best <- names(chem_scores)[which.max(chem_scores)]
phys_max <- max(phys_scores)
phys_best <- names(phys_scores)[which.max(phys_scores)]

cat("\nChemistry highest score:", chem_max, "by", chem_best, "\n")
cat("Physics highest score:", phys_max, "by", phys_best, "\n")


