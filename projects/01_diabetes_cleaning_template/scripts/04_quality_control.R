# ============================================================
# 04 - QUALITY CONTROL
# Diabetes 130-US Hospitals Dataset
# ============================================================

library(tidyverse)


# Load cleaned dataset ----------------------------------------

if (!exists("diabetes_clean")) {
  
  stop(
    "Object 'diabetes_clean' not found. ",
    "Run 02_data_cleaning.R before running 04_quality_control.R."
  )
}


# Dataset dimensions ------------------------------------------

cat("============================================================\n")
cat("QUALITY CONTROL - CLEANED DATASET\n")
cat("============================================================\n\n")

cat("Rows:", nrow(diabetes_clean), "\n")
cat("Columns:", ncol(diabetes_clean), "\n\n")


# ID quality checks -------------------------------------------

duplicated_encounters <- sum(
  duplicated(diabetes_clean$encounter_id)
)

duplicated_patients <- sum(
  duplicated(diabetes_clean$patient_nbr)
)

unique_patients <- n_distinct(
  diabetes_clean$patient_nbr
)

unique_encounters <- n_distinct(
  diabetes_clean$encounter_id
)


qc_ids <- data.frame(
  check = c(
    "Total records",
    "Unique encounters",
    "Duplicated encounter IDs",
    "Unique patients",
    "Duplicated patient IDs"
  ),
  value = c(
    nrow(diabetes_clean),
    unique_encounters,
    duplicated_encounters,
    unique_patients,
    duplicated_patients
  )
)

cat("ID quality control:\n")
print(qc_ids)


# Export ID QC results ----------------------------------------

write_csv(
  qc_ids,
  "documentation/qc_id_check.csv"
)

cat("\nID quality control table exported successfully.\n")


# Remaining '?' values ---------------------------------------

question_mark_counts <- sapply(
  diabetes_clean,
  function(x) {
    sum(as.character(x) == "?", na.rm = TRUE)
  }
)

question_mark_table <- data.frame(
  variable = names(question_mark_counts),
  remaining_question_marks = as.numeric(question_mark_counts)
)

question_mark_table <- question_mark_table[
  question_mark_table$remaining_question_marks > 0,
]

cat("\nRemaining '?' values after cleaning:\n")

if (nrow(question_mark_table) == 0) {
  
  cat("No remaining '?' values detected.\n")
  
} else {
  
  print(question_mark_table)
}


# Missingness by variable ------------------------------------

missing_counts <- sapply(
  diabetes_clean,
  function(x) {
    sum(is.na(x))
  }
)

missingness_table <- data.frame(
  variable = names(missing_counts),
  missing_count = as.numeric(missing_counts)
)

missingness_table$missing_percentage <- round(
  (missingness_table$missing_count / nrow(diabetes_clean)) * 100,
  2
)

missingness_table <- missingness_table[
  missingness_table$missing_count > 0,
]

missingness_table <- missingness_table[
  order(-missingness_table$missing_percentage),
]

cat("\nMissingness by variable:\n")
print(missingness_table)


# Export missingness results ---------------------------------

write_csv(
  missingness_table,
  "tables/missingness_table.csv"
)

cat("\nMissingness table exported successfully.\n")


# Numeric range quality control -------------------------------

range_checks <- data.frame(
  check = c(
    "time_in_hospital >= 1",
    "num_lab_procedures >= 1",
    "num_procedures >= 0",
    "num_medications >= 1",
    "number_outpatient >= 0",
    "number_emergency >= 0",
    "number_inpatient >= 0",
    "number_diagnoses >= 1"
  ),
  invalid_records = c(
    sum(diabetes_clean$time_in_hospital < 1, na.rm = TRUE),
    sum(diabetes_clean$num_lab_procedures < 1, na.rm = TRUE),
    sum(diabetes_clean$num_procedures < 0, na.rm = TRUE),
    sum(diabetes_clean$num_medications < 1, na.rm = TRUE),
    sum(diabetes_clean$number_outpatient < 0, na.rm = TRUE),
    sum(diabetes_clean$number_emergency < 0, na.rm = TRUE),
    sum(diabetes_clean$number_inpatient < 0, na.rm = TRUE),
    sum(diabetes_clean$number_diagnoses < 1, na.rm = TRUE)
  )
)

cat("\nNumeric range quality control:\n")
print(range_checks)


# Gender quality control --------------------------------------

gender_values <- unique(diabetes_clean$gender)

cat("\nGender values:\n")
print(gender_values)

unknown_gender <- diabetes_clean %>%
  filter(gender == "Unknown/Invalid")

cat("\nRecords with Unknown/Invalid gender:",
    nrow(unknown_gender), "\n")


# Final QC status ---------------------------------------------

cat("\n============================================================\n")
cat("Quality control completed successfully.\n")
cat("No records were removed during quality control.\n")
cat("============================================================\n")
