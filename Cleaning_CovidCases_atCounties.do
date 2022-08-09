cd "C:\Users\vitor\OneDrive\Research_Resources\Covid_NursingHomes\Data"

* Reshaping and saving covid cases data
clear
insheet using "covid_confirmed_usafacts.csv"
save covid_county.dta, replace

clear
use covid_county.dta

drop if countyfips == 0
reshape long v, i(countyfips) j(year, string)

rename countyfips fips
destring year, replace force
sort fips year
rename v total_cases


save covid_county_long.dta, replace

* Reshaping and saving covid deaths data
clear
insheet using "covid_deaths_usafacts.csv"

drop if countyfips == 0
reshape long v, i(countyfips) j(year, string)

rename countyfips fips
destring year, replace force
sort fips year

rename v total_covid_deaths

save covid_deaths_county.dta, replace

* Save population datasets
clear 
insheet using "covid_county_population_usafacts.csv"


drop if countyFIPS == 0

rename countyFIPS fips

save covid_county_population

* Merge both datasets on county covid and population

clear
use covid_deaths_county.dta


merge 1:1 fips year using covid_county_long.dta
drop _merge

merge m:m fips using covid_county_population.dta, force
drop if _merge==2
drop _merge

* Generating total covid vars per 1000 residents
gen county_cases_pcp = total_cases/population*1000
gen county_coviddeaths_pcp = total_covid_deaths/population*1000

save combined_countycovid, replace

* Keeping only relvant data for study
clear
use combined_countycovid
*drop if year < 121

* Generating weekly covid deaths and cases per 1000 residents
gen weeks_cases = total_cases - total_cases[_n-7]
gen weeks_covid_deaths = total_covid_deaths - total_covid_deaths[_n-7]

gen weeks_cases_pcp = weeks_cases/population*1000
gen weeks_covid_deaths_pcp = weeks_covid_deaths/population*1000

save countycovid_complete, replace


* Get data into monthly format
rename year date2
gen date = date2 + 21931
gen date3 = date
format date3 %d
rename date3 date_formated
generate m=month(date_formated) 
generate d=day(date_formated) 
generate y=year(date_formated) 

* creating covid cases this month
keep if d == 1 
gen monthly_county_cases = total_cases[_n+1] - total_cases if fips == fips[_n+1]
gen monthly_county_deaths = total_covid_deaths[_n+1] - total_covid_deaths if fips == fips[_n+1]

save monthly_countycovid













