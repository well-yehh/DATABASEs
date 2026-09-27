SELECT* FROM zepto

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
availablequantity IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

--diffrent product Categories

SELECT DISTINCT category FROM zepto
ORDER BY category;

--Products in stock vs out stock
SELECT outofstock, COUNT(sku_id) FROM zepto
Group by outofstock;

--Product name present multiple times
SELECT name ,COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC

--Data Cleaning

--Products with price = 0
SELECT * FROM zepto 
Where mrp = 0 OR discountedsellingprice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

SELECT mrp, discountedsellingprice FROM zepto;

--Q1. Find the top 10 best-value products based on the discount percentage,
SELECT DISTINCT name, discountpercent FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

--Q2. What are the Products with High MRP but out of Stock
SELECT DISTINCT name, mrp FROM zepto
WHERE outofstock = TRUE
ORDER BY mrp DESC
LIMIT 10;

--Q3. Calculate estimate Revenue for each category
SELECT category,
SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto
GROUP by category
ORDER BY total_revenue;

--Q4. Find all the products where MRP is greater then 500 and discount is less then 10%
SELECT DISTINCT name,mrp,discountpercent FROM zepto
WHERE mrp > 500.0  and discountpercent < 10.0
ORDER BY mrp DESC;

--Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountpercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--Q6. Find the Price per gram for product above 100g and sort by best value.
SELECT DISTINCT name,
ROUND((discountedsellingprice/weightingms),2) AS mrp_pergm,
weightingms,
discountedsellingprice
FROM zepto
WHERE weightingms > 100
ORDER BY mrp_pergm DESC

--Q7. Group the products into categories like low,medium, Bulk.
SELECT DISTINCT name,
weightingms,
CASE WHEN weightingms < 1000 THEN 'low'
	WHEN weightingms < 5000 THEN 'medium'
	else 'Bulk'
	END AS weight_categories
FROM zepto;

--Q8. What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightingms * availablequantity) AS Weight_per_category
FROM zepto
GROUP BY category                    
ORDER BY Weight_per_category;

