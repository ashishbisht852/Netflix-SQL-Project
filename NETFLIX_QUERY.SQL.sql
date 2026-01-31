---15 Business Problem------
----------1. Count the number of Movies vs TV Shows---------
select type, count(*)
from netflix
Group By type
-------- Find the most common rating for movies and TV shows-----

with cte as (
select type,rating ,count(rating) as ratings
,RANK()OVER(PARTITION BY type order by count(rating)   desc ) as ranks 
	from netflix
group by type, rating)
select * from cte 
where ranks = 1

----List all movies released in a specific year (e.g., 2020)---
select title , type ,release_year from netflix
where release_year = 2020
and type = 'Movie'
------Find the top 5 countries with the most content on Netflix----
SELECT 
UNNEST ( STRING_TO_ARRAY(country, ','))
AS new_country, COUNT(*)
   from netflix
   GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
----------Identify the longest movie----
SELECT * from netflix
where duration = (select max(duration) from netflix)
and type ='Movie'
------Find content added in the last 5 years-----
select * , TO_DATE(date_added , 'Month DD, YYYY') as date
from netflix
where TO_DATE(date_added , 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

--------Find all the movies/TV shows by director 'Rajiv Chilaka'!---
select type,title, director from netflix
where type in('Movie','TV Show')
and director LIKE '%Rajiv Chilaka%'

----List all TV shows with more than 5 seasons----
with cte as (select type , title, duration , split_part(duration,' ',1):: numeric as season
from netflix
where type = 'TV Show')
select type,title ,duration from cte
where season > 5
----- Count the number of content items in each genre---
select  UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre
, count(*) from netflix 
group by 1
----Find each year and the average numbers of content release in India on netflix
-------return top 5 year with highest avg content release!-----
select
EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD ,YYYY')) AS YEAR,
country,
COUNT(*),
ROUND(
COUNT(*)::NUMERIC /(SELECT COUNT(*) FROM netflix where country ='India')::NUMERIC * 100 ,2)AS AVG_PER_YEAR

from netflix
where country = 'India'
group by 1,2
ORDER BY 3 DESC
Limit 5; 

------ List all movies that are documentaries-------
select * from 
netflix
where
listed_in 
ILIKE '%documentaries%'
-----Find all content without a director--------
select * from 
netflix
where director IS NULL
------------ Find how many movies actor 'Salman Khan' appeared in last 10 years!---
select * from 
netflix
where  
casts ILIKE '%Salman Khan%'
AND

release_year > EXTRACT(YEAR FROM CURRENT_DATE)- 10 
-------- Find the top 10 actors who have appeared in the highest number of movies produced in India.-----
select  UNNEST ( STRING_TO_ARRAY(casts, ',')), count(show_id)
from netflix
where country = 'India'
group by 1 
order by 2 desc
limit 10;
-------Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
---the description field. Label content containing these keywords as 'Bad' and all other 
----content as 'Good'. Count how many items fall into each category.----

with cte as (select 
* ,
CASE 
WHEN description ILIKE '%kill%' OR 
           description ILIKE '%violence%'  THEN  'Bad Category'
ELSE 'Good Content'
END AS category
from netflix
)
select category, count(*) AS total_content
from cte
group by 1




































              
                                      
