
* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

* Creating dta files
clear
insheet using "Population_Counties.csv"
save Population_Counties, replace

clear
insheet using "faclevel_2020.csv"
save faclevel_2020, replace

clear
insheet using "faclevel_2021.csv"
save faclevel_2021, replace

clear
insheet using "faclevel_2022.csv"
save faclevel_2022, replace

append using faclevel_2021.dta 
append using faclevel_2020.dta, force 

destring federalprovidernumber, replace


*gen int week_num = wofd(weekending)
gen week = substr(reportinginterval,6,2)
destring week, replace

sort federalprovidernumber week


* Creating fips code:

rename providerstate state
gen id = .
replace id = 1 if state=="AL"
replace id = 2 if state=="AK"
replace id = 4 if state=="AZ"
replace id = 5 if state=="AR"
replace id = 6 if state=="CA"
replace id = 8 if state=="CO"
replace id = 9 if state=="CT"
replace id = 10 if state=="DE"
replace id = 11 if state=="DC"
replace id = 12 if state=="FL"
replace id = 13 if state=="GA"
replace id = 15 if state=="HI"
replace id = 16 if state=="ID"
replace id = 17 if state=="IL"
replace id = 18 if state=="IN"
replace id = 19 if state=="IA"
replace id = 20 if state=="KS"
replace id = 21 if state=="KY"
replace id = 22 if state=="LA"
replace id = 23 if state=="ME"
replace id = 24 if state=="MD"
replace id = 25 if state=="MA"
replace id = 26 if state=="MI"
replace id = 27 if state=="MN"
replace id = 28 if state=="MS"
replace id = 29 if state=="MO"
replace id = 30 if state=="MT"
replace id = 31 if state=="NE"
replace id = 32 if state=="NV"
replace id = 33 if state=="NH"
replace id = 34 if state=="NJ"
replace id = 35 if state=="NM"
replace id = 36 if state=="NY"
replace id = 37 if state=="NC"
replace id = 38 if state=="ND"
replace id = 39 if state=="OH"
replace id = 40 if state=="OK"
replace id = 41 if state=="OR"
replace id = 42 if state=="PA"
replace id = 44 if state=="RI"
replace id = 45 if state=="SC"
replace id = 46 if state=="SD"
replace id = 47 if state=="TN"
replace id = 48 if state=="TX"
replace id = 49 if state=="UT"
replace id = 50 if state=="VT"
replace id = 51 if state=="VA"
replace id = 53 if state=="WA"
replace id = 54 if state=="WV"
replace id = 55 if state=="WI"
replace id = 56 if state=="WY"


save faclevel_allyears.dta, replace

* merging the con data
/*
clear
insheet using "CON_data.csv"
save CON_data, replace
*/
clear
use faclevel_allyears.dta

merge m:m id using CON_data.dta

save faclevel_allyears.dta, replace



gen mo = substr(weekending,1,2)
gen day = substr(weekending,4,2)
gen year = substr(weekending,7,2)
destring mo, replace
destring day, replace
destring year, replace
replace year = year+2000


gen date = mdy(mo, day, year)

save faclevel_allyears.dta, replace 

* Generating Date (Weekly) variable
clear
use faclevel_allyears.dta

gen weekly_date = week(date)
gen date_weeks = .
replace date_weeks = weekly_date + 3119 if year==2020
replace date_weeks = weekly_date + 3171 if year==2021
replace date_weeks = weekly_date + 3223 if year==2022
format date_weeks %tw


* Creating Ocupancy percentage variable
gen ocup_pct = totalnumberofoccupiedbeds/numberofallbeds*100

drop if missing(real(federalprovidernumber))
destring federalprovidernumber, replace

sort federalprovidernumber date


*collapse (mean) ocup_pct con, by(id)

* Merging with county fips codes data
/*clear
insheet using "ZIP_CountyFIPs.csv"
save ZIP_CountyFIPs, replace */

*clear
*use faclevel_allyears.dta

rename providerzipcode zip

drop _merge
merge m:m zip using ZIP_CountyFIPs.dta
rename stcountyfp fips

save facilities_complete, replace

*clear 
*insheet using "NH_ProviderInfo_Nov2020.csv"
*save quality_data_2020

/*clear
use facilities_complete.dta
drop _merge
merge m:m federalprovidernumber using quality_data_2020.dta
keep if _merge ==3
drop _merge */


* -------------------------------------------------------------------------------------


clear 
use facilities_complete.dta

* Getting total number of resident deaths from covid

*keep if date ==22724

*egen newvar = sum(residentstotalcovid19deaths)


