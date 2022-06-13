* Ownership and quality cleaning

cd "C:\Users\vitor\OneDrive\Research_Resources\Covid_NursingHomes\Data"

* Reshaping and saving covid cases data
clear

foreach i in "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" {
    clear
	insheet using "NH_ProviderInfo_`i'2020.csv"
	gen year = 2020
	gen month = "`i'"
	
	rename provnum federalprovidernumber
rename provname providername
rename ownership ownershiptype
rename overall_rating overallrating
rename quality_rating qmrating
rename adj_rn adjustedrnstaffinghoursperreside
rename adj_total adjustedtotalnursestaffinghoursp

rename zip providerzipcode
	
	
	
	save NH_Provider`i'2020, replace
	
}






foreach i in "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" {
    clear
	insheet using "NH_ProviderInfo_`i'2021.csv"
	gen year = 2021
	gen month = "`i'"
	save NH_Provider`i'2021, replace
	
}

foreach i in "Jan" "Feb"  {
    clear
	insheet using "NH_ProviderInfo_`i'2022.csv"
	gen year = 2022
	gen month = "`i'"
	save NH_Provider`i'2022, replace
	
}


* inputing data from Nov  to month of December because CMS does not share these data for the month of december in 2020 and 2021
clear 
use NH_ProviderNov2020.dta
replace month = "Dec"
save NH_ProviderDec2020.dta

clear 
use NH_ProviderNov2021.dta
replace month = "Dec"
save NH_ProviderDec2021.dta


* Appending everything
clear
use NH_ProviderFeb2022.dta
append using NH_ProviderJan2022.dta
foreach i in "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec" {

	append using "NH_Provider`i'2021.dta"
}

foreach i in "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec" {

	append using "NH_Provider`i'2020.dta"
}

drop if missing(real(federalprovidernumber))
destring federalprovidernumber, replace

rename month month_string
gen month = 1
replace month = 2 if month_string == "Feb"
replace month = 3 if month_string == "Mar"
replace month = 4 if month_string == "Apr"
replace month = 5 if month_string == "May"
replace month = 6 if month_string == "Jun"
replace month = 7 if month_string == "Jul"
replace month = 8 if month_string == "Aug"
replace month = 9 if month_string == "Sep"
replace month = 10 if month_string == "Oct"
replace month = 11 if month_string == "Nov"
replace month = 12 if month_string == "Dec"

gen date = mdy(month, 1, year)
gen weekly_date = week(date)
gen monthly_date = month(date)

gen date_weeks = .
replace date_weeks = weekly_date + 3119 if year==2020
replace date_weeks = weekly_date + 3171 if year==2021
replace date_weeks = weekly_date + 3223 if year==2022
format date_weeks %tw


* Keep only variables that matter
keep federalprovidernumber ownershiptype overallrating qmrating providerzipcode date_weeks adjustedrnstaffinghoursperreside adjustedtotalnursestaffinghoursp averagenumberofresidentsperday

save ownership_quality_cleaned, replace

clear 
use ownership_quality_cleaned.dta
