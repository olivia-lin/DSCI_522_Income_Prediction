#! /usr/bin/env Rscript 

# script_02_visualizations.R
# Olivia Lin, Mani Kohli Nov 23 2018
#
# This script takes in the viz data set from the 1st script and returns visualizations of the 
# data for our project.
# This script should be run under the root folder.
#
# Usage: Rscript src/data_cleaned_viz arg1 arg2 arg3 arg4
# arg1 = input data file, arg2 = output visualizations file
# Example: Rscript src/script_02_visualizations.R data/tidy_data_viz.csv results/data_viz_01.png results/data_viz_02.png results/data_viz_03.png

# import libraries/packages
library(tidyverse)
library(ggplot2)
#library(corrplot)

# parse/define command line arguments here
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
# output_file_viz_01 <- args[2]
output_file_viz_02 <- args[3]
output_file_viz_03 <- args[4]

#viz_data <- read_csv("data/tidy_data_viz.csv")
#Read in data file
viz_data <- read_csv(input_file)

# Visualizing individual attributes, not being saved to files. 
# Meant for data explorations for further plots below
#base_viz <- viz_data %>% 
# ggplot()

#base_viz + 
#  geom_histogram(aes(x=age), bins=20) +
#  labs(title="Age Distribution", x="Age", y="Frequency")
    
#base_viz + 
#  geom_bar(aes(x=education)) +
#  labs(title="Education Distribution", x="Education Level", y="Frequency")

#base_viz + 
#  geom_histogram(aes(x=educationNum)) +
#  labs(title="Number of Educational Years Distribution", x="Number of years", y="Frequency")

#base_viz + 
#  geom_bar(aes(x=married)) +
#  labs(title="Married and Non-married Distribution", x="Married or Not Married", y="Frequency")

#base_viz + 
#  geom_bar(aes(x=race)) +
#  labs(title="Race Distribution", x="Race", y="Frequency")

#base_viz + 
#  geom_bar(aes(x=sex)) +
#  labs(title="Sex Distribution", x="Sex", y="Frequency")

#base_viz + 
#  geom_histogram(aes(x=capitalGain)) +
#  scale_x_log10() +
#  labs(title="Capital Gain Distribution", x="Capital Gains (Log10 Scale", y="Frequency")

#base_viz + 
#  geom_histogram(aes(x=capitalLoss)) +
#  scale_x_log10() +
#  labs(title="Capital Loss Distribution", x="Capital Loss (Log10 Scale)", y="Frequency")

#base_viz + 
#  geom_histogram(aes(x=hrPerWeek)) +
#  labs(title="Hours Worked Per Week Distribution", x="Hours", y="Frequency")

#base_viz + 
#  geom_bar(aes(x=income)) +
#  labs(title="Income Distribution", x="Income", y="Frequency")

#save following plot
#png(file=output_file_viz_01, width = 5, height = 5, units = "in", res = 600)

#Correlation of Quantitative Variables
col1 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "white",
                           "cyan", "#007FFF", "blue", "#00007F"))
numeric_var <- sapply(viz_data, is.numeric)
corr_matrix <- cor(viz_data[, numeric_var])
# corrplot(corr_matrix, method = "ellipse", col = col1(100),
#          main="Correlation of Quantitative Variables",
#          mar = c(0,0,2,0))

# dev.off()

#save file
#ggsave(output_file_viz_01, plot = last_plot(), width = 7.29, height = 4.51, units = "in")
png(file=output_file_viz_02, width = 7.29, height = 4.51, units = "in", res = 600)

#Correlation of numerical variables and income 
par(mfrow=c(2,3))  ## Arrange plots 
boxplot(viz_data$age~viz_data$income, main="Age vs Income", xlab="Income", ylab="Income")
boxplot(viz_data$educationNum~viz_data$income, main="Years of Education vs Income", 
        xlab="Years of Education", ylab="Income")
boxplot(viz_data$capitalGain~viz_data$income, main="Capital Gains vs Income", 
        xlab="Capital Gains", ylab="Income")
boxplot(viz_data$capitalLoss~viz_data$income, main="Capital Loss vs Income", 
        xlab="Capital Loss", ylab="Income")
boxplot(viz_data$hrPerWeek~viz_data$income, main="Hours Worked Per Week vs Income", 
        xlab="Hours Per Week", ylab="Income")

dev.off()

#save image
#ggsave(output_file_viz_02, plot = last_plot(), width = 7.29, height = 4.51, units = "in")
png(file=output_file_viz_03, width = 7.29, height = 7, units = "in", res = 600)


#Correlation of categorical variables and income 
par(mfrow=c(2,2))
par(las=1)  ## horizontal axis labels
plot(table(viz_data$income, viz_data$education), main="Education vs. Income")
plot(table(viz_data$income, viz_data$married), main="Marital Status vs. Income")
plot(table(viz_data$income, viz_data$race), main="Race vs. Income")
plot(table(viz_data$income, viz_data$sex), main="Sex vs. Income")
par(las=0)

dev.off()
#save image
#ggsave(output_file_viz_03, plot = last_plot(), width = 7.29, height = 4.51, units = "in")
