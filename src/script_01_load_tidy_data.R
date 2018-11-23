#! /usr/bin/env Rscript 

# tidy_data.R
# Olivia Lin, Mani Kohli Nov 22 2016
#
# This script takes in the original data set and returns a cleaned data set for our project.
# This script should be run under the root folder.
#
<<<<<<< HEAD
# Usage: Rscript script_01_load_tidy_data.R
# ex. RScript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data.csv
         
=======
# Usage: Rscript src/script_01_load_tidy_data.R 
# Example: Rscript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data_viz.csv data/tidy_data_ml.csv
>>>>>>> upstream/master


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


data_cleaned_ml <- data %>% 
  mutate(workclass=factor(workclass), education=factor(education), married=factor(married),
         occupation=factor(occupation), relationship=factor(relationship), 
         race=factor(race), sex=factor(sex), nativeCountry=factor(nativeCountry), 
         income=factor(income)) %>% 
  mutate_if(is.factor, as.numeric)
  

#  select(-workclass, -occupation, -relationship, -nativeCountry, -educationNum) %>% 
#  mutate(married = fct_collapse(data$married,
#                              married = c("Married-AF-spouse", "Married-civ-spouse", "Married-spouse-absent"),
#                              notMarried = c("Divorced", "Never-married", "Separated", "Widowed"))) %>% 
#  mutate(education = fct_collapse(data$education,
#                                0 = c("10th", "11th", "12th", "1st-4th", "5th-6th", "7th-8th", "9th", "Preschool"),
#                                1 = "HS-grad",
#                                2 = "Some-college",
#                                3 = "Bachelors",
#                                4 = c("Assoc-acdm", "Assoc-voc"),
#                                5 = "Masters",
#                                6 = "Doctorate",
#                                7 = "Prof-school"))) %>% 
#  mutate(race = fct_recode(data$race, 
#                         0 = "Amer-Indian-Eskimo", 1 = "Asian-Pac-Islander", 2 = "Black", 3 = "Other", 4 = "White")) %>% 
#  mutate(sex = fct_recode(data$sex), 0 = "Female", 1 = "Male")


#' Note
#' For variable `married`, 1 means married and 0 means not married
#' For variable `education`, 0 means not high school graduate, 1 means high school graduate, 2 means some college, 
#'                           3 means bachelor's degree, 4 means associate, 5 means master's degree, 6 means doctorate, 7 means prof school.
#' For variable `race`, 0 means Amer-Indian-Eskimo", 1 means Asian-Pac-Islander, 2 means Black, 3 means Other, 4 means White.
#' For variable `sex`, 0 means female and 1 means male.
   

#Write output file
write_csv(data_cleaned_viz, output_file_viz)
write_csv(data_cleaned_ml, output_file_ml)



 



