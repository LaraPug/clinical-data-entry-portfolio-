getwd()
# Define data path

data_path <- "datasets/diabetes/diabetic_data.csv"

# Import dataset

diabetes_raw <- read_csv(data_path)

# Inspect dataset

glimpse(diabetes_raw)

summary(diabetes_raw)



list.files("projects")
library(tidyverse)

data_path <- "datasets/diabetes/diabetic_data.csv"

diabetes_raw <- read_csv(data_path, show_col_types = FALSE)

dim(diabetes_raw)
names(diabetes_raw)
library(tidyverse)

data_path <- "datasets/diabetes/diabetic_data.csv"

diabetes_raw <- read_csv(data_path, show_col_types = FALSE)

dim(diabetes_raw)
names(diabetes_raw)