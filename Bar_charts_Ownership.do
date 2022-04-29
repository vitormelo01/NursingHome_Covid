
* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

clear
use covid_nursinghomes_complete.dta 


keep if date == 22647 
gen ones = 1

collapse (sum) ones, by(ownershiptype)

label variable ones "Number of Firms"



*outsheet using ownership_twelve.csv

* Creating ownership by for profit vs non profit vs gov
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

gen own = 1 
replace own = 2 if nonprofit == 1
replace own = 3 if gov == 1

gen inutil = 10000 - ones 
sort own inutil

graph bar ones, over(ownershiptype)









collapse (sum) ones, by(own)

outsheet using ownership_three.csv



