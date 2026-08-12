# ============================================================
# 03 - EXPLORATORY ANALYSIS
# Diabetes 130-US Hospitals Dataset
# ============================================================

library(tidyverse)


# Load cleaned dataset ----------------------------------------

data_path <- "datasets/diabetes/diabetic_data_clean.csv"

diabetes_clean <- read_csv(
  data_path,
  show_col_types = FALSE
)


# Dataset overview --------------------------------------------

cat("Rows:", nrow(diabetes_clean), "\n")
cat("Columns:", ncol(diabetes_clean), "\n\n")

cat("Variables used in this analysis:\n")
print(
  diabetes_clean %>%
    select(insulin, readmitted) %>%
    names()
)
# Insulin treatment by readmission ----------------------------

insulin_readmission_counts <- diabetes_clean %>%
  count(insulin, readmitted)

print(insulin_readmission_counts)
# Insulin treatment by readmission - row percentages ---------

insulin_readmission_percentages <- diabetes_clean %>%
  count(insulin, readmitted) %>%
  group_by(insulin) %>%
  mutate(
    percentage = round(
      n / sum(n) * 100,
      2
    )
  ) %>%
  ungroup()

print(insulin_readmission_percentages)
