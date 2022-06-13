* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

clear
use covid_nursinghomes_complete.dta 

gen weekly_excess_deaths = (residentsweeklyalldeaths - residentsweeklycovid19deaths)/totalnumberofoccupiedbeds*1000

*drop if date > 22584
gen own = 1 
replace own = 2 if nonprofit == 1
drop if gov == 1

drop if date == 22059

********************* Graph for weekly cases************************************
********************************************************************************

collapse (mean) weeklycases_perthousand weeklydeaths_perthousand weekly_excess_deaths, by(own date)
keep weeklycases_perthousand own date
reshape wide weeklycases_perthousand, i(date) j(own)
gen diff = weeklycases_perthousand1 -  weeklycases_perthousand2


* Two trends
graph twoway line weeklycases_perthousand* date


* Differences
graph twoway line diff date
binscatter diff date, ytitle("Differences in Covid-19 Cases") xtitle("Time") nquantiles(47)

help binscatter 

********************* Graph for weekly Covid deaths************************************
********************************************************************************

collapse (mean) weeklycases_perthousand weeklydeaths_perthousand weekly_excess_deaths, by(own date)
keep weeklydeaths_perthousand own date
reshape wide weeklydeaths_perthousand, i(date) j(own)
gen diff = weeklydeaths_perthousand1 -  weeklydeaths_perthousand2

* Two trends
graph twoway line weeklydeaths_perthousand* date


* Differences

graph twoway line diff date
binscatter diff date, ytitle("Differences in Covid-19 Deaths") xtitle("Time") nquantiles(47)

********************* Graph for excess deaths************************************
********************************************************************************

* Two trends
collapse (mean) weeklycases_perthousand weeklydeaths_perthousand weekly_excess_deaths, by(own date)
keep weekly_excess_deaths own date
reshape wide weekly_excess_deaths, i(date) j(own)
gen diff2 = weekly_excess_deaths1 -  weekly_excess_deaths2

graph twoway line weekly_excess_deaths* date
* Differences

graph twoway line diff2 date

*ssc install binscatter
binscatter diff2 date, yscale(r(0 -3)) ytitle("Differences in Non-Covid Deaths") xtitle("Time") nquantiles(47)

********************* Graph for total deaths************************************
********************************************************************************


* Two trends
collapse (mean) residentsweeklyalldeaths, by(own date)
reshape wide residentsweeklyalldeaths, i(date) j(own)
gen diff2 = residentsweeklyalldeaths1 -  residentsweeklyalldeaths2

graph twoway line residentsweeklyalldeaths* date
* Differences

graph twoway line diff2 date

*ssc install binscatter
binscatter diff2 date, yscale(r(0 )) ytitle("Differences in Total Deaths") xtitle("Time") nquantiles(47)