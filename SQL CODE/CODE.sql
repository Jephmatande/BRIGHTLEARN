--Injesting the data and checking the dataset.
Select*
from `bright_coffee_shop_analysis_project_case_study_1` 
limit 100;

---Understanding the size of the data and its number of rows.
Select COUNT(*) AS number_of_rows
from `bright_coffee_shop_analysis_project_case_study_1`;
--The dataset has 149116 rows. This is a large dataset , sufficient for analysis.

---Understanding the size of the data- its number of products, number of stores, the number of transations and the volumne of sales.
Select COUNT(*) AS number_of_rows,
      count(DISTINCT transaction_id) AS Number_of_Sales,
      count(distinct product_id) AS Number_of_products,
      count(distinct store_id) AS Number_of_stores
from `bright_coffee_shop_analysis_project_case_study_1`;
---The datasets has 149116 entries, making it large enough for the analysis. This signifies a high volume of transations happening at the three store locations.

---CHECKING THE PERIOD COVERED BY THE DATA
Select 
min(transaction_date) AS START_DATE, MAX(transaction_date) AS END_DATE
FROM `bright_coffee_shop_analysis_project_case_study_1`;
---The data is from the period 1 January 2023 to 30 June 2026. There is sufficient data to perform the analysis and the data is relevant as it os
---fairly old. Thusm it is relevant to the analysis.Also, it covers two main seasons- summer and winter, hence, its relevance in explaining customer consumption behaviours.

---Chacking the lowest, average and highest amount spent.
SELECT
      Min(transaction_qty*Unit_price) AS LOWEST_SPENDER,
      Max(transaction_qty*unit_price) AS HIGHEST_SPENDER,
      Avg(transaction_qty*unit_price) AS AVERAGE_PRICE
From `bright_coffee_shop_analysis_project_case_study_1`;
--The lowest spender spent 0,8 unit of currency while the highest spender spent 360 units of currency. The aveareg shows that a few are big spenders.

---checking the number of stores
Select 
Distinct store_location, store_id
from `bright_coffee_shop_analysis_project_case_study_1`;
---There are 3 unique stores locations in the dataset.Their names are Lower Manhattan, Hell`s Kitchen and Astoria.The business has limited locations. There is room for the business to expand into new locations. The CEO should consider adding more locations.

--- chenking the range of products being sold by the business.
Select 
Distinct product_category
from `bright_coffee_shop_analysis_project_case_study_1`;
---The business is silling 9 product categories ranging from coffee, bakery , tea and drinking chocolates.These stores sale a fairly sizable product range.

---checking the product category and product types.
Select
Distinct product_category, product_type
from `bright_coffee_shop_analysis_project_case_study_1`;
--The 9 product categories have 29 product types.There is s wide range of product types.

---checking the different product details
Select 
Distinct product_detail, product_category
from `bright_coffee_shop_analysis_project_case_study_1`;
---The datas shows that there are 80 different product details. This shows that there is a wide range of products the business is selling.
---this shows potential of growing the business by targeting different clintile.

---checking the cheapest price and the highest price of  the products.
select 
MIN(unit_price) AS CHEAPEST_PRICE,
MAX(Unit_price) AS HIGHEST_PRICE
from `bright_coffee_shop_analysis_project_case_study_1`;
---The cheapest produc price is 0.8 unit price and the highest price is 45 unit price. This demonstrate a huge difference in product prices.

---checking the average price
Select 
avg(unit_price) AS AVERAGE_PRICE
from `bright_coffee_shop_analysis_project_case_study_1`;
---The most expensive price is 3.38 unit price. This shows that most of the different products are generally low.

---Perform an analysis of the data functions. This includes showing the days of the week and the months of the year.
select 
Transaction_date,
dayname(Transaction_date) AS DAY_OF_THE_WEEK,
monthname(transaction_date) AS MONTH_NAME
from `bright_coffee_shop_analysis_project_case_study_1`
Limit 10;

---Calculating the revenue received per transaction per day from 1 Jan 2023 to 30 June 2023.
select 
Transaction_date,
dayname(Transaction_date) AS DAY_OF_THE_WEEK,
monthname(transaction_date) AS Month_name,
transaction_qty*unit_price AS Revenue_per_trans
from `bright_coffee_shop_analysis_project_case_study_1`; 

---Calculating the total revenue received per day from 1 January 2023 to 30 June 2023.
select Transaction_date,
dayname(Transaction_date) AS DAY_OF_THE_WEEK,
monthname(transaction_date) AS Month_name,
Count(distinct transaction_id) as Number_of_sales,
Sum(transaction_qty*unit_price) AS Revenue_per_day
from `bright_coffee_shop_analysis_project_case_study_1`
Group by Transaction_date, Month_name;

--Checking for null values in the dataset.
Select*
from `bright_coffee_shop_analysis_project_case_study_1`
where unit_price is null
or transaction_id is null
or transaction_qty is null;
--The dataset is clean with no null values. This means it is readily usable for analysis.

--Checking categorical columns
select store_location,
product_category,
Product_detail
from `bright_coffee_shop_analysis_project_case_study_1`
Group by store_location,
product_category,
Product_detail;

--Calculating the total revenue received on 1 January 2023
select Transaction_date,
dayname(Transaction_date) AS Day_name,
monthname(transaction_date) AS Month_name
from `bright_coffee_shop_analysis_project_case_study_1`
Group by transaction_date,
Day_name,
Month_name;

--Categorical data
Select product_category,
store_location,
product_detail
from `bright_coffee_shop_analysis_project_case_study_1`;

-- Creating the big clean dataset
select
  *
from
  `workspace`.`default`.`project2_bright_coffee_shop_analysis_case_study`
limit 100;

SELECT
  Transaction_id,
  Transaction_date,
  Dayname(transaction_date) as Day_name,
  Monthname(transaction_date) as Month_name,
  Dayofmonth(transaction_date) as Day_of_month,
  Transaction_time,
  Transaction_qty,
  store_id,
  store_location,
  product_id,
  unit_price,
  product_category,
  product_type,
  product_detail,
  CASE
    WHEN Dayname(transaction_date) IN ('Sun', 'Sat') THEN 'WEEKEND'
    ELSE 'WEEKDAY'
  END AS DAY_CLASSIFICATION,
  --Four new columns were added to the table. These are the Day name, Month name, Day of Month name and the Day classification from the case.
  --Time buckets created.
  CASE
    WHEN
      Date_format(transaction_time, 'hh:mm:ss') BETWEEN '00:00:00' AND '05:59:59'
    THEN
      'Early_Morning'
    WHEN Date_format(transaction_time, 'hh:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN
      Date_format(transaction_time, 'hh:mm:ss') BETWEEN '12:00:00' AND '17:59:59'
    THEN
      'Afternoon'
    WHEN Date_format(transaction_time, 'hh:mm:ss') BETWEEN '18:00:00' AND '23:59:59' THEN 'Night'
    ELSE 'STRANGE_TIME'
  END AS TIME_BUCKETS,
  --Expenditure buckets
  CASE
    WHEN (transaction_qty * unit_price) <= 50 THEN 'Low_spender'
    WHEN (transaction_qty * unit_price) Between 50.1 and 150 THEN 'Moderate_ spender'
    WHEN (transaction_qty * unit_price) >= 50 THEN 'High_spender'
    ELSE 'Ungraded'
  END AS SPENDING_BUCKET,
  --Add the Revenue column
  Transaction_qty
    * unit_price AS REVENUE
FROM
  `workspace`.`default`.`project2_bright_coffee_shop_analysis_case_study`;
