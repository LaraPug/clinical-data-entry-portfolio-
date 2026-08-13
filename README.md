# Clinical Data & Clinical Research Portfolio

Portfolio focused on **Clinical Data Management, Clinical Data Entry, Data Quality, Clinical Research, and Biomedical Data Analysis**.

This repository contains reproducible projects developed using publicly available clinical and biomedical datasets, with an emphasis on **data cleaning, validation, quality control, documentation, statistical analysis, and reproducibility**.

---

## About Me

I am a **Biochemistry about to graduate** with a background in biomedical research, data analysis, and scientific documentation.

I am building practical experience in **Clinical Data Management and Clinical Research**, combining my scientific background with computational tools and structured data workflows.

### Career Focus

**Clinical Data Management | Clinical Data Entry | Data Quality | Clinical Research | Biomedical Data Analysis**

---

## Core Skills

### Clinical Data Management

- Clinical data cleaning
- Data validation
- Quality control (QC)
- Missing data assessment
- Data consistency checks
- Identifier and duplicate checks
- Categorical and numerical validation
- Documentation of cleaning decisions
- Data review and traceability

### Data Analysis

- Exploratory Data Analysis (EDA)
- Statistical analysis
- Logistic regression
- Odds ratios and confidence intervals
- ROC/AUC analysis
- Sensitivity and specificity
- Predictive values
- Model calibration
- Data visualization

### Technical Skills

- R
- tidyverse
- ggplot2
- Microsoft Excel
- Git
- GitHub
- Visual Studio Code
- Reproducible scripting

### Clinical Research

- Good Clinical Practice (GCP) principles
- Clinical research data workflows
- Data quality concepts
- Scientific documentation
- Reproducible research practices

---

# Featured Project

## Diabetes Clinical Data Cleaning, Quality Control & Statistical Analysis

**Status: Completed**

An end-to-end clinical data workflow using the **Diabetes 130-US Hospitals Dataset**, containing more than 100,000 hospital encounters.

The project demonstrates the complete process from raw clinical data to **cleaning, validation, quality control, statistical analysis, visualization, and documented outputs**.

### Workflow

```text
Raw Clinical Data
        ↓
Data Import
        ↓
Data Cleaning
        ↓
Missing Data Assessment
        ↓
Quality Control
        ↓
Exploratory Analysis
        ↓
Statistical Modeling
        ↓
Model Evaluation
        ↓
Visualization & Reporting
```
### Key Activities
- Imported and structurally assessed 101,766 clinical encounters
- Identified 71,518 unique patients
- Standardized missing values
- Assessed variable-level missingness
- Performed identifier and duplicate checks
- Conducted categorical and numerical quality control
- Evaluated invalid records
- Documented cleaning decisions
- Created a reproducible data cleaning pipeline in R
- Developed a multivariable logistic regression model
- Evaluated model discrimination and calibration
- Generated reproducible analytical tables and figures
- Version-controlled the workflow using Git and GitHub

### Key Data Quality Results
| Quality Check             |      Result |
| ------------------------- | ----------: |
| Clinical encounters       | **101,766** |
| Unique patients           |  **71,518** |
| Duplicate encounter IDs   |       **0** |
| Missing weight            |  **96.86%** |
| Missing medical specialty |  **49.08%** |
| Missing payer code        |  **39.56%** |

Highly incomplete variables were documented and evaluated rather than automatically imputed.

### Statistical Model Results
A multivariable logistic regression model was developed to investigate factors associated with hospital readmission.
| Performance Metric |     Result |
| ------------------ | ---------: |
| AUC                | **0.6524** |
| Accuracy           | **61.93%** |
| Sensitivity        | **42.50%** |
| Specificity        | **78.54%** |
| PPV                | **62.87%** |
| NPV                | **61.51%** |

Prior inpatient utilization showed a strong association with readmission:
| Prior Inpatient Visits | Odds Ratio |      95% CI |
| ---------------------- | ---------: | ----------: |
| 1                      |  **1.772** | 1.715–1.831 |
| 2                      |  **2.566** | 2.439–2.699 |
| 3+                     |  **3.756** | 3.545–3.979 |
These findings represent observational associations from a retrospective dataset and should not be interpreted as causal effects.

