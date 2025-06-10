-- Importing large data more than lakhs of rows
use wakad35;

-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table
select * from athletes;

-- Location to add the csv
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile '"C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/Athletes_Cleaned.csv" ' -- 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

-- Check number of rows in the table
select count(*) from athletes;


-- view the athletes table
show tables;

/* SQL Olymics project */

-- Q1. Show how many medal counts present for entire data.

select count(medal) as medalcount from athletes
where medal <> "Nomedal"; -- where medal in ("gold", "silver", "bronze")

-- Q2. Show count of unique Sports are present in olympics.
select count(distinct(sport)) from athletes;

-- Q3. Show how many different medals won by Team India in data.

select count(medal) as medalcount from athletes
where team = "india" and medal <> "nomedal";



/* Q4. Show event wise medals won by india show from highest to 
lowest medals won in order. */
select * from athletes;
select event, count(medal) as medalcount from athletes
where medal <> "nomedal" and team = "india"
group by event
order by medalcount desc;

-- Q5. Show event and yearwise medals won by india in order of year.

select event, year, count(medal) as medalcount from athletes
where medal <> "nomedal" and team = "india"
group by event, year
order by year;

-- Q6. Show the country with maximum medals won gold, silver, bronze

select noc, count(medal) as medalcount from athletes
where medal in ("gold", "silver", "bronze")
group by noc
order by medalcount desc
limit 1;

-- Q7. Show the top 10 countries with respect to gold medals

select noc,count(medal) as medalcount from athletes
where medal = "gold"
group by noc
order by medalcount desc
limit 10;


-- Q8. Show in which year did United States won most medals

select year,count(medal) as medalcount from athletes
where medal <> "nomedal" and noc = "USA"
group by year
order by medalcount desc
limit 1;

-- Q9. In which sports United States has most medals

select sport,count(medal) as medalcount from athletes
where team = "united states" and medal <> "nomedal"
group by sport
order by medalcount desc
limit 1;

-- Q10. Find top 3 players who have won most medals along with their sports and country

select name,sport,noc, count(medal) as medalcount from athletes
where medal <> "nomedal"
group by name, sport, noc
order by medalcount desc
limit 3;

-- Q11. Find player with most gold medals in cycling along with his country.

select name,  noc, count(medal) as medalcount from athletes
where medal = "gold" and sport = "cycling"
group by name, noc
order by medalcount desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.

select name,sport,noc, count(medal) as medalcount from athletes
where medal in ("gold", "silver", "bronze") and sport = "basketball" 
group by name, sport, noc
order by medalcount desc
limit 1;

-- Q13. Find out the count of different medals of the top basketball player.

select name,sport,medal,count(medal) as medalcount from athletes
where medal <> "nomedal" and name = "Teresa Edwards" and sport="basketball"
group by name,sport,medal;

-- Q14. Find out medals won by male, female each year.

select sex,year,count(medal) as medalcount from athletes
where medal <> "nomedal"
group by sex,year
order by year;