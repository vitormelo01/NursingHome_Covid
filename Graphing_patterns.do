cd "C:\Users\vmelo\OneDrive\Research_Resources\Covid_NursingHomes\Data"

clear
use safegraph_merged

collapse (mean) robustvisits_PctChange  (mean) visitor_PctChange, by(y m)
drop if y < 2020 
drop if y > 2021
drop if m < 3 & y == 2020
drop if m > 8 & y == 2021

*drop if forprofit == .

outsheet using overall_patterns_graph.csv, comma



