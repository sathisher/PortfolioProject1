
--Join for explaratory analysis. Determine the types of queries for the data in order to gain insight.

SELECT * FROM dbo.credits$ CRED
LEFT JOIN dbo.titles$ TITLE ON CRED.ID = TITLE.ID


--Determine if and how much average runtimes have changed through the years for MOVIES/SHOWS
SELECT  dbo.titles$.Release_Year, ROUND(AVG(dbo.titles$.[Runtime (minutes)]),2) AS AVERAGE_RUNTIME_MINUTES
FROM dbo.titles$
WHERE dbo.titles$.Type = 'MOVIE'
GROUP BY dbo.titles$.Release_Year
ORDER BY dbo.titles$.Release_Year ASC

SELECT dbo.titles$.Release_Year, ROUND(AVG(dbo.titles$.[Runtime (minutes)]),2) AS AVERAGE_RUNTIME_MINUTES
FROM dbo.titles$
WHERE dbo.titles$.Type = 'SHOW'
GROUP BY dbo.titles$.Release_Year
ORDER BY dbo.titles$.Release_Year ASC


--Determine whether age rating affects IMDB Score

SELECT dbo.titles$.Age_Certification, ROUND(AVG(dbo.titles$.IMDB_Score), 2) AS AVERAGE_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'SHOW' AND dbo.titles$.Age_Certification IS NOT NULL
GROUP BY dbo.titles$.Age_Certification

SELECT dbo.titles$.Age_Certification, ROUND(AVG(dbo.titles$.IMDB_Score), 2) AS AVERAGE_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'MOVIE' AND dbo.titles$.Age_Certification IS NOT NULL
GROUP BY dbo.titles$.Age_Certification

--Determine whether IMDB rating is affected by the number of seasons of a show. Union for top 10 and bottom 10 shows.

SELECT * FROM (SELECT TOP 10 dbo.titles$.Seasons, ROUND(AVG(dbo.titles$.IMDB_Score), 2) AS AVERAGE_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'SHOW'
GROUP BY dbo.titles$.Seasons
ORDER BY dbo.titles$.Seasons DESC) A
UNION
SELECT * FROM (SELECT TOP 10 dbo.titles$.Seasons, ROUND(AVG(dbo.titles$.IMDB_Score), 2) AS AVERAGE_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'SHOW'
GROUP BY dbo.titles$.Seasons
ORDER BY dbo.titles$.Seasons ASC) B
ORDER BY AVERAGE_IMDB_SCORE DESC


--Compare US Based Production Ratings against those not Produced in the US

SELECT DISTINCT TOP 10 dbo.titles$.Production_Countries, ROUND(AVG(dbo.titles$.IMDB_Score),2) AS AVG_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'MOVIE' AND dbo.titles$.Production_Countries LIKE '%US%' AND 
dbo.titles$.IMDB_Score IS NOT NULL
GROUP BY dbo.titles$.Production_Countries 
ORDER BY AVG_IMDB_SCORE DESC


SELECT DISTINCT TOP 10 dbo.titles$.Production_Countries, ROUND(AVG(dbo.titles$.IMDB_Score),2) AS AVG_IMDB_SCORE
FROM dbo.titles$
WHERE dbo.titles$.Type = 'MOVIE' AND dbo.titles$.Production_Countries NOT LIKE '%US%' AND 
dbo.titles$.IMDB_Score IS NOT NULL
GROUP BY dbo.titles$.Production_Countries, dbo.titles$.Title
ORDER BY AVG_IMDB_SCORE DESC