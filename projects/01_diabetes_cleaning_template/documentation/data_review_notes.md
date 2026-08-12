# Initial Data Review Notes

## Dataset

Diabetes 130-US Hospitals Dataset

## Dataset structure

- Records: 101,766
- Variables: 50
- Unique patients: 71,518
- Unique encounters: 101,766

## Identifier quality assessment

- `encounter_id`: 0 duplicated identifiers detected.
- `patient_nbr`: 30,248 duplicated identifiers detected.
- Repeated `patient_nbr` values are expected because a patient may have multiple hospital encounters.
- Each encounter has a unique `encounter_id`.

## Missing data assessment

Missing values are represented in the source dataset using the `"?"` character.

The following variables contain `"?"` values:

| Variable | Missing values |
|---|---:|
| `race` | 2,273 |
| `weight` | 98,569 |
| `payer_code` | 40,256 |
| `medical_specialty` | 49,949 |
| `diag_1` | 21 |
| `diag_2` | 358 |
| `diag_3` | 1,423 |

## Initial observations

- `weight` has a very high proportion of missing values and requires specific consideration before analysis.
- `payer_code` and `medical_specialty` also contain substantial amounts of missing data.
- The diagnosis variables (`diag_1`, `diag_2`, and `diag_3`) contain relatively few missing values compared with the total number of records.
- Missing values will not be removed automatically. Their treatment will be determined according to variable type, missingness frequency, and analytical relevance.
- No duplicated `encounter_id` values were detected.

## Quality control status

Initial structural and identifier quality checks completed successfully.

Further data cleaning and validation are pending.

# Initial Data Review Notes

## Dataset

Diabetes 130-US Hospitals Dataset

## Initial assessment

The dataset contains 101,766 records and 50 variables. Initial quality control focused on identifier uniqueness and identification of missing values represented by the "?" character

## Observations
encounter_id is unique across all 101,766 records; no duplicated encounter IDs were identified.
patient_nbr is not unique, with 30,248 duplicated patient identifiers. This is consistent with the dataset structure, where a patient may have multiple hospital encounters.
The dataset contains 71,518 unique patients and 101,766 unique encounters.
Missing values are represented by "?" in seven variables: race, weight, payer_code, medical_specialty, diag_1, diag_2, and diag_3.
weight has the highest proportion of missing values (96.86%), followed by medical_specialty (49.08%) and payer_code (39.56%).
Diagnostic variables contain relatively low proportions of missing values: diag_1 (0.02%), diag_2 (0.35%), and diag_3 (1.40%).
The missingness pattern should be documented before applying any cleaning, exclusion, or imputation strategy.
