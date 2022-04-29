
* Setting Env Variables
global directory: env CovidProject

* Setting Directory
cd "$directory\Data"

************************ CREATING REGRESSION TABLES ************************************
*--------------------------------------------------------------------------------------*

* Creating tables for Covid Deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* Since 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using covid_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for Cases

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe cases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe cases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe cases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* Since 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe cases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using cases_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons


* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for excess deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe excess_deaths forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using excess_deaths_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for Resident vaccination percentage

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe resident_nomedicalcontra_pctvacc forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using resident_vacc_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons


* Creating tables for staff vaccination percentage

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_nomedicalcontra_pctvacc forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_vacc_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons


* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for staff cases

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, replace tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_covidcases_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_covidcases_perthousand_file, append tex label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* ----------------------------------------------------------------------------------------------------------------------------------

* ----------------------------------------------------------------------------------------------------------------------------------


* Creating tables for staff deaths

* from 05/24/2020 - 09/13/2020
clear
use covid_nursinghomes_complete.dta 
drop if date > 22171

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, replace word label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 09/13/2020 - 12/06/2020
clear
use covid_nursinghomes_complete.dta 
drop if date < 22171
drop if date > 22255

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date fips) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append word label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 12/06/2020 - 04/25/2021
clear
use covid_nursinghomes_complete.dta 
drop if date < 22255
drop if date > 22395

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append word label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* from 04/25/2021 - 3/1/2022
clear
use covid_nursinghomes_complete.dta 
drop if date < 22395

reghdfe staff_coviddeaths_perthousand forprofit five_star four_star three_star two_star weeks_cases_pcp, absorb(date id) vce(cluster id)
outreg2 using staff_coviddeaths_perthousand_file, append word label keep(forprofit five_star four_star three_star two_star weeks_cases_pcp) addtext(Weekly FE, YES, State FE, YES) title(Table 1) nocons

* ----------------------------------------------------------------------------------------------------------------------------------
