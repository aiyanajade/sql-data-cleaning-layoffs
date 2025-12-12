# Layoffs Data Cleaning Project

### 1. What is this dataset and why does it require cleaning?
This dataset contains information on global layoffs collected from publicly available sources. It allows analysis of layoff patterns across geography, funding levels, industry and company maturity in the time period of 2020 to 2023 (COVID and post-COVID era).

Cleaning the data ensures accuracy and reliability for exploratory data analysis (EDA), visualization, and future modeling.

### 2. Goals
1. Remove duplicate records
2. Standardize formatting and data types
3. Address NULL/blank values
4. Drop unnecessary or redundant columns
5. Prepare a clean, analysis-ready dataset

### 3. Steps
1. Created a backup copy of the raw dataset to preserve the original.
2. Created a second staging table for cleaning and comparison throughout the process without disturbing the raw dataset.
3. Identified and removed duplicates using ROW_NUMBER() window function.
4. Standardized inconsistent values by correcting any trailing periods, leading/trailing whitespace and incorrect data types.
5. Handled NULL/blank values -
* identifying columns with missing data using CTEs
* updating values where reliable data existed
* leaving remaining NULLs where no valid assumption was possible
6. Dropped unnecessary columns, including temporary columns created during the cleaning process.

### 4. Files Uploaded
1. raw data = layoffs.csv (2361 X 9)
2. SQL code = data_cleaning.SQL
3. cleaned data = layoff_staging2.csv (2356 X 9)

### 5. Tools and Queries Used
1. Platform: MySQL Workbench
2. SQL Concepts:
* CTEs
* CRUD operations (SELECT, UPDATE, DELETE)
* Window functions (ROW_NUMBER())
* String functions (TRIM, STR_TO_DATE)
3. Version Control: Git & GitHub

### 6. Skills Demonstrated
1. SQL Data Cleaning
2. Window Functions
3. Data Quality Checks
4. Data Documentation & Version Control
5. Analytical Thinking


*Dataset Source: This dataset was taken from AlexTheAnalyst’s GitHub repository for learning purposes.*
