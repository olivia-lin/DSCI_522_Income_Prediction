#! /usr/bin/env Rscript 

# tidy_data.R
# Olivia Lin, Mani Kohli Nov 22 2016
#
# This script takes in the original data set and returns a cleaned data set for our project.
# This script should be run under the root folder.
#
# Usage: Rscript src/script_01_load_tidy_data.R 
# Example: Rscript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data_viz.csv data/tidy_data_ml.csv


# import libraries/packages
library(tidyverse)

# parse/define command line arguments here
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file_viz <- args[2]
output_file_ml <- args[3]


# data <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", col_names = FALSE)

data <- read_csv(input_file, col_names = FALSE)


#Data Wrangling
colnames(data) <- c("age", "workclass", "fnlwgt", "education", "educationNum", "married", 
                    "occupation", "relationship", "race",  "sex", "capitalGain", "capitalLoss", 
                    "hrPerWeek", "nativeCountry", "income")

data_cleaned_viz <- data %>%
  mutate(workclass=factor(workclass), education=factor(education), married=factor(married),
         occupation=factor(occupation), relationship=factor(relationship), 
         race=factor(race), sex=factor(sex), nativeCountry=factor(nativeCountry), 
         income=factor(income)) %>% 
  select(-occupation, -relationship, -nativeCountry, -workclass) %>% 
  mutate(married=fct_collapse(data$married,
                              married = c("Married-AF-spouse", "Married-civ-spouse", "Married-spouse-absent"),
                              notMarried = c("Divorced", "Never-married", "Separated", "Widowed"))) %>% 
  mutate(education=fct_collapse(data$education,
                                nonHSgrad = c("10th", "11th", "12th", "1st-4th", "5th-6th", "7th-8th", "9th", "Preschool"),
                                HSgrad = "HS-grad",
                                someCollege = "Some-college",
                                assoc = c("Assoc-acdm", "Assoc-voc"),
                                bachelors = "Bachelors",
                                masters = "Masters",
                                profSchool = "Prof-school",
                                doctorate = "Doctorate"))
  
data_cleaned_viz <- data_cleaned_viz %>% 
  mutate(education=fct_relevel(data_cleaned_viz$education, "nonHSgrad", "HSgrad", "someCollege", "assoc", "bachelors", "masters", "profSchool"))

#' Note
#' For variable `married`, 1 means not married and 2 means married
#' For variable `education`, 1 means not high school graduate, 2 means high school graduate, 3 means some college, 
#'                           4 means associate, 5 means bachelor's degree, 6 means master's degree, 7 means prof school, and 8 means doctorate,.
#' For variable `race`, 1 means Amer-Indian-Eskimo, 2 means Asian-Pac-Islander, 3 means Black, 4 means Other, 5 means White.
#' For variable `sex`, 1 means female and 2 means male.
#' For variable `income`, 1 means <=50K and 2 means >50K.

data_cleaned_ml <- data_cleaned_viz %>% 
  mutate_if(is.factor, as.numeric)
  

#Write output file
write_csv(data_cleaned_viz, output_file_viz)
write_csv(data_cleaned_ml, output_file_ml)



 
