-- Basic problems

/*1. How many distinct zip codes are in this dataset?*/

SELECT COUNT(DISTINCT zip_code)
FROM homevalue;	

-- 2. How many zip codes are from each state?

SELECT state, COUNT(DISTINCT zip_code)
FROM homevalue
GROUP BY state;	

-- 3. What range of years are represented in the data?

SELECT DISTINCT substr(date, 1, 4) Year_range
FROM homevalue;

-- 4. Using the most recent month of data available, what is the range of estimated home values across the nation?

SELECT date, value
FROM homevalue
WHERE date = (SELECT MAX(date) FROM homevalue);

-- 5. Using the most recent month of data available, which states have the highest average home values? How about the lowest?

SELECT date, state, ROUND(AVG(value), 2) 'Avg_value'
FROM homevalue
WHERE date = (SELECT MAX(date) FROM homevalue)
GROUP BY state
ORDER BY ROUND(AVG(value), 2) DESC;

-- 6. Which states have the highest/lowest average home values for the year of 2017?

SELECT substr(date, 1, 4), state, ROUND(AVG(value), 2) 'Avg_value'
FROM homevalue
WHERE substr(date, 1, 4) = '2017'
GROUP BY state
ORDER BY ROUND(AVG(value), 2) DESC;

-- Intermediate Problems

-- 7. What is the percent change 59 in average home values from 2007 to 2017 by state?

WITH baseyear AS (SELECT homevalue.state, substr(date, 1, 4), ROUND(AVG(value), 2) 'average'
FROM homevalue
WHERE substr(date, 1, 4) = "2007"
GROUP BY homevalue.state), endyear AS (SELECT homevalue.state, substr(date, 1, 4), ROUND(AVG(value), 2) 'average'
FROM homevalue
WHERE substr(date, 1, 4) = "2017"
GROUP BY homevalue.state)

SELECT baseyear.state, baseyear.average 'Base_avg', endyear.average 'End_avg', (endyear.average - baseyear.average)/baseyear.average * 100 'Percent_change'
FROM baseyear
JOIN endyear ON baseyear.state = endyear.state; 

-- 8. How would you describe the trend in home values for each state from 2007 to 2017?

SELECT substr(date, 1, 4) 'Year', state, ROUND(AVG(value), 2) 'Avg_value'
FROM homevalue
WHERE substr(date, 1, 4) BETWEEN "2007" AND "2017"
GROUP BY substr(date, 1, 4), state;