* Keeping only relevant variables
keep federalprovidernumber state residentsweeklyconfirmedcovid19 residentstotalconfirmedcovid19 residentsweeklyalldeaths residentstotalalldeaths residentsweeklycovid19deaths residentstotalcovid19deaths numberofallbeds totalnumberofoccupiedbeds weeklyresidentconfirmedcovid19ca weeklyresidentcovid19deathsper10 totalresidentconfirmedcovid19cas totalresidentcovid19deathsper100 initialconfirmedcovid19casethisw numberofresidentswithanewpositiv fips id date year day mo shortageofnursingstaff shortageofclinicalstaff shortageofaides shortageofotherstaff v142 v163 alcoholbasedhandrubabhravailable alcoholbasedhandrubabhrnolongera facemasksstrategyforoptimization eyeprotectionstrategyforoptimiza gownsstrategyforoptimization glovesstrategyforoptimization facemasksnolongeravailablein7day eyeprotectionnolongeravailablein gownsnolongeravailablein7days glovesnolongeravailablein7days stafftotalconfirmedcovid19 stafftotalcovid19deaths numberofallhealthcarepersonnelel

* reportedlpnstaffinghoursperresid reportedrnstaffinghoursperreside adjustedlpnstaffinghoursperresid adjustedrnstaffinghoursperreside

*Creating clearly formatyted weekes variable
gen weekly_date = week(date)
gen date_weeks = .
replace date_weeks = weekly_date + 3119 if year==2020
replace date_weeks = weekly_date + 3171 if year==2021
replace date_weeks = weekly_date + 3223 if year==2022
format date_weeks %tw

* Dropping observations that do not contain real id provider number
*drop if missing(real(federalprovidernumber))
*destring federalprovidernumber, replace

* Merging with ownership data

merge m:m federalprovidernumber date_weeks using ownership_quality_cleaned.dta

* Dragging data for weeks after it (since onwnership and qualoity and monthly data)

foreach i in "ownershiptype" "overallrating" "qmrating" "adjustedrnstaffinghoursperreside" "adjustedtotalnursestaffinghoursp" {
	
	replace `i' = `i'[_n-1] if missing(`i') & federalprovidernumber == federalprovidernumber[_n-1]
	replace `i' = `i'[_n+1] if missing(`i')
}


* Renaming variables with long names
rename weeklyresidentconfirmedcovid19ca weeklycases_perthousand
rename weeklyresidentcovid19deathsper10 weeklydeaths_perthousand
rename totalresidentconfirmedcovid19cas cases_perthousand
rename totalresidentcovid19deathsper100 coviddeaths_perthousand
rename initialconfirmedcovid19casethisw weekly_initialcase
rename residentstotalalldeaths totaldeaths
rename residentstotalcovid19deaths covid_deaths

rename v142 resident_nomedicalcontra_pctvacc
rename v163 staff_nomedicalcontra_pctvacc





* Generating dummies for ownership type
gen forprofit = 0
replace forprofit = 1 if ownershiptype == "For profit - Corporation"
replace forprofit = 1 if ownershiptype == "For profit - Individual"
replace forprofit = 1 if ownershiptype == "For profit - Partnership"
replace forprofit = 1 if ownershiptype == "For profit - Limited Liability company"

gen nonprofit = 0
replace nonprofit = 1 if ownershiptype == "Non profit - Corporation"
replace nonprofit = 1 if ownershiptype == "Non profit - Other"
replace nonprofit = 1 if ownershiptype == "Non profit - Church related"

gen gov = 0
replace gov = 1 if ownershiptype == "Government - Hospital district"
replace gov = 1 if ownershiptype == "Government - State"
replace gov = 1 if ownershiptype == "Government - City"
replace gov = 1 if ownershiptype == "Government - City/county"
replace gov = 1 if ownershiptype == "Government - County"
replace gov = 1 if ownershiptype == "Government - Federal"


count if gov == 1 
count if nonprofit == 1 
count if forprofit == 1

* Merging with CON data
drop _merge
merge m:m id using CON_data.dta
drop if _merge == 1
drop _merge


* sorting by provider and then date
sort federalprovidernumber date 

* Generating ocupancy variable
gen ocupancy_pct = totalnumberofoccupiedbeds/numberofallbeds*100

* Generating dummies for each overall quality level
gen five_star = 0
replace five_star = 1 if overallrating == 5

gen four_star = 0
replace four_star = 1 if overallrating == 4

gen three_star = 0
replace three_star = 1 if overallrating == 3

gen two_star = 0
replace two_star = 1 if overallrating == 2

gen one_star = 0
replace one_star = 1 if overallrating == 1

* Generating dummies for each QM rating
gen qm_five_star = 0
replace qm_five_star = 1 if qmrating == 5

gen qm_four_star = 0
replace qm_four_star = 1 if qmrating == 4

gen qm_three_star = 0
replace qm_three_star = 1 if qmrating == 3

gen qm_two_star = 0
replace qm_two_star = 1 if qmrating == 2

gen qm_one_star = 0
replace qm_one_star = 1 if qmrating == 1


*generating dummy for initial cases 
gen initial_case = 0
replace initial_case = 1 if weekly_initialcase == "Y"



* Creating first date variable
/*rename datefirstapprovedtoprovidemedica first_date


gen year2 = substr(first_date,1,4)
gen mo2 = substr(first_date,6,2)
gen day2 = substr(first_date,9,2)
destring mo2, replace
destring day2, replace
destring year2, replace

gen first_date_cleaned = mdy(mo2, day2, year2)
gen jan1_2022 = mdy(1, 1, 2022)

*generating cleaned days since being founded
gen days_since_founded = jan1_2022 - first_date_cleaned */

* merging with controls for cross-sectional regressions

rename fips area_fips
merge m:m area_fips using income_pct_counties
keep if _merge==3
drop _merge
rename area_fips fips
destring PerCapitaIncome, replace force

merge m:m fips using Population_Counties.dta, force
keep if _merge==3
drop _merge

sort federalprovidernumber date 


* Generating covid deaths and cases per 1000 full time staff. adjustedtotalnursestaffinghoursp represents the total staff hours per resident in an given week. totalnumberofoccupiedbeds represents the total amount of residents in a given week. thus, the numerator devided by the denominator (before the 40*1000) gives me the amount of cases per staff hour dedicated to a resident. I multiple it by 40*1000 to give me the amount of cases per 1000 full time staff. 
gen staff_covidcases_perthousand = stafftotalconfirmedcovid19/(adjustedtotalnursestaffinghoursp*totalnumberofoccupiedbeds)*40*1000
gen staff_coviddeaths_perthousand = stafftotalcovid19deaths/(adjustedtotalnursestaffinghoursp*totalnumberofoccupiedbeds)*40*1000

* Generating total deaths (including covid) per 1000 residents. 
gen totaldeaths_perthousand = totaldeaths/totalnumberofoccupiedbeds*1000

* Generating non-covid deaths per 1000 residents.
gen excess_deaths = totaldeaths_perthousand - coviddeaths_perthousand

* Ordering import variables
order federalprovidernumber covid_deaths coviddeaths_perthousand totalnumberofoccupiedbeds totaldeaths totaldeaths_perthousand excess_deaths

* Merging with covid county cases
merge m:m fips date  using countycovid_complete
drop if _merge == 2
drop _merge

* Labeling Variables 
label variable cases_perthousand "Cases per 1000 Residents"
label variable coviddeaths_perthousand "Covid-19 Deaths per 1000 Residents"
label variable excess_deaths "Excess Deaths per 1000 Residents"
label variable population "Population"
label variable PerCapitaIncome "Income Per Capita"
label variable five_star "Five Stars"
label variable four_star "Four Stars"
label variable three_star "Three Stars"
label variable two_star "Two Stars"
label variable ocupancy "Occupancy %"
label variable resident_nomedicalcontra_pctvacc "% of Residents Vaccinated"
label variable staff_nomedicalcontra_pctvacc "Pct of Staff Vaccinated"
label variable forprofit "For-Profit"
label variable weeks_cases_pcp "Weekly Cases at County"

* Sorting by provider number and then date
sort federalprovidernumber date

* Creating variable showing if a facility changed status from forprofit to not for profit or vice versa within then sample period. 
gen ownership_changed = .
replace ownership_changed = 1 if forprofit != forprofit[_n-1] & federalprovidernumber == federalprovidernumber[_n-1]
replace ownership_changed = ownership_changed[_n-1] if ownership_changed[_n-1]==1 & federalprovidernumber == federalprovidernumber[_n-1]

