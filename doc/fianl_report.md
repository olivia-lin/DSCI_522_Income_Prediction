Income Prediction Using Decision Tree
================
Olivia Lin, Mani Kohli
November 24, 2018

Introduction
------------

There are huge disparities in salary amongst the population today. Why does someone receive a higher salary than the next person? There could be many, many factors as to why. How do we narrow down these factors? One approach would be to analyze collected data from censuses which would give us pre-defined attributes, including salaries.

Our research proposal for this project is to determine what are the strongest predictors (attributes) would be to determine a salary greater than $50,000.

Our goal is to build a model on census data for a specific year with the hopes that it could be applied on other years as well.

Data Set and Wrangling
----------------------

The public data set for our project is <https://archive.ics.uci.edu/ml/datasets/Adult> from UCI machine learning repository. The data we will use for this project is from the 1994 US Census Database.

Based on our initial analysis of the data set, we omitted various features for the following reasons: - Workclass: We felt this attribute did not offered meaningful data, the defined categories were not descriptive and too limited. - Fnlwgt: This attribute was not useful for our purpose and was highly skewed with zeros. - Occupation: We felt this attribute did not offered meaningful data, the defined categories were not descriptive and too limited. - Relationship: We felt this attribute did not offered meaningful data, the defined categories were not descriptive and too limited and partially repetitive with ‘marital-status’. - native-country: This attribute was not useful for our purpose.

Our final data set consisted of 9 attributes, 5 were numerical and 4 were categorical.

| Attributes   | Description                                                                                                                                                                                                      |
|:-------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| age          | Age of an individual (continuous range from 17-90 years old)                                                                                                                                                     |
| education    | The highest level of education achieved by an individual (Bachelors, Some-college, 11th, HS-grad, Prof-school, Assoc-acdm, Assoc-voc, 9th, 7th-8th, 12th, Masters, 1st-4th, 10th, Doctorate, 5th-6th, Preschool) |
| educationNum | The highest level of education achieved in numerical (continuous) form                                                                                                                                           |
| married      | Marital status of an individual (Married-civ-spouse, Divorced, Never-married, Separated, Widowed, Married-spouse-absent, Married-AF-spouse)                                                                      |
| race         | Descriptions of an individual’s race (White, Asian-Pac-Islander, Amer-Indian-Eskimo, Other, Black)                                                                                                               |
| sex          | The biological sex of the individual (Female, Male)                                                                                                                                                              |
| capitalGain  | Capital gains (continuous integer, greater than 0) for an individual                                                                                                                                             |
| capitalLoss  | Capital loss (continuous integer, greater than 0) for an individual                                                                                                                                              |
| hrPerWeek    | The hours (continuous) an individual has reported to work per week                                                                                                                                               |
| income       | Whether or not an individual makes more than $50,000 annually (&lt;=50k, &gt;50k)                                                                                                                                |

We created 2 separate data sets. 1 for exploratory data analysis which used our defined string levels for categorical variables. 1 for our machine learning model which we converted the string levels to numeric levels.

Exploratory Data Analysis
-------------------------
