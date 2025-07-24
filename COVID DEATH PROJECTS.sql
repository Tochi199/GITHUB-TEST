-- Selecting data we are going to use 

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covidproject.`coviddeaths 1`
order by 1,2; 

-- Looking at the total cases vs total deaths (where clause to show likelihood of dying in your country)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_percentage
FROM covidproject.`coviddeaths 1`
WHERE location like '%states%'
ORDER BY 1,2;

-- Looking at total cases vs population (showing what percentage of population that got covid
SELECT location, date, total_cases, population, (total_cases/population) * 100 as Percentage_population_infected
FROM covidproject.`coviddeaths 1`
WHERE location like '%hana%'
ORDER BY 1,2;

-- Looking at countries with highest infection rates compared to population
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population)) * 100 as percent_population_infected
FROM covidproject.`coviddeaths 1`
-- WHERE location like '%hana%'
GROUP BY location, population
ORDER BY percent_population_infected DESC;

-- Looking at the countries with highest death count per population
SELECT 
	location, population, 
	MAX(CAST(total_deaths AS UNSIGNED)) AS Highest_Death_Count, 
    MAX(CAST(total_deaths AS UNSIGNED))/population * 100 AS percent_population_death
FROM covidproject.`coviddeaths 1`
-- WHERE location like '%hana%'
GROUP BY location, population
ORDER BY percent_population_death DESC;

-- SHowing the continent with the highest death count
SELECT 
	continent, popul ation, 
	MAX(CAST(total_deaths AS UNSIGNED)) AS Highest_Death_Count, 
    MAX(CAST(total_deaths AS UNSIGNED))/population * 100 AS percent_population_death
FROM covidproject.`coviddeaths 1`
-- WHERE location like '%hana%'
GROUP BY continent, population
ORDER BY Highest_Death_Count DESC;

-- Global numbers
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Death_percentage
FROM covidproject.`coviddeaths 1`
WHERE location like '%states%'
ORDER BY 1,2;
