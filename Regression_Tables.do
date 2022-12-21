
* Setting Env Variables
*global directory: env CovidProject

* Setting Directory
*cd "$directory\Data"

cd "C:\Users\vmelo\OneDrive\Research_Resources\Covid_NursingHomes\Data"

************************ CREATING REGRESSION TABLES ************************************
*--------------------------------------------------------------------------------------*

global controls five_star four_star three_star two_star change_countycasespcp urban unemp_2020 median_income_2020 pop poverty_2020 pct_lesshighschool pct_bachelors pop pctalz_dem staff_shortage

************************ Summary statistics *****************************************
*--------------------------------------------------------------------------------------*
clear
use VisitsAnalysis_March2021_Data.dta
nbreg changecovidcases_perhundredbeds isolation $controls i.id, vce(cluster fips)
asdoc sum changecovidcases_perhundredbeds changecoviddeaths_perhundredbeds changeexcessdeaths changetotaldeaths_perhundredbeds isolation $controls if e(sample)
asdoc sum changecovidcases_perhundredbeds changecoviddeaths_perhundredbeds changeexcessdeaths changetotaldeaths_perhundredbeds isolation $controls if e(sample), stats(median)


clear
use VisitsAnalysis_March2022_Data.dta
asdoc sum changecovidcases_perhundredbeds changecoviddeaths_perhundredbeds changeexcessdeaths changetotaldeaths_perhundredbeds isolation $controls 


************************ visitors - Covid Cases*****************************************
*--------------------------------------------------------------------------------------*

clear
use VisitsAnalysis_March2021_Data.dta
nbreg changecovidcases_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using cases_2021_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use VisitsAnalysis_March2022_Data.dta
nbreg changecovidcases_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using cases_2022_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use Visits_Total_Data.dta
nbreg changecovidcases_perhundredbeds isolation  $controls i.id, vce(cluster fips)
*outreg2 using cases_AllYears_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

************************ visitors - Covid Deaths************************************
*--------------------------------------------------------------------------------------*
reg changecoviddeaths_perhundredbeds isolation

*binscatter changetotaldeaths_perhundredbeds isolation
clear
use VisitsAnalysis_March2021_Data.dta
nbreg changecoviddeaths_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using coviddeaths_2021_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use VisitsAnalysis_March2022_Data.dta
nbreg changecoviddeaths_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using coviddeaths_2022_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use Visits_Total_Data.dta
nbreg changecoviddeaths_perhundredbeds isolation  $controls i.id, vce(cluster fips)
*outreg2 using coviddeaths_AllYears_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

************************ visitors - Non-Covid Deaths************************************
*--------------------------------------------------------------------------------------*

clear
use VisitsAnalysis_March2021_Data.dta
nbreg changeexcessdeaths isolation $controls i.id, vce(cluster id)
*outreg2 using noncoviddeaths_2021_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use VisitsAnalysis_March2022_Data.dta
nbreg changeexcessdeaths isolation $controls i.id, vce(cluster id)
*outreg2 using noncoviddeaths_2022_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)
margins, dydx(isolation) at(pctalz_dem =(0(10)100))
*marginsplot 

clear
use Visits_Total_Data.dta
nbreg changeexcessdeaths isolation $controls i.id, vce(cluster fips)
*outreg2 using noncoviddeaths_AllYears_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)
margins, dydx(isolation) at(pctalz_dem =(0(10)100))

************************ visitors - Total Deaths************************************
*--------------------------------------------------------------------------------------*

clear
use VisitsAnalysis_March2021_Data.dta
nbreg changetotaldeaths_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using total_2021_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)

clear
use VisitsAnalysis_March2022_Data.dta
nbreg changetotaldeaths_perhundredbeds isolation $controls i.id, vce(cluster fips)
*outreg2 using total_2022_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)
margins, dydx(isolation) at(pctalz_dem =(0(1)100))

clear
use Visits_Total_Data.dta
nbreg changetotaldeaths_perhundredbeds isolation  $controls i.id, vce(cluster fips)
outreg2 using totaldeaths_AllYears_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons
margins, dydx(isolation)
************************ Total years - Total deaths ************************************
*--------------------------------------------------------------------------------------*
clear
use Visits_Total_Data.dta
nbreg changetotaldeaths_perhundredbeds isolation  $controls i.id, vce(cluster fips)
*outreg2 using total_allyears_file, replace tex label keep(isolation change_countycasespcp pctalz_dem staff_shortage) nocons

reg changetotaldeaths_perhundredbeds isolation pctalz_dem
*vce(bootstrap, reps(1000) seed(123) nodots)

margins, dydx(isolation) at(pctalz_dem =(0(10)100))

*******************************************************************************************************************************************************
*******************************************************************************************************************************************************
*******************************************************************************************************************************************************
*******************************************************************************************************************************************************
*******************************************************************************************************************************************************



































*******************************************************************************************************************************************************
*******************************************************************************************************************************************************
*******************************       FORPROFIT ANALYSIS          *************************************************************************************
*******************************************************************************************************************************************************
*******************************************************************************************************************************************************
*******************************************************************************************************************************************************


************************ Summary statistics *****************************************
*--------------------------------------------------------------------------------------*
clear
use Sep2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit $controls i.id, vce(cluster fips)
gen category = .
replace category = 1 if forprofit == 1
replace category = 2 if nonprofit == 1
replace category = 3 if gov == 1
asdoc by category: sum changecovidcases_perhundredbeds changecoviddeaths_perhundredbeds changeexcessdeaths changetotaldeaths_perhundredbeds $controls if e(sample)










************************ Resident Covid Cases ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use April2021_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

clear
use March2022_NB_Data.dta
nbreg changecovidcases_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) nocons

************************ Resident Covid Deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit $controls  i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changecoviddeaths_perhundredbeds forprofit $controls i.id , vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using deaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons


************************ Resident excess deaths ************************************
*--------------------------------------------------------------------------------------*
clear
use Sep2020_NB_Data.dta
nbreg changeexcessdeaths forprofit $controls i.id, vce(cluster fips)
*outreg2 using excess_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons
margins, dydx(forprofit)

clear
use Dec2020_NB_Data.dta
nbreg changeexcessdeaths forprofit $controls i.id, vce(cluster fips)
*outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons
margins, dydx(forprofit)

clear
use April2021_NB_Data.dta
nbreg changeexcessdeaths forprofit $controls i.id, vce(cluster fips)
*outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons
margins, dydx(forprofit)
margins, dydx(isolation) at(pctalz_dem =(0(10)100))

clear
use March2022_NB_Data.dta
nbreg changeexcessdeaths forprofit $controls  i.id, vce(cluster fips)
*outreg2 using excess_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons
margins, dydx(forprofit)
margins, dydx(forprofit) at(pctalz_dem =(0(5)100))
marginsplot 

************************ Resident total deaths ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using totaldeaths_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use Dec2020_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use April2021_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

clear
use March2022_NB_Data.dta
nbreg changetotaldeaths_perhundredbeds forprofit $controls i.id, vce(cluster fips)
margins, dydx(forprofit)
*outreg2 using totaldeaths_file, append tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons

************************ Staff Covid-19 Cases per 100 Full Time Staff ************************************
*--------------------------------------------------------------------------------------*

clear
use Sep2020_NB_Data.dta
nbreg changestaffcases_FTWorkers forprofit $controls i.id, vce(cluster fips)
*outreg2 using staffcases_file, replace tex label keep(forprofit five_star four_star three_star two_star change_countycasespcp) addtext(State FE, YES) nocons



/*











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
