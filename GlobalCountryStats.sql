USE [Portfolio Project]
------------------------------------------
--UPDATE NULL VALUES

--UPDATE DBO.GlobalCountryStats$
--SET [Armed Forces size] = ISNULL(dbo.GlobalCountryStats$.[Armed Forces size],0)

--UPDATE DBO.GlobalCountryStats$
--SET Abbreviation = ISNULL(dbo.GlobalCountryStats$.Abbreviation,'N/A')

--UPDATE DBO.GlobalCountryStats$
--SET [Agricultural Land( %)] = ISNULL(dbo.GlobalCountryStats$.[Agricultural Land( %)],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Land Area(Km2)] = ISNULL(dbo.GlobalCountryStats$.[Land Area(Km2)],0)

--UPDATE DBO.GlobalCountryStats$
--SET [Birth Rate] = ISNULL(dbo.GlobalCountryStats$.[Birth Rate],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Calling Code] = ISNULL(dbo.GlobalCountryStats$.[Calling Code],000)

--UPDATE DBO.GlobalCountryStats$
--SET [Capital/Major City] = ISNULL(dbo.GlobalCountryStats$.[Capital/Major City],'N/A')

--UPDATE DBO.GlobalCountryStats$
--SET [Co2-Emissions] = ISNULL(dbo.GlobalCountryStats$.[Co2-Emissions],000)

