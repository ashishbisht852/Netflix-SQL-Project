Netflix Movies & TV Shows Analysis using SQL



 Project Overview

This project focuses on analyzing Netflix’s movies and TV shows dataset using SQL.  
The objective is to extract meaningful insights by answering real-world business questions related to content type, ratings, countries, release trends, genres, and descriptions.

The project demonstrates hands-on SQL skills such as filtering, aggregation, joins, CTEs, window functions, string manipulation, and date handling—commonly required for data analyst roles.

 Project Objectives

- Analyze the distribution of Movies and TV Shows  
- Identify the most common ratings for each content type  
- Explore content trends across countries and release years  
- Work with multi-valued columns like cast, country, and genres  
- Categorize content based on keywords in descriptions  


 Dataset Information

- **Source:** Kaggle  
- **Dataset Name:** Netflix Movies and TV Shows  
- **Link:** https://www.kaggle.com/datasets/shivamb/netflix-shows  

The dataset includes details such as title, type, director, cast, country, release year, rating, duration, genre, and description.

---

 Database Schema

```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix (
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
