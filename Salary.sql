USE [Portfolio Project]

SELECT * FROM DBO.Salary_Data$

--Determine count in each job title

SELECT dbo.Salary_Data$.[Job Title],COUNT(dbo.Salary_Data$.[Job Title]) as Count_of_Job
FROM dbo.Salary_Data$
GROUP BY dbo.Salary_Data$.[Job Title]
ORDER BY Count_of_Job DESC

--Distribution of Salary, Years of Experience, and Education Level per Job Title

SELECT dbo.Salary_Data$.[Job Title], dbo.Salary_Data$.[Education Level], dbo.Salary_Data$.Salary, dbo.Salary_Data$.[Years of Experience],
ROUND(AVG(dbo.Salary_Data$.Salary) OVER (PARTITION BY dbo.Salary_Data$.[Job Title]),2) AS Average_Salary,
ROUND(AVG(dbo.Salary_Data$.[Years of Experience]) OVER(PARTITION BY dbo.Salary_Data$.[Job Title]),2) AS Average_YOE
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY [Job Title], [Education Level], Salary, [Years of Experience]
ORDER BY [Years of Experience] DESC


--Max Salary for Each Job Title

SELECT dbo.Salary_Data$.[Job Title], MAX(dbo.Salary_Data$.Salary) AS Max_Salary
FROM dbo.Salary_Data$
GROUP BY dbo.Salary_Data$.[Job Title]
ORDER BY Max_Salary DESC

--Min Salary for Each Job Title

SELECT dbo.Salary_Data$.[Job Title], MIN(dbo.Salary_Data$.Salary) AS Min_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.[Job Title]
ORDER BY Min_Salary ASC

--Average Salary by Job Title and Country

SELECT dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title], ROUND(AVG(dbo.Salary_Data$.Salary),2) AS Avg_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title]
ORDER BY dbo.Salary_Data$.Country

--Jobs with Salaries > 200,000

SELECT dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title], MAX(dbo.Salary_Data$.Salary) as Max_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title]
HAVING MAX(dbo.Salary_Data$.Salary) > 200000
ORDER BY Max_Salary DESC

--Jobs with Salaries < 40,000

SELECT dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title], MIN(dbo.Salary_Data$.Salary) as Min_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.Country, dbo.Salary_Data$.[Job Title]
HAVING MIN(dbo.Salary_Data$.Salary) < 40000
ORDER BY Min_Salary ASC

--Distribution of Salaries by Race and Gender

SELECT TOP 50 dbo.Salary_Data$.[Job Title], dbo.Salary_Data$.Race, dbo.Salary_Data$.Gender, 
MAX(dbo.Salary_Data$.Salary) as Max_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Years of Experience] > 2 AND dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.[Years of Experience], dbo.Salary_Data$.[Job Title], dbo.Salary_Data$.Race, dbo.Salary_Data$.Gender
ORDER BY Max_Salary DESC

SELECT TOP 50 dbo.Salary_Data$.[Job Title], dbo.Salary_Data$.Race, dbo.Salary_Data$.Gender, 
MAX(dbo.Salary_Data$.Salary) as Max_Salary
FROM dbo.Salary_Data$
WHERE dbo.Salary_Data$.[Years of Experience] > 2 AND dbo.Salary_Data$.[Job Title] IS NOT NULL
GROUP BY dbo.Salary_Data$.[Years of Experience], dbo.Salary_Data$.[Job Title], dbo.Salary_Data$.Race, dbo.Salary_Data$.Gender
ORDER BY Max_Salary ASC
