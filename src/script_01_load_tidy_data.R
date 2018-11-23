#! /usr/bin/env Rscript 

# tidy_data.R
# Olivia Lin, Mani Kohli Nov 22 2016
#
# This script takes in the original data set and returns a cleaned data set for our project.
# This script takes no arguments.
#
# Usage: Rscript script_01_load_tidy_data.R
# ex. RScript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data.csv
         


# import libraries/packages
library(tidyverse)

# parse/define command line arguments here
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]


#data <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", 
#                 col_names = FALSE)
data <- read_csv(input_file, col_names = FALSE)


#Data Wrangling
colnames(data) <- c("age", "workclass", "fnlwgt", "education", "educationNum", "married", 
                    "occupation", "relationship", "race",  "sex", "capitalGain", "capitalLoss", 
                    "hrPerWeek", "nativeCountry", "income")

income_data_cleaned <- data %>% 
  mutate(workclass=factor(workclass), education=factor(education), married=factor(married),
         occupation=factor(occupation), relationship=factor(relationship), 
         race=factor(race), sex=factor(sex), nativeCountry=factor(nativeCountry), 
         income=factor(income)) %>% 
  mutate(workclass=fct_recode(data$workclass, "unknown" = "?")) %>% 
  mutate(married=fct_collapse(data$married,
                              married = c("Married-AF-spouse", "Married-civ-spouse", "Married-spouse-absent"),
                              notMarried = c("Divorced", "Never-married", "Separated", "Widowed"))) %>% 
  mutate(education=fct_collapse(data$education,
                                nonHSgrad = c("10th", "11th", "12th", "1st-4th", "5th-6th", "7th-8th", "9th", "Preschool"),
                                assoc = c("Assoc-acdm", "Assoc-voc"),
                                HSgrad = "HS-grad",
                                profSchool = "Prof-school",
                                someCollege = "Some-college")) %>% 
  mutate(occupation=fct_recode(data$occupation, "unknown" = "?")) %>% 
  mutate(nativeCountry=fct_recode(data$nativeCountry, "unknown" = "?"))
   
   
  
#Write output file
write_csv(income_data_cleaned, output_file)


 



