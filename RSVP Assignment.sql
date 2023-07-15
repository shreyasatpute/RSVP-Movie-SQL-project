USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
 SELECT COUNT(*) FROM director_mapping; SELECT COUNT(*) FROM genre; SELECT COUNT(*) FROM movie; SELECT COUNT(*) FROM ratings; SELECT COUNT(*) FROM names; SELECT COUNT(*) FROM role_mapping;
 +----------+
| COUNT(*) |
+----------+
|     3867 |
+----------+
1 row in set (0.00 sec)

+----------+
| COUNT(*) |
+----------+
|    14662 |
+----------+
1 row in set (0.00 sec)

+----------+
| COUNT(*) |
+----------+
|     7997 |
+----------+
1 row in set (0.00 sec)

+----------+
| COUNT(*) |
+----------+
|     7997 |
+----------+
1 row in set (0.00 sec)

+----------+
| COUNT(*) |
+----------+
|    25735 |
+----------+
1 row in set (0.00 sec)

+----------+
| COUNT(*) |
+----------+
|    15615 |
+----------+
1 row in set (0.00 sec)








-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT 
		SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS ID_nulls, 
		SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_nulls, 
		SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_nulls,
		SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_published_nulls,
		SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_nulls,
		SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
		SUM(CASE WHEN worlwide_gross_income IS NULL THEN 1 ELSE 0 END) AS worlwide_gross_income_nulls,
		SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages_nulls,
		SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS production_company_nulls

FROM movie;
+----------+-------------+------------+----------------------+----------------+---------------+-----------------------------+-----------------+--------------------------+
| ID_nulls | title_nulls | year_nulls | date_published_nulls | duration_nulls | country_nulls | worlwide_gross_income_nulls | languages_nulls | production_company_nulls |
+----------+-------------+------------+----------------------+----------------+---------------+-----------------------------+-----------------+--------------------------+
|        0 |           0 |          0 |                    0 |              0 |            20 |                        3724 |             194 |
         528 |
+----------+-------------+------------+----------------------+----------------+---------------+-----------------------------+-----------------+--------------------------+
1 row in set (0.04 sec)








-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


number of movies released each year
SELECT year, COUNT(id) as number_of_movies
FROM movie
GROUP BY year
ORDER BY year;
+------+------------------+
| year | number_of_movies |
+------+------------------+
| 2017 |             3052 |
| 2018 |             2944 |
| 2019 |             2001 |
+------+------------------+
3 rows in set (0.03 sec)



number of movies released month wise
 SELECT MONTH(date_published) AS month_number, COUNT(id) AS number_movies FROM movie GROUP BY MONTH(date_published) ORDER BY MONTH(date_published);
 +--------------+---------------+
| month_number | number_movies |
+--------------+---------------+
|            1 |           804 |
|            2 |           640 |
|            3 |           824 |
|            4 |           680 |
|            5 |           625 |
|            6 |           580 |
|            7 |           493 |
|            8 |           678 |
|            9 |           809 |
|           10 |           801 |
|           11 |           625 |
|           12 |           438 |
+--------------+---------------+
12 rows in set (0.01 sec)








/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:


 SELECT COUNT(id) AS total_movies_ptoduced, year FROM movie WHERE country = 'USA' OR country = 'India' GROUP BY country HAVING year = 2019;
 +-----------------------+------+
| total_movies_ptoduced | year |
+-----------------------+------+
|                  1007 | 2019 |
+-----------------------+------+







/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT DISTINCT genre FROM genre;
+-----------+
| genre     |
+-----------+
| Drama     |
| Fantasy   |
| Thriller  |
| Comedy    |
| Horror    |
| Family    |
| Romance   |
| Adventure |
| Action    |
| Sci-Fi    |
| Crime     |
| Mystery   |
| Others    |
+-----------+
13 rows in set (0.03 sec)









/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

 SELECT genre, year, COUNT(movie_id) AS total_movies FROM genre AS g INNER JOIN movie AS m ON g.movie_id = m.id WHERE year = 2019 GROUP BY genre ORDER
 BY total_movies DESC LIMIT 1;
 +-------+------+--------------+
| genre | year | total_movies |
+-------+------+--------------+
| Drama | 2019 |         1078 |
+-------+------+--------------+
1 row in set (0.03 sec)









/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

 WITH ct_genre AS (SELECT movie_id, COUNT(genre) AS total_movies FROM genre GROUP BY movie_id HAVING total_movies = 1) SELECT COUNT(movie_id) AS total_movies FROM ct_genre;
 +--------------+
| total_movies |
+--------------+
|         3289 |
+--------------+
1 row in set (0.01 sec)









/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


 SELECT genre, ROUND(AVG(duration),2) AS avg_duration FROM genre INNER JOIN movie ON genre.movie_id = movie.id GROUP BY genre ORDER BY AVG(duration) D
ESC;
+-----------+--------------+
| genre     | avg_duration |
+-----------+--------------+
| Action    |       112.88 |
| Romance   |       109.53 |
| Crime     |       107.05 |
| Drama     |       106.77 |
| Fantasy   |       105.14 |
| Comedy    |       102.62 |
| Adventure |       101.87 |
| Mystery   |       101.80 |
| Thriller  |       101.58 |
| Family    |       100.97 |
| Others    |       100.16 |
| Sci-Fi    |        97.94 |
| Horror    |        92.72 |
+-----------+--------------+
13 rows in set (0.04 sec)






/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:



  WITH gen_rank AS
    -> (
    -> SELECT genre, COUNT(movie_id) AS total_movies,
    ->    RANK() OVER(ORDER BY COUNT(movie_id) DESC) AS gen_rank
    -> FROM genre
    -> GROUP BY genre
    -> )
    -> SELECT * FROM gen_rank WHERE genre='thriller';
+----------+--------------+----------+
| genre    | total_movies | gen_rank |
+----------+--------------+----------+
| Thriller |         1484 |        3 |
+----------+--------------+----------+
1 row in set (0.02 sec)






/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

 SELECT MIN(avg_rating) AS minimum_ratings,MAX(avg_rating) AS maximum_ratings,MIN(total_votes) AS minimum_votes, MAX(total_votes) AS maximum_votes,MIN
(median_rating) AS minimum_rating, MAX(median_rating) AS maximum_rating FROM ratings;
+-----------------+-----------------+---------------+---------------+----------------+----------------+
| minimum_ratings | maximum_ratings | minimum_votes | maximum_votes | minimum_rating | maximum_rating |
+-----------------+-----------------+---------------+---------------+----------------+----------------+
|             1.0 |            10.0 |           100 |        725138 |              1 |             10 |
+-----------------+-----------------+---------------+---------------+----------------+----------------+
1 row in set (0.01 sec)




    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
 SELECT title, avg_rating,
    ->          DENSE_RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON r.movie_id = m.id
    -> LIMIT 10;
+--------------------------------+------------+------------+
| title                          | avg_rating | movie_rank |
+--------------------------------+------------+------------+
| Kirket                         |       10.0 |          1 |
| Love in Kilnerry               |       10.0 |          1 |
| Gini Helida Kathe              |        9.8 |          2 |
| Runam                          |        9.7 |          3 |
| Fan                            |        9.6 |          4 |
| Android Kunjappan Version 5.25 |        9.6 |          4 |
| Yeh Suhaagraat Impossible      |        9.5 |          5 |
| Safe                           |        9.5 |          5 |
| The Brighton Miracle           |        9.5 |          5 |
| Shibu                          |        9.4 |          6 |
+--------------------------------+------------+------------+
10 rows in set (0.11 sec)





/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

 SELECT median_rating, COUNT(movie_id) AS total_movies FROM ratings GROUP BY median_rating ORDER BY median_rating;
+---------------+--------------+
| median_rating | total_movies |
+---------------+--------------+
|             1 |           94 |
|             2 |          119 |
|             3 |          283 |
|             4 |          479 |
|             5 |          985 |
|             6 |         1975 |
|             7 |         2257 |
|             8 |         1030 |
|             9 |          429 |
|            10 |          346 |
+---------------+--------------+
10 rows in set (0.01 sec)









/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

 
 SELECT production_company, COUNT(id) AS movie_count,
    ->          DENSE_RANK() OVER(ORDER BY COUNT(id) DESC) AS prod_company_rank
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id = r.movie_id
    -> WHERE avg_rating > 8 AND production_company IS NOT NULL
    -> GROUP BY production_company
    -> ORDER BY movie_count DESC;
+-----------------------------------------+-------------+-------------------+
| production_company                      | movie_count | prod_company_rank |
+-----------------------------------------+-------------+-------------------+
| Dream Warrior Pictures                  |           3 |                 1 |
| National Theatre Live                   |           3 |                 1 |
| Lietuvos Kinostudija                    |           2 |                 2 |
| Swadharm Entertainment                  |           2 |                 2 |
| Panorama Studios                        |           2 |                 2 |
| Marvel Studios                          |           2 |                 2 |
| Central Base Productions                |           2 |                 2 |
| Painted Creek Productions               |           2 |                 2 |
| National Theatre                        |           2 |                 2 |
| Colour Yellow Productions               |           2 |                 2 |
| The Archers                             |           1 |                 3 |
| Blaze Film Enterprises                  |           1 |                 3 |
| Bradeway Pictures                       |           1 |                 3 |
| Bert Marcus Productions                 |           1 |                 3 |
| A Studios                               |           1 |                 3 |
| Ronk Film                               |           1 |                 3 |
| Benaras Mediaworks                      |           1 |                 3 |
| Bioscope Film Framers                   |           1 |                 3 |
| Bestwin Production                      |           1 |                 3 |
| Studio Green                            |           1 |                 3 |
| AKS Film Studio                         |           1 |                 3 |
| Kaargo Cinemas                          |           1 |                 3 |
| Animonsta Studios                       |           1 |                 3 |
| O3 Turkey Medya                         |           1 |                 3 |
| StarVision                              |           1 |                 3 |
| Synergy Films                           |           1 |                 3 |
| PVP Cinema                              |           1 |                 3 |
| Plan J Studios                          |           1 |                 3 |
| 20 Steps Productions                    |           1 |                 3 |
| Prime Zero Productions                  |           1 |                 3 |
| Shreya Films International              |           1 |                 3 |
| SLN Cinemas                             |           1 |                 3 |
| Epiphany Entertainments                 |           1 |                 3 |
| 3 Ng Film                               |           1 |                 3 |
| Eastpool Films                          |           1 |                 3 |
| A square productions                    |           1 |                 3 |
| Oak Entertainments                      |           1 |                 3 |
| Doha Film Institute                     |           1 |                 3 |
| Fenrir Films                            |           1 |                 3 |
| F├íbrica de Cine                        |           1 |                 3 |
| Chernin Entertainment                   |           1 |                 3 |
| Cross Creek Pictures                    |           1 |                 3 |
| Loaded Dice Films                       |           1 |                 3 |
| WM Films                                |           1 |                 3 |
| Walt Disney Pictures                    |           1 |                 3 |
| Excel Entertainment                     |           1 |                 3 |
| Ancine                                  |           1 |                 3 |
| Twentieth Century Fox                   |           1 |                 3 |
| Ave Fenix Pictures                      |           1 |                 3 |
| Runaway Productions                     |           1 |                 3 |
| Aletheia Films                          |           1 |                 3 |
| 70 MM Entertainments                    |           1 |                 3 |
| Moho Film                               |           1 |                 3 |
| BR Productions and Riding High Pictures |           1 |                 3 |
| Cana Vista Films                        |           1 |                 3 |
| Gurbani Media                           |           1 |                 3 |
| Sony Pictures Entertainment (SPE)       |           1 |                 3 |
| InnoVate Productions                    |           1 |                 3 |
| Saanvi Pictures                         |           1 |                 3 |
| The SPA Studios                         |           1 |                 3 |
| Rotten Productions                      |           1 |                 3 |
| Film Village                            |           1 |                 3 |
| Arka Mediaworks                         |           1 |                 3 |
| Atresmedia Cine                         |           1 |                 3 |
| Goopy Bagha Productions Limited         |           1 |                 3 |
| Maxmedia                                |           1 |                 3 |
| 1234 Cine Creations                     |           1 |                 3 |
| Silent Hills Studio                     |           1 |                 3 |
| Blueprint Pictures                      |           1 |                 3 |
| Archangel Studios                       |           1 |                 3 |
| HI Film Productions                     |           1 |                 3 |
| Tin Drum Beats                          |           1 |                 3 |
| Fr├¡o Fr├¡o                             |           1 |                 3 |
| Warnuts Entertainment                   |           1 |                 3 |
| Potential Studios                       |           1 |                 3 |
| Adrama                                  |           1 |                 3 |
| Dark Steel Entertainment                |           1 |                 3 |
| Allfilm                                 |           1 |                 3 |
| Nokkhottro Cholochitra                  |           1 |                 3 |
| BOB Film Sweden AB                      |           1 |                 3 |
| Smash Entertainment!                    |           1 |                 3 |
| EFilm                                   |           1 |                 3 |
| Urvashi Theaters                        |           1 |                 3 |
| Angel Capital Film Group                |           1 |                 3 |
| Grass Root Film Company                 |           1 |                 3 |
| Art Movies                              |           1 |                 3 |
| Lost Legends                            |           1 |                 3 |
| Ra.Mo.                                  |           1 |                 3 |
| Avocado Media                           |           1 |                 3 |
| Tigmanshu Dhulia Films                  |           1 |                 3 |
| Think Music                             |           1 |                 3 |
| Anwar Rasheed Entertainment             |           1 |                 3 |
| Dwarakish Chitra                        |           1 |                 3 |
| Anto Joseph Film Company                |           1 |                 3 |
| Dijital Sanatlar Production             |           1 |                 3 |
| Missart produkcija                      |           1 |                 3 |
| Jayanna Combines                        |           1 |                 3 |
| Jar Pictures                            |           1 |                 3 |
| British Muslim TV                       |           1 |                 3 |
| Crossing Bridges Films                  |           1 |                 3 |
| BrightKnight Entertainment              |           1 |                 3 |
| Mirror Images LTD.                      |           1 |                 3 |
| Mango Pickle Entertainment              |           1 |                 3 |
| Detailfilm                              |           1 |                 3 |
| Archway Pictures                        |           1 |                 3 |
| Vehli Janta Films                       |           1 |                 3 |
| Grooters Productions                    |           1 |                 3 |
| Fulwell 73                              |           1 |                 3 |
| Participant                             |           1 |                 3 |
| Madras Enterprises                      |           1 |                 3 |
| Alchemy Vision Workz                    |           1 |                 3 |
| Axess Film Factory                      |           1 |                 3 |
| PRK Productions                         |           1 |                 3 |
| Dashami Studioz                         |           1 |                 3 |
| Fablemaze                               |           1 |                 3 |
| StarFab Production                      |           1 |                 3 |
| RGK Cinema                              |           1 |                 3 |
| Shreyasree Movies                       |           1 |                 3 |
| BRON Studios                            |           1 |                 3 |
| Bhadrakali Pictures                     |           1 |                 3 |
| The Icelandic Filmcompany               |           1 |                 3 |
| The Church of Almighty God Film Center  |           1 |                 3 |
| Maha Sithralu                           |           1 |                 3 |
| Mythri Movie Makers                     |           1 |                 3 |
| Orange M├®dias                          |           1 |                 3 |
| Mumbai Film Company                     |           1 |                 3 |
| Swapna Cinema                           |           1 |                 3 |
| Vivid Films                             |           1 |                 3 |
| HRX Films                               |           1 |                 3 |
| Wonder Head                             |           1 |                 3 |
| Sixteen by Sixty-Four Productions       |           1 |                 3 |
| Akshar Communications                   |           1 |                 3 |
| Moviee Mill                             |           1 |                 3 |
| Happy Hours Entertainments              |           1 |                 3 |
| M-Films                                 |           1 |                 3 |
| Cineddiction Films                      |           1 |                 3 |
| Heyday Films                            |           1 |                 3 |
| Diamond Works                           |           1 |                 3 |
| Shree Raajalakshmi Films                |           1 |                 3 |
| Dream Tree Film Productions             |           1 |                 3 |
| Cine Sarasavi Productions               |           1 |                 3 |
| Acropolis Entertainment                 |           1 |                 3 |
| RedhanThe Cinema People                 |           1 |                 3 |
| Hombale Films                           |           1 |                 3 |
| Swonderful Pictures                     |           1 |                 3 |
| COMETE Films                            |           1 |                 3 |
| Cinepro Lanka International             |           1 |                 3 |
| Williams 4 Productions                  |           1 |                 3 |
| Touch Wood Multimedia Creations         |           1 |                 3 |
| Rocket Beans Entertainment              |           1 |                 3 |
| Hepifilms                               |           1 |                 3 |
| SRaj Productions                        |           1 |                 3 |
| Kharisma Starvision Plus PT             |           1 |                 3 |
| MD productions                          |           1 |                 3 |
| Ataraxia Entertainment                  |           1 |                 3 |
| NBW Films                               |           1 |                 3 |
| Kannamthanam Films                      |           1 |                 3 |
| Brainbox Studios                        |           1 |                 3 |
| Matchbox Pictures                       |           1 |                 3 |
| Reliance Entertainment                  |           1 |                 3 |
| Neelam Productions                      |           1 |                 3 |
| Jyot & Aagnya Anusaare Productions      |           1 |                 3 |
| Clown Town Productions                  |           1 |                 3 |
| Special Treats Production Company       |           1 |                 3 |
| Mooz Films                              |           1 |                 3 |
| Bulb Chamka                             |           1 |                 3 |
| GreenTouch Entertainment                |           1 |                 3 |
| Crystal Paark Cinemas                   |           1 |                 3 |
| Kangaroo Broadcasting                   |           1 |                 3 |
| Swami Samartha Creations                |           1 |                 3 |
| DreamReality Movies                     |           1 |                 3 |
| Fahadh Faasil and Friends               |           1 |                 3 |
| Narrator                                |           1 |                 3 |
| Kineo Filmproduktion                    |           1 |                 3 |
| Appu Pathu Pappu Production House       |           1 |                 3 |
| Rishab Shetty Films                     |           1 |                 3 |
| Namah Pictures                          |           1 |                 3 |
| Annai Tamil Cinemas                     |           1 |                 3 |
| Viacom18 Motion Pictures                |           1 |                 3 |
| MNC Pictures                            |           1 |                 3 |
| Clyde Vision Films                      |           1 |                 3 |
| Adenium Productions                     |           1 |                 3 |
| Trafalgar Releasing                     |           1 |                 3 |
| Lovely World Entertainment              |           1 |                 3 |
| Hayagriva Movie Adishtana               |           1 |                 3 |
| OPM Cinemas                             |           1 |                 3 |
| Sithara Entertainments                  |           1 |                 3 |
| French Quarter Film                     |           1 |                 3 |
| Mumba Devi Motion Pictures              |           1 |                 3 |
| Fox STAR Studios                        |           1 |                 3 |
| Aries Telecasting                       |           1 |                 3 |
| Abis Studio                             |           1 |                 3 |
| Rapi Films                              |           1 |                 3 |
| Ay Yapim                                |           1 |                 3 |
| Aatpaat Production                      |           1 |                 3 |
| Channambika Films                       |           1 |                 3 |
| Cinenic Film                            |           1 |                 3 |
| The United Team of Art                  |           1 |                 3 |
| Grahalakshmi Productions                |           1 |                 3 |
| Mahesh Manjrekar Movies                 |           1 |                 3 |
| Manikya Productions                     |           1 |                 3 |
| Bombay Walla Films                      |           1 |                 3 |
| Viva Inen Productions                   |           1 |                 3 |
| Banana Film DOOEL                       |           1 |                 3 |
| Toei Animation                          |           1 |                 3 |
| Golden Horse Cinema                     |           1 |                 3 |
| V. Creations                            |           1 |                 3 |
| Moonshot Entertainments                 |           1 |                 3 |
| Humble Motion Pictures                  |           1 |                 3 |
| Coconut Motion Pictures                 |           1 |                 3 |
| Bayview Projects                        |           1 |                 3 |
| Piecewing Productions                   |           1 |                 3 |
| Manyam Productions                      |           1 |                 3 |
| Suresh Productions                      |           1 |                 3 |
| Benzy Productions                       |           1 |                 3 |
| RMCC Productions                        |           1 |                 3 |
+-----------------------------------------+-------------+-------------------+
216 rows in set (0.01 sec)







-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

 SELECT g.genre, COUNT(g.movie_id) AS total_movies FROM genre AS g INNER JOIN ratings AS r ON g.movie_id = r.movie_id INNER JOIN movie AS m ON m.id = g.movie_id WHERE m.country='USA' AND r.total_votes>1000 AND MONTH(date_published)=3 AND year=2017 GROUP BY g.genre ORDER BY total_movies DESC;
+----------+--------------+
| genre    | total_movies |
+----------+--------------+
| Drama    |           16 |
| Comedy   |            8 |
| Crime    |            5 |
| Horror   |            5 |
| Action   |            4 |
| Sci-Fi   |            4 |
| Thriller |            4 |
| Romance  |            3 |
| Fantasy  |            2 |
| Mystery  |            2 |
| Family   |            1 |
+----------+--------------+
11 rows in set (0.03 sec)







-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


1054 (42S22): Unknown column 'g.genre' in 'field list'
mysql> SELECT title, avg_rating, genre
    -> FROM genre AS g
    -> INNER JOIN ratings AS r
    -> ON g.movie_id = r.movie_id
    -> INNER JOIN movie AS m
    -> ON m.id = g.movie_id
    -> WHERE title LIKE 'The%' AND avg_rating > 8
    -> ORDER BY avg_rating DESC;
+--------------------------------------+------------+----------+
| title                                | avg_rating | genre    |
+--------------------------------------+------------+----------+
| The Brighton Miracle                 |        9.5 | Drama    |
| The Colour of Darkness               |        9.1 | Drama    |
| The Blue Elephant 2                  |        8.8 | Drama    |
| The Blue Elephant 2                  |        8.8 | Horror   |
| The Blue Elephant 2                  |        8.8 | Mystery  |
| The Irishman                         |        8.7 | Crime    |
| The Irishman                         |        8.7 | Drama    |
| The Mystery of Godliness: The Sequel |        8.5 | Drama    |
| The Gambinos                         |        8.4 | Crime    |
| The Gambinos                         |        8.4 | Drama    |
| Theeran Adhigaaram Ondru             |        8.3 | Action   |
| Theeran Adhigaaram Ondru             |        8.3 | Crime    |
| Theeran Adhigaaram Ondru             |        8.3 | Thriller |
| The King and I                       |        8.2 | Drama    |
| The King and I                       |        8.2 | Romance  |
+--------------------------------------+------------+----------+
15 rows in set (0.02 sec)






-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:



SELECT median_rating, COUNT(movie_id) AS total_movies
FROM movie AS m
INNER JOIN ratings AS r
ON m.id = r.movie_id
WHERE median_rating = 8 AND date_published BETWEEN '2018-04-01' AND '2019-04-01'
GROUP BY median_rating;
+---------------+--------------+
| median_rating | total_movies |
+---------------+--------------+
|             8 |          361 |
+---------------+--------------+
1 row in set (0.02 sec)





-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

> SELECT total_votes, languages
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id = r.movie_id
    -> WHERE languages LIKE 'German' OR languages LIKE 'Italian'
    -> GROUP BY languages
    -> ORDER BY total_votes DESC;
+-------------+-----------+
| total_votes | languages |
+-------------+-----------+
|        4695 | German    |
|        1684 | Italian   |
+-------------+-----------+
2 rows in set (0.01 sec)






-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

 SELECT
    -> SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS names,
    ->  SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_null_value,
    ->  SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_null_value,
    ->  SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_null_value
    -> FROM names;
+-------+-------------------+--------------------------+-----------------------------+
| names | height_null_value | date_of_birth_null_value | known_for_movies_null_value |
+-------+-------------------+--------------------------+-----------------------------+
|     0 |             17335 |                    13431 |                       15226 |
+-------+-------------------+--------------------------+-----------------------------+
1 row in set (0.03 sec)






/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
WITH top_genre AS
    -> (
    ->  SELECT g.genre, COUNT(g.movie_id) AS total_movies
    ->  FROM genre AS g
    ->  INNER JOIN ratings AS r
    ->  ON g.movie_id = r.movie_id
    ->  WHERE avg_rating > 8
    ->     GROUP BY genre
    ->     ORDER BY total_movies
    ->     LIMIT 3
    -> ),
    ->
    -> director AS
    -> (
    -> SELECT n.name AS dir_name,
    ->          COUNT(g.movie_id) AS movie_count,
    ->         ROW_NUMBER() OVER(ORDER BY COUNT(g.movie_id) DESC) AS dir_rank
    -> FROM names AS n
    -> INNER JOIN director_mapping AS dm
    -> ON n.id = dm.name_id
    -> INNER JOIN genre AS g
    -> ON dm.movie_id = g.movie_id
    -> INNER JOIN ratings AS r
    -> ON r.movie_id = g.movie_id,
    -> top_genre
    -> WHERE g.genre in (top_genre.genre) AND avg_rating>8
    -> GROUP BY dir_name
    -> ORDER BY total_movies DESC
    -> )
    ->
    -> SELECT *
    -> FROM director
    -> WHERE dir_rank <= 3
    -> LIMIT 3;
+---------------+-------------+----------+
| dir_name      | movie_count | dir_rank |
+---------------+-------------+----------+
| Josh Oreck    |           1 |        1 |
| Joe Russo     |           1 |        2 |
| Anthony Russo |           1 |        3 |
+---------------+-------------+----------+
3 rows in set (0.01 sec)








/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

 SELECT DISTINCT name AS actor, COUNT(r.movie_id) AS total_movies
    -> FROM ratings AS r
    -> INNER JOIN role_mapping AS rm
    -> ON rm.movie_id = r.movie_id
    -> INNER JOIN names AS n
    -> ON rm.name_id = n.id
    -> WHERE median_rating >= 8 AND category = 'actor'
    -> GROUP BY name
    -> ORDER BY total_movies DESC
    -> LIMIT 2;
+-----------+--------------+
| actor     | total_movies |
+-----------+--------------+
| Mammootty |            8 |
| Mohanlal  |            5 |
+-----------+--------------+
2 rows in set (0.03 sec)







/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:



 SELECT production_company, SUM(total_votes) AS votes,
    ->          DENSE_RANK() OVER(ORDER BY SUM(total_votes) DESC) AS com_rank
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id = r.movie_id
    -> GROUP BY production_company
    -> LIMIT 3;
+-----------------------+---------+----------+
| production_company    | votes   | com_rank |
+-----------------------+---------+----------+
| Marvel Studios        | 2656967 |        1 |
| Twentieth Century Fox | 2411163 |        2 |
| Warner Bros.          | 2396057 |        3 |
+-----------------------+---------+----------+
3 rows in set (0.04 sec)








/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT name AS actor_name, total_votes,
    ->                 COUNT(m.id) as movie_count,
    ->                 ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actor_avg_rating,
    ->                 RANK() OVER(ORDER BY avg_rating DESC) AS actor_rank
    ->
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id = r.movie_id
    -> INNER JOIN role_mapping AS rm
    -> ON m.id=rm.movie_id
    -> INNER JOIN names AS nm
    -> ON rm.name_id=nm.id
    -> WHERE category='actor' AND country= 'india'
    -> GROUP BY name
    -> HAVING COUNT(m.id)>=5
    -> LIMIT 1;
+------------------+-------------+-------------+------------------+------------+
| actor_name       | total_votes | movie_count | actor_avg_rating | actor_rank |
+------------------+-------------+-------------+------------------+------------+
| Vijay Sethupathi |       20364 |           5 |             8.42 |          1 |
+------------------+-------------+-------------+------------------+------------+
1 row in set (0.02 sec)








-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

  SELECT name AS actress_name, total_votes,
    ->                 COUNT(m.id) AS movie_count,
    ->                 ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actress_avg_rating,
    ->                 RANK() OVER(ORDER BY avg_rating DESC) AS actress_rank
    ->
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id = r.movie_id
    -> INNER JOIN role_mapping AS rm
    -> ON m.id=rm.movie_id
    -> INNER JOIN names AS nm
    -> ON rm.name_id=nm.id
    -> WHERE category='actress' AND country='india' AND languages='hindi'
    -> GROUP BY name
    -> HAVING COUNT(m.id)>=3
    -> LIMIT 1;
+---------------+-------------+-------------+--------------------+--------------+
| actress_name  | total_votes | movie_count | actress_avg_rating | actress_rank |
+---------------+-------------+-------------+--------------------+--------------+
| Taapsee Pannu |        2269 |           3 |               7.74 |            1 |
+---------------+-------------+-------------+--------------------+--------------+
1 row in set (0.01 sec)






/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:
SELECT title,
    ->          CASE WHEN avg_rating > 8 THEN 'Superhit movies'
    ->                   WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
    ->              WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movies'
    ->                   WHEN avg_rating < 5 THEN 'Flop movies'
    ->          END AS avg_rating_category
    -> FROM movie AS m
    -> INNER JOIN genre AS g
    -> ON m.id=g.movie_id
    -> INNER JOIN ratings as r
    -> ON m.id=r.movie_id
    -> WHERE genre='thriller';
+---------------------------------------------------------------+-----------------------+
| title                                                         | avg_rating_category   |
+---------------------------------------------------------------+-----------------------+
| Der m├╝de Tod                                                 | Hit movies            |
| Fahrenheit 451                                                | Flop movies           |
| Pet Sematary                                                  | One-time-watch movies |
| Dukun                                                         | One-time-watch movies |
| Back Roads                                                    | Hit movies            |
| Countdown                                                     | One-time-watch movies |
| Staged Killer                                                 | Flop movies           |
| Vellaipookal                                                  | Hit movies            |
| Uriyadi 2                                                     | Hit movies            |
| Incitement                                                    | Hit movies            |
| Rakshasudu                                                    | Superhit movies       |
| Trois jours et une vie                                        | One-time-watch movies |
| Killer in Law                                                 | One-time-watch movies |
| Kalki                                                         | Hit movies            |
| Milliard                                                      | Flop movies           |
| Vinci Da                                                      | Hit movies            |
| Gunned Down                                                   | One-time-watch movies |
| Deviant Love                                                  | Flop movies           |
| Storozh                                                       | One-time-watch movies |
| Sivappu Manjal Pachai                                         | Hit movies            |
| Magamuni                                                      | Superhit movies       |
| Hometown Killer                                               | One-time-watch movies |
| ECCO                                                          | One-time-watch movies |
| Baaji                                                         | Hit movies            |
| Kasablanka                                                    | One-time-watch movies |
| Annabellum: The Curse of Salem                                | Flop movies           |
| Zuo jia de huang yan: Bi zhong you zui                        | One-time-watch movies |
| Evaru                                                         | Superhit movies       |
| Saja                                                          | One-time-watch movies |
| Jiivi                                                         | Hit movies            |
| Ai-naki Mori de Sakebe                                        | One-time-watch movies |
| Ne Zha zhi mo tong jiang shi                                  | Hit movies            |
| Bornoporichoy: A Grammar Of Death                             | One-time-watch movies |
| Ratu Ilmu Hitam                                               | Hit movies            |
| Barot House                                                   | Hit movies            |
| La llorona                                                    | Hit movies            |
| Tekst                                                         | One-time-watch movies |
| Byeonshin                                                     | One-time-watch movies |
| Fanxiao                                                       | Hit movies            |
| The Belko Experiment                                          | One-time-watch movies |
| Safe                                                          | Superhit movies       |
| Chanakya                                                      | One-time-watch movies |
| Raju Gari Gadhi 3                                             | Superhit movies       |
| Shapludu                                                      | Hit movies            |
| 2:22                                                          | One-time-watch movies |
| Rambo: Last Blood                                             | One-time-watch movies |
| Retina                                                        | One-time-watch movies |
| Caller ID                                                     | Flop movies           |
| I See You                                                     | Flop movies           |
| Venom                                                         | One-time-watch movies |
| London Fields                                                 | Flop movies           |
| xXx: Return of Xander Cage                                    | One-time-watch movies |
| Infection: The Invasion Begins                                | Flop movies           |
| Truth                                                         | Hit movies            |
| Kidnap                                                        | One-time-watch movies |
| Mute                                                          | One-time-watch movies |
| Halloween                                                     | One-time-watch movies |
| Voice from the Stone                                          | One-time-watch movies |
| Simple Creature                                               | Flop movies           |
| The Commuter                                                  | One-time-watch movies |
| The Foreigner                                                 | Hit movies            |
| Scary Story Slumber Party                                     | Flop movies           |
| Jasmine                                                       | One-time-watch movies |
| The Entitled                                                  | One-time-watch movies |
| Message from the King                                         | One-time-watch movies |
| 59 Seconds                                                    | Hit movies            |
| Trafficked                                                    | One-time-watch movies |
| Identical                                                     | Flop movies           |
| Art of Deception                                              | Flop movies           |
| Mara                                                          | One-time-watch movies |
| Teenage Cocktail                                              | One-time-watch movies |
| Catskill Park                                                 | Flop movies           |
| Seberg                                                        | One-time-watch movies |
| An Ordinary Man                                               | One-time-watch movies |
| Operation Ragnar├Âk                                           | Flop movies           |
| Demonic                                                       | One-time-watch movies |
| Hunter Killer                                                 | One-time-watch movies |
| Insomnium                                                     | One-time-watch movies |
| 7 Splinters in Time                                           | Flop movies           |
| Brimstone                                                     | Hit movies            |
| True Crimes                                                   | One-time-watch movies |
| Overdrive                                                     | One-time-watch movies |
| Amityville: The Awakening                                     | Flop movies           |
| American Assassin                                             | One-time-watch movies |
| City of Tiny Lights                                           | One-time-watch movies |
| Beyond White Space                                            | Flop movies           |
| Geostorm                                                      | One-time-watch movies |
| Whispers                                                      | Flop movies           |
| Would You Rather                                              | One-time-watch movies |
| Nobel Chor                                                    | One-time-watch movies |
| The Outsider                                                  | One-time-watch movies |
| Redcon-1                                                      | Flop movies           |
| Never Here                                                    | Flop movies           |
| The Unseen                                                    | Flop movies           |
| Sanctuary; Quite a Conundrum                                  | One-time-watch movies |
| Delirium                                                      | One-time-watch movies |
| Sleepless                                                     | One-time-watch movies |
| This Is Your Death                                            | One-time-watch movies |
| Black Butterfly                                               | One-time-watch movies |
| The Garlock Incident                                          | Flop movies           |
| Arizona                                                       | One-time-watch movies |
| Found                                                         | One-time-watch movies |
| Nightmare Box                                                 | Flop movies           |
| I Still See You                                               | One-time-watch movies |
| A Life Not to Follow                                          | Hit movies            |
| A Patch of Fog                                                | One-time-watch movies |
| The Elevator: Three Minutes Can Change Your Life              | Flop movies           |
| Bent                                                          | One-time-watch movies |
| The Forgiven                                                  | One-time-watch movies |
| Dark Cove                                                     | One-time-watch movies |
| 100 Ghost Street: The Return of Richard Speck                 | Flop movies           |
| Gali Guleiyan                                                 | Hit movies            |
| Inspiration                                                   | Hit movies            |
| Lost Angelas                                                  | Superhit movies       |
| Alien: Covenant                                               | One-time-watch movies |
| Bottom of the World                                           | One-time-watch movies |
| Gas Light                                                     | Flop movies           |
| Five Fingers for Marseilles                                   | One-time-watch movies |
| Atomic Blonde                                                 | One-time-watch movies |
| The Forbidden Dimensions                                      | Flop movies           |
| The Guest House                                               | Flop movies           |
| The Ghost and The Whale                                       | Flop movies           |
| Primrose Lane                                                 | Flop movies           |
| Deep Burial                                                   | Flop movies           |
| The Church                                                    | Flop movies           |
| The Answer                                                    | Flop movies           |
| Division 19                                                   | One-time-watch movies |
| Point Blank                                                   | One-time-watch movies |
| Needlestick                                                   | Flop movies           |
| Keep Watching                                                 | Flop movies           |
| Blowtorch                                                     | Flop movies           |
| Skybound                                                      | One-time-watch movies |
| Krampus: The Christmas Devil                                  | Flop movies           |
| Sweet Virginia                                                | One-time-watch movies |
| Caretakers                                                    | Hit movies            |
| The Big Take                                                  | Hit movies            |
| Leatherface                                                   | One-time-watch movies |
| The Ascent                                                    | One-time-watch movies |
| Greta                                                         | One-time-watch movies |
| Vishwaroopam 2                                                | One-time-watch movies |
| Displacement                                                  | Flop movies           |
| The Harrowing                                                 | Flop movies           |
| Angelica                                                      | Flop movies           |
| Dassehra                                                      | Flop movies           |
| Circus of the Dead                                            | One-time-watch movies |
| Message Man                                                   | One-time-watch movies |
| Ascent to Hell                                                | Flop movies           |
| Mississippi Murder                                            | Flop movies           |
| Strange But True                                              | One-time-watch movies |
| Red Sparrow                                                   | One-time-watch movies |
| Higher Power                                                  | One-time-watch movies |
| The Snare                                                     | Flop movies           |
| Money                                                         | One-time-watch movies |
| The Circle                                                    | One-time-watch movies |
| Corbin Nash                                                   | One-time-watch movies |
| Wild for the Night                                            | Flop movies           |
| Alcoholist                                                    | One-time-watch movies |
| Voyoucratie                                                   | One-time-watch movies |
| Cruel Summer                                                  | One-time-watch movies |
| The Man Who Was Thursday                                      | One-time-watch movies |
| Two Down                                                      | Hit movies            |
| Where the Devil Dwells                                        | Flop movies           |
| Stockholm                                                     | Flop movies           |
| Beacon Point                                                  | One-time-watch movies |
| Delirium                                                      | Flop movies           |
| The Perfect Host: A Southern Gothic Tale                      | Flop movies           |
| Convergence                                                   | Flop movies           |
| Capps Crossing                                                | Flop movies           |
| Billy Boy                                                     | Flop movies           |
| The Birdcatcher                                               | Flop movies           |
| 5th Passenger                                                 | Flop movies           |
| A Violent Separation                                          | One-time-watch movies |
| Be My Cat: A Film for Anne                                    | One-time-watch movies |
| Ver├│nica                                                     | One-time-watch movies |
| Call of the Wolf                                              | One-time-watch movies |
| Neckan                                                        | One-time-watch movies |
| Bad Samaritan                                                 | One-time-watch movies |
| The Dinner                                                    | Flop movies           |
| Among Us                                                      | Flop movies           |
| Valley of the Sasquatch                                       | Flop movies           |
| Anabolic Life                                                 | One-time-watch movies |
| As Worlds Collide                                             | Hit movies            |
| Domino                                                        | Flop movies           |
| Benzin                                                        | One-time-watch movies |
| Asylum of Fear                                                | Flop movies           |
| The Autopsy of Jane Doe                                       | One-time-watch movies |
| Mientras el Lobo No Est├í                                     | Hit movies            |
| HHhH                                                          | One-time-watch movies |
| Jekyll Island                                                 | Flop movies           |
| Den 12. mann                                                  | Hit movies            |
| The Hollow One                                                | Flop movies           |
| Be Afraid                                                     | Flop movies           |
| Accident                                                      | Flop movies           |
| White Orchid                                                  | One-time-watch movies |
| Above Ground                                                  | Flop movies           |
| Burning Kiss                                                  | Flop movies           |
| Slender                                                       | Flop movies           |
| Diverge                                                       | Flop movies           |
| No Way to Live                                                | One-time-watch movies |
| Jigsaw                                                        | One-time-watch movies |
| Bad Kids of Crestview Academy                                 | One-time-watch movies |
| Bad Frank                                                     | One-time-watch movies |
| Scary Stories to Tell in the Dark                             | One-time-watch movies |
| Xian yi ren X de xian shen                                    | One-time-watch movies |
| Puriyaadha Pudhir                                             | One-time-watch movies |
| Adios Vaya Con Dios                                           | Superhit movies       |
| Painless                                                      | One-time-watch movies |
| Rabbit                                                        | One-time-watch movies |
| A Place in Hell                                               | Flop movies           |
| One Less God                                                  | One-time-watch movies |
| Land of Smiles                                                | Flop movies           |
| Havenhurst                                                    | Flop movies           |
| Grinder                                                       | Flop movies           |
| Land of the Little People                                     | One-time-watch movies |
| Investigation 13                                              | Flop movies           |
| Deadly Sanctuary                                              | Flop movies           |
| Abduct                                                        | Flop movies           |
| The Drownsman                                                 | Flop movies           |
| Damascus Cover                                                | One-time-watch movies |
| Unforgettable                                                 | One-time-watch movies |
| Inconceivable                                                 | One-time-watch movies |
| Relentless                                                    | Flop movies           |
| Your Move                                                     | Flop movies           |
| Security                                                      | One-time-watch movies |
| Furthest Witness                                              | Flop movies           |
| Welcome to Curiosity                                          | One-time-watch movies |
| The Ballerina                                                 | Flop movies           |
| The Lighthouse                                                | One-time-watch movies |
| The Tank                                                      | Flop movies           |
| Haunted                                                       | Flop movies           |
| Retribution                                                   | One-time-watch movies |
| Submergence                                                   | One-time-watch movies |
| Arise from Darkness                                           | Hit movies            |
| Stratton                                                      | Flop movies           |
| She Who Must Burn                                             | Flop movies           |
| The Dark Below                                                | Flop movies           |
| Us and Them                                                   | One-time-watch movies |
| Bad Girl                                                      | One-time-watch movies |
| Bank Chor                                                     | One-time-watch movies |
| The Ghoul                                                     | One-time-watch movies |
| Tell Me Your Name                                             | Flop movies           |
| Candiland                                                     | Flop movies           |
| MindGamers                                                    | Flop movies           |
| The Inherited                                                 | Flop movies           |
| Glass Jaw                                                     | Hit movies            |
| Body of Deceit                                                | Flop movies           |
| Creep 2                                                       | One-time-watch movies |
| Madtown                                                       | One-time-watch movies |
| Beyond the Sky                                                | One-time-watch movies |
| Eloise                                                        | Flop movies           |
| The Harvesting                                                | Flop movies           |
| Vincent N Roxxy                                               | One-time-watch movies |
| Face of Evil                                                  | Flop movies           |
| Quarries                                                      | Flop movies           |
| The Last Witness                                              | One-time-watch movies |
| Elle                                                          | Hit movies            |
| The Wicked One                                                | Flop movies           |
| Cuando los ├íngeles duermen                                   | One-time-watch movies |
| I Before Thee                                                 | Flop movies           |
| Besetment                                                     | Flop movies           |
| Recall                                                        | Flop movies           |
| Jungle                                                        | One-time-watch movies |
| Blood Money                                                   | Flop movies           |
| Ladyworld                                                     | Flop movies           |
| The Evil Inside Her                                           | Flop movies           |
| The Equalizer 2                                               | One-time-watch movies |
| Body Keepers                                                  | Flop movies           |
| Dead Awake                                                    | Flop movies           |
| The Grinn                                                     | Flop movies           |
| House of Afflictions                                          | Flop movies           |
| Clowntergeist                                                 | Flop movies           |
| Against the Clock                                             | Flop movies           |
| Hank Boyd Is Dead                                             | Flop movies           |
| Slasher.com                                                   | Flop movies           |
| Blood Stripe                                                  | One-time-watch movies |
| Infinity Chamber                                              | One-time-watch movies |
| Viktorville                                                   | One-time-watch movies |
| Dangerous Company                                             | Flop movies           |
| Strangers Within                                              | Flop movies           |
| Dark Beacon                                                   | One-time-watch movies |
| Seeds                                                         | Flop movies           |
| Hounds of Love                                                | One-time-watch movies |
| Savageland                                                    | One-time-watch movies |
| We Go On                                                      | One-time-watch movies |
| The Neighbor                                                  | One-time-watch movies |
| Deadly Crush                                                  | One-time-watch movies |
| Hell of a Night                                               | Flop movies           |
| The Nth Ward                                                  | Flop movies           |
| ├ünimas                                                       | Flop movies           |
| Hebbuli                                                       | Hit movies            |
| House by the Lake                                             | Flop movies           |
| Legionario                                                    | One-time-watch movies |
| Level 16                                                      | One-time-watch movies |
| Lost Solace                                                   | Flop movies           |
| The Tale                                                      | Hit movies            |
| Braxton                                                       | Flop movies           |
| Ah-ga-ssi                                                     | Superhit movies       |
| The Honor Farm                                                | Flop movies           |
| The Man in the Wall                                           | One-time-watch movies |
| Lycan                                                         | One-time-watch movies |
| Cut to the Chase                                              | Flop movies           |
| Ultimate Justice                                              | Flop movies           |
| Blood Bound                                                   | Flop movies           |
| I Spit on Your Grave: Deja Vu                                 | Flop movies           |
| The Nightingale                                               | Hit movies            |
| Monochrome                                                    | One-time-watch movies |
| In Extremis                                                   | Flop movies           |
| Dark Sense                                                    | Flop movies           |
| O Rastro                                                      | One-time-watch movies |
| Alterscape                                                    | One-time-watch movies |
| Darling                                                       | One-time-watch movies |
| Demon House                                                   | One-time-watch movies |
| But Deliver Us from Evil                                      | Flop movies           |
| The Tracker                                                   | Flop movies           |
| Replicas                                                      | One-time-watch movies |
| Boar                                                          | One-time-watch movies |
| Live Cargo                                                    | Flop movies           |
| Restraint                                                     | Flop movies           |
| The Redeeming                                                 | Flop movies           |
| A Room to Die For                                             | Flop movies           |
| Valley of Bones                                               | Flop movies           |
| The Crucifixion                                               | One-time-watch movies |
| Sleepwalker                                                   | One-time-watch movies |
| Norman: The Moderate Rise and Tragic Fall of a New York Fixer | One-time-watch movies |
| Del Playa                                                     | Flop movies           |
| Chimera Strain                                                | One-time-watch movies |
| We Are Monsters                                               | Flop movies           |
| Widows                                                        | One-time-watch movies |
| The Wall                                                      | One-time-watch movies |
| Inhumane                                                      | Flop movies           |
| Virus of the Dead                                             | Flop movies           |
| Wrecker                                                       | Flop movies           |
| Tangent Room                                                  | Flop movies           |
| Bloodlands                                                    | One-time-watch movies |
| La nuit a d├®vor├® le monde                                   | One-time-watch movies |
| Sum1                                                          | Flop movies           |
| Terrifier                                                     | One-time-watch movies |
| Broken Star                                                   | Flop movies           |
| The Circle                                                    | One-time-watch movies |
| Mirror Game                                                   | One-time-watch movies |
| The Evangelist                                                | One-time-watch movies |
| Sugar Daddies                                                 | One-time-watch movies |
| Fractured                                                     | One-time-watch movies |
| Bonded by Blood 2                                             | One-time-watch movies |
| My Birthday Song                                              | One-time-watch movies |
| 3 Lives                                                       | Flop movies           |
| Tau                                                           | One-time-watch movies |
| Blackmark                                                     | Flop movies           |
| The Man in the Shadows                                        | Flop movies           |
| Ghost House                                                   | Flop movies           |
| Hide in the Light                                             | Flop movies           |
| Blood Vow                                                     | One-time-watch movies |
| Detour                                                        | One-time-watch movies |
| Los Angeles Overnight                                         | One-time-watch movies |
| Enclosure                                                     | Flop movies           |
| Rock, Paper, Scissors                                         | Flop movies           |
| Lies We Tell                                                  | Flop movies           |
| 7 Witches                                                     | Flop movies           |
| John Wick: Chapter 2                                          | Hit movies            |
| Innuendo                                                      | One-time-watch movies |
| Aux                                                           | Flop movies           |
| Desolation                                                    | One-time-watch movies |
| The Playground                                                | Flop movies           |
| The Marker                                                    | One-time-watch movies |
| Terminal                                                      | One-time-watch movies |
| Bodysnatch                                                    | Flop movies           |
| Fifty Shades Freed                                            | Flop movies           |
| My Pure Land                                                  | One-time-watch movies |
| Cyber Case                                                    | One-time-watch movies |
| Gehenna: Where Death Lives                                    | One-time-watch movies |
| Maze Runner: The Death Cure                                   | One-time-watch movies |
| The Prodigy                                                   | One-time-watch movies |
| The Wasting                                                   | Flop movies           |
| Check Point                                                   | Flop movies           |
| Defective                                                     | Flop movies           |
| Robin Hood                                                    | One-time-watch movies |
| Zhui bu                                                       | One-time-watch movies |
| Miss Sloane                                                   | Hit movies            |
| Project Eden: Vol. I                                          | Flop movies           |
| I Kill Giants                                                 | One-time-watch movies |
| Altitude                                                      | Flop movies           |
| Armed Response                                                | Flop movies           |
| Mile 22                                                       | One-time-watch movies |
| The Haunted                                                   | Flop movies           |
| The Book of Henry                                             | One-time-watch movies |
| Beneath the Leaves                                            | Flop movies           |
| 2036 Origin Unknown                                           | Flop movies           |
| Rupture                                                       | Flop movies           |
| The Witch Files                                               | Flop movies           |
| Aftermath                                                     | One-time-watch movies |
| The Body Tree                                                 | Flop movies           |
| Darc                                                          | One-time-watch movies |
| Haze                                                          | One-time-watch movies |
| Paralytic                                                     | Flop movies           |
| The Fate of the Furious                                       | One-time-watch movies |
| Bloody Crayons                                                | One-time-watch movies |
| Shot Caller                                                   | Hit movies            |
| Braid                                                         | One-time-watch movies |
| Night Pulse                                                   | Flop movies           |
| Razbudi menya                                                 | One-time-watch movies |
| Drifter                                                       | Flop movies           |
| The Broken Key                                                | Flop movies           |
| Beirut                                                        | One-time-watch movies |
| The Sound                                                     | Flop movies           |
| Wolves at the Door                                            | Flop movies           |
| American Fable                                                | One-time-watch movies |
| Woodshock                                                     | Flop movies           |
| Dark Iris                                                     | Flop movies           |
| Lavender                                                      | One-time-watch movies |
| Josie                                                         | One-time-watch movies |
| 1 Buck                                                        | One-time-watch movies |
| Discarnate                                                    | Flop movies           |
| In the Tall Grass                                             | One-time-watch movies |
| Parasites                                                     | Flop movies           |
| Shuddhi                                                       | Superhit movies       |
| Gurgaon                                                       | One-time-watch movies |
| El Complot Mongol                                             | One-time-watch movies |
| Mountain Fever                                                | Flop movies           |
| Monolith                                                      | Flop movies           |
| Cold November                                                 | Flop movies           |
| Money                                                         | One-time-watch movies |
| Curvature                                                     | One-time-watch movies |
| Killing Ground                                                | One-time-watch movies |
| Fantasma                                                      | Flop movies           |
| The Limehouse Golem                                           | One-time-watch movies |
| CTRL                                                          | Flop movies           |
| Unfriended: Dark Web                                          | One-time-watch movies |
| 200 Degrees                                                   | Flop movies           |
| The Summoning                                                 | Flop movies           |
| Negative                                                      | Flop movies           |
| Fighting the Sky                                              | Flop movies           |
| Central Park                                                  | Flop movies           |
| Unhinged                                                      | Flop movies           |
| Larceny                                                       | Flop movies           |
| Countrycide                                                   | Flop movies           |
| Rough Night                                                   | One-time-watch movies |
| Ruin Me                                                       | One-time-watch movies |
| Lens                                                          | Hit movies            |
| Bang jia zhe                                                  | One-time-watch movies |
| Armed                                                         | Flop movies           |
| The Parts You Lose                                            | One-time-watch movies |
| Hush Money                                                    | One-time-watch movies |
| Together For Ever                                             | One-time-watch movies |
| Black Wake                                                    | Flop movies           |
| Good Time                                                     | Hit movies            |
| Buckout Road                                                  | Flop movies           |
| Contratiempo                                                  | Superhit movies       |
| Rapid Eye Movement                                            | Flop movies           |
| The Holly Kane Experiment                                     | One-time-watch movies |
| Hollow in the Land                                            | One-time-watch movies |
| Mind and Machine                                              | Flop movies           |
| Most Beautiful Island                                         | One-time-watch movies |
| Out of the Shadows                                            | Flop movies           |
| Ridge Runners                                                 | Flop movies           |
| Die, My Dear                                                  | One-time-watch movies |
| The Spearhead Effect                                          | Flop movies           |
| Strip Club Massacre                                           | One-time-watch movies |
| Death Pool                                                    | Flop movies           |
| Digbhayam                                                     | Superhit movies       |
| Baadshaho                                                     | Flop movies           |
| Lyst                                                          | Flop movies           |
| Mission: Impossible - Fallout                                 | Hit movies            |
| The Curse of La Llorona                                       | One-time-watch movies |
| 9/11                                                          | Flop movies           |
| Parallel                                                      | One-time-watch movies |
| El guardi├ín invisible                                        | One-time-watch movies |
| Tomato Red                                                    | One-time-watch movies |
| Las tinieblas                                                 | One-time-watch movies |
| The Worthy                                                    | One-time-watch movies |
| Demonios tus ojos                                             | One-time-watch movies |
| Fixeur                                                        | One-time-watch movies |
| From a House on Willow Street                                 | One-time-watch movies |
| Awaken the Shadowman                                          | Flop movies           |
| Rondo                                                         | Flop movies           |
| Axis                                                          | Flop movies           |
| Split                                                         | Hit movies            |
| Zombies Have Fallen                                           | One-time-watch movies |
| A martf├╝i r├®m                                               | Hit movies            |
| Daas Dev                                                      | One-time-watch movies |
| Unwritten                                                     | Flop movies           |
| They Remain                                                   | Flop movies           |
| Life in the Hole                                              | One-time-watch movies |
| Operation Brothers                                            | One-time-watch movies |
| Presumed                                                      | One-time-watch movies |
| Cage                                                          | Flop movies           |
| Breakdown Forest - Reise in den Abgrund                       | Hit movies            |
| Residue                                                       | One-time-watch movies |
| Prodigy                                                       | One-time-watch movies |
| Goodland                                                      | One-time-watch movies |
| Kings Bay                                                     | One-time-watch movies |
| American Gothic                                               | Flop movies           |
| Soul to Keep                                                  | Flop movies           |
| Fare                                                          | Flop movies           |
| Trench 11                                                     | One-time-watch movies |
| Incontrol                                                     | Flop movies           |
| The Assignment                                                | Flop movies           |
| Dismissed                                                     | One-time-watch movies |
| Last Seen in Idaho                                            | One-time-watch movies |
| Muse                                                          | One-time-watch movies |
| Desolation                                                    | Flop movies           |
| Nereus                                                        | Flop movies           |
| Get Out                                                       | Hit movies            |
| The Village in the Woods                                      | One-time-watch movies |
| Body of Sin                                                   | Flop movies           |
| Easy Living                                                   | Flop movies           |
| Altered Hours                                                 | Flop movies           |
| Transfert                                                     | Hit movies            |
| The Butler                                                    | Hit movies            |
| The Isle                                                      | One-time-watch movies |
| Kundschafter des Friedens                                     | One-time-watch movies |
| El ata├║d de cristal                                          | One-time-watch movies |
| Luna                                                          | One-time-watch movies |
| Jasper Jones                                                  | One-time-watch movies |
| O lyubvi                                                      | One-time-watch movies |
| M.F.A.                                                        | One-time-watch movies |
| Beneath Us                                                    | One-time-watch movies |
| Ghost Note                                                    | One-time-watch movies |
| Noctem                                                        | Flop movies           |
| Khaneye dokhtar                                               | One-time-watch movies |
| Warning Shot                                                  | One-time-watch movies |
| Coyote Lake                                                   | Flop movies           |
| Perfect s├ún├útos                                             | Flop movies           |
| Red Christmas                                                 | Flop movies           |
| El bar                                                        | One-time-watch movies |
| O Animal Cordial                                              | One-time-watch movies |
| Ira                                                           | One-time-watch movies |
| Lover                                                         | One-time-watch movies |
| Annabelle: Creation                                           | One-time-watch movies |
| 12 Feet Deep                                                  | One-time-watch movies |
| Liebmann                                                      | One-time-watch movies |
| Illicit                                                       | Flop movies           |
| Shortwave                                                     | Flop movies           |
| Nightworld                                                    | Flop movies           |
| Nibunan                                                       | One-time-watch movies |
| Escape Room                                                   | Flop movies           |
| Mean Dreams                                                   | One-time-watch movies |
| In Darkness                                                   | One-time-watch movies |
| Another Soul                                                  | Flop movies           |
| The Chamber                                                   | Flop movies           |
| Inside                                                        | One-time-watch movies |
| Billionaire Boys Club                                         | One-time-watch movies |
| Forushande                                                    | Hit movies            |
| Beach House                                                   | One-time-watch movies |
| The Mason Brothers                                            | One-time-watch movies |
| Ravenswood                                                    | One-time-watch movies |
| Volt                                                          | One-time-watch movies |
| Juzni vetar                                                   | Superhit movies       |
| Pray for Rain                                                 | One-time-watch movies |
| Rosy                                                          | Flop movies           |
| 3 ting                                                        | One-time-watch movies |
| The Rake                                                      | Flop movies           |
| Intensive Care                                                | Flop movies           |
| Despair                                                       | Hit movies            |
| Assimilate                                                    | One-time-watch movies |
| Final Score                                                   | One-time-watch movies |
| B&B                                                           | One-time-watch movies |
| Enigma                                                        | Superhit movies       |
| Chappaquiddick                                                | One-time-watch movies |
| The Terrible Two                                              | Flop movies           |
| Berlin Falling                                                | One-time-watch movies |
| Immigration Game                                              | Flop movies           |
| Videomannen                                                   | One-time-watch movies |
| Le serpent aux mille coupures                                 | One-time-watch movies |
| The Standoff at Sparrow Creek                                 | One-time-watch movies |
| Happy Death Day                                               | One-time-watch movies |
| Is This Now                                                   | Hit movies            |
| Close                                                         | One-time-watch movies |
| Singam 3                                                      | One-time-watch movies |
| Hate Story IV                                                 | Flop movies           |
| Pirmdzimtais                                                  | One-time-watch movies |
| Kaygi                                                         | One-time-watch movies |
| Ryde                                                          | One-time-watch movies |
| The Wolf Hour                                                 | Flop movies           |
| The Child Remains                                             | Flop movies           |
| A Young Man with High Potential                               | One-time-watch movies |
| The Hatton Garden Job                                         | One-time-watch movies |
| Drone                                                         | One-time-watch movies |
| The Midnight Man                                              | Flop movies           |
| Magellan                                                      | One-time-watch movies |
| Callback                                                      | One-time-watch movies |
| The Job                                                       | One-time-watch movies |
| The Martyr Maker                                              | Flop movies           |
| Gatta Cenerentola                                             | One-time-watch movies |
| Tilt                                                          | One-time-watch movies |
| Life                                                          | One-time-watch movies |
| 24 Hours to Live                                              | One-time-watch movies |
| American Satan                                                | One-time-watch movies |
| The Men                                                       | One-time-watch movies |
| Trendy                                                        | One-time-watch movies |
| Zona hostil                                                   | One-time-watch movies |
| Blood Child                                                   | Hit movies            |
| Break-Up Nightmare                                            | Flop movies           |
| Kaabil                                                        | Hit movies            |
| Corporate                                                     | One-time-watch movies |
| Hotel Mumbai                                                  | Hit movies            |
| Mom and Dad                                                   | One-time-watch movies |
| Kill Switch                                                   | Flop movies           |
| Havana Darkness                                               | Flop movies           |
| Contract to Kill                                              | Flop movies           |
| Dagenham                                                      | Flop movies           |
| Vargur                                                        | One-time-watch movies |
| Shattered                                                     | One-time-watch movies |
| The Samaritans                                                | Flop movies           |
| Apotheosis                                                    | One-time-watch movies |
| Lazarat                                                       | One-time-watch movies |
| Two Pigeons                                                   | One-time-watch movies |
| Dhaka Attack                                                  | Hit movies            |
| Raasta                                                        | Flop movies           |
| Maatr                                                         | Flop movies           |
| The Music Box                                                 | One-time-watch movies |
| Maanagaram                                                    | Superhit movies       |
| The Good Liar                                                 | One-time-watch movies |
| Replace                                                       | Flop movies           |
| Lucid                                                         | One-time-watch movies |
| Wetlands                                                      | Flop movies           |
| Mu ji zhe                                                     | Hit movies            |
| Clinical                                                      | One-time-watch movies |
| The Mad Whale                                                 | One-time-watch movies |
| Arsenal                                                       | Flop movies           |
| Harmony                                                       | One-time-watch movies |
| Die H├Âlle                                                    | One-time-watch movies |
| Extracurricular                                               | One-time-watch movies |
| The Beguiled                                                  | One-time-watch movies |
| Driven                                                        | One-time-watch movies |
| Polaroid                                                      | One-time-watch movies |
| Eshtebak                                                      | Hit movies            |
| Ambition                                                      | Flop movies           |
| Deadman Standing                                              | Flop movies           |
| Cabaret                                                       | Flop movies           |
| Boyne Falls                                                   | One-time-watch movies |
| Spinning Man                                                  | One-time-watch movies |
| Webcast                                                       | One-time-watch movies |
| 3                                                             | Flop movies           |
| Cardinals                                                     | One-time-watch movies |
| Black Water                                                   | Flop movies           |
| Kaleidoscope                                                  | One-time-watch movies |
| Antisocial.app                                                | Flop movies           |
| The Second                                                    | Flop movies           |
| Wraith                                                        | Flop movies           |
| The Ritual                                                    | One-time-watch movies |
| BNB Hell                                                      | One-time-watch movies |
| 8 Remains                                                     | Flop movies           |
| Thoroughbreds                                                 | One-time-watch movies |
| 5 Frauen                                                      | Flop movies           |
| Camera Obscura                                                | Flop movies           |
| Bad Day for the Cut                                           | One-time-watch movies |
| Den enda v├ñgen                                               | One-time-watch movies |
| Barracuda                                                     | One-time-watch movies |
| Fashionista                                                   | One-time-watch movies |
| Cut Shoot Kill                                                | Flop movies           |
| Charm├©ren                                                    | One-time-watch movies |
| The Recall                                                    | Flop movies           |
| Frazier Park Recut                                            | One-time-watch movies |
| Agent                                                         | Flop movies           |
| Breaking Point                                                | Flop movies           |
| Coffin 2                                                      | One-time-watch movies |
| La Misma Sangre                                               | One-time-watch movies |
| The Corrupted                                                 | One-time-watch movies |
| Killing Gunther                                               | Flop movies           |
| Mom                                                           | Hit movies            |
| Slender Man                                                   | Flop movies           |
| ExPatriot                                                     | Flop movies           |
| Darkness Visible                                              | One-time-watch movies |
| American Criminal                                             | Hit movies            |
| The Changeover                                                | One-time-watch movies |
| Dark River                                                    | One-time-watch movies |
| Everfall                                                      | Flop movies           |
| Heartthrob                                                    | One-time-watch movies |
| Madre                                                         | One-time-watch movies |
| Carnivore: Werewolf of London                                 | Flop movies           |
| The Killing of a Sacred Deer                                  | Hit movies            |
| Thumper                                                       | One-time-watch movies |
| Small Crimes                                                  | One-time-watch movies |
| Never Hike Alone                                              | One-time-watch movies |
| Aus dem Nichts                                                | Hit movies            |
| Insidious: The Last Key                                       | One-time-watch movies |
| The Stranger Inside                                           | Flop movies           |
| Salinjaui gieokbeob                                           | Hit movies            |
| Involution                                                    | Flop movies           |
| The Possession of Hannah Grace                                | One-time-watch movies |
| Sam Was Here                                                  | Flop movies           |
| Midnighters                                                   | One-time-watch movies |
| Red Room                                                      | Flop movies           |
| Il permesso - 48 ore fuori                                    | One-time-watch movies |
| Small Town Crime                                              | One-time-watch movies |
| Skyscraper                                                    | One-time-watch movies |
| Kung Fu Traveler                                              | One-time-watch movies |
| Freddy/Eddy                                                   | One-time-watch movies |
| Tiyaan                                                        | One-time-watch movies |
| Bad Blood                                                     | Flop movies           |
| Voidfinder                                                    | One-time-watch movies |
| Tera Intezaar                                                 | Flop movies           |
| The Institute                                                 | Flop movies           |
| The Cutlass                                                   | Flop movies           |
| Running with the Devil                                        | One-time-watch movies |
| Dementia 13                                                   | Flop movies           |
| The Archer                                                    | One-time-watch movies |
| Let Her Out                                                   | Flop movies           |
| Ji qi zhi xue                                                 | One-time-watch movies |
| Christmas Crime Story                                         | Flop movies           |
| The Nun                                                       | One-time-watch movies |
| Close Calls                                                   | One-time-watch movies |
| Tout nous s├®pare                                             | One-time-watch movies |
| Laissez bronzer les cadavres                                  | One-time-watch movies |
| What Death Leaves Behind                                      | Superhit movies       |
| Look Away                                                     | One-time-watch movies |
| Devil in the Dark                                             | Flop movies           |
| River Runs Red                                                | Flop movies           |
| Dark Meridian                                                 | Flop movies           |
| Chai dan zhuan jia                                            | One-time-watch movies |
| American Violence                                             | Flop movies           |
| Lasso                                                         | Flop movies           |
| The Atoning                                                   | Flop movies           |
| The Poison Rose                                               | Flop movies           |
| The Capture                                                   | One-time-watch movies |
| Silencer                                                      | Flop movies           |
| Created Equal                                                 | One-time-watch movies |
| The Student                                                   | Flop movies           |
| Serpent                                                       | Flop movies           |
| 22-nenme no kokuhaku: Watashi ga satsujinhan desu             | One-time-watch movies |
| First Kill                                                    | One-time-watch movies |
| The Super                                                     | One-time-watch movies |
| Ghatel-e ahli                                                 | Flop movies           |
| Cain Hill                                                     | Flop movies           |
| Ezra                                                          | One-time-watch movies |
| Project Ghazi                                                 | One-time-watch movies |
| Avenge the Crows                                              | One-time-watch movies |
| Dead on Arrival                                               | One-time-watch movies |
| The Nursery                                                   | One-time-watch movies |
| Ana de d├¡a                                                   | One-time-watch movies |
| Thondimuthalum Dhriksakshiyum                                 | Superhit movies       |
| Beyond the Night                                              | One-time-watch movies |
| Hongo                                                         | One-time-watch movies |
| A Death in the Gunj                                           | Hit movies            |
| A Crooked Somebody                                            | One-time-watch movies |
| Marlina si Pembunuh dalam Empat Babak                         | Hit movies            |
| The Pale Man                                                  | Flop movies           |
| Stay                                                          | One-time-watch movies |
| Steel Country                                                 | One-time-watch movies |
| BuyBust                                                       | One-time-watch movies |
| We Have Always Lived in the Castle                            | One-time-watch movies |
| Commando 2                                                    | One-time-watch movies |
| Tiger Zinda Hai                                               | One-time-watch movies |
| Motorrad                                                      | Flop movies           |
| The Cabin                                                     | Flop movies           |
| Zavod                                                         | Hit movies            |
| The Angel                                                     | One-time-watch movies |
| Captive State                                                 | One-time-watch movies |
| Lost Fare                                                     | Flop movies           |
| The Transcendents                                             | Hit movies            |
| Bad Match                                                     | One-time-watch movies |
| La niebla y la doncella                                       | One-time-watch movies |
| First Light                                                   | One-time-watch movies |
| The 13th Friday                                               | Flop movies           |
| Roman J. Israel, Esq.                                         | One-time-watch movies |
| What Lies Ahead                                               | Flop movies           |
| Oru Mexican Aparatha                                          | One-time-watch movies |
| Extracurricular Activities                                    | One-time-watch movies |
| What Still Remains                                            | Flop movies           |
| S.W.A.T.: Under Siege                                         | Flop movies           |
| The Strange Ones                                              | One-time-watch movies |
| Sawoleuiggeut                                                 | One-time-watch movies |
| Obsession                                                     | Flop movies           |
| All Light Will End                                            | Flop movies           |
| The Wrong Mother                                              | One-time-watch movies |
| Mal Nosso                                                     | One-time-watch movies |
| La Cordillera                                                 | One-time-watch movies |
| Welcome to Acapulco                                           | Flop movies           |
| Die Vierh├ñndige                                              | One-time-watch movies |
| First Reformed                                                | Hit movies            |
| The Toybox                                                    | Flop movies           |
| Monos                                                         | Hit movies            |
| Acrimony                                                      | One-time-watch movies |
| [Cargo]                                                       | Flop movies           |
| Bitch                                                         | One-time-watch movies |
| The School                                                    | Flop movies           |
| Possum                                                        | One-time-watch movies |
| Looking Glass                                                 | Flop movies           |
| Still/Born                                                    | One-time-watch movies |
| Hitsuji no ki                                                 | One-time-watch movies |
| M/M                                                           | Flop movies           |
| Romina                                                        | Flop movies           |
| Mona_Darling                                                  | One-time-watch movies |
| Point of no Return                                            | Flop movies           |
| Khoj                                                          | One-time-watch movies |
| Radius                                                        | One-time-watch movies |
| Isabelle                                                      | Flop movies           |
| A Thought of Ecstasy                                          | Flop movies           |
| Kaalakaandi                                                   | One-time-watch movies |
| Jackals                                                       | One-time-watch movies |
| Ramaleela                                                     | Hit movies            |
| Aadhi                                                         | One-time-watch movies |
| The Young Cannibals                                           | Flop movies           |
| The Night Comes for Us                                        | Hit movies            |
| Jahr des Tigers                                               | One-time-watch movies |
| Paradise Hills                                                | One-time-watch movies |
| Blood Prism                                                   | Flop movies           |
| Ara├▒a                                                        | One-time-watch movies |
| Asher                                                         | One-time-watch movies |
| The Line                                                      | One-time-watch movies |
| Girl Followed                                                 | Flop movies           |
| Downrange                                                     | One-time-watch movies |
| Bullitt County                                                | Flop movies           |
| The Black String                                              | One-time-watch movies |
| Skin in the Game                                              | Flop movies           |
| Hex                                                           | Flop movies           |
| Distorted                                                     | One-time-watch movies |
| John Wick: Chapter 3 - Parabellum                             | Hit movies            |
| Vikram Vedha                                                  | Superhit movies       |
| K.O.                                                          | One-time-watch movies |
| Best F(r)iends: Volume 1                                      | One-time-watch movies |
| Perdidos                                                      | Flop movies           |
| Astro                                                         | Flop movies           |
| The Nanny                                                     | Flop movies           |
| A Violent Man                                                 | One-time-watch movies |
| Angamaly Diaries                                              | Hit movies            |
| Naam Shabana                                                  | One-time-watch movies |
| Paint It Red                                                  | Flop movies           |
| Feedback                                                      | Hit movies            |
| Nur Gott kann mich richten                                    | One-time-watch movies |
| St. Agatha                                                    | One-time-watch movies |
| Canal Street                                                  | Flop movies           |
| Carbone                                                       | One-time-watch movies |
| The Executioners                                              | Flop movies           |
| Angel Has Fallen                                              | One-time-watch movies |
| X.                                                            | One-time-watch movies |
| Gremlin                                                       | Flop movies           |
| Berserk                                                       | Flop movies           |
| Zero 3                                                        | One-time-watch movies |
| The Kill Team                                                 | One-time-watch movies |
| Malicious                                                     | One-time-watch movies |
| Bairavaa                                                      | One-time-watch movies |
| The Villain                                                   | One-time-watch movies |
| Urvi                                                          | Hit movies            |
| Bullet Head                                                   | One-time-watch movies |
| The Crossbreed                                                | Flop movies           |
| Trapped                                                       | Hit movies            |
| Fun├┤han                                                      | One-time-watch movies |
| No Date, No Signature                                         | Hit movies            |
| Loverboy                                                      | One-time-watch movies |
| 10x10                                                         | One-time-watch movies |
| ├ûteki Taraf                                                  | One-time-watch movies |
| The Journey                                                   | One-time-watch movies |
| The Russian Bride                                             | One-time-watch movies |
| Allure                                                        | Flop movies           |
| Cereyan                                                       | Flop movies           |
| Calibre                                                       | One-time-watch movies |
| Pledge                                                        | One-time-watch movies |
| Occidental                                                    | One-time-watch movies |
| Halt: The Motion Picture                                      | Flop movies           |
| Ride                                                          | One-time-watch movies |
| Accident Man                                                  | One-time-watch movies |
| Shelter                                                       | One-time-watch movies |
| Followers                                                     | Flop movies           |
| Sarvann                                                       | One-time-watch movies |
| #Selfi                                                        | One-time-watch movies |
| Candy Corn                                                    | Flop movies           |
| Konvert                                                       | One-time-watch movies |
| In This Gray Place                                            | One-time-watch movies |
| Door in the Woods                                             | Flop movies           |
| Abstruse                                                      | Superhit movies       |
| Vodka Diaries                                                 | One-time-watch movies |
| Raju Gari Gadhi 2                                             | One-time-watch movies |
| Love Me Not                                                   | One-time-watch movies |
| Kolaiyuthir Kaalam                                            | Flop movies           |
| Knuckleball                                                   | One-time-watch movies |
| Acts of Vengeance                                             | One-time-watch movies |
| Mon gar├ºon                                                   | One-time-watch movies |
| Witch-Hunt                                                    | One-time-watch movies |
| Hong yi xiao nu hai 2                                         | One-time-watch movies |
| The Ghazi Attack                                              | Hit movies            |
| Broken Ghost                                                  | One-time-watch movies |
| Matriarch                                                     | One-time-watch movies |
| Perfect Skin                                                  | One-time-watch movies |
| Yeo-gyo-sa                                                    | One-time-watch movies |
| Game of Death                                                 | One-time-watch movies |
| Take Off                                                      | Superhit movies       |
| Empathy, Inc.                                                 | Flop movies           |
| Deadly Expose                                                 | Flop movies           |
| Bogan                                                         | One-time-watch movies |
| Inuyashiki                                                    | One-time-watch movies |
| Burn Out                                                      | One-time-watch movies |
| Keshava                                                       | One-time-watch movies |
| Where the Skin Lies                                           | Flop movies           |
| Adhe Kangal                                                   | Hit movies            |
| Sniper: Ultimate Kill                                         | One-time-watch movies |
| The Guardian Angel                                            | One-time-watch movies |
| Last Ferry                                                    | Hit movies            |
| Edge of Isolation                                             | Flop movies           |
| Una especie de familia                                        | One-time-watch movies |
| Aake                                                          | One-time-watch movies |
| Spell                                                         | One-time-watch movies |
| Naa Panta Kano                                                | Flop movies           |
| Simran                                                        | One-time-watch movies |
| Beautiful Manasugalu                                          | Hit movies            |
| The Doll 2                                                    | One-time-watch movies |
| Anonymous 616                                                 | One-time-watch movies |
| V.I.P.                                                        | One-time-watch movies |
| Ten                                                           | Flop movies           |
| Fast Color                                                    | One-time-watch movies |
| Konw├│j                                                       | One-time-watch movies |
| Puthan Panam                                                  | One-time-watch movies |
| Patser                                                        | One-time-watch movies |
| Brothers in Arms                                              | One-time-watch movies |
| Las grietas de Jara                                           | One-time-watch movies |
| The Coldest Game                                              | One-time-watch movies |
| The Hurt                                                      | Flop movies           |
| End Trip                                                      | Hit movies            |
| Housewife                                                     | Flop movies           |
| Irada                                                         | One-time-watch movies |
| Tempus Tormentum                                              | Flop movies           |
| Pol├¡cia Federal: A Lei ├® para Todos                         | One-time-watch movies |
| Serenity                                                      | One-time-watch movies |
| Mersal                                                        | Hit movies            |
| Gol-deun seul-leom-beo                                        | One-time-watch movies |
| K├ñ├ñnt├Âpiste                                                | One-time-watch movies |
| Project Ithaca                                                | Flop movies           |
| Siberia                                                       | Flop movies           |
| Rideshare                                                     | One-time-watch movies |
| Armomurhaaja                                                  | One-time-watch movies |
| Mata Batin                                                    | One-time-watch movies |
| Tiere                                                         | One-time-watch movies |
| Haseena Parkar                                                | Flop movies           |
| Baazaar                                                       | One-time-watch movies |
| Piercing                                                      | One-time-watch movies |
| Spyder                                                        | One-time-watch movies |
| El otro hermano                                               | One-time-watch movies |
| Jagveld                                                       | One-time-watch movies |
| Skjelvet                                                      | One-time-watch movies |
| The Wicked Gift                                               | One-time-watch movies |
| Fr├¿res ennemis                                               | One-time-watch movies |
| Nomis                                                         | One-time-watch movies |
| Haunt                                                         | One-time-watch movies |
| #SquadGoals                                                   | Flop movies           |
| Reprisal                                                      | Flop movies           |
| Life Like                                                     | One-time-watch movies |
| Siew Lup                                                      | One-time-watch movies |
| Monster Party                                                 | One-time-watch movies |
| American Pets                                                 | Flop movies           |
| Sweetheart                                                    | One-time-watch movies |
| Cutterhead                                                    | One-time-watch movies |
| Yaman                                                         | One-time-watch movies |
| Death Game                                                    | One-time-watch movies |
| Tamaroz                                                       | One-time-watch movies |
| Night Bus                                                     | Hit movies            |
| The Fast and the Fierce                                       | Flop movies           |
| Adam Joan                                                     | One-time-watch movies |
| Sathya                                                        | Flop movies           |
| Strategy and Pursuit                                          | Hit movies            |
| Hesperia                                                      | Flop movies           |
| Drive                                                         | Flop movies           |
| Kuttram 23                                                    | Hit movies            |
| Mai mee Samui samrab ter                                      | One-time-watch movies |
| Haebing                                                       | One-time-watch movies |
| Rust Creek                                                    | One-time-watch movies |
| Solo                                                          | Hit movies            |
| Manu                                                          | Hit movies            |
| Villain                                                       | One-time-watch movies |
| Lakshyam                                                      | One-time-watch movies |
| Indu Sarkar                                                   | One-time-watch movies |
| The House of Violent Desire                                   | Flop movies           |
| A Good Woman Is Hard to Find                                  | One-time-watch movies |
| The Wrong Nanny                                               | Flop movies           |
| Triple Threat                                                 | One-time-watch movies |
| Yuddham Sharanam                                              | One-time-watch movies |
| Maracaibo                                                     | One-time-watch movies |
| Carbon                                                        | One-time-watch movies |
| Fantasten                                                     | One-time-watch movies |
| Every Time I Die                                              | Flop movies           |
| Nabab                                                         | Hit movies            |
| Amok                                                          | One-time-watch movies |
| Two Graves                                                    | Flop movies           |
| Incoming                                                      | Flop movies           |
| Off the Rails                                                 | Flop movies           |
| Street Lights                                                 | One-time-watch movies |
| Rapurasu no majo                                              | One-time-watch movies |
| Steig. Nicht. Aus!                                            | One-time-watch movies |
| Ittefaq                                                       | Hit movies            |
| The Riot Act                                                  | Flop movies           |
| Babumoshai Bandookbaaz                                        | One-time-watch movies |
| Kavan                                                         | Hit movies            |
| Dead Water                                                    | Flop movies           |
| Playing with Dolls: Havoc                                     | Flop movies           |
| Bhaagamathie                                                  | Hit movies            |
| Oxygen                                                        | One-time-watch movies |
| Revenge                                                       | One-time-watch movies |
| Num├®ro une                                                   | One-time-watch movies |
| Den skyldige                                                  | Hit movies            |
| 8 Thottakkal                                                  | Hit movies            |
| Room for Rent                                                 | One-time-watch movies |
| Saab Bahadar                                                  | Hit movies            |
| High Heel Homicide                                            | Flop movies           |
| Dogman                                                        | Hit movies            |
| American Dreamer                                              | One-time-watch movies |
| Escape Plan: The Extractors                                   | Flop movies           |
| Truth or Dare                                                 | One-time-watch movies |
| Diwanji Moola Grand Prix                                      | Flop movies           |
| Aiyaary                                                       | One-time-watch movies |
| Aala Kaf Ifrit                                                | Hit movies            |
| Totem                                                         | Flop movies           |
| A Deadly View                                                 | Flop movies           |
| El crack cero                                                 | Hit movies            |
| Verna                                                         | Hit movies            |
| Nighthawks                                                    | Flop movies           |
| The 15:17 to Paris                                            | One-time-watch movies |
| Une vie violente                                              | One-time-watch movies |
| Doe                                                           | One-time-watch movies |
| Si-gan-wi-ui jib                                              | One-time-watch movies |
| Glass                                                         | One-time-watch movies |
| The Field                                                     | Flop movies           |
| Mr. Jones                                                     | One-time-watch movies |
| Welcome Home                                                  | One-time-watch movies |
| Loosideu deurim                                               | One-time-watch movies |
| Das Ende der Wahrheit                                         | One-time-watch movies |
| Saaho                                                         | One-time-watch movies |
| Vault                                                         | One-time-watch movies |
| A Tale of Shadows                                             | One-time-watch movies |
| Baaghi 2                                                      | One-time-watch movies |
| Til Death Do Us Part                                          | Flop movies           |
| Peppermint                                                    | One-time-watch movies |
| Nigerian Prince                                               | One-time-watch movies |
| Elizabeth Harvest                                             | One-time-watch movies |
| Alien Domicile 2: Lot 24                                      | Hit movies            |
| #Captured                                                     | One-time-watch movies |
| The Appearance                                                | Flop movies           |
| Us                                                            | One-time-watch movies |
| Roofied                                                       | Flop movies           |
| The Hummingbird Project                                       | One-time-watch movies |
| Vivegam                                                       | One-time-watch movies |
| Perception                                                    | One-time-watch movies |
| Hong hai xing dong                                            | One-time-watch movies |
| The Follower                                                  | Flop movies           |
| Ha-roo                                                        | One-time-watch movies |
| Absurd Accident                                               | One-time-watch movies |
| La ragazza nella nebbia                                       | One-time-watch movies |
| Tueurs                                                        | One-time-watch movies |
| Hyeob-sang                                                    | One-time-watch movies |
| Al Asleyeen                                                   | Hit movies            |
| The Midnight Matinee                                          | Flop movies           |
| Journal 64                                                    | Hit movies            |
| Deadly Exchange                                               | Flop movies           |
| Prodigy                                                       | Flop movies           |
| Prescience                                                    | Flop movies           |
| Sarajin bam                                                   | One-time-watch movies |
| One                                                           | One-time-watch movies |
| The Fox                                                       | Flop movies           |
| Hospitality                                                   | Flop movies           |
| The Nightmare Gallery                                         | Flop movies           |
| Blackmail                                                     | Hit movies            |
| Clickbait                                                     | One-time-watch movies |
| Nommer 37                                                     | One-time-watch movies |
| Joel                                                          | Flop movies           |
| Curse of the Nun                                              | Flop movies           |
| Uru                                                           | One-time-watch movies |
| Paul Sanchez est revenu!                                      | One-time-watch movies |
| The Wrong Son                                                 | One-time-watch movies |
| Betrayed                                                      | One-time-watch movies |
| Velaikkaran                                                   | Hit movies            |
| Tam jeong 2                                                   | One-time-watch movies |
| El-Khaliyyah                                                  | One-time-watch movies |
| Russkiy Bes                                                   | One-time-watch movies |
| Balloon                                                       | Flop movies           |
| Velvet Buzzsaw                                                | One-time-watch movies |
| The Cleaning Lady                                             | One-time-watch movies |
| Jang-san-beom                                                 | One-time-watch movies |
| The Pages                                                     | One-time-watch movies |
| Fuga                                                          | One-time-watch movies |
| Dharmayuddhaya                                                | Hit movies            |
| Gi-eok-ui bam                                                 | Hit movies            |
| Angel of Mine                                                 | One-time-watch movies |
| Ratsasan                                                      | Superhit movies       |
| Theeran Adhigaaram Ondru                                      | Superhit movies       |
| The Place                                                     | Hit movies            |
| What Keeps You Alive                                          | One-time-watch movies |
| Inori no maku ga oriru toki                                   | Hit movies            |
| Carnivores                                                    | One-time-watch movies |
| Sathya                                                        | One-time-watch movies |
| Nowhere Mind                                                  | Flop movies           |
| In un giorno la fine                                          | One-time-watch movies |
| Donnybrook                                                    | One-time-watch movies |
| Pandigai                                                      | One-time-watch movies |
| Gemini Ganeshanum Suruli Raajanum                             | One-time-watch movies |
| Duvern├¢ nepr├¡tel                                            | One-time-watch movies |
| The Chain                                                     | Flop movies           |
| El reino                                                      | Hit movies            |
| Woosang                                                       | One-time-watch movies |
| Raazi                                                         | Hit movies            |
| Rocky Mental                                                  | One-time-watch movies |
| La sombra de la ley                                           | One-time-watch movies |
| Kavaludaari                                                   | Superhit movies       |
| Die in One Day                                                | Flop movies           |
| Ballon                                                        | Hit movies            |
| Stillwater                                                    | One-time-watch movies |
| Bonehill Road                                                 | One-time-watch movies |
| Zhan lang II                                                  | One-time-watch movies |
| Ach spij kochanie                                             | One-time-watch movies |
| Against the Night                                             | Flop movies           |
| Maradona                                                      | One-time-watch movies |
| Edge of Fear                                                  | Flop movies           |
| Kataka                                                        | Hit movies            |
| Net I Die                                                     | Flop movies           |
| No dormir├ís                                                  | One-time-watch movies |
| Sequestro Rel├ómpago                                          | Flop movies           |
| Night Zero                                                    | Flop movies           |
| The Perception                                                | Flop movies           |
| Iravukku Aayiram Kangal                                       | Hit movies            |
| Irumbu Thirai                                                 | Hit movies            |
| Lifechanger                                                   | One-time-watch movies |
| Benzersiz                                                     | Flop movies           |
| Thupparivaalan                                                | Hit movies            |
| Twin Betrayal                                                 | One-time-watch movies |
| Real Cases of Shadow People The Sarah McCormick Story         | One-time-watch movies |
| Pussy Kills                                                   | Flop movies           |
| Jawaan                                                        | Flop movies           |
| Heilst├ñtten                                                  | Flop movies           |
| Operation Alamelamma                                          | Superhit movies       |
| Kuang shou                                                    | One-time-watch movies |
| Kaaviyyan                                                     | One-time-watch movies |
| Puen Tee Raluek                                               | One-time-watch movies |
| The System                                                    | Flop movies           |
| Heesaeng boohwalja                                            | One-time-watch movies |
| Artik                                                         | Flop movies           |
| En aff├ªre                                                    | One-time-watch movies |
| Lucky Day                                                     | One-time-watch movies |
| Nene Raju Nene Mantri                                         | One-time-watch movies |
| LIE                                                           | One-time-watch movies |
| Botoks                                                        | Flop movies           |
| Kala Viplavam Pranayam                                        | Flop movies           |
| Orayiram Kinakkalal                                           | One-time-watch movies |
| Kurangu Bommai                                                | Superhit movies       |
| Karuppan                                                      | One-time-watch movies |
| A Lover Betrayed                                              | One-time-watch movies |
| #Followme                                                     | Flop movies           |
| Kaashi in Search of Ganga                                     | One-time-watch movies |
| Tik Tik Tik                                                   | One-time-watch movies |
| Long Lost                                                     | One-time-watch movies |
| Hell Is Where the Home Is                                     | One-time-watch movies |
| Joker                                                         | Superhit movies       |
| Pimped                                                        | Flop movies           |
| Between Worlds                                                | Flop movies           |
| The Lake Vampire                                              | One-time-watch movies |
| Nothing Really Happens                                        | One-time-watch movies |
| Svaha: The Sixth Finger                                       | One-time-watch movies |
| Notes on an Appearance                                        | One-time-watch movies |
| Them That Follow                                              | One-time-watch movies |
| 30 Miles from Nowhere                                         | Flop movies           |
| Killer Kate!                                                  | Flop movies           |
| Savovi                                                        | Hit movies            |
| Vals                                                          | One-time-watch movies |
| Hex                                                           | Flop movies           |
| Direnis Karatay                                               | Hit movies            |
| Abrahaminte Santhathikal                                      | Hit movies            |
| Scars of Xavier                                               | Flop movies           |
| The Lodge                                                     | One-time-watch movies |
| Head Count                                                    | One-time-watch movies |
| El desentierro                                                | Flop movies           |
| Eter                                                          | One-time-watch movies |
| La hora final                                                 | One-time-watch movies |
| Ouija House                                                   | Flop movies           |
| Duelles                                                       | One-time-watch movies |
| Red Letter Day                                                | Flop movies           |
| In the Cloud                                                  | Flop movies           |
| Missing                                                       | One-time-watch movies |
| Removed                                                       | One-time-watch movies |
| Illusions                                                     | Hit movies            |
| C├│mprame un revolver                                         | One-time-watch movies |
| The Wrong Daughter                                            | One-time-watch movies |
| War                                                           | One-time-watch movies |
| Race 3                                                        | Flop movies           |
| Low Tide                                                      | One-time-watch movies |
| The Farm: En Veettu Thottathil                                | Hit movies            |
| Askin G├Âren G├Âzlere Ihtiyaci yok                            | One-time-watch movies |
| Bottle Girl                                                   | Flop movies           |
| Like.Share.Follow.                                            | One-time-watch movies |
| Doll Cemetery                                                 | Flop movies           |
| Anna                                                          | One-time-watch movies |
| Le chant du loup                                              | Hit movies            |
| Killers Within                                                | One-time-watch movies |
| The Oath                                                      | One-time-watch movies |
| 7 Hosil                                                       | One-time-watch movies |
| Yol kenari                                                    | One-time-watch movies |
| The Boat                                                      | One-time-watch movies |
| Seung joi nei jor yau                                         | One-time-watch movies |
| Silencio                                                      | Flop movies           |
| The Gallows Act II                                            | Flop movies           |
| Nematoma                                                      | Hit movies            |
| B. Tech                                                       | One-time-watch movies |
| The Tooth and the Nail                                        | One-time-watch movies |
| Xue guan yin                                                  | Hit movies            |
| Semma Botha Aagatha                                           | One-time-watch movies |
| Eyewitness                                                    | Flop movies           |
| The Burial Of Kojo                                            | One-time-watch movies |
| Party Hard Die Young                                          | One-time-watch movies |
| Thiruttu Payale 2                                             | One-time-watch movies |
| Kee                                                           | One-time-watch movies |
| Yin bao zhe                                                   | One-time-watch movies |
| Paradise Beach                                                | Flop movies           |
| The Dig                                                       | One-time-watch movies |
| Bez menya                                                     | One-time-watch movies |
| Animal                                                        | One-time-watch movies |
| It Kills                                                      | Flop movies           |
| Swathanthryam Ardharathriyil                                  | Hit movies            |
| Koxa                                                          | Flop movies           |
| Trickster                                                     | Flop movies           |
| F20                                                           | One-time-watch movies |
| Unda                                                          | Superhit movies       |
| Wake Up                                                       | One-time-watch movies |
| Survival Box                                                  | Flop movies           |
| Schoolhouse                                                   | Flop movies           |
| The Legend of Halloween Jack                                  | Flop movies           |
| Ira                                                           | One-time-watch movies |
| The Open House                                                | Flop movies           |
| Daughter of the Wolf                                          | One-time-watch movies |
| A Night to Regret                                             | One-time-watch movies |
| Rewind: Die zweite Chance                                     | One-time-watch movies |
| The Wedding Guest                                             | One-time-watch movies |
| This Old Machine                                              | Flop movies           |
| La quietud                                                    | One-time-watch movies |
| The Manson Family Massacre                                    | Flop movies           |
| Searching                                                     | Hit movies            |
| Thriller                                                      | Flop movies           |
| Papa, sdokhni                                                 | One-time-watch movies |
| Yazh                                                          | Superhit movies       |
| Monsters and Men                                              | One-time-watch movies |
| Superfly                                                      | One-time-watch movies |
| El pacto                                                      | One-time-watch movies |
| 18am Padi                                                     | One-time-watch movies |
| Best F(r)iends: Volume 2                                      | One-time-watch movies |
| According to Mathew                                           | One-time-watch movies |
| Diya                                                          | One-time-watch movies |
| Chanakyatanthram                                              | One-time-watch movies |
| To th├ívma tis th├ílassas ton Sargass├│n                      | One-time-watch movies |
| Alpha Wolf                                                    | Flop movies           |
| Silent Panic                                                  | Flop movies           |
| Genius                                                        | Flop movies           |
| Nirdosh                                                       | Flop movies           |
| Il testimone invisibile                                       | One-time-watch movies |
| Blood Craft                                                   | Flop movies           |
| Naachiyar                                                     | One-time-watch movies |
| Until Midnight                                                | Hit movies            |
| ├çocuklar Sana Emanet                                         | One-time-watch movies |
| Somewhere Beyond the Mist                                     | One-time-watch movies |
| Apr├│ mes├®k                                                  | Hit movies            |
| Goodachari                                                    | Hit movies            |
| Okka Kshanam                                                  | Hit movies            |
| Cola de Mono                                                  | One-time-watch movies |
| Varikkuzhiyile Kolapathakam                                   | One-time-watch movies |
| The Perfection                                                | One-time-watch movies |
| Awe!                                                          | Hit movies            |
| Lukas                                                         | One-time-watch movies |
| Odds Are                                                      | Flop movies           |
| Thadam                                                        | Superhit movies       |
| Profile                                                       | Hit movies            |
| Thuppaki Munai                                                | One-time-watch movies |
| Loon Lake                                                     | One-time-watch movies |
| Feedback                                                      | One-time-watch movies |
| Luz                                                           | One-time-watch movies |
| Aapla Manus                                                   | Hit movies            |
| 122                                                           | Hit movies            |
| The Fanatic                                                   | Flop movies           |
| Mercury                                                       | One-time-watch movies |
| Family Blood                                                  | Flop movies           |
| Lottery                                                       | One-time-watch movies |
| 4 Rah Istanbul                                                | One-time-watch movies |
| Be Vaghte Sham                                                | One-time-watch movies |
| Maghzhaye Koochake Zang Zadeh                                 | Hit movies            |
| Gogol. Viy                                                    | One-time-watch movies |
| Deception: Oo Pel Dan Myin                                    | Superhit movies       |
| E-Demon                                                       | Flop movies           |
| Spider in the Web                                             | Flop movies           |
| Body at Brighton Rock                                         | Flop movies           |
| Depraved                                                      | Flop movies           |
| Prospect                                                      | One-time-watch movies |
| Bordo Bereliler Afrin                                         | Flop movies           |
| Acusada                                                       | One-time-watch movies |
| Ma                                                            | One-time-watch movies |
| The Mule                                                      | Hit movies            |
| Ut├©ya 22. juli                                               | Hit movies            |
| The Farm                                                      | Flop movies           |
| Vikadakumaran                                                 | One-time-watch movies |
| Kargar sadeh niazmandim                                       | One-time-watch movies |
| Quien a hierro mata                                           | Hit movies            |
| 70 Binladens                                                  | One-time-watch movies |
| The Haunting of Sharon Tate                                   | Flop movies           |
| Garbage                                                       | Flop movies           |
| Sabrina                                                       | Flop movies           |
| Morto N├úo Fala                                               | One-time-watch movies |
| Aschhe Abar Shabor                                            | One-time-watch movies |
| The Operative                                                 | One-time-watch movies |
| Foto na pamyat                                                | Flop movies           |
| Burn                                                          | One-time-watch movies |
| Boomerang                                                     | One-time-watch movies |
| Rassvet                                                       | Flop movies           |
| Shadow Wolves                                                 | Flop movies           |
| Dressage                                                      | One-time-watch movies |
| Prowler                                                       | Flop movies           |
| The Surrogate                                                 | Flop movies           |
| Taxiwaala                                                     | Hit movies            |
| Manyak                                                        | One-time-watch movies |
| Kabir                                                         | One-time-watch movies |
| 7 Nyeon-eui bam                                               | One-time-watch movies |
| The Watcher                                                   | One-time-watch movies |
| Solum                                                         | One-time-watch movies |
| The Row                                                       | Flop movies           |
| Shohrat the Trap                                              | One-time-watch movies |
| Ban-deu-si jab-neun-da                                        | One-time-watch movies |
| The Refuge                                                    | One-time-watch movies |
| His Perfect Obsession                                         | One-time-watch movies |
| Judgementall Hai Kya                                          | One-time-watch movies |
| Andhadhun                                                     | Superhit movies       |
| The Tashkent Files                                            | Hit movies            |
| Hattrick                                                      | One-time-watch movies |
| Bbaengban                                                     | One-time-watch movies |
| Linhas de Sangue                                              | Flop movies           |
| One Day: Justice Delivered                                    | One-time-watch movies |
| Veera Bhoga Vasantha Rayalu                                   | One-time-watch movies |
| El Hijo                                                       | One-time-watch movies |
| Chase                                                         | Hit movies            |
| Varathan                                                      | Hit movies            |
| Cuck                                                          | One-time-watch movies |
| Soul Hunters                                                  | One-time-watch movies |
| B├Âr├╝                                                        | Hit movies            |
| Satyameva Jayate                                              | One-time-watch movies |
| The Furies                                                    | One-time-watch movies |
| El Hoyo                                                       | Hit movies            |
| The Report                                                    | Hit movies            |
| Downward Twin                                                 | Flop movies           |
| Khamoshi                                                      | Flop movies           |
| Non sono un assassino                                         | One-time-watch movies |
| Lilli                                                         | One-time-watch movies |
| The Huntress: Rune of the Dead                                | One-time-watch movies |
| Fractured                                                     | One-time-watch movies |
| Muere, monstruo, muere                                        | One-time-watch movies |
| Memorias de lo que no fue                                     | Flop movies           |
| Cucuy: The Boogeyman                                          | Flop movies           |
| Tone-Deaf                                                     | Flop movies           |
| Zoo-Head                                                      | Flop movies           |
| The Burnt Orange Heresy                                       | One-time-watch movies |
| Annabelle Comes Home                                          | One-time-watch movies |
| Cradle Robber                                                 | One-time-watch movies |
| 5 ├¿ il numero perfetto                                       | One-time-watch movies |
| Witches in the Woods                                          | Flop movies           |
| Deadly Switch                                                 | Flop movies           |
| Cam                                                           | One-time-watch movies |
| Brokedown                                                     | Hit movies            |
| Birbal Trilogy                                                | Superhit movies       |
| Adanga Maru                                                   | Hit movies            |
| Mu hou wan jia                                                | One-time-watch movies |
| Swallow                                                       | One-time-watch movies |
| Instinct                                                      | One-time-watch movies |
| El silencio de la ciudad blanca                               | One-time-watch movies |
| Witnesses                                                     | One-time-watch movies |
| Savita Damodar Paranjpe                                       | One-time-watch movies |
| Amavas                                                        | Flop movies           |
| Sultan: The Saviour                                           | One-time-watch movies |
| Portal                                                        | Flop movies           |
| Tutsak                                                        | One-time-watch movies |
| Ventajas de viajar en tren                                    | Hit movies            |
| Rabbia furiosa                                                | One-time-watch movies |
| Kaappaan                                                      | One-time-watch movies |
| We Belong Together                                            | Flop movies           |
| Lie Low                                                       | One-time-watch movies |
| Running Out Of Time                                           | Flop movies           |
| Abrakadabra                                                   | One-time-watch movies |
| Female Human Animal                                           | One-time-watch movies |
| Pihu                                                          | One-time-watch movies |
| Sh├®h├®razade                                                 | Hit movies            |
| Somnium                                                       | Flop movies           |
| Jai mat ze moon                                               | One-time-watch movies |
| Creep Nation                                                  | Flop movies           |
| Target                                                        | Flop movies           |
| Les fauves                                                    | One-time-watch movies |
| Sumaho o otoshita dake na no ni                               | One-time-watch movies |
| Kill Chain                                                    | One-time-watch movies |
| Bundy and the Green River Killer                              | Flop movies           |
| Romeo Akbar Walter                                            | One-time-watch movies |
| Killer in a Red Dress                                         | Flop movies           |
| Joseph                                                        | Superhit movies       |
| Crypto                                                        | One-time-watch movies |
| Purity Falls                                                  | One-time-watch movies |
| Karma                                                         | One-time-watch movies |
| The Wrong Friend                                              | Flop movies           |
| Il signor Diavolo                                             | One-time-watch movies |
| Kidnapping Stella                                             | Flop movies           |
| Plagi Breslau                                                 | One-time-watch movies |
| An Affair to Die For                                          | Flop movies           |
| Amityville: Mt. Misery Rd.                                    | One-time-watch movies |
| Bluff Master                                                  | One-time-watch movies |
| Subrahmanyapuram                                              | One-time-watch movies |
| Nguoi B├ót Tu                                                 | One-time-watch movies |
| 118                                                           | One-time-watch movies |
| O Banquete                                                    | One-time-watch movies |
| Family Vanished                                               | Flop movies           |
| Byomkesh Gotro                                                | One-time-watch movies |
| Mikhael                                                       | One-time-watch movies |
| Lupt                                                          | Hit movies            |
| Instakiller                                                   | Flop movies           |
| Rem├®lem legk├Âzelebb siker├╝l meghalnod:)                    | Hit movies            |
| U-Turn                                                        | Hit movies            |
| The Collini Case                                              | Hit movies            |
| Gogol. Strashnaya mest                                        | One-time-watch movies |
| Fear Bay                                                      | Flop movies           |
| Mercy Black                                                   | Flop movies           |
| Freaks                                                        | One-time-watch movies |
| The Dead Center                                               | One-time-watch movies |
| Come to Daddy                                                 | One-time-watch movies |
| Aurora                                                        | Flop movies           |
| Avengement                                                    | One-time-watch movies |
| The Ex Next Door                                              | One-time-watch movies |
| Mok-gyeok-ja                                                  | One-time-watch movies |
| Batla House                                                   | Hit movies            |
| Bloodline                                                     | One-time-watch movies |
| Live                                                          | Flop movies           |
| Mata Batin 2                                                  | One-time-watch movies |
| Kavacha                                                       | Superhit movies       |
| Trezor                                                        | Hit movies            |
| Room 37: The Mysterious Death of Johnny Thunders              | Flop movies           |
| Game Over                                                     | Hit movies            |
| Virus                                                         | Superhit movies       |
| Aadai                                                         | One-time-watch movies |
| Rojo                                                          | One-time-watch movies |
| Mr. & Ms. Rowdy                                               | Flop movies           |
| Valhalla                                                      | Hit movies            |
| O Paciente: O Caso Tancredo Neves                             | One-time-watch movies |
| American Hangman                                              | One-time-watch movies |
| Excursion                                                     | Hit movies            |
| Cleavers: Killer Clowns                                       | Flop movies           |
| Boi                                                           | Flop movies           |
| Bumperkleef                                                   | One-time-watch movies |
| Alpha: The Right to Kill                                      | One-time-watch movies |
| Homestay                                                      | Hit movies            |
| The Husband                                                   | One-time-watch movies |
| Blank                                                         | One-time-watch movies |
| Cold Blood Legacy                                             | Flop movies           |
| Home Is Where the Killer Is                                   | Flop movies           |
| Vera                                                          | Hit movies            |
| The Pool                                                      | One-time-watch movies |
| Rattlesnakes                                                  | One-time-watch movies |
| Killer Under the Bed                                          | One-time-watch movies |
| Seven                                                         | One-time-watch movies |
| The Villagers                                                 | One-time-watch movies |
| Pozivniy ┬½Banderas┬╗                                         | Hit movies            |
| Quick                                                         | Hit movies            |
| J├╗ni-nin no shinitai kodomo-tachi                            | One-time-watch movies |
| Madre                                                         | Hit movies            |
| Setters                                                       | One-time-watch movies |
| Kadaram Kondan                                                | One-time-watch movies |
| Kavacham                                                      | One-time-watch movies |
| Only Mine                                                     | Flop movies           |
| Scare BNB                                                     | Flop movies           |
| Halloween Horror Tales                                        | Flop movies           |
| Laal Kabootar                                                 | Hit movies            |
| Watchman                                                      | One-time-watch movies |
| Muse                                                          | Flop movies           |
| Ghost                                                         | Superhit movies       |
| The Car: Road to Revenge                                      | Flop movies           |
| 706                                                           | One-time-watch movies |
| Dokyala Shot                                                  | Superhit movies       |
| Do-eo-lak                                                     | One-time-watch movies |
| Secret Obsession                                              | Flop movies           |
| Revenger                                                      | One-time-watch movies |
| Bell Bottom                                                   | Superhit movies       |
| Ishq                                                          | Hit movies            |
| Bagh bandi khela                                              | Flop movies           |
| Danmarks s├©nner                                              | One-time-watch movies |
| ├£├º Harfliler: Adak                                          | Hit movies            |
| Sindhubaadh                                                   | One-time-watch movies |
| Along Came the Devil 2                                        | Flop movies           |
| Night                                                         | Flop movies           |
| Trhlina                                                       | One-time-watch movies |
| Gaddalakonda Ganesh                                           | Hit movies            |
| Nerkonda Paarvai                                              | Superhit movies       |
| Xue bao                                                       | One-time-watch movies |
| Athiran                                                       | One-time-watch movies |
| Falaknuma Das                                                 | One-time-watch movies |
| Otryv                                                         | Flop movies           |
| Majaray Nimrooz: Radde Khoon                                  | One-time-watch movies |
| Metri Shesh Va Nim                                            | Hit movies            |
| Misteri Dilaila                                               | One-time-watch movies |
| Nightmare Tenant                                              | One-time-watch movies |
| Paranormal Investigation                                      | Flop movies           |
| Sathru                                                        | One-time-watch movies |
| Kaithi                                                        | Superhit movies       |
| Jessie                                                        | Hit movies            |
+---------------------------------------------------------------+-----------------------+
1484 rows in set (0.01 sec)








/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:


mysql> SELECT genre,
    ->          ROUND(AVG(duration),2) AS average_duration,
    ->         SUM(ROUND(AVG(duration),2)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_duration,
    ->         AVG(ROUND(AVG(duration),2)) OVER(ORDER BY genre ROWS 10 PRECEDING) AS moving_duration
    -> FROM movie AS m
    -> INNER JOIN genre AS g
    -> ON m.id= g.movie_id
    -> GROUP BY genre
    -> ORDER BY genre;
+-----------+------------------+------------------+-----------------+
| genre     | average_duration | running_duration | moving_duration |
+-----------+------------------+------------------+-----------------+
| Action    |           112.88 |           112.88 |      112.880000 |
| Adventure |           101.87 |           214.75 |      107.375000 |
| Comedy    |           102.62 |           317.37 |      105.790000 |
| Crime     |           107.05 |           424.42 |      106.105000 |
| Drama     |           106.77 |           531.19 |      106.238000 |
| Family    |           100.97 |           632.16 |      105.360000 |
| Fantasy   |           105.14 |           737.30 |      105.328571 |
| Horror    |            92.72 |           830.02 |      103.752500 |
| Mystery   |           101.80 |           931.82 |      103.535556 |
| Others    |           100.16 |          1031.98 |      103.198000 |
| Romance   |           109.53 |          1141.51 |      103.773636 |
| Sci-Fi    |            97.94 |          1239.45 |      102.415455 |
| Thriller  |           101.58 |          1341.03 |      102.389091 |
+-----------+------------------+------------------+-----------------+
13 rows in set (0.06 sec)










-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

 WITH top_3_genre AS
    -> (
    ->  SELECT genre, COUNT(movie_id) AS number_of_movies
    ->     FROM genre AS g
    ->     INNER JOIN movie AS m
    ->     ON g.movie_id = m.id
    ->     GROUP BY genre
    ->     ORDER BY COUNT(movie_id) DESC
    ->     LIMIT 3
    -> ),
    ->
    -> top_5 AS
    -> (
    ->  SELECT genre,
    ->                  year,
    ->                  title AS movie_name,
    ->                  worlwide_gross_income,
    ->                  DENSE_RANK() OVER(PARTITION BY year ORDER BY worlwide_gross_income DESC) AS movie_rank
    ->
    ->  FROM movie AS m
    ->     INNER JOIN genre AS g
    ->     ON m.id= g.movie_id
    ->  WHERE genre IN (SELECT genre FROM top_3_genre)
    -> )
    ->
    -> SELECT *
    -> FROM top_5
    -> WHERE movie_rank<=5;
+----------+------+----------------------------+-----------------------+------------+
| genre    | year | movie_name                 | worlwide_gross_income | movie_rank |
+----------+------+----------------------------+-----------------------+------------+
| Drama    | 2017 | Shatamanam Bhavati         | INR 530500000         |          1 |
| Drama    | 2017 | Winner                     | INR 250000000         |          2 |
| Drama    | 2017 | Thank You for Your Service | $ 9995692             |          3 |
| Drama    | 2017 | The Healer                 | $ 9979800             |          4 |
| Comedy   | 2017 | The Healer                 | $ 9979800             |          4 |
| Thriller | 2017 | Gi-eok-ui bam              | $ 9968972             |          5 |
| Thriller | 2018 | The Villain                | INR 1300000000        |          1 |
| Drama    | 2018 | Antony & Cleopatra         | $ 998079              |          2 |
| Comedy   | 2018 | La fuitina sbagliata       | $ 992070              |          3 |
| Drama    | 2018 | Zaba                       | $ 991                 |          4 |
| Comedy   | 2018 | Gung-hab                   | $ 9899017             |          5 |
| Thriller | 2019 | Prescience                 | $ 9956                |          1 |
| Drama    | 2019 | Joker                      | $ 995064593           |          2 |
| Thriller | 2019 | Joker                      | $ 995064593           |          2 |
| Comedy   | 2019 | Eaten by Lions             | $ 99276               |          3 |
| Comedy   | 2019 | Friend Zone                | $ 9894885             |          4 |
| Drama    | 2019 | Nur eine Frau              | $ 9884                |          5 |
+----------+------+----------------------------+-----------------------+------------+
17 rows in set (0.07 sec)








-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT production_company,
    ->          COUNT(m.id) AS total_movies,
    ->         ROW_NUMBER() OVER(ORDER BY count(id) DESC) AS production_company_rank
    -> FROM movie AS m
    -> INNER JOIN ratings AS r
    -> ON m.id=r.movie_id
    -> WHERE median_rating>=8 AND production_company IS NOT NULL AND POSITION(',' IN languages)>0
    -> GROUP BY production_company
    -> LIMIT 2;
+-----------------------+--------------+-------------------------+
| production_company    | total_movies | production_company_rank |
+-----------------------+--------------+-------------------------+
| Star Cinema           |            7 |                       1 |
| Twentieth Century Fox |            4 |                       2 |
+-----------------------+--------------+-------------------------+
2 rows in set (0.01 sec)






-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT name, SUM(total_votes) AS votes,
    ->          COUNT(rm.movie_id) AS total_movies,
    ->          avg_rating,
    ->         DENSE_RANK() OVER(ORDER BY avg_rating DESC) AS act_rank
    -> FROM names AS n
    -> INNER JOIN role_mapping AS rm
    -> ON n.id = rm.name_id
    -> INNER JOIN ratings AS r
    -> ON r.movie_id = rm.movie_id
    -> INNER JOIN genre AS g
    -> ON r.movie_id = g.movie_id
    -> WHERE category = 'actress' AND avg_rating > 8 AND genre = 'drama'
    -> GROUP BY name
    -> LIMIT 3;
+-----------------+-------+--------------+------------+----------+
| name            | votes | total_movies | avg_rating | act_rank |
+-----------------+-------+--------------+------------+----------+
| Sangeetha Bhat  |  1010 |            1 |        9.6 |        1 |
| Fatmire Sahiti  |  3932 |            1 |        9.4 |        2 |
| Adriana Matoshi |  3932 |            1 |        9.4 |        2 |
+-----------------+-------+--------------+------------+----------+
3 rows in set (0.02 sec)






/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
WITH ctf_date_summary AS
    -> (
    -> SELECT d.name_id,
    -> NAME,
    -> d.movie_id,
    -> duration,
    -> r.avg_rating,
    -> total_votes,
    -> m.date_published,
    -> Lead(date_published,1) OVER(PARTITION BY d.name_id ORDER BY date_published,movie_id ) AS next_date_published
    -> FROM director_mapping AS d
    -> INNER JOIN names AS n ON n.id = d.name_id
    -> INNER JOIN movie AS m ON m.id = d.movie_id
    -> INNER JOIN ratings AS r ON r.movie_id = m.id ),
    -> top_director_summary AS
    -> (
    -> SELECT *,
    -> Datediff(next_date_published, date_published) AS date_difference
    -> FROM ctf_date_summary
    -> )
    -> SELECT name_id AS director_id,
    -> NAME AS d_name,
    -> COUNT(movie_id) AS total_movies,
    -> ROUND(AVG(date_difference),2) AS avg_inter_days,
    -> ROUND(AVG(avg_rating),2) AS average_rating,
    -> SUM(total_votes) AS votes,
    -> MIN(avg_rating) AS minimum_rating,
    -> MAX(avg_rating) AS maximum_rating,
    -> SUM(duration) AS total_duration
    -> FROM top_director_summary
    -> GROUP BY director_id
    -> ORDER BY COUNT(movie_id) DESC
    -> limit 9;
+-------------+-------------------+--------------+----------------+----------------+--------+----------------+----------------+----------------+
| director_id | d_name            | total_movies | avg_inter_days | average_rating | votes  | minimum_rating | maximum_rating | total_duration |
+-------------+-------------------+--------------+----------------+----------------+--------+----------------+----------------+----------------+
| nm2096009   | Andrew Jones      |            5 |         190.75 |           3.02 |   1989 |            2.7 |            3.2 |            432 |
| nm1777967   | A.L. Vijay        |            5 |         176.75 |           5.42 |   1754 |            3.7 |            6.9 |            613 |
| nm0814469   | Sion Sono         |            4 |         331.00 |           6.03 |   2972 |            5.4 |            6.4 |            502 |
| nm0831321   | Chris Stokes      |            4 |         198.33 |           4.33 |   3664 |            4.0 |            4.6 |            352 |
| nm0515005   | Sam Liu           |            4 |         260.33 |           6.23 |  28557 |            5.8 |            6.7 |            312 |
| nm0001752   | Steven Soderbergh |            4 |         254.33 |           6.48 | 171684 |            6.2 |            7.0 |            401 |
| nm0425364   | Jesse V. Johnson  |            4 |         299.00 |           5.45 |  14778 |            4.2 |            6.5 |            383 |
| nm2691863   | Justin Price      |            4 |         315.00 |           4.50 |   5343 |            3.0 |            5.8 |            346 |
| nm6356309   | ├ûzg├╝r Bakar     |            4 |         112.00 |           3.75 |   1092 |            3.1 |            4.9 |            374 |
+-------------+-------------------+--------------+----------------+----------------+--------+----------------+----------------+----------------+
9 rows in set (0.04 sec)






