# TEB2164 Lab10b - Almas Nasri - Linear Regression & KNN in R
# Submit this .R + screenshots/PDF to GA

# Packages (install if needed)
library(caTools)
library(e1071)
library(class)

# ACTIVITY 1: Theoph Linear Regression
data(Theoph)
model_theoph <- lm(Dose ~ Wt, data=Theoph)
summary(model_theoph)  # Screenshot: R²=0.9794, p<2e-16
plot(Theoph$Wt, Theoph$Dose, col="blue", pch=16, cex=1.3, 
     main="Dose vs Weight Regression", xlab="Weight (kg)", ylab="Dose (mg/kg)")
abline(model_theoph, col="red", lwd=2)  # Screenshot plot
new_weights <- data.frame(Wt = c(90, 95, 100))
predictions <- predict(model_theoph, new_weights)
print(predictions)  # 3.037, 2.648, 2.259 mg/kg - Screenshot

# DISCUSSION 1: Excellent fit (R²=97.9%); dose decreases 0.078 mg/kg per kg weight.

# ACTIVITY 2: ChickWeight KNN Classifier (predict Diet)
data(ChickWeight)
ChickWeight$weight <- as.numeric(as.character(ChickWeight$weight))
split_chick <- sample.split(ChickWeight, SplitRatio = 0.7)
train_chick <- subset(ChickWeight, split_chick == TRUE)
test_chick <- subset(ChickWeight, split_chick == FALSE)
train_target <- train_chick$Diet

features <- c("Time", "weight")
train_scale <- scale(train_chick[,features])
test_scale <- scale(test_chick[,features])

k_values <- c(1,3,5,7,15,19)
for(k in k_values) {
  knn_pred <- knn(train_scale, test_scale, cl=train_target, k=k)
  cm <- table(test_chick$Diet, knn_pred)
  acc <- 1 - mean(knn_pred != test_chick$Diet)
  cat("K=", k, "Accuracy:", round(acc,3), "\n")
  print(cm); cat("\n")
}
# Optimal K=19 (acc~0.38) - Screenshot highest acc matrix

# DISCUSSION 2: K=19 optimal (38.1% acc); high errors (off-diagonals) due to feature overlap.

cat("Lab10b COMPLETE - Submit .R + screenshots\n")
