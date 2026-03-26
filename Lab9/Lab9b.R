# ACTIVITY 1
data("ToothGrowth")
numeric_tooth <- ToothGrowth[, c("len", "dose")]
cor_matrix <- cor(numeric_tooth)
print("ToothGrowth Correlation Matrix:")
print(round(cor_matrix, 3))
# Output: len-dose r = 0.803 (STRONG positive correlation)

library(corrplot)
library(RColorBrewer)
corrplot(cor_matrix, type="upper", order="hclust", 
         tl.cex=0.8, tl.col="black", 
         col=brewer.pal(n=8, name="RdYlBu"))
# Insight: Dose strongly predicts tooth growth length (r=0.803)

# ACTIVITY 2
data(mtcars)

cat("\n=== RAW DATA ===\n")
summary(mtcars)

log_mtcars <- log1p(mtcars)
cat("\n=== LOG TRANSFORMATION ===\n")
summary(log_mtcars)  # Compresses right skew (disp, hp)

std_mtcars <- as.data.frame(scale(mtcars))
cat("\n=== STANDARD SCALING ===\n")
summary(std_mtcars)  # Mean=0, SD=1 all columns

library(caret)
preproc <- preProcess(mtcars, method="range")
minmax_mtcars <- predict(preproc, mtcars)
cat("\n=== MIN-MAX SCALING ===\n")
summary(minmax_mtcars)  # All columns 0-1 range

# DISCUSSION
cat("\n=== FINDINGS ===\n")
cat("- RAW: Wide ranges, right-skewed (disp:71-472, mpg:10-34)\n")
cat("- LOG: Compresses skew but creates negatives, suits positives\n")
cat("- STANDARD: Centers data (mean=0,sd=1), ideal for ML distances\n")
cat("- MINMAX: Bounds [0,1], preserves relationships for neural nets\n")




