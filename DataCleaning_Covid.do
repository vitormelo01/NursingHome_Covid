
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











clear
use covid_nursinghomes_complete.dta 




/*

*------------------------------------------------------------------------------
* Effect of CON on how new facility is

* Keeping only one observation per facility 

* Cross sectional on how old facilities are
*keep if date == 22647 
*reg days_since_founded con popestimate2000 

ssc install reghdfe


clear
use covid_nursinghomes_complete.dta 

sort federalprovidernumber date

* deviding data into different covid periods

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

* Since 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395


* droping first week because all previous covid cases were reported on that day.
drop if date == 22059




*Weekly cases per 1000 residents
*reg weeklycases_perthousand forprofit weeks_cases_pcp population PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

*total cases per 1000 residents
reg cases_perthousand forprofit weeks_cases_pcp population PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

*Weekly deaths per 100 residents 
*reg weeklydeaths_perthousand forprofit weeks_cases_pcp population PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

*total Deaths per 1000 residents
reg coviddeaths_perthousand forprofit weeks_cases_pcp population PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

*total excess deaths per 1000 residents
reg excess_deaths forprofit weeks_cases_pcp population PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster fips)






*____________________________________________________________________________________________________________________________________________________

* Vaccination percentage
reg resident_nomedicalcontra_pctvacc forprofit popestimate2000 PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

reg staff_nomedicalcontra_pctvacc forprofit popestimate2000 PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

* Other strategies 
*reg alcoholbasedhandrubabhravailable forprofit popestimate2000 PerCapitaIncome five_star four_star three_star two_star i.date, vce(cluster id)

* alcoholbasedhandrubabhravailable alcoholbasedhandrubabhrnolongera facemasksstrategyforoptimization eyeprotectionstrategyforoptimiza gownsstrategyforoptimization glovesstrategyforoptimization facemasksnolongeravailablein7day eyeprotectionnolongeravailablein gownsnolongeravailablein7days glovesnolongeravailablein7days

*Initial case
*reg initial_case forprofit nonprofit con overallrating i.date i.id, vce(cluster id)

*ocupancy rates
reg  ocupancy nonprofit con overallrating i.date i.id, vce(cluster id)

reg  ocupancy five_star four_star three_star two_star i.date i.id, vce(cluster id)

* con on for profit
reg gov con four_star three_star two_star one_star i.date i.id, vce(cluster id)

reg forprofit con overallrating i.date i.id, vce(cluster id)

save cleaned_covid_data.dta, replace

* effect on quality


*/