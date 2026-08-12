# ============================================================
# 03 - DATA CLEANING
# Diabetes 130-US Hospitals Dataset
# ============================================================

library(tidyverse)


# ============================================================
# 1. LOAD RAW DATA
# ============================================================

data_path <- "datasets/diabetes/diabetic_data.csv"

diabetes_raw <- read_csv(data_path)


# ============================================================
# 2. STANDARDIZE MISSING VALUES
# ============================================================

# The original dataset uses "?" to represent missing values.
# Only character variables are converted.
# Numeric variables retain their original data type.

diabetes_clean <- diabetes_raw %>%
  mutate(
    across(
      where(is.character),
      ~ na_if(.x, "?")
    )
  )


# ============================================================
# 3. VERIFY MISSING VALUES
# ============================================================

missing_after_cleaning <- sapply(
  diabetes_clean,
  function(x) sum(is.na(x))
)

missing_after_cleaning <- data.frame(
  variable = names(missing_after_cleaning),
  missing_count = as.numeric(missing_after_cleaning)
)

missing_after_cleaning <- missing_after_cleaning %>%
  filter(missing_count > 0) %>%
  mutate(
    missing_percentage = round(
      (missing_count / nrow(diabetes_clean)) * 100,
      2
    )
  ) %>%
  arrange(desc(missing_percentage))


cat("\nMissing values after standardization:\n")
print(missing_after_cleaning)


# Export missingness summary

dir.create(
  "documentation",
  showWarnings = FALSE,
  recursive = TRUE
)

write_csv(
  missing_after_cleaning,
  "documentation/missingness_summary.csv"
)

cat("\nMissingness summary exported successfully.\n")


# ============================================================
# 4. VERIFY THAT NO "?" VALUES REMAIN
# ============================================================

question_marks_remaining <- sapply(
  diabetes_clean,
  function(x) sum(as.character(x) == "?", na.rm = TRUE)
)

question_marks_remaining <- question_marks_remaining[
  question_marks_remaining > 0
]

cat("\nRemaining '?' values after cleaning:\n")
print(question_marks_remaining)


# ============================================================
# 5. CHECK VARIABLE TYPES
# ============================================================

variable_classes <- data.frame(
  variable = names(diabetes_clean),
  class = sapply(diabetes_clean, class)
)

cat("\nVariable classes after cleaning:\n")
print(variable_classes)


# Export variable classes

write_csv(
  variable_classes,
  "documentation/variable_classes.csv"
)


# ============================================================
# 6. CATEGORICAL VARIABLE INSPECTION
# ============================================================

categorical_variables <- diabetes_clean %>%
  select(where(is.character)) %>%
  names()

categorical_summary <- lapply(
  categorical_variables,
  function(var) {
    
    data.frame(
      variable = var,
      unique_values = n_distinct(
        diabetes_clean[[var]],
        na.rm = TRUE
      ),
      missing_values = sum(
        is.na(diabetes_clean[[var]])
      )
    )
    
  }
) %>%
  bind_rows() %>%
  arrange(desc(missing_values))


cat("\nCategorical variable summary:\n")
print(categorical_summary)


# Export categorical summary

write_csv(
  categorical_summary,
  "documentation/categorical_summary.csv"
)


# ============================================================
# 7. INSPECT KEY CATEGORICAL VARIABLES
# ============================================================

cat("\nGender values:\n")
print(
  table(
    diabetes_clean$gender,
    useNA = "ifany"
  )
)


cat("\nRace values:\n")
print(
  table(
    diabetes_clean$race,
    useNA = "ifany"
  )
)


cat("\nAge values:\n")
print(
  table(
    diabetes_clean$age,
    useNA = "ifany"
  )
)


# ============================================================
# 8. DETAILED CATEGORICAL VALUE INSPECTION
# ============================================================

cat("\nUnique gender values:\n")
print(unique(diabetes_clean$gender))


cat("\nUnique race values:\n")
print(unique(diabetes_clean$race))


cat("\nUnique age values:\n")
print(unique(diabetes_clean$age))


cat("\nUnique max_glu_serum values:\n")
print(unique(diabetes_clean$max_glu_serum))


cat("\nUnique A1Cresult values:\n")
print(unique(diabetes_clean$A1Cresult))


cat("\nUnique insulin values:\n")
print(unique(diabetes_clean$insulin))


cat("\nUnique diabetesMed values:\n")
print(unique(diabetes_clean$diabetesMed))


cat("\nUnique readmitted values:\n")
print(unique(diabetes_clean$readmitted))


# ============================================================
# 9. NUMERIC VARIABLE INSPECTION
# ============================================================

numeric_variables <- diabetes_clean %>%
  select(where(is.numeric)) %>%
  names()

numeric_summary <- lapply(
  numeric_variables,
  function(var) {
    
    x <- diabetes_clean[[var]]
    
    data.frame(
      variable = var,
      min = min(x, na.rm = TRUE),
      max = max(x, na.rm = TRUE),
      mean = round(
        mean(x, na.rm = TRUE),
        2
      ),
      median = median(
        x,
        na.rm = TRUE
      ),
      missing_values = sum(
        is.na(x)
      )
    )
    
  }
) %>%
  bind_rows()


cat("\nNumeric variable summary:\n")
print(numeric_summary)


# Export numeric summary

write_csv(
  numeric_summary,
  "documentation/numeric_summary.csv"
)


# ============================================================
# 10. NUMERIC RANGE QUALITY CONTROL
# ============================================================

range_qc <- data.frame(
  
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
    sum(
      diabetes_clean$time_in_hospital < 1,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$num_lab_procedures < 1,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$num_procedures < 0,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$num_medications < 1,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$number_outpatient < 0,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$number_emergency < 0,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$number_inpatient < 0,
      na.rm = TRUE
    ),
    
    sum(
      diabetes_clean$number_diagnoses < 1,
      na.rm = TRUE
    )
  )
)


cat("\nNumeric range quality control:\n")
print(range_qc)


# Export range QC

write_csv(
  range_qc,
  "documentation/numeric_range_qc.csv"
)


# ============================================================
# 11. ADMINISTRATIVE CODE INSPECTION
# ============================================================

cat("\nAdmission type IDs:\n")
print(
  sort(
    unique(
      diabetes_clean$admission_type_id
    )
  )
)


cat("\nDischarge disposition IDs:\n")
print(
  sort(
    unique(
      diabetes_clean$discharge_disposition_id
    )
  )
)


cat("\nAdmission source IDs:\n")
print(
  sort(
    unique(
      diabetes_clean$admission_source_id
    )
  )
)


# ============================================================
# 12. HIGH-MISSINGNESS VARIABLE INSPECTION
# ============================================================

high_missing_variables <- diabetes_clean %>%
  summarise(
    
    weight_missing = sum(
      is.na(weight)
    ),
    
    weight_missing_pct = round(
      mean(is.na(weight)) * 100,
      2
    ),
    
    medical_specialty_missing = sum(
      is.na(medical_specialty)
    ),
    
    medical_specialty_missing_pct = round(
      mean(is.na(medical_specialty)) * 100,
      2
    ),
    
    payer_code_missing = sum(
      is.na(payer_code)
    ),
    
    payer_code_missing_pct = round(
      mean(is.na(payer_code)) * 100,
      2
    )
  )


cat("\nHigh-missingness variable summary:\n")
print(high_missing_variables)


# Export high-missingness summary

write_csv(
  high_missing_variables,
  "documentation/high_missingness_summary.csv"
)


# ============================================================
# 13. WEIGHT INSPECTION
# ============================================================

cat("\nWeight values:\n")

weight_summary <- table(
  diabetes_clean$weight,
  useNA = "ifany"
)

print(weight_summary)


# ============================================================
# 14. PAYER CODE INSPECTION
# ============================================================

cat("\nPayer code values:\n")

payer_code_summary <- table(
  diabetes_clean$payer_code,
  useNA = "ifany"
)

print(payer_code_summary)


# ============================================================
# 15. MEDICAL SPECIALTY INSPECTION
# ============================================================

cat("\nMedical specialty frequencies:\n")

medical_specialty_summary <- diabetes_clean %>%
  count(
    medical_specialty,
    sort = TRUE
  )

print(
  medical_specialty_summary,
  n = Inf
)


# Export medical specialty frequencies

write_csv(
  medical_specialty_summary,
  "documentation/medical_specialty_summary.csv"
)


# ============================================================
# 16. CLEANING DECISION LOG
# ============================================================

cleaning_decisions <- data.frame(
  
  variable = c(
    "weight",
    "medical_specialty",
    "payer_code",
    "race",
    "diag_1",
    "diag_2",
    "diag_3",
    "gender"
  ),
  
  issue = c(
    "96.86% missing; values recorded as weight ranges",
    "49.08% missing; multiple specialty categories observed",
    "39.56% missing; multiple payer codes observed",
    "2.23% missing",
    "0.02% missing",
    "0.35% missing",
    "1.40% missing",
    "3 records classified as Unknown/Invalid"
  ),
  
  missing_percentage = c(
    96.86,
    49.08,
    39.56,
    2.23,
    0.02,
    0.35,
    1.40,
    0
  ),
  
  action = c(
    "Retain; preserve NA; no imputation",
    "Retain; preserve NA",
    "Retain; preserve NA; preserve coded values",
    "Retain; preserve NA",
    "Retain; preserve NA",
    "Retain; preserve NA",
    "Retain; preserve NA",
    "Review; flag Unknown/Invalid; no automatic removal"
  )
)


cat("\nCleaning decision log:\n")
print(cleaning_decisions)


# Export cleaning decision log

write_csv(
  cleaning_decisions,
  "documentation/cleaning_decisions.csv"
)

cat("\nCleaning decision log exported successfully.\n")


# ============================================================
# 17. REVIEW UNKNOWN/INVALID GENDER RECORDS
# ============================================================

invalid_gender_records <- diabetes_clean %>%
  filter(
    gender == "Unknown/Invalid"
  )


cat("\nRecords with Unknown/Invalid gender:\n")
print(invalid_gender_records)


# Export records for review

write_csv(
  invalid_gender_records,
  "documentation/invalid_gender_records.csv"
)


# ============================================================
# END OF PRELIMINARY DATA CLEANING
# ============================================================

cat("\n============================================================\n")
cat("Preliminary data cleaning completed successfully.\n")
cat("No records have been removed at this stage.\n")
cat("============================================================\n")
# Check gender values -----------------------------------------

gender_qc <- diabetes_clean %>%
  count(gender, sort = TRUE)

gender_qc
# Unknown/Invalid gender records ------------------------------

unknown_gender <- diabetes_clean %>%
  filter(gender == "Unknown/Invalid")

unknown_gender