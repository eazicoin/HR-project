-- Find the top 5 departments with the highest average monthly income: 

SELECT TOP 5 [Department], AVG([Monthly_Income]) as avg_montly FROM [HR].[dbo].[HR_Data] 
GROUP BY [dbo].[HR_Data].[Department]
ORDER BY avg_montly DESC;


-- Calculate the percentage of employees who have left the organization for each job level 
SELECT 
    [Job_Level],
    -- Count the total number of employees for each job level
    COUNT(*) AS Total_Employees,
    
	 -- Count the number of employees who have left (Attrition = 1)
    COUNT(CASE WHEN [Attrition] = 1 THEN 1 ELSE NULL END) AS Ex_Employees,
    
    -- Calculate the percentage of employees who have left
    ROUND(
        (COUNT(CASE WHEN [Attrition] = 1 THEN 1 ELSE NULL END) * 100.0) / COUNT(*), 
        2
    ) AS Percentage_Ex_Employees
FROM 
    [dbo].[HR_Data]
GROUP BY 
    [Job_Level];

-- Retrieve employees who have the highest performance rating within each department
SELECT [Employee_Number], 
    [Department], 
    [Performance_Rating]
FROM [dbo].[HR_Data]
WHERE [Performance_Rating] = (
    SELECT MAX([Performance_Rating])
    FROM [dbo].[HR_Data] AS sub
    WHERE sub.[Department] = [dbo].[HR_Data].[Department]
)
ORDER BY [Department], [Performance_Rating] DESC;

-- Find the average distance from home for employees with different levels of job involvement
SELECT [Job_Involvement], AVG([Distance_From_Home]) as Avg_Distance_From_Home
FROM [dbo].[HR_Data]
GROUP BY [Job_Involvement];

-- Calculate the average hourly rate for employees who work overtime and those who don't 

SELECT 
AVG(CASE WHEN [Over_Time] = 1 THEN [Hourly_Rate] ELSE null END) as AVG_Hourly_Rate_For_Overtime,
AVG(CASE WHEN [Over_Time] = 0 THEN [Hourly_Rate] ELSE null END) as AVG_Hourly_Rate_For_NON_Overtime
FROM [dbo].[HR_Data];

-- Retrieve employees who have worked for the maximum number of companies 
SELECT [Employee_Number], 
    [Department], [Num_Companies_Worked]
FROM [dbo].[HR_Data]
WHERE [Num_Companies_Worked] = (
 SELECT MAX([Num_Companies_Worked]) FROM [dbo].[HR_Data] 
)
ORDER BY [Num_Companies_Worked];

-- Find the most common education field among employees
SELECT TOP 1 COUNT(*) as Frequency, [Education_Field]
FROM [dbo].[HR_Data]
GROUP BY [Education_Field]
ORDER BY Frequency Desc;

-- Calculate the average performance rating for employees in each business travel category
SELECT [Business_Travel], AVG([Performance_Rating]) AS Avg_Performance_Rating
FROM [dbo].[HR_Data]
GROUP BY [Business_Travel]
ORDER BY Avg_Performance_Rating DESC;

-- Retrieve employees who have the highest stock option level within each department 
SELECT [Employee_Number], [Department], [Stock_Option_Level]
FROM [dbo].[HR_Data]
WHERE [Stock_Option_Level] = (
	SELECT MAX([Stock_Option_Level]) 
	FROM [dbo].[HR_Data] AS sub
	WHERE sub.[Department] = [dbo].[HR_Data].[Department]
)
ORDER BY [Department], [Stock_Option_Level] DESC;

--  Find the total working years and average monthly income for employees with different levels of environment satisfaction
SELECT [Environment_Satisfaction],
    SUM([Total_Working_Years]) AS Total_Working_Years,
    AVG([Monthly_Income]) AS AVG_Monthly_Income
FROM [dbo].[HR_Data]
GROUP BY [Environment_Satisfaction]
ORDER BY AVG_Monthly_Income DESC;

-- The number of active employees
SELECT COUNT(*) AS No_Of_Active_Employees
FROM [dbo].[HR_Data]
WHERE [CF_current_Employee] = 1;

-- Find the number of employees by age group
SELECT [CF_age_band], COUNT(*) AS No_Employees
FROM [dbo].[HR_Data]
GROUP BY [CF_age_band]
ORDER BY No_Employees DESC;

-- Display the attrition by education field 
SELECT [Education_Field], COUNT(CASE WHEN [Attrition] = 1 THEN 1 END) AS No_Of_Attrition
FROM [dbo].[HR_Data]
GROUP BY [Education_Field]
ORDER BY [Education_Field];

--  Attrition rate by gender for different age group 
SELECT [CF_age_band], [Gender],
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN [Attrition] = 1 THEN 1 END) AS No_Of_Attrition,
ROUND(100.0 * COUNT(CASE WHEN [Attrition] = 1 THEN 1 END) / COUNT(*), 2) AS Attrition_Rate
FROM [dbo].[HR_Data]
GROUP BY [CF_age_band], [Gender]
ORDER BY [CF_age_band], [Gender];