### Visual Outputs
ROC Curve
The ROC curve evaluates model discrimination across different classification thresholds.
AUC = 0.6524

Forest Plot — Odds Ratios
The forest plot summarizes estimated odds ratios and 95% confidence intervals for predictors included in the final logistic regression model.

Calibration Plot
The calibration plot compares predicted probabilities with observed readmission rates across probability groups.

## Complete Diabetes Project

→ View the complete Diabetes Clinical Data project

The project README contains the complete methodology, data quality assessment, statistical analysis, documentation, reproducibility instructions, and project structure.

| Project                             | Focus                                                           | Status        |
| ----------------------------------- | --------------------------------------------------------------- | ------------- |
| **Diabetes Clinical Data Cleaning** | Clinical data cleaning, QC, validation and statistical analysis | **Completed** |
| **Breast Cancer Statistics**        | Gene expression analysis and statistical workflow               | **Completed** |
| Heart Failure Clinical Analysis     | Clinical risk factor analysis                                   | Planned       |
| Stroke Clinical Dataset Analysis    | Exploratory clinical data analysis                              | Planned       |
| Clinical Trials Landscape Analysis  | Clinical trial registry data analysis                           | Planned       |
| Electronic Data Capture Simulation  | Clinical database and EDC validation workflow                   | Planned       |

```
clinical-data-entry-portfolio/
│
├── datasets/
│   ├── diabetes/
│   ├── heart failure/
│   ├── stroke/
│   └── clinical_trials/
│
├── projects/
│   └── 01_diabetes_cleaning_template/
│       ├── README.md
│       ├── data/
│       ├── documentation/
│       └── scripts/
│
├── outputs/
│   ├── figures/
│   │   ├── calibration_plot_final_model.png
│   │   ├── forest_plot_final_model.png
│   │   └── roc_curve_final_model.png
│   │
│   └── tables/
│       ├── calibration_data.csv
│       ├── final_model_results.csv
│       └── model_performance.csv
│
└── README.md
```
## Reproducibility & Documentation

The projects in this repository are designed around principles of:

- Traceability
- Reproducibility
- Data quality
- Structured documentation
- Version control
- Transparent analytical workflows

The Diabetes project separates the workflow into sequential R scripts so that individual processing stages can be reviewed independently.
```text
01 Import Data
      ↓
02 Data Cleaning
      ↓
03 Exploratory Analysis
      ↓
04 Quality Control
      ↓
05 Export Clean Dataset
      ↓
06 Visualization
      ↓
07 Statistical Analysis
```

### Each stage produces documented outputs that can be reviewed and reproduced.

### Data Quality Approach

The portfolio emphasizes that clinical data analysis is not only about producing statistical results.

### The workflow also addresses:

Data → Quality → Validation → Documentation → Analysis → Interpretation

### Examples of quality procedures implemented include:

- Missingness assessment
- Identifier validation
- Duplicate detection
- Variable class checks
- Numeric range checks
- Categorical validation
- Invalid record identification
- Cleaning decision documentation
- Quality control summaries
This approach reflects the importance of data integrity and traceability in clinical research workflows.

---
### Limitations

The analytical projects in this repository are intended for portfolio and educational purposes, not for clinical decision-making.

Depending on the dataset and analysis, limitations may include:
- Retrospective observational data
- Potential selection bias
- Potential measurement bias
- Missing data
- Class imbalance
- Lack of external validation
- Lack of prospective validation
- Moderate model discrimination
- Association does not imply causation
- Career Focus

I am particularly interested in opportunities involving:
- Clinical Data Management
- Clinical Data Entry
- Data Quality & Validation
- Clinical Research
- Clinical Research Operations
- Biomedical Data Analysis

### I am especially interested in roles where my background in Biochemistry can be combined with structured clinical data workflows, quality control, and analytical tools.

## Contact

Biochemistry | Clinical Data | Data Quality | Clinical Research

LinkedIn: https://www.linkedin.com/in/lara-pugnaloni-aa813329a/

GitHub: LaraPug

Lara Pugnaloni
