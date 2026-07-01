select *from netflix_analysis

--1. Find the Top 10 Directors with the Most Movies

SELECT
    director,
    COUNT(*) AS total_movies
FROM netflix_analysis
WHERE type = 'Movie'
  AND director IS NOT NULL
GROUP BY director
ORDER BY total_movies DESC
LIMIT 10;

--2. Rank Countries Based on Number of Titles

SELECT
    TRIM(country_name) AS country,
    COUNT(*) AS total_titles,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS country_rank
FROM (
    SELECT
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country_name
    FROM netflix_analysis
    WHERE country IS NOT NULL
) t
GROUP BY country
ORDER BY country_rank;

--3. Find the Longest Movie

SELECT
    title,
    director,
    country,
    release_year,
    duration
FROM netflix_analysis
WHERE type = 'Movie'
ORDER BY CAST(REPLACE(duration, ' min', '') AS INTEGER) DESC
LIMIT 1;

--4. Find All Movies Released After 2020

SELECT
    title,
    director,
    release_year,
    duration
FROM netflix_analysis
WHERE type = 'Movie'
  AND release_year > 2020
ORDER BY release_year DESC;

--5. Find Directors Who Have Directed Both Movies and TV Shows

SELECT
    director
FROM netflix_analysis
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(DISTINCT type) = 2;

--6. Count Titles by Rating

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_analysis
GROUP BY rating
ORDER BY total_titles DESC;

--7. Find Duplicate Titles

SELECT
    title,
    COUNT(*) AS occurrences
FROM netflix_analysis
GROUP BY title
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

--8. Calculate Average Movie Duration by Country

SELECT
    TRIM(country_name) AS country,
    ROUND(
        AVG(
            CAST(REPLACE(duration, ' min', '') AS NUMERIC)
        ),
        2
    ) AS avg_duration
FROM (
    SELECT
        duration,
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country_name
    FROM netflix_analysis
    WHERE type = 'Movie'
      AND duration IS NOT NULL
      AND country IS NOT NULL
) t
GROUP BY country
ORDER BY avg_duration DESC;

--9. Find the Top 5 Genres

SELECT
    TRIM(genre) AS genre,
    COUNT(*) AS total_titles
FROM (
    SELECT
        UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
    FROM netflix_analysis
) t
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 5;

--10. Calculate Yearly Growth in Netflix Titles

WITH yearly_titles AS (
    SELECT
        release_year,
        COUNT(*) AS total_titles
    FROM netflix_analysis
    GROUP BY release_year
)

SELECT
    release_year,
    total_titles,
    total_titles -
    LAG(total_titles) OVER (ORDER BY release_year) AS yearly_growth
FROM yearly_titles
ORDER BY release_year;

--Year-over-Year Growth %

WITH yearly_titles AS (
    SELECT
        release_year,
        COUNT(*) AS total_titles
    FROM netflix_analysis
    GROUP BY release_year
)

SELECT
    release_year,
    total_titles,
    LAG(total_titles) OVER (ORDER BY release_year) AS previous_year,
    ROUND(
        (
            (total_titles - LAG(total_titles) OVER (ORDER BY release_year))
            * 100.0 /
            LAG(total_titles) OVER (ORDER BY release_year)
        ),
        2
    ) AS growth_percentage
FROM yearly_titles
ORDER BY release_year;