* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

clear
use covid_nursinghomes_complete.dta 

gen weekly_excess_deaths = (residentsweeklyalldeaths - residentsweeklycovid19deaths)/totalnumberofoccupiedbeds*1000


gen own = 1 
replace own = 2 if nonprofit == 1
drop if gov == 1

drop if date == 22059

collapse (mean) weeklycases_perthousand weeklydeaths_perthousand weekly_excess_deaths, by(own date)

keep weekly_excess_deaths own date

reshape wide weekly_excess_deaths, i(date) j(own)
graph twoway line weekly_excess_deaths* date



gen diff = weekly_excess_deaths2 -  weekly_excess_deaths1
gen zeros = 0
graph twoway line diff zeros date

*graph twoway line cases_perthousand date, sort lpattern(dash solid dot)
