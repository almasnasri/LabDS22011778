# TEB2164 Lab 10b — Almas Nasri
# Task 1: Theoph — linear regression, plot, summary, predict dose at 90/95/100 kg
# Task 2: ChickWeight — k-NN for Diet, choose k, confusion matrix

# ----- TASK 1: Theoph -----
data(Theoph)

# One row per subject: dose (mg/kg) vs body weight (kg); repeated rows share same Wt/Dose
theoph_sub <- unique(Theoph[, c("Subject", "Wt", "Dose")])

cat("=== TASK 1: Theoph (one row per subject, n =", nrow(theoph_sub), ") ===\n")
print(theoph_sub)

model_dose <- lm(Dose ~ Wt, data = theoph_sub)
cat("\n--- Model: Dose ~ Wt ---\n")
print(summary(model_dose))

cat("\n--- Discussion (summary) ---\n")
cat(
  "R-squared and F-statistic show how well weight explains variation in oral dose.\n",
  "Check sign of Wt coefficient: negative means higher predicted dose at lower weight\n",
  "(clinical dosing adjusted by body size). Predictions below are from this linear fit.\n\n"
)

# Regression plot (Wt on x, Dose on y)
plot(
  theoph_sub$Wt,
  theoph_sub$Dose,
  pch = 16,
  col = "darkblue",
  main = "Theoph: oral theophylline dose vs body weight",
  xlab = "Weight (kg)",
  ylab = "Dose (mg/kg)"
)
abline(model_dose, col = "red", lwd = 2)

new_wt <- data.frame(Wt = c(90, 95, 100))
pred_dose <- predict(model_dose, new_wt)
cat("--- Predicted dose (mg/kg) at Wt = 90, 95, 100 kg ---\n")
print(data.frame(Wt_kg = new_wt$Wt, predicted_Dose_mg_per_kg = round(pred_dose, 4)))
cat(
  "\nNote: training Wt range is about",
  round(min(theoph_sub$Wt), 1), "–",
  round(max(theoph_sub$Wt), 1),
  "kg; 90–100 kg is extrapolation — interpret cautiously.\n\n"
)

# ----- TASK 2: ChickWeight (k-NN, predict Diet) -----
data(ChickWeight)

library(caTools)
library(class)

set.seed(42)
split <- sample.split(ChickWeight$Diet, SplitRatio = 0.7)
train_df <- subset(ChickWeight, split == TRUE)
test_df <- subset(ChickWeight, split == FALSE)

# Features: weight and Time (days); response: Diet
train_x <- train_df[, c("weight", "Time")]
test_x <- test_df[, c("weight", "Time")]
train_scale <- scale(train_x)
test_scale <- scale(test_x)

cat("=== TASK 2: ChickWeight k-NN (predict Diet from weight + Time) ===\n")
cat("Train rows:", nrow(train_df), " Test rows:", nrow(test_df), "\n\n")

# Try k = 1, 3, ..., 21 (odd k common for classification)
k_candidates <- seq(1, 21, by = 2)
acc <- numeric(length(k_candidates))
names(acc) <- paste0("k=", k_candidates)

for (i in seq_along(k_candidates)) {
  k <- k_candidates[i]
  pred <- knn(
    train = train_scale,
    test = test_scale,
    cl = train_df$Diet,
    k = k
  )
  acc[i] <- mean(pred == test_df$Diet)
}

cat("Accuracy by k:\n")
print(round(acc, 4))

k_opt <- k_candidates[which.max(acc)]
cat("\nChosen optimal k (max accuracy on this split):", k_opt,
    "  accuracy =", round(max(acc), 4), "\n")

classifier_knn <- knn(
  train = train_scale,
  test = test_scale,
  cl = train_df$Diet,
  k = k_opt
)

cm <- table(Actual = test_df$Diet, Predicted = classifier_knn)
cat("\n--- Confusion matrix (test set, optimal k) ---\n")
print(cm)

cat(
  "\n--- Discussion ---\n",
  "Rows: actual Diet; columns: predicted Diet.\n",
  "Diagonal counts are correct classifications; off-diagonals are mistakes.\n",
  "Diet is somewhat separable using growth (weight) and day (Time) in this split.\n",
  "Different random seeds / splits can change best k slightly — report the k you used.\n",
  sep = ""
)
