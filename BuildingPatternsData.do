cd "C:\Users\vitor\OneDrive\Research_Resources\Covid_NursingHomes\Data"
* Converting updated safeway data into dta format
clear 
insheet using "safegraph_added.csv"
rename v23 fewer_five
rename v24 five_ten
rename v25 eleven_twenty
rename v26 twentyone_sixty
rename v27 sixtyone_onetwenty
rename v28 onetwentyone_twoforty
rename v29 more_twoforty

save safegraph_added


*Merging provide rnumbers data with safegraph data
clear
use combined_placekey_updated.dta
drop _merge
unique placekey
drop if placekey == ""
duplicates drop placekey, force

merge 1:m placekey using safegraph_added.dta
count if _merge == 2
drop if providernumber == .
drop _merge

sort providernumber d 

save final_placekey, replace


*unique providernumber

* Generating dummies for ownership type
clear
use final_placekey.dta

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

* Creating fips code:

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

* Generating variable with 2019 mean visits for each facility 
gen mean_visits_2019 = .
replace mean_visits_2019 = (raw_visit_counts + raw_visit_counts[_n-1] + raw_visit_counts[_n-2] + raw_visit_counts[_n-3] + raw_visit_counts[_n-4] + raw_visit_counts[_n-5] + raw_visit_counts[_n-6] + raw_visit_counts[_n-7] + raw_visit_counts[_n-8] + raw_visit_counts[_n-9] + raw_visit_counts[_n-10] + raw_visit_counts[_n-11])/12
replace mean_visits_2019 = . if y != 2019
replace mean_visits_2019 = . if m != 12
replace mean_visits_2019 =  mean_visits_2019[_n-1] if y>2019 & providernumber[_n-1] == providernumber

* Generating variable with 2019 mean visits for each facility 
gen mean_visitor_2019 = .
replace mean_visitor_2019 = (raw_visitor_counts + raw_visitor_counts[_n-1] + raw_visitor_counts[_n-2] + raw_visitor_counts[_n-3] + raw_visitor_counts[_n-4] + raw_visitor_counts[_n-5] + raw_visitor_counts[_n-6] + raw_visitor_counts[_n-7] + raw_visitor_counts[_n-8] + raw_visitor_counts[_n-9] + raw_visitor_counts[_n-10] + raw_visitor_counts[_n-11])/12
replace mean_visitor_2019 = . if y != 2019
replace mean_visitor_2019 = . if m != 12
replace mean_visitor_2019 =  mean_visitor_2019[_n-1] if y>2019 & providernumber[_n-1] == providernumber

* Generating pct change variable
gen visits_PctChange = (raw_visit_counts - mean_visits_2019)/mean_visits_2019*100 
gen visitor_PctChange = (raw_visitor_counts - mean_visitor_2019)/mean_visitor_2019*100 

* Merging with fips code data
rename providerzipcode zip
merge m:m zip using ZIP_CountyFIPs.dta
rename stcountyfp fips
keep if _merge == 3
drop _merge

* merging with demographic variables data
merge m:m fips using DemographicData_Complete.dta
keep if _merge == 3
drop _merge 

* Merging with monthly county covid cases
merge m:1 fips m y using monthly_countycovid.dta


global dem_controls "urban unemp_2020 median_income_2020 pct_lesshighschool pct_bachelors poverty_2020 pop"

* Creating robust_visits - defined as people who visted for more than 10min but less that 4h
gen robust_visits = eleven_twenty + twentyone_sixty + sixtyone_onetwenty + onetwentyone_twoforty
sort providernumber y m 


* Generating variable with 2019 mean robust_visits for each facility 
gen mean_robustvisits_2019 = .
replace mean_robustvisits_2019 = (robust_visits + robust_visits[_n-1] + robust_visits[_n-2] + robust_visits[_n-3] + robust_visits[_n-4] + robust_visits[_n-5] + robust_visits[_n-6] + robust_visits[_n-7] + robust_visits[_n-8] + robust_visits[_n-9] + robust_visits[_n-10] + robust_visits[_n-11])/12
replace mean_robustvisits_2019 = . if y != 2019
replace mean_robustvisits_2019 = . if m != 12
replace mean_robustvisits_2019 =  mean_robustvisits_2019[_n-1] if y>2019 & providernumber[_n-1] == providernumber
gen robustvisits_PctChange = (robust_visits - mean_robustvisits_2019)/mean_robustvisits_2019*100 


* Regression for visitors
preserve
keep if y == 2020
drop if m < 3
sum visitor_PctChange
reg visitor_PctChange forprofit i.d  i.id five_star four_star three_star two_star monthly_county_cases $dem_controls, cluster(id)
restore

* Regression for robust_visitors
preserve
keep if y == 2020
drop if m < 3

sum robustvisits_PctChange
reg robustvisits_PctChange forprofit i.d  i.id five_star four_star three_star two_star monthly_county_cases $dem_controls, cluster(id)
restore


* Saving complete data 
save safegraph_merged, replace













clear
use safegraph_merged.dta

keep if y == 2020

* reg raw_visit_counts forprofit i.d, r










* Collapsing data 

collapse (mean) raw_visitor_counts, by(d forprofit)

sort forprofit d
gen PctChange = .
*replace PctChange = (raw_visit_counts - 319.21)/319.21*100 if forprofit == 0
*replace PctChange = (raw_visit_counts - 262.75)/319.21*100 if forprofit == 1

replace PctChange = (raw_visitor_counts - 93.39)/93.39*100 if forprofit == 0
replace PctChange = (raw_visitor_counts - 79.67)/79.67*100 if forprofit == 1
