--Select *
--From PortfolioProject ..Covid_Death$
--order by 3,4

--Select *
--From PortfolioProject ..Covid_Vaccination$
--order by 3,4

--data to use
--Select location, date, total_cases, new_cases, total_deaths, population
--From PortfolioProject ..Covid_Death$
--order by 1,2

--Looking at total cases vs Total Deaths

--Select location, date, total_cases, total_deaths, (Cast (total_deaths as float) / cast (total_cases as float) * 100) as deathpercentage
--From PortfolioProject ..Covid_Death$
--order by 1,2

 --Looking at Highest Infection Rate compared to Population

-- Select location, population, MAX (total_cases) as HighestInfectionCount, (Cast (total_deaths as float) / cast (total_cases as float) * 100) as PercentagePopulationInfected
--From PortfolioProject..Covid_Death$
--Group by population, location, total_cases, total_deaths
--order by PercentagePopulationInfected desc

--Showing continent with Highest Death Count Per Population

--Select continent,  MAX (cast (total_deaths as int)) as TotalDeathCount
--From PortfolioProject..Covid_Death$
--Where continent is not Null
--Group by continent
--order by TotalDeathCount desc

----Global Numbers

--Select SUM(cast(new_cases as int)) as total_cases, SUM(Cast(new_deaths as float)) as total_deaths, 
--SUM(Cast(new_deaths as float) as total_sum) / SUM(cast (new_cases as int)) * 100) as deathpercentage
--From PortfolioProject..Covid_Death$
--Where continent is not Null
--Group by total_cases,  total_deaths
--order by 1,2

--SELECT
--    SUM(CAST(new_cases AS INT)) AS total_cases,
--    SUM(CAST(new_deaths AS FLOAT)) AS total_deaths,
--    CASE
--        WHEN SUM(CAST(new_cases AS INT)) > 0 THEN
--            (SUM(CAST(new_deaths AS FLOAT)) / SUM(CAST(new_cases AS INT))) * 100
--        ELSE
--            NULL
--    END AS death_percentage
--FROM PortfolioProject..Covid_Death$
--WHERE continent IS NOT NULL
--GROUP BY total_cases, total_deaths
--ORDER BY
--    1, 2;


--Looking at Total Population Vs Vaccinations

--SELECT
--    dea.continent,
--    dea.location,
--    dea.date,
--    dea.population,
--    Vac.new_vaccinations,
--    SUM(CONVERT(float, Vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--FROM PortfolioProject..Covid_Death$ dea
--JOIN PortfolioProject..Covid_Vaccination$ Vac ON dea.location = Vac.location AND dea.date = Vac.date
--WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3;

--NOW USE CTE
--With PopvsVac (Continent, Location, date, population, new_vaccinantions, RollingpeopleVaccinated)
--as
--(
--SELECT
--    dea.continent,
--    dea.location,
--    dea.date,
--    dea.population,
--    Vac.new_vaccinations,
--    SUM(CONVERT(float, Vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--FROM PortfolioProject..Covid_Death$ dea
--JOIN PortfolioProject..Covid_Vaccination$ Vac ON dea.location = Vac.location AND dea.date = Vac.date
--WHERE dea.continent IS NOT NULL
----ORDER BY 2, 3;
--)
--Select * , (RollingPeopleVaccinated / population)*100
--From PopvsVac

--TEMP TABLE
--Drop Table if exists #PercentpopulationVaccinated;
--Create Table #PercentpopulationVaccinated
--(
-- continent nvarchar(255),
-- location nvarchar(255),
-- date datetime,
-- population numeric,
-- new_vaccinations float,
-- RollingPeopleVaccinated numeric
-- )
-- Insert into #PercentpopulationVaccinated
--SELECT
--    dea.continent,
--    dea.location,
--    dea.date,
--    dea.population,
--    Vac.new_vaccinations,
--    SUM(CONVERT(float, Vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--FROM PortfolioProject..Covid_Death$ dea
--JOIN PortfolioProject..Covid_Vaccination$ Vac ON dea.location = Vac.location AND dea.date = Vac.date
--WHERE dea.continent IS NOT NULL
----ORDER BY 2, 3;

--Select * , (RollingPeopleVaccinated / population)*100
--From #PercentpopulationVaccinated

/*Create View to store data for later Visualizations*/

--Create View PercentpopulationVaccinated as
--SELECT
--    dea.continent,
--    dea.location,
--    dea.date,
--    dea.population,
--    Vac.new_vaccinations,
--    SUM(CONVERT(float, Vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--FROM PortfolioProject..Covid_Death$ dea
--JOIN PortfolioProject..Covid_Vaccination$ Vac ON dea.location = Vac.location AND dea.date = Vac.date
--WHERE dea.continent IS NOT NULL
----ORDER BY 2, 3;
