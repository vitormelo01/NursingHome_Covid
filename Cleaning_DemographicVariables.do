cd "C:\Users\vitor\OneDrive\Research_Resources\Covid_NursingHomes\Data"

* coverting demographic variables  csv files into dta files.
clear
insheet using "unemployment_data.csv"
save unemployment_data, replace

clear
insheet using "education_data.csv"
save education_data, replace

clear
insheet using "GDP_data.csv"
save GDP_data, replace

clear
insheet using "poverty_data.csv"
save poverty_data, replace

clear
insheet using "population_data.csv"
save population_data, replace

* Merging all demographic variables at county level

clear
use unemployment_data.dta
merge 1:1 fips using education_data.dta
drop _merge

merge 1:1 fips using poverty_data.dta
drop if _merge == 1
drop _merge

merge 1:1 fips using population_data.dta
drop if _merge == 2
drop _merge

rename metro_2013 urban
drop if urban == .

drop state
drop areaname

save DemographicData_Complete, replace






