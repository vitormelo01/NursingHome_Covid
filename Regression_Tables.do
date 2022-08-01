
* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

************************ CREATING REGRESSION TABLES ************************************
*--------------------------------------------------------------------------------------*

global controls urban unemp_2020 median_income_2020 pct_lesshighschool pct_bachelors poverty_2020 pop

************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Staff Covid-19 Cases per 100 Full Time Staff ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changestaffcases_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using staffcases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changestaffcases_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changestaffcases_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changestaffcases_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons



/*

************************ Staff Covid-19 Deaths per 100 Full Time Staff ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changestaffdeaths_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster id)
outreg2 using staffcases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changestaffdeaths_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changestaffdeaths_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changestaffdeaths_FTWorkers forprofit five_star four_star three_star two_star change_countycasespcp i.id, vce(cluster fips)
outreg2 using staffcases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

*/










**********************************************************************************************************
**************************************** Robustness Checks ***********************************************
**********************************************************************************************************

***** Negative binomial with no fixed effects ****

************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons












***** Poisson  Model ****

************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
poisson changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
poisson changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
poisson changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
poisson changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
poisson changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
poisson changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
poisson changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
poisson changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
poisson changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
poisson changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
poisson changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
poisson changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
poisson changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
poisson changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
poisson changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
poisson changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons





***** OLS  Model ****

************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
reg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
reg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
reg changecovidcases_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg changecoviddeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg changeexcessdeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg changetotaldeaths_perhundredbeds forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons







***** OLS  Model with LOG (deaths + 1) ****

/*
gen log_cases = log(changecovidcases_perhundredbeds + 1)
gen log_coviddeaths = log(changecoviddeaths_perhundredbeds + 1)
gen log_noncovid = log(changeexcessdeaths + 1)
gen log_totaldeaths = log(changetotaldeaths_perhundredbeds + 1) */

************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg log_cases forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
reg log_cases forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
reg log_cases forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
reg log_cases forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg log_coviddeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg log_coviddeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg log_coviddeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg log_coviddeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg log_noncovid forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg log_noncovid forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg log_noncovid forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg log_noncovid forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
reg log_totaldeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
reg log_totaldeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
reg log_totaldeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
reg log_totaldeaths forprofit five_star four_star three_star two_star change_countycasespcp $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons
















/*


clear
use covid_nursinghomes_complete.dta 
keep if date == 22171

reg excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp i.id, vce(cluster id)

clear
use covid_nursinghomes_complete.dta 
keep if date == 22255

reg coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp i.id, vce(cluster id)

clear
use covid_nursinghomes_complete.dta 
keep if date == 22395

reg coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp i.id, vce(cluster id)

clear
use covid_nursinghomes_complete.dta 
keep if date == 22724

reg excess_deaths  forprofit five_star four_star three_star two_star weeks_cases_pcp i.id, vce(cluster id)

cases_perthousand
coviddeaths_perthousand



* Creating tables for Covid Deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171
drop if date ==22059 

reghdfe weeklydeaths_perthousand forprofit weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe weeklydeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe weeklydeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* Since 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe weeklydeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for Cases

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171
drop if date ==22059 

reghdfe weeklycases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe weeklycases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe weeklycases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* Since 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe weeklycases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons


* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for excess deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for Resident vaccination percentage

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe resident_nomedicalcontra_pctvacc forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using resident_vacc_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons


* Creating tables for staff vaccination percentage

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_nomedicalcontra_pctvacc forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_vacc_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons


* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for staff cases

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* ----------------------------------------------------------------------------------------------------------------------------------

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for staff deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date fips) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) nocons

* ----------------------------------------------------------------------------------------------------------------------------------
