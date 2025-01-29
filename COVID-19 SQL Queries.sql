--COVID-19

--TOTAL POPULATION
DROP TABLE IF EXISTS #TempTable
-- temporary table with population per location
CREATE TABLE #TempTable (
    Location VARCHAR(255),
    MaxPopulation BIGINT
)

INSERT INTO #TempTable
SELECT location, MAX(population) 
FROM DAProject..CovidDeaths 
where continent is not null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')
GROUP BY location

SELECT SUM(MaxPopulation) AS Total_Population 
FROM #TempTable

--TOTAL POPULATION Per Country
SELECT DISTINCT population, location
FROM DAProject..CovidDeaths
where continent is not null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')
order by location

--CASES AND DEATHS
--Total Cases and Total Deaths from COVID-19
Select SUM(new_cases) as Total_cases, 
       SUM(cast(new_deaths as int)) as Total_deaths, 
	   SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From DAProject..CovidDeaths
where continent is not null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')

--Death Count per Continent
Select continent, 
       SUM(cast(new_deaths as int)) as TotalDeathCount
From DAProject..CovidDeaths
Where continent is NOT null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')
Group by continent
order by TotalDeathCount desc

--Case Count per Continent
Select continent, 
       SUM(cast(new_cases as int)) as TotalCaseCount
From DAProject..CovidDeaths
Where continent is NOT null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')
Group by continent
order by TotalCaseCount desc

--COVID-19 Infection Count per Countries
Select Location, 
       Population, 
	   max(total_cases) as CaseCount,
	   SUM(cast(new_deaths as int)) as TotalDeathCount,
	   MAX((total_cases/population))*100 as PercentPopulationInfected
From DAProject..CovidDeaths
Where continent is NOT null and 
      location not in ('Africa', 'Asia', 'World', 'Europe', 'European Union', 
	                   'International','North America', 'Oceania', 'South America')
Group by Location, 
         Population
order by CaseCount desc

