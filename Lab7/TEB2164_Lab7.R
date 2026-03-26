df <- data.frame(
  name = c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jas"),
  score = c(12.5, 9.0, 16.5, 12.5, 12.0, 9.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)
df$score[2] <- NA
df$attempts[6] <- NA
titanic <- read.csv("titanic.csv")

sum(is.na(df))
sum(is.na(titanic))
df_cleaned <- na.omit(df)
titanic_cleaned <- na.omit(titanic)

library(dplyr)
filter(df_cleaned, score > 12)
filter(titanic_cleaned, Sex == "female" & Fare > 500)

df_sortbyscore <- arrange(df_cleaned, desc(score))
titanic_sortbyfare <- arrange(titanic_cleaned, desc(Fare))
write.csv(df_sortbyscore, "df_sortbyscore.csv", row.names = FALSE)
write.csv(titanic_sortbyfare, "titanic_sortbyfare.csv", row.names = FALSE)

df_insights <- df_cleaned %>%
  mutate(high_scorer = score > 12) %>%
  group_by(attempts) %>%
  summarise(count = n(), pct_high = round(mean(high_scorer)*100, 1), .groups = "drop")

titanic_insights <- titanic_cleaned %>%
  group_by(Embarked, Pclass) %>%
  summarise(n = n(), survived = round(mean(Survived)*100, 1), .groups = "drop") %>%
  arrange(desc(survived))

write.csv(df_insights, "Student_Insights.csv", row.names = FALSE)
write.csv(titanic_insights, "Titanic_Insights.csv", row.names = FALSE)
