# TEB2164 Lab 9b — Almas Nasri
# Task 1: ToothGrowth — correlation + heatmap (screenshot from Plots pane yourself)
# Task 2: mtcars — log, standard scale, min–max + comparison

# ----- TASK 1: ToothGrowth -----
data("ToothGrowth")
numeric_tooth <- ToothGrowth[, c("len", "dose")]
cor_matrix <- cor(numeric_tooth)
print("ToothGrowth Correlation Matrix:")
print(round(cor_matrix, 3))
# len–dose r ≈ 0.803 (strong positive correlation)

library(corrplot)
library(RColorBrewer)

corrplot(
  cor_matrix,
  type = "upper",
  order = "hclust",
  tl.cex = 0.8,
  tl.col = "black",
  col = brewer.pal(n = 8, name = "RdYlBu")
)

# Insight: Higher dose is strongly associated with longer odontoblast length (len).

# ----- TASK 2: mtcars -----
data(mtcars)

cat("\n=== RAW DATA ===\n")
summary(mtcars)

log_mtcars <- log1p(mtcars)
cat("\n=== LOG TRANSFORMATION (log1p) ===\n")
summary(log_mtcars)

std_mtcars <- as.data.frame(scale(mtcars))
cat("\n=== STANDARD SCALING ===\n")
summary(std_mtcars)

library(caret)
preproc <- preProcess(mtcars, method = "range")
minmax_mtcars <- predict(preproc, mtcars)
cat("\n=== MIN-MAX SCALING ===\n")
summary(minmax_mtcars)

# ----- DISCUSSION (Lab 9b) -----
cat("\n=== FINDINGS ===\n")
cat("- RAW: Wide scales across variables; several (e.g. disp, hp) are right-skewed.\n")
cat("- LOG1P: Pulls in large values and reduces right-skew; all values stay >= 0 on positive inputs.\n")
cat("- STANDARD: Each column mean ~0, SD ~1 — good for comparing/combining in models.\n")
cat("- MIN-MAX: Each column scaled to [0,1] — preserves order; easy to compare bounded inputs.\n")
cat("\nCompare: Log changes interpretability (log-scale); z-score and min-max keep ranks but\n")
cat("rescale differently — z-score uses spread (SD); min-max uses min/max per column.\n")

