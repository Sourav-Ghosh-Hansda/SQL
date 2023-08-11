create table appleStore_description_combined AS
select * from appleStore_description1
UNION ALL
SELECT * from appleStore_description2
UNION ALL 
SELECT * from appleStore_description3
UNION ALL 
SELECT * FROM appleStore_description4;
** EDA **
-- check the number of unique apps in both tables AppleStore
SELECT COUNT(DISTINCT id) As UniqueAppIDs
from AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
from appleStore_description_combined;

--Check for any missing values in key fields
SELECT count(*) AS MissingValues
FROM AppleStore
where track_name is NULL or user_rating is NULL OR prime_genre;IS NULL

SELECT count(*) AS MissingValues
FROM appleStore_description_combined 
where app_desc IS NULL;

--Find out the number of apps per genre
SELECT prime_genre,COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC;

--Get an overview of the apps ratings 
SELECT min(user_rating) AS MinRating,
max(user_rating) as MaxRating, 
avg(user_rating) AS AvgRating 
FROM AppleStore;

**Data Analysis**
--Determine whether paid apps have higher ratings than free apps
SELECT case 
WHEN price > 0 THEN 'Paid'
ELSE 'Free'
END AS App_Type,
avg(user_rating) AS Avg_rating
from AppleStore
group BY App_Type;
--- Check if apps with more supported languages have higher ratings
SELECT case 
WHEN lang_num < 10 THEN '< 10 languages' 
WHEN lang_num BETWEEN 10 and 30 THEN '10-30 languages' 
ELSE'>30 languages'
END as language_bucket,
avg(user_rating) as Avg_Rating
from AppleStore
GROUP bY language_bucket
ORDER by Avg_Rating DESC;
--- Check genre with low ratings
SELECT prime_genre,
avg(user_rating) as Avg_Rating
FROM AppleStore 
GROUP by prime_genre
ORDER by Avg_Rating ASC;
--Check if there is correlation between the length of the app description and the user rating 
SELECT
case 
when length(b.app_desc)<500 then 'Short'
when length(b.app_desc) BETWEEN 500 and 1000 then 'Medium'
else 'Long'
end as description_length_bucket,
avg(a.user_rating) as average_rating
FROM
AppleStore AS a
JOIN 
appleStore_description_combined AS b
on a.id = b.id
GROUP by description_length_bucket
order by average_rating DESC;
--Check the top rated apps for each genre 
SELECT prime_genre,
track_name,
user_rating
from (
  SELECT prime_genre,
         track_name,
         user_rating,
         RANK() OVER(PARTITION by prime_genre order by user_rating desc, rating_count_tot desc) as rank
         from 
         AppleStore
  ) as a 
  where a.rank=1;