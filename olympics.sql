create database olympic_games;
use olympic_games;
select * from athlete_events where 3=2;
select * from athlete_events;
select count(*) from athlete_events;
select distinct(Medal) from athlete_events;
select distinct(Team) from athlete_events;
select count(distinct(NOC)),year from athlete_events where year='1896';
select NOC from athlete_events where Team='India';
select count(*) from noc_regions;
select * from noc_regions;
select distinct region from noc_regions;
# Which year was the first olympics games held?
select min(Year) as olympics_year from athlete_events;
#How many olympics games have been held?
select distinct Games from athlete_events;
select count(distinct Year) from athlete_events;
#List down all Olympics games held so far.
select distinct(Games),Year from athlete_events order by Games;
select distinct(Year) from athlete_events order by Year;
#Mention the total no of nations who participated in each olympics game?
select count(distinct noc_regions.region) as total_nations,athlete_events.Games from athlete_events join noc_regions on athlete_events.NOC=noc_regions.NOC group by athlete_events.Games order by total_nations;
select Year,count(distinct NOC) as total_nations from athlete_events where Season='Summer' group by Year order by Year desc;
#Which year saw the highest and lowest no of countries participating in olympics?
#highest
select athlete_events.Year,count(distinct noc_regions.region) as number_of_nations from athlete_events join noc_regions on athlete_events.NOC = noc_regions.NOC group by athlete_events.Year order by number_of_nations desc limit 1;
select Year,count(distinct NOC) as total_nations from athlete_events group by Year order by total_nations desc limit 1;
#lowest
select athlete_events.Year,count(distinct noc_regions.region) as number_of_nations from athlete_events join noc_regions on athlete_events.NOC = noc_regions.NOC group by athlete_events.Year order by number_of_nations limit 1;
select Year,count(distinct NOC) as total_nations from athlete_events group by Year order by total_nations  limit 1;
#highest and lowest
(select Year,count(distinct NOC) as total_nations from athlete_events group by Year order by total_nations desc limit 1) union all
(select Year,count(distinct NOC) as total_nations from athlete_events group by Year order by total_nations  limit 1);
select Year, total_number_countries from (
    select Year, count(distinct NOC) as total_number_countries from athlete_events
    group by Year
) as subquery where total_number_countries = (
        select max(total_number_countries) from (
            select count(distinct NOC) as total_number_countries from athlete_events group by Year
        ) as max_subquery)
   or total_number_countries = (select min(total_number_countries)
        from (
            select count(distinct NOC) as total_number_countries from athlete_events group by Year
        ) AS min_subquery);
select Year, NOC from athlete_events where NOC='ITA' group by Year,NOC order by Year;
select * from athlete_events where NOC='ITA' and Year =1896;
#Which nation has participated in all of the olympic games?
select NOC from athlete_events where Season='Summer' group by NOC having count(distinct Year)=
(select count(distinct Year) from athlete_events where Season='Summer');
#Identify the sport which was played in all summer olympics.
select distinct(Sport) from athlete_events where Season='Summer' group by Sport having count(distinct Year)=
(select count(distinct Year) from athlete_events where Season='Summer'); 
#Which Sports were just played only once in the olympics?
select distinct(Sport) from athlete_events where Season='Summer' group by Sport having count(distinct Year)=1;
select distinct(Sport) from athlete_events group by Sport having count(distinct Year)=1;
#Fetch the total no of sports played in each olympic games.
select count(distinct Sport),Year from athlete_events group by Year order by Year desc;
select count(distinct Sport),Year from athlete_events where Season='Summer' group by Year order by Year desc;
#Fetch details of the oldest athletes to win a gold medal.
select Name,Age,Team,Year,Sport,Event from athlete_events where Age=( select max(Age)from athlete_events where Medal='Gold')and Medal='Gold';
#Find the Ratio of male and female athletes participated in all olympic games.
select Sex,count(*) as total_athletes from athlete_events group by Sex;
#M/F=187037/73934=2.529
#Fetch the top 5 athletes who have won the most gold medals.
select Name,count(Medal) as gold_medals from athlete_events where Medal='Gold' group by name order by gold_medals desc limit 5;
#Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
select Name,count(Medal) as medals from athlete_events where Medal in ('Gold','Silver','Bronze') group by name order by medals desc limit 5;
#Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select NOC,count(Medal) as medals from athlete_events where Medal in ('Gold','Silver','Bronze') group by NOC order by medals desc limit 5;
#List down total gold, silver and bronze medals won by each country.
select NOC,sum(case when Medal = 'Gold' then 1 else 0 end) as Gold,sum(case when Medal = 'Silver' then 1 else 0 end) as Silver,sum(case when Medal = 'Bronze' then 1 else 0 end) as Bronze from athlete_events where Medal in ('Gold', 'Silver', 'Bronze') group by NOC order by Gold desc,Silver desc,Bronze desc;
#List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
select NOC,Year,sum(case when Medal = 'Gold' then 1 else 0 end) as Gold,sum(case when Medal = 'Silver' then 1 else 0 end) as Silver,sum(case when Medal = 'Bronze' then 1 else 0 end) as Bronze from athlete_events where Medal in ('Gold', 'Silver', 'Bronze') group by Year,NOC order by Year,NOC;
#Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
#Max Gold
select total_medal.Year, max(count_Medal) as max_gold, total_medal.NOC
from (select Year, NOC, count(Medal) as count_Medal from athlete_events
where Medal ='Gold'
 group by Year, NOC 
) as total_medal
group by total_medal.Year,total_medal.NOC 
order by max(count_Medal)desc;
#Max Silver
select total_medal.Year, max(count_Medal) as max_gold, total_medal.NOC
from (select Year, NOC, count(Medal) as count_Medal from athlete_events
where Medal ='Silver'
 group by Year, NOC 
) as total_medal
group by total_medal.Year,total_medal.NOC 
order by max(count_Medal)desc;
#Max Bronze
select total_medal.Year, max(count_Medal) as max_gold, total_medal.NOC
from (select Year, NOC, count(Medal) as count_Medal from athlete_events
where Medal ='Bronze'
 group by Year, NOC 
) as total_medal
group by total_medal.Year,total_medal.NOC 
order by max(count_Medal)desc;
#Which countries have never won gold medal but have won silver/bronze medals?
#method 1
select distinct NOC
from athlete_events
where Medal in('Silver','Bronze') and NOC not in (select distinct NOC from athlete_events where Medal ='Gold')
group by NOC;
#method 2
select distinct NOC from athlete_events where medal in ('Silver', 'Bronze') 
and not exists(select 1 
    from athlete_events as a2 
    where a2.NOC = athlete_events.NOC 
    and a2.Medal = 'Gold');
#In which Sport/event, India has won highest medals.
select Sport,count(Medal) as medals from athlete_events where NOC='IND' group by Sport order by medals desc limit 1;
#Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
select Year,count(Medal) as medals from athlete_events where NOC = 'IND' and Sport = 'Hockey' and Medal is not null group by Year order by medals DESC;