# TEB2164 Lab8b - Almas Nasri - March 2026
# Task 1: Titanic Analysis (Lab7 files)
# Task 2: Chickwts Built-in Dataset

# ========================================
# TASK 1: TITANIC (External Lab7 CSV)
setwd("C:/Users/almas/Documents/LabDS22011778/Lab7")
titanic <- read.csv("titanic_sortbyfare.csv", stringsAsFactors=TRUE)

# Bar Chart: Survivors by Class
png("TitanicSurvivors Bar.png", width=800, height=600)
barplot(table(titanic$Pclass, titanic$Survived),
        main="Titanic: Survivors by Passenger Class",
        xlab="Class", ylab="Count",
        col=c("red", "green"), beside=TRUE,
        legend.text=c("Died", "Survived"))
dev.off()

# Box Plot: Age by Survival
png("TitanicAge BoxPlot.png", width=800, height=600)
boxplot(Age ~ Survived, data=titanic,
        main="Titanic: Age Distribution by Survival",
        xlab="Survived (0=Died, 1=Survived)", ylab="Age",
        col=c("red", "green"))
dev.off()

# ========================================
# TASK 2: CHICKWEIGHTS (Built-in R Dataset)
data(chickwts)

# Bar Chart: Number of Chicks by Feed Type
png("ChickenNum Bar.png", width=800, height=600)
feed_counts <- table(chickwts$feed)
barplot(feed_counts,
        main="Chicken Weights Dataset: Chicks by Feed Type",
        xlab="Feed Type", ylab="Number of Chicks",
        col="skyblue", border="darkblue")
dev.off()

# Box Plot: Weight by Feed Type
png("Chicken Weight BoxPlot.png", width=800, height=600)
boxplot(weight ~ feed, data=chickwts,
        main="Chicken Weight by Feed Type (6 weeks)",
        xlab="Feed Type", ylab="Weight (grams)",
        col=c("lightblue","lightgreen","pink","orange","yellow","violet"),
        varwidth=TRUE, notch=TRUE)
dev.off()

cat("Lab8b COMPLETE: 4 PNG plots saved in Lab8 folder\n")
cat("Task 1: Titanic (2 plots)\n")
cat("Task 2: Chickwts (2 plots)\n")