--UPDATE DBO.GlobalCountryStats$
--SET CPI = ISNULL(dbo.GlobalCountryStats$.CPI,0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [CPI Change (%)] = ISNULL(dbo.GlobalCountryStats$.CPI,0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Currency-Code] = ISNULL(dbo.GlobalCountryStats$.[Currency-Code],'N/A')

--UPDATE DBO.GlobalCountryStats$
--SET [Fertility Rate] = ISNULL(dbo.GlobalCountryStats$.[Fertility Rate],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Forested Area (%)] = ISNULL(dbo.GlobalCountryStats$.[Forested Area (%)],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Gasoline Price] = ISNULL(dbo.GlobalCountryStats$.[Gasoline Price],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET GDP = ISNULL(dbo.GlobalCountryStats$.GDP,000)

--UPDATE DBO.GlobalCountryStats$
--SET [Gross primary education enrollment (%)] = ISNULL(dbo.GlobalCountryStats$.[Gross primary education enrollment (%)],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Gross tertiary education enrollment (%)] = ISNULL(dbo.GlobalCountryStats$.[Gross tertiary education enrollment (%)],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Infant mortality] = ISNULL(dbo.GlobalCountryStats$.[Infant mortality],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Largest city] = ISNULL(dbo.GlobalCountryStats$.[Largest city],'N/A')

--UPDATE DBO.GlobalCountryStats$
--SET [Life expectancy] = ISNULL(dbo.GlobalCountryStats$.[Life expectancy],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Maternal mortality ratio] = ISNULL(dbo.GlobalCountryStats$.[Maternal mortality ratio],0)

--UPDATE DBO.GlobalCountryStats$
--SET [Minimum wage] = ISNULL(dbo.GlobalCountryStats$.[Minimum wage],0)

--UPDATE DBO.GlobalCountryStats$
--SET [Official language] = ISNULL(dbo.GlobalCountryStats$.[Official language],'N/A')

--UPDATE DBO.GlobalCountryStats$
--SET [Out of pocket health expenditure] = ISNULL(dbo.GlobalCountryStats$.[Out of pocket health expenditure],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Physicians per thousand] = ISNULL(dbo.GlobalCountryStats$.[Physicians per thousand],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET Population = ISNULL(dbo.GlobalCountryStats$.Population, 0)

--UPDATE DBO.GlobalCountryStats$
--SET [Population: Labor force participation (%)] = ISNULL(dbo.GlobalCountryStats$.[Population: Labor force participation (%)],0.00)

--UPDATE DBO.GlobalCountryStats$
--SET [Tax revenue (%)] = ISNULL(dbo.GlobalCountryStats$.[Tax revenue (%)],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Total tax rate] = ISNULL(dbo.GlobalCountryStats$.[Total tax rate],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET [Unemployment rate] = ISNULL(dbo.GlobalCountryStats$.[Unemployment rate],0.000)

--UPDATE DBO.GlobalCountryStats$
--SET Urban_population = ISNULL(dbo.GlobalCountryStats$.Urban_population, 0)


------------------------------------------

--DATA QUERIES
------------------------------------------

--DOES URBAN POPULATION CORRELATE WITH CO2 EMMISSIONS AND AGRICULTURAL LAND?

SELECT * FROM dbo.GlobalCountryStats$

SELECT TOP 10 dbo.GlobalCountryStats$.Country,dbo.GlobalCountryStats$.Urban_population,
dbo.GlobalCountryStats$.[Co2-Emissions(tons)], dbo.GlobalCountryStats$.[Agricultural Land( %)]
FROM dbo.GlobalCountryStats$
WHERE dbo.GlobalCountryStats$.[Co2-Emissions(tons)] > 0
GROUP BY Country, [Co2-Emissions(tons)], Urban_population, [Agricultural Land( %)]
ORDER BY Urban_population DESC

--WHAT PERCENT OF THE TOTAL POPULATION IS CONSIDERED URBAN?

SELECT dbo.GlobalCountryStats$.Country, dbo.GlobalCountryStats$.Population, dbo.GlobalCountryStats$.Urban_population,
		(dbo.GlobalCountryStats$.Urban_population/dbo.GlobalCountryStats$.Population)* 100  AS Percent_PopulationisUrban
FROM dbo.GlobalCountryStats$
WHERE dbo.GlobalCountryStats$.Urban_population > 0
ORDER BY Percent_PopulationisUrban DESC


--IS THERE A CORRELATION BETWEEN LIFE EXPECTANCY AND CO2 EMMISSIONS?

SELECT * FROM(
SELECT TOP 5 dbo.GlobalCountryStats$.Country, dbo.GlobalCountryStats$.[Life expectancy], dbo.GlobalCountryStats$.[Co2-Emissions(tons)]
FROM dbo.GlobalCountryStats$
WHERE dbo.GlobalCountryStats$.[Life expectancy] > 0 AND dbo.GlobalCountryStats$.[Co2-Emissions(tons)] > 0
GROUP BY COUNTRY, [Life expectancy], [Co2-Emissions(tons)]
ORDER BY dbo.GlobalCountryStats$.[Life expectancy] ASC) A
UNION
SELECT * FROM(
SELECT TOP 5 dbo.GlobalCountryStats$.Country, dbo.GlobalCountryStats$.[Life expectancy], dbo.GlobalCountryStats$.[Co2-Emissions(tons)]
FROM dbo.GlobalCountryStats$
WHERE dbo.GlobalCountryStats$.[Life expectancy] > 0 AND dbo.GlobalCountryStats$.[Co2-Emissions(tons)] > 0
GROUP BY COUNTRY, [Life expectancy], [Co2-Emissions(tons)]
ORDER BY dbo.GlobalCountryStats$.[Life expectancy] DESC) B
ORDER BY [Life expectancy] DESC


--DOES MINIMUM WAGE/UNEMPLOYMENT RATE CORRELATE WITH LIFE EXPECTANCY?
SELECT * FROM(
SELECT TOP 10 dbo.GlobalCountryStats$.Country,dbo.GlobalCountryStats$.[Minimum wage], [Life expectancy]
FROM dbo.GlobalCountryStats$
WHERE [Minimum wage] > 0 AND [Life expectancy] > 0
ORDER BY [Minimum wage] ASC) A
UNION
SELECT * FROM(
SELECT TOP 10 dbo.GlobalCountryStats$.Country,dbo.GlobalCountryStats$.[Minimum wage], [Life expectancy]
FROM dbo.GlobalCountryStats$
WHERE [Minimum wage] > 0 AND [Life expectancy] > 0
ORDER BY [Minimum wage] DESC) B
ORDER BY [Minimum wage] DESC

--DOES GROSS TERTIARY EDUCATION ENROLLMENT CORRELATE WITH LABOR FORCE PARTICIPATION/OUT OF POCKET HEALTHCARE EXPENDITURE?

SELECT * FROM(
SELECT TOP 10 dbo.GlobalCountryStats$.Country, dbo.GlobalCountryStats$.[Gross tertiary education enrollment (%)], dbo.GlobalCountryStats$.[Population: Labor force participation (%)],
dbo.GlobalCountryStats$.[Out of pocket health expenditure]
FROM dbo.GlobalCountryStats$
WHERE [Population: Labor force participation (%)] > 0
GROUP BY [Country], [Gross tertiary education enrollment (%)], [Out of pocket health expenditure], [Population: Labor force participation (%)]
ORDER BY [Gross tertiary education enrollment (%)] DESC) A
UNION 
SELECT * FROM(
SELECT TOP 10 dbo.GlobalCountryStats$.Country, dbo.GlobalCountryStats$.[Gross tertiary education enrollment (%)], dbo.GlobalCountryStats$.[Population: Labor force participation (%)],
dbo.GlobalCountryStats$.[Out of pocket health expenditure]
FROM dbo.GlobalCountryStats$
WHERE [Population: Labor force participation (%)] > 0 AND [Gross tertiary education enrollment (%)] > 0
GROUP BY [Country], [Gross tertiary education enrollment (%)], [Out of pocket health expenditure], [Population: Labor force participation (%)]
ORDER BY [Gross tertiary education enrollment (%)] ASC) B
ORDER BY [Gross tertiary education enrollment (%)] DESC