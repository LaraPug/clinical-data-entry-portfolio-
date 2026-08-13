# Diabetes Clinical Data Cleaning, Quality Control & Statistical Analysis

![R](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
![Clinical Data](https://img.shields.io/badge/Clinical%20Data-Management-blue)
![Data Quality](https://img.shields.io/badge/Data%20Quality-QC-green)
![Statistics](https://img.shields.io/badge/Statistics-Logistic%20Regression-orange)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032)

## Project Overview

This project demonstrates a reproducible clinical data workflow using the **Diabetes 130-US Hospitals Dataset**, containing more than 100,000 hospital encounters.

The project demonstrates practical skills relevant to **Clinical Data Management, Clinical Data Entry, Data Quality Control, and clinical research data workflows**.

### Key competencies demonstrated

- Clinical data cleaning and standardization
- Data quality control and validation
- Missing data assessment
- Identifier and duplicate checks
- Exploratory data analysis
- Logistic regression
- Odds ratios and confidence intervals
- ROC/AUC analysis
- Sensitivity and specificity
- Model calibration
- Reproducible R workflows
- Git and GitHub version control
- Documentation and traceability

---

## Dataset

**Diabetes 130-US Hospitals Dataset**

The dataset contains:

- **101,766 clinical encounters**
- **71,518 unique patients**
- **50 original variables**
- Demographic information
- Admission and hospitalization variables
- Laboratory and medication variables
- Hospital readmission information

The original dataset is publicly available through the **UCI Machine Learning Repository**.

---

# Clinical Data Workflow

```text
RAW DATA
   |
   v
DATA IMPORT
   |
   v
DATA CLEANING
   |
   v
MISSING DATA ASSESSMENT
   |
   v
DATA QUALITY CONTROL
   |
   v
EXPLORATORY DATA ANALYSIS
   |
   v
STATISTICAL MODELING
   |
   v
MODEL EVALUATION
   |
   v
VISUALIZATION & REPORTING
```
Each stage was implemented using independent R scripts so the workflow can be reviewed, reproduced and audited.

### Data Quality & Cleaning
Missing Data

The original dataset uses "?" to represent missing values.

These values were standardized to NA for downstream analysis.

| Variable          | Missing records | Missingness |
| ----------------- | --------------: | ----------: |
| Weight            |          98,569 |      96.86% |
| Medical specialty |          49,949 |      49.08% |
| Payer code        |          40,256 |      39.56% |
| Race              |           2,273 |       2.23% |


Highly incomplete variables were documented rather than automatically imputed.

This approach preserves transparency and prevents introducing unsupported assumptions into the dataset.

### Identifier Quality Control
Identifier integrity was assessed as part of the quality control workflow.

| QC check                |  Result |
| ----------------------- | ------: |
| Total encounters        | 101,766 |
| Unique encounters       | 101,766 |
| Duplicate encounter IDs |       0 |
| Unique patients         |  71,518 |


A distinction was maintained between encounter-level records and patient-level identifiers, since a single patient can have multiple hospital encounters.

### Additional Quality Control

The project also includes:

- Variable class validation
- Numeric range checks
- Categorical summaries
- Invalid gender records
- Medical specialty summaries
- Missingness summaries
- Cleaning decisions
- Data review documentation
- Statistical Analysis

A multivariable logistic regression model was developed to evaluate factors associated with hospital readmission.

### Outcome
The original readmission variable was transformed into a binary outcome:

| Original outcome | Binary outcome |
| ---------------- | -------------: |
| NO               |              0 |
| >30              |              1 |
| <30              |              1 |

The resulting binary outcome was used for the statistical model.

### Predictors
The final model included:

- Age
- Insulin treatment
- Prior inpatient utilization
- Emergency visits
- Outpatient visits
- Number of diagnoses
- Length of hospital stay
- Number of medications
- Number of laboratory procedures
- Key Statistical Findings

Prior inpatient utilization showed one of the strongest associations with readmission.

Compared with patients with no prior inpatient visits:

| Predictor                 | Odds Ratio |      95% CI |
| ------------------------- | ---------: | ----------: |
| 1 prior inpatient visit   |      1.772 | 1.715-1.831 |
| 2 prior inpatient visits  |      2.566 | 2.439-2.699 |
| 3+ prior inpatient visits |      3.756 | 3.545-3.979 |


Patients in the 3+ prior inpatient visits category had approximately 3.76 times the odds of readmission compared with patients with no prior inpatient visits, after adjustment for the other variables included in the model.

Other statistically significant predictors included emergency visits, outpatient visits, number of diagnoses, age, length of hospitalization, medication count and laboratory procedures.

### Interpretation: These are observational associations from a retrospective dataset and should not be interpreted as causal effects.

Model Performance
| Metric      |     Result |
| ----------- | ---------: |
| Accuracy    | **61.93%** |
| Sensitivity | **42.50%** |
| Specificity | **78.54%** |
| PPV         | **62.87%** |
| NPV         | **61.51%** |
| AUC         | **65.24%** |


The model demonstrated moderate discrimination, with an AUC of 0.6524.

The selected classification threshold produced higher specificity than sensitivity, meaning the model was better at identifying patients who were not readmitted than patients who were readmitted.

## Model Visualizations
ROC Curve
![ROC Curve](https://github.com/LaraPug/clinical-data-entry-portfolio-/raw/refs/heads/main/outputs/figures/roc_curve_final_model.png)
The ROC curve evaluates model discrimination across different classification thresholds.

AUC = 0.6524

Forest Plot - Odds Ratios
![Forest Plot](https://github.com/LaraPug/clinical-data-entry-portfolio-/raw/refs/heads/main/outputs/figures/forest_plot_final_model.png)
The forest plot summarizes the estimated odds ratios and 95% confidence intervals for predictors included in the final logistic regression model.

Calibration Plot
![Calibration Plot](https://github.com/LaraPug/clinical-data-entry-portfolio-/raw/refs/heads/main/outputs/figures/calibration_plot_final_model.png)
The calibration plot compares predicted probabilities with observed readmission rates across probability groups.

The model showed generally reasonable agreement between predicted and observed probabilities, although some deviation was present at the lower and upper probability ranges.

### Reproducible Analysis Pipeline

The analysis is organized into sequential R scripts:

| Script                      | Purpose                               |
| --------------------------- | ------------------------------------- |
| `01_import_data.R`          | Import and initial dataset assessment |
| `02_data_cleaning.R`        | Data cleaning and standardization     |
| `03_exploratory_analysis.R` | Exploratory analysis                  |
| `04_quality_control.R`      | Data validation and QC                |
| `05_export_clean_dataset.R` | Export cleaned dataset                |
| `06_visualization.R`        | Generate analytical visualizations    |
| `07_statistical_analysis.R` | Statistical modeling and evaluation   |

### Run the statistical analysis

From the repository root:

source("projects/01_diabetes_cleaning_template/scripts/07_statistical_analysis.R")

The analysis generates reproducible tables and figures in the outputs/ directory.

Project Structure
```
01_diabetes_cleaning_template/
|
|-- README.md
|
|-- data/
|   `-- raw/
|       `-- processed/
|           `-- data_dictionary.md
|
|-- documentation/
|   |-- categorical_summary.csv
|   |-- cleaning_decisions.csv
|   |-- cleaning_log.md
|   |-- data_review_notes.md
|   |-- data_validation_plan.md
|   |-- high_missingness_summary.csv
|   |-- invalid_gender_records.csv
|   |-- medical_specialty_summary.csv
|   |-- missingness_summary.csv
|   |-- numeric_range_qc.csv
|   |-- numeric_summary.csv
|   |-- qc_id_check.csv
|   `-- variable_classes.csv
|
`-- scripts/
    |-- 01_import_data.R
    |-- 02_data_cleaning.R
    |-- 03_exploratory_analysis.R
    |-- 04_quality_control.R
    |-- 05_export_clean_dataset.R
    |-- 06_visualization.R
    `-- 07_statistical_analysis.R
Analytical Outputs
outputs/
|
|-- figures/
|   |-- calibration_plot_final_model.png
|   |-- forest_plot_final_model.png
|   `-- roc_curve_final_model.png
|
`-- tables/
    |-- calibration_data.csv
    |-- final_model_results.csv
    `-- model_performance.csv
```

### Documentation
The project includes documentation designed to make the workflow traceable and reproducible.

### Data Review
data_review_notes.md
Initial assessment of dataset structure, distributions and data quality observations.

### Cleaning Decisions
cleaning_decisions.csv
Documents the main cleaning and standardization decisions.

### Cleaning Log
cleaning_log.md
Records the main data processing steps.

### Data Validation Plan
data_validation_plan.md
Defines validation checks used to assess data quality and consistency.

### Skills Demonstrated
- Clinical Data
- Clinical dataset handling
- Data cleaning
- Data validation
- Data quality control
- Missing data assessment
- Identifier checks
- Duplicate detection
- Categorical and numerical QC
- Documentation of cleaning decisions
- 
### Statistical Analysis
- Logistic regression
- Odds ratios
- Confidence intervals
- P-values
- ROC analysis
- AUC
- Sensitivity and specificity
- Predictive values
- Calibration assessment
- 
### Technical Skills
- R
- tidyverse
- ggplot2
- Reproducible scripting
- CSV data processing
- Git
- GitHub
- Version-controlled workflows

## Limitations
This analysis is intended as a portfolio demonstration rather than a clinical prediction tool.

### Important limitations include:

- Retrospective observational data
- Potential selection and measurement bias
- Class imbalance between outcome categories
- Moderate model discrimination
- No external validation cohort
- No prospective validation
- Statistical association does not imply causation

These limitations should be considered before interpreting the model for clinical decision-making.

### Portfolio Objective

This project demonstrates the ability to manage a clinical dataset through a structured workflow resembling real-world clinical data processes:

Import -> Clean -> Validate -> Document -> Analyze -> Visualize -> Report

The emphasis is on:

- Data quality
- Traceability
- Reproducibility
- Documentation
- Statistical interpretation
- Structured clinical data workflows

## Author
Lara Pugnaloni

Biochemistry  | Clinical Data | Data Quality | Clinical Research

Linkedin: https://www.linkedin.com/in/lara-pugnaloni-aa813329a/

GitHub - LaraPug
