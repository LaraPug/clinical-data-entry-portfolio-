# ============================================================
# 05 - EXPORT CLEAN DATASET
# Diabetes 130-US Hospitals Dataset
# ============================================================

library(tidyverse)


# Check that cleaned dataset exists ---------------------------

if (!exists("diabetes_clean")) {
  
  stop(
    "Object 'diabetes_clean' not found. ",
    "Run 02_data_cleaning.R before running 05_export_clean_dataset.R."
  )
}


# Define output path ------------------------------------------

output_path <- "datasets/diabetes/diabetic_data_clean.csv"


# Export cleaned dataset --------------------------------------

write_csv(
  diabetes_clean,
  output_path
)


# Confirm export ----------------------------------------------

cat("Clean dataset exported successfully.\n")
cat("Output:", output_path, "\n")
cat("Rows:", nrow(diabetes_clean), "\n")
cat("Columns:", ncol(diabetes_clean), "\n")