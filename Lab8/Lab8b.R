# TEB2164 Lab8b - Almas Nasri - March 2026
# Task 1: Titanic Analysis (Lab7 CSV)
# Task 2: Chickwts built-in dataset
#
# Plots are written to this Lab8 folder (not Lab7).

lab7 <- "C:/Users/almas/Documents/LabDS22011778/Lab7"
lab8 <- "C:/Users/almas/Documents/LabDS22011778/Lab8"
dir.create(lab8, showWarnings = FALSE)

# ========================================
# TASK 1: TITANIC (external Lab7 file)
titanic <- read.csv(file.path(lab7, "titanic_sort_byfare.csv"), stringsAsFactors = TRUE)

# Bar chart: rows = passenger class, cols = survival (0 = died, 1 = survived)
# beside = TRUE gives two bars per class (died vs survived).
tbl_ps <- table(titanic$Pclass, titanic$Survived)
png(file.path(lab8, "TitanicSurvivors_Bar.png"), width = 800, height = 600)
barplot(
  tbl_ps,
  beside = TRUE,
  col = c("#d62728", "#2ca02c"),
  main = "Titanic: Counts by Passenger Class and Survival",
  xlab = "Passenger class",
  ylab = "Count",
  legend.text = c("Died", "Survived"),
  args.legend = list(x = "topright", bty = "n", inset = 0.02)
)
dev.off()

# Box plot: age by survival
png(file.path(lab8, "TitanicAge_BoxPlot.png"), width = 800, height = 600)
boxplot(
  Age ~ Survived,
  data = titanic,
  main = "Titanic: Age Distribution by Survival",
  xlab = "Survived (0 = Died, 1 = Survived)",
  ylab = "Age",
  col = c("#d62728", "#2ca02c")
)
dev.off()

# ========================================
# TASK 2: CHICKWEIGHTS (built-in)
data(chickwts)

png(file.path(lab8, "ChickenNum_Bar.png"), width = 800, height = 600)
feed_counts <- table(chickwts$feed)
barplot(
  feed_counts,
  main = "Chicken Weights Dataset: Chicks by Feed Type",
  xlab = "Feed type",
  ylab = "Number of chicks",
  col = "skyblue",
  border = "darkblue"
)
dev.off()

png(file.path(lab8, "ChickenWeight_BoxPlot.png"), width = 800, height = 600)
boxplot(
  weight ~ feed,
  data = chickwts,
  main = "Chicken Weight by Feed Type (6 weeks)",
  xlab = "Feed type",
  ylab = "Weight at 6 weeks (g)",
  col = c("lightblue", "lightgreen", "pink", "orange", "yellow", "violet"),
  varwidth = TRUE,
  notch = TRUE
)
dev.off()

cat("Lab8b complete: PNG files saved under:\n", lab8, "\n", sep = "")
cat("Task 1: TitanicSurvivors_Bar.png, TitanicAge_BoxPlot.png\n")
cat("Task 2: ChickenNum_Bar.png, ChickenWeight_BoxPlot.png\n")
