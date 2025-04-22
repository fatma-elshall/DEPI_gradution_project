SELECT * FROM depi.`superstore sales dataset`;

/*select total number of rows*/
select count(*)
from depi.`superstore sales dataset`;

/* change data type of orderdate and shipdate*/
UPDATE depi.`superstore sales dataset`
SET 
  `Order Date` = STR_TO_DATE(TRIM(`Order Date`), '%d/%m/%Y'),
  `Ship Date` = STR_TO_DATE(TRIM(`Ship Date`), '%d/%m/%Y');

ALTER TABLE depi.`superstore sales dataset`
MODIFY COLUMN `Order Date` DATE,
MODIFY COLUMN `Ship Date` DATE;



SET SQL_SAFE_UPDATES = 0;   /*to turn off safe updates*/
DESCRIBE depi.`superstore sales dataset`;   /*to confirm of data types again*/

/* delete 'postal code ' and 'row id'*/
alter table depi.`superstore sales dataset`
drop column `Postal Code`,
drop column `Row ID`;

/* check for nulls in all columns */ 
SELECT 
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS Order_ID_nulls,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS Order_Date_nulls,
    SUM(CASE WHEN `Ship Date` IS NULL THEN 1 ELSE 0 END) AS Ship_Date_nulls,
    SUM(CASE WHEN `Ship Mode` IS NULL THEN 1 ELSE 0 END) AS Ship_Mode_nulls,
    SUM(CASE WHEN `City` IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN `Country` IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN `Region` IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN `State` IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN `Sub-Category` IS NULL THEN 1 ELSE 0 END) AS region_nulls
FROM depi.`superstore sales dataset`;

/*Check validate Dates ( if Ship Date before Order Date)*/
SELECT *
 FROM depi.`superstore sales dataset`
WHERE `Ship Date` < `Order Date`;

/* check duplicates in data*/
SELECT 
    `Order ID`,`Ship Mode`, `Customer ID`, `Customer Name`, `Segment`, `Country`, `City`, `State`, `Region`, 
    `Product ID`, `Category`, `Sub-Category`, `Product Name`,`Sales`, `Order Date`, `Ship Date`, 
    COUNT(*) AS duplicate_count
FROM  depi.`superstore sales dataset`
GROUP BY 
`Order ID`, `Ship Mode`, `Customer ID`, `Customer Name`, `Segment`, `Country`, `City`, `State`, `Region`, 
`Product ID`, `Category`, `Sub-Category`, `Product Name`, `Sales`, `Order Date`, `Ship Date`
HAVING COUNT(*) > 1;

/* drop duplicates */
/* create new table for cleaned data*/
CREATE TABLE depi.`superstore_clean` AS
SELECT DISTINCT *
FROM depi.`superstore sales dataset`;

/* to confirm again the total number of rows*/
select count(*)
from depi.`superstore_clean`;