* replacing variables equal 1 if later preiods there was a one in facility ownership.
replace ownership_changed = 1 if ownership_changed[_n+1]==1 & federalprovidernumber == federalprovidernumber[_n+1]
forvalues i = 1/150 {
	
	* `i'
	replace ownership_changed = 1 if ownership_changed[_n+1]==1 & federalprovidernumber == federalprovidernumber[_n+1]
	
}
* 
replace ownership_changed = 0 if ownership_changed == .

*replace ownership_changed = ownership_changed[_n-1] 

* Saving data
save covid_nursinghomes_complete, replace


*--------------------------------------------------------------------------------
*Creating data for cross-sectional analysis
*--------------------------------------------------------------------------------

clear
use covid_nursinghomes_complete.dta 

* Keeping relvent dates to create change variable
keep if date == 22059 | date == 22171 | date == 22255 | date == 22395 | date == 22724


* Dropping missing variables ?
drop if date == 22171 & date[_n-1] != 22059
drop if date == 22255 & date[_n-1] != 22171
drop if date == 22395 & date[_n-1] != 22255
drop if date == 22724 & date[_n-1] != 22395 


foreach i in "numberofallbeds" "adjustedtotalnursestaffinghoursp" "adjustedtotalnursestaffinghoursp" {
	
replace `i' = `i'[_n-1] if `i' ==. & date == 22171 & date[_n-1] == 22059 & federalprovidernumber == federalprovidernumber[_n-1]
replace `i' = `i'[_n-1] if `i' ==. & date == 22255 & date[_n-1] == 22171 & federalprovidernumber == federalprovidernumber[_n-1]
replace `i' = `i'[_n-1] if `i' ==. & date == 22395 & date[_n-1] == 22255 & federalprovidernumber == federalprovidernumber[_n-1]
replace `i' = `i'[_n-1] if `i' ==. & date == 22724 & date[_n-1] == 22395 & federalprovidernumber == federalprovidernumber[_n-1]

replace `i' = `i'[_n+1] if `i' ==. & date == 22171 & date[_n+1] == 22255 & federalprovidernumber == federalprovidernumber[_n+1]
replace `i' = `i'[_n+1] if `i' ==. & date == 22255 & date[_n+1] == 22395 & federalprovidernumber == federalprovidernumber[_n+1]
replace `i' = `i'[_n+1] if `i' ==. & date == 22395 & date[_n+1] == 22724 & federalprovidernumber == federalprovidernumber[_n+1]
}

* Generating non-covid deaths data
gen excessdeaths = totaldeaths - covid_deaths

* Generating change in covid cases per capita at county
gen change_countycasespcp = county_cases_pcp - county_cases_pcp[_n-1] if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

* Generating change in dependent variable of interest
gen changeexcessdeaths = (excessdeaths - excessdeaths[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changetotaldeaths_perhundredbeds = (totaldeaths - totaldeaths[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changecoviddeaths_perhundredbeds = (covid_deaths- covid_deaths[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changecovidcases_perhundredbeds = (residentstotalconfirmedcovid19 - residentstotalconfirmedcovid19[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changestaffcases_FTWorkers = (stafftotalconfirmedcovid19- stafftotalconfirmedcovid19[_n-1])/(adjustedtotalnursestaffinghoursp*totalnumberofoccupiedbeds)*40*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changestaffdeaths_FTWorkers = (stafftotalcovid19deaths - stafftotalcovid19deaths[_n-1])/(adjustedtotalnursestaffinghoursp*totalnumberofoccupiedbeds)*40*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changestaffcases_perhundredbeds = (stafftotalconfirmedcovid19 - stafftotalconfirmedcovid19[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

gen changestaffdeaths_perhundredbeds = (stafftotalcovid19deaths - stafftotalcovid19deaths[_n-1])/numberofallbeds*100 if date == 22171 | date == 22255 | date == 22395 | date == 22724 & federalprovidernumber == federalprovidernumber[_n-1]

*checking for negative numbers
count if changetotaldeaths_perhundredbeds<0
count if changecoviddeaths_perhundredbeds<0
count if changecovidcases_perhundredbeds<0
count if changestaffcases_FTWorkers<0
count if changestaffdeaths_FTWorkers<0
count if changestaffcases_perhundredbeds<0
count if changestaffdeaths_perhundredbeds<0

* Saving data for each time period

preserve 
keep if date == 22171
save Sep2020_NB_Data, replace
restore

preserve 
keep if date == 22255
save Dec2020_NB_Data, replace
restore

preserve 
keep if date == 22395
save April2021_NB_Data, replace
restore

preserve 
keep if date == 22724
save March2022_NB_Data, replace
restore



/*
rename totalresidentconfirmedcovid19cas cases_perthousand
rename totalresidentcovid19deathsper100 coviddeaths_perthousand

totalresidentconfirmedcovid19cas
totalresidentcovid19deathsper100

totaldeaths = residents total deaths 

stafftotalconfirmedcovid19
stafftotalcovid19deaths
*/




