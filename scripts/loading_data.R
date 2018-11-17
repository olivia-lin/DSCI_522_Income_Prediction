library(tidyverse)
data <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", col_names = FALSE)
colnames(data) <- c("age", "workclass", "fnlwgt", "education", "education_num", "married", "occupation", "relationship", "race",  "sex", "capital-gain", "capital-loss", "hours-per-week", "native-country", "income")