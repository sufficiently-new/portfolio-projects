

select * from portifolioproject..CovidDeaths$

--order by 3,4
--select * from portifolioproject..CovidVaccinations$
--order by 3,4

--select  location,date,total_cases,new_cases,total_deaths,population from portifolioproject..CovidDeaths$
--order by 1,2

--					--looking at total_cases vs total_deaths
--					-- shows the likelihood of dying if you contact covid in your country
----select  location,date,total_cases,total_deaths,(total_deaths/total_cases)* 100 as deathpercentage from portifolioproject..CovidDeaths$
----where  location like '%states'
----order by 1,2
--					-- looking at the total_cases vs population
--					-- shows what  percantage of population has goten covid
--select  location,date,population, total_cases,(total_cases/population)* 100 as populationpercentage from portifolioproject..CovidDeaths$
--where  location like '%states'
--order by 1,2

				-- looking at countries with the highest infection rate compared to population


--select  location,population, max(total_cases) as highestinfectioncount,max((total_cases/population))* 100 as percentagepopulationinfected from portifolioproject..CovidDeaths$
--group by location, population
--order by percentagepopulationinfected desc

				-- showing the highest deathcount per population


--select location, max(cast(total_deaths as int)) as totaldeathcount from portifolioproject..CovidDeaths$
--where continent is  null
----where location like'%states%'
--group by  location
--order by totaldeathcount desc

					--showing che continent with the highest deathcount per population


--select continent, max(cast(total_deaths as int)) as totaldeathcount from portifolioproject..CovidDeaths$
--where continent is not  null
--where location like'%states%'
--group by continent
--order by totaldeathcount desc

				-- global numbers


--select  sum(new_cases) as total_cases,sum(cast(new_deaths as int))as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)
--* 100 as deathpercentage from portifolioproject..CovidDeaths$
----where  location like '%states'
--where continent is not null
----group by date
--order by 1,2
						--total population vs vaccinations

--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,sum(cast (vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location , dea. date)
--as  rollingpeoplevaccinated
----,(rollingpeoplevaccinated/population) * 100
--from portifolioproject..CovidDeaths$ dea
--join portifolioproject..CovidVaccinations$ vac
--on dea.location =vac.location
--and dea.date =vac.date
--where dea.continent is not null
--order by 2,3
		--with CTE 
--with popvsvac( continent,location,date,population,new_vaccinations,rollingpeoplevaccinated)
--as (select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,sum(cast (vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location , dea. date)
--as  rollingpeoplevaccinated
----,(rollingpeoplevaccinated/population) * 100
--from portifolioproject..CovidDeaths$ dea
--join portifolioproject..CovidVaccinations$ vac
--on dea.location =vac.location
--and dea.date =vac.date
--where dea.continent is not null
----order by 2,3
--)
--select* ,(rollingpeoplevaccinated/population)*100 from popvsvac

			--TEMP TABLE
--			drop table if exists #percentpopulationvaccinated
--create table #percentpopulationvaccinated
--(continent nvarchar (255),
--lovation nvarchar(255),
--date datetime,
--population numeric,
--new_vaccinations numeric,
--rollingpeoplevaccinated numeric)

--insert into #percentpopulationvaccinated
--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,sum(cast (vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location , dea. date)
--as  rollingpeoplevaccinated
----,(rollingpeoplevaccinated/population) * 100
--from portifolioproject..CovidDeaths$ dea
--join portifolioproject..CovidVaccinations$ vac
--on dea.location =vac.location
--and dea.date =vac.date
----where dea.continent is not null
----order by 2,3
--select* ,(rollingpeoplevaccinated/population)*100 from #percentpopulationvaccinated
		--creating view to store data for later visualizations
--create view percentpopulationvaccinated as
--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,sum(cast (vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location , dea. date)
--as  rollingpeoplevaccinated
----,(rollingpeoplevaccinated/population) * 100
--from portifolioproject..CovidDeaths$ dea
--join portifolioproject..CovidVaccinations$ vac
--on dea.location =vac.location
--and dea.date =vac.date
--where dea.continent is not null
----order by 2,3

select * from percentpopulationvaccinated