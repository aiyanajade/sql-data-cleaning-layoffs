SELECT * FROM world_layoffs.layoffs;

CREATE TABLE layoff_staging
LIKE layoffs;

INSERT layoff_staging
SELECT *
FROM layoffs;

-- REMOVING DUPLICATES --

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location,industry,total_laid_off,percentage_laid_off,`date`,stage,country, funds_raised_millions)
AS row_num
FROM layoff_staging;

DELETE
FROM layoff_staging2
WHERE row_num >1;

SELECT *
FROM layoff_staging2
WHERE row_num>1;

-- STANDARDIZING DATA --

SELECT DISTINCT country
FROM layoff_staging2;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT *
FROM layoff_staging2;

UPDATE layoff_staging2
SET  `date` = str_to_date(`date`,'%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

-- ADDRESSING NULL/BLANK VALUES --

WITH blank_ind AS
(
SELECT company c
FROM layoff_staging2
WHERE industry IS NULL OR industry = ''
)
SELECT company, industry
FROM layoff_staging2 INNER JOIN blank_ind ON company = c;

SELECT *
FROM layoff_staging2 T1
JOIN layoff_staging2 T2
ON T1.company=T2.company
WHERE (T1.industry IS NULL OR T1.industry = '')
AND (T2.industry IS NOT NULL AND T2.industry !='');

UPDATE layoff_staging2 T1
JOIN layoff_staging2 T2
ON T1.company=T2.company
SET T1.industry = T2.industry
WHERE (T1.industry IS NULL OR T1.industry = '')
AND (T2.industry IS NOT NULL AND T2.industry !='');

SELECT *
FROM layoff_staging2;

WITH blank_country AS
(
SELECT location l
FROM layoff_staging2
WHERE country IS NULL OR country = ''
)
SELECT location,country
FROM layoff_staging2 INNER JOIN blank_country ON location = l;

-- DROPPING ROW_NUM COLUMN --

ALTER TABLE layoff_staging2
DROP COLUMN row_num;