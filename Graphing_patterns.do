cd "C:\Users\vitor\OneDrive\Research_Resources\Covid_NursingHomes\Data"

clear
use safegraph_merged

collapse (mean) robustvisits_PctChange  (mean) visitor_PctChange, by(forprofit y m)
drop if y < 2020 
drop if y > 2021
drop if m < 4 & y == 2020

drop if forprofit == .

outsheet using patterns_graph.csv, comma



