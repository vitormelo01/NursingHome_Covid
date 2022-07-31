cd "C:\Users\vmelo\OneDrive\Research_Resources\Covid_NursingHomes\Data"

* -----------------------------------------------------------------------------*
* Working with the data from address matching
clear
insheet using "merged_data_2020.csv"

*Renaming and droping string provider numbers 
drop if v1 == "federalprovidernumber"
rename v1 providernumber 
rename v2 placekey

*Destringgin provier number variable
drop if real(providernumber)==.
destring providernumber, replace
save address_patterns_data, replace

unique providernumber 

duplicates drop providernumber, force
save address_patterns_data_unique, replace

* -----------------------------------------------------------------------------*
* Working with Placekey data 
clear
insheet using "PlaceKey_NH_ProviderInfo_Aug2020.csv"

*Renaming provider number
rename federalprovidernumber providernumber

* destringgin provider number
drop if real(providernumber)==.
destring providernumber, replace
save placekey_patterns_data, replace

* -----------------------------------------------------------------------------*
* Merging the two datasets
merge 1:1 providernumber using address_patterns_data_unique.dta
order generated_placekey placekey providernumber

* Generating combined placekey 
gen combined_placekey = "."
replace combined_placekey = generated_placekey if generated_placekey != "nan"

order combined_placekey

replace combined_placekey = placekey if generated_placekey == "nan"

count if combined_placekey == ""
drop generated_place
drop placekey
rename combined_placekey placekey

save combined_placekey, replace


*ssc install unique
unique providernumber 
