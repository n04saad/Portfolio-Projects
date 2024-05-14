******** LFS 2022 Data Set **********



clear all
set more off
cd "/Users/saad/Documents/LFS 23"



******** Quarter 1 *********

use Q1_LFS_Socio_Economic_2022.dta, clear 
sum HHNO
sort HHNO
duplicates report PSU EAUM HHNO
save Q1_LFS_2022_Socio_Economic_Edited.dta, replace 

/*use Q1_LFS_Roster_Disability_2022.dta, clear 
sort HHNO
save Q1_LFS_2022_Roster_Disability_Edited.dta, replace */


use Q1_LFS_Education_Employment_2022.dta, clear 
sort HHNO
save Q1_LFS_2022_Education_Employment_Edited.dta, replace 


use Q1_LFS_Migration_2022.dta, clear 
sort HHNO
gen EMP_HRLN =  MGT_LN 
tab MGT_LN, missing
tab EMP_HRLN, missing
encode QUARTER, generate (QUARTER2)
drop QUARTER
rename QUARTER2 QUARTER 
order YEAR QUARTER
save Q1_LFS_2022_Migration_Edited.dta, replace 



use Q1_LFS_2022_Socio_Economic_Edited.dta, clear
sum HHNO
use Q1_LFS_2022_Roster_Disability_Edited.dta, clear
sum HHNO EMP_HRLN
use Q1_LFS_2022_Education_Employment_Edited.dta, clear
sum HHNO EMP_HRLN
use Q1_LFS_2022_Migration_Edited.dta, clear
sum HHNO EMP_HRLN


///// Q1 Merging //////

/* use Q1_LFS_2022_Roster_Disability_Edited.dta, clear 
sum HHNO EMP_HRLN
merge 1:1 PSU EAUM HHNO EMP_HRLN using Q1_LFS_2022_Education_Employment_Edited.dta
sum HHNO EMP_HRLN
rename _merge q1_merge_1
tab q1_merge_1 */

use Q1_LFS_2022_Education_Employment_Edited.dta, clear 
sum HHNO EMP_HRLN
merge 1:1 PSU EAUM HHNO EMP_HRLN using Q1_LFS_2022_Migration_Edited.dta
rename _merge q1_merge_2
drop if q1_merge_2 == 2
tab q1_merge_2


merge m:1 PSU EAUM HHNO using Q1_LFS_2022_Socio_Economic_Edited.dta
rename _merge q1_merge_3

save Q1_LFS_2022_All_Section_Merged.dta, replace 



use Q1_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
gen quarter = 1
order YEAR QUARTER quarter PSU EAUM HHNO EMP_HRLN 

save Q1_LFS_2022_All_Section_Merged.dta, replace 




******** Quarter 2 *********


use Q2_LFS_Socio_Economic_2022.dta, clear 
sum HHNO
sort HHNO
rename HR_LN EMP_HRLN
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN
save Q2_LFS_2022_Socio_Economic_Edited.dta, replace 

/* use Q2_LFS_Roster_Disability_2022.dta, clear 
sort HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN
save Q2_LFS_2022_Roster_Disability_Edited.dta, replace */


use Q2_LFS_Education_Employment_2022.dta, clear 
sort HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

save Q2_LFS_2022_Education_Employment_Edited.dta, replace 


use Q2_LFS_Migration_2022.dta, clear 
sort HHNO
gen EMP_HRLN =  MGT_LN 
tab MGT_LN, missing
tab EMP_HRLN, missing
encode QUARTER, generate (QUARTER2)
drop QUARTER
rename QUARTER2 QUARTER 
order YEAR QUARTER
sum QUARTER
tab QUARTER
gen QUARTER3 = 2 if QUARTER == 1
label define QUARTERNEW 2 "2n"
label values QUARTER3 QUARTERNEW
drop QUARTER
rename QUARTER3 QUARTER
order YEAR QUARTER
tab QUARTER
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

save Q2_LFS_2022_Migration_Edited.dta, replace 


use Q2_LFS_2022_Socio_Economic_Edited.dta, clear
sum HHNO
use Q2_LFS_2022_Roster_Disability_Edited.dta, clear
sum HHNO EMP_HRLN
use Q2_LFS_2022_Education_Employment_Edited.dta, clear
sum HHNO EMP_HRLN
use Q2_LFS_2022_Migration_Edited.dta, clear
sum HHNO EMP_HRLN



///// Q2 Merging //////

/* use Q2_LFS_2022_Roster_Disability_Edited.dta, clear 
sum HHNO EMP_HRLN
merge 1:1 PSU EAUM HHNO EMP_HRLN using Q2_LFS_2022_Education_Employment_Edited.dta
sum HHNO EMP_HRLN
rename _merge q2_merge_1
tab q2_merge_1 */


use Q2_LFS_2022_Education_Employment_Edited.dta, clear 
sum HHNO EMP_HRLN

merge 1:1 PSU EAUM HHNO EMP_HRLN using Q2_LFS_2022_Migration_Edited.dta
rename _merge q2_merge_2
drop if q2_merge_2 == 2
tab q2_merge_2


merge 1:1 PSU EAUM HHNO EMP_HRLN using Q2_LFS_2022_Socio_Economic_Edited.dta
rename _merge q2_merge_3

sum HHNO EMP_HRLN

save Q2_LFS_2022_All_Section_Merged.dta, replace 



use Q2_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
gen quarter = 2
order YEAR QUARTER quarter PSU EAUM HHNO EMP_HRLN 
save Q2_LFS_2022_All_Section_Merged.dta, replace 



******** Quarter 3 *********

use Q3_LFS_Socio_Economic_2022.dta, clear 
sum HHNO
sort HHNO
duplicates report PSU EAUM HHNO
duplicates drop PSU EAUM HHNO, force 
duplicates report PSU EAUM HHNO

save Q3_LFS_2022_Socio_Economic_Edited.dta, replace 

/* use Q3_LFS_Roster_Disability_2022.dta, clear 
sort HHNO
sum HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN
save Q3_LFS_2022_Roster_Disability_Edited.dta, replace */


use Q3_LFS_Education_Employment_2022.dta, clear 
sort HHNO
sum HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN
save Q3_LFS_2022_Education_Employment_Edited.dta, replace 


use Q3_LFS_Migration_2022.dta, clear 
sort HHNO
gen EMP_HRLN =  MGT_LN 
tab MGT_LN, missing
tab EMP_HRLN, missing
encode QUARTER, generate (QUARTER2)
drop QUARTER
rename QUARTER2 QUARTER 
order YEAR QUARTER
sum QUARTER
tab QUARTER
gen QUARTER3 = 2 if QUARTER == 1
label define QUARTERNEW 3 "3r"
label values QUARTER3 QUARTERNEW
drop QUARTER
rename QUARTER3 QUARTER
order YEAR QUARTER
tab QUARTER
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

save Q3_LFS_2022_Migration_Edited.dta, replace 

use Q3_LFS_2022_Socio_Economic_Edited.dta, clear
sum HHNO
// use Q3_LFS_2022_Roster_Disability_Edited.dta, clear
sum HHNO EMP_HRLN
use Q3_LFS_2022_Education_Employment_Edited.dta, clear
sum HHNO EMP_HRLN
use Q3_LFS_2022_Migration_Edited.dta, clear
sum HHNO EMP_HRLN



///// Q3 Merging //////

/* use Q3_LFS_2022_Roster_Disability_Edited.dta, clear 
sum HHNO EMP_HRLN
merge 1:1 PSU EAUM HHNO EMP_HRLN using Q3_LFS_2022_Education_Employment_Edited.dta
sum HHNO EMP_HRLN
rename _merge q3_merge_1
tab q3_merge_1 */


use Q3_LFS_2022_Education_Employment_Edited.dta, clear 
sum HHNO EMP_HRLN

merge 1:1 PSU EAUM HHNO EMP_HRLN using Q3_LFS_2022_Migration_Edited.dta
rename _merge q3_merge_2
drop if q3_merge_2 == 2
tab q3_merge_2


merge m:1 PSU EAUM HHNO using Q3_LFS_2022_Socio_Economic_Edited.dta
rename _merge q3_merge_3
drop if q3_merge_3 == 2
tab q3_merge_3


save Q3_LFS_2022_All_Section_Merged.dta, replace 




use Q3_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
gen quarter = 3
order YEAR QUARTER quarter PSU EAUM HHNO EMP_HRLN 
save Q3_LFS_2022_All_Section_Merged.dta, replace 




******** Quarter 4 *********

use Q4_LFS_Socio_Economic_2022.dta, clear 
sum HHNO
sort HHNO
duplicates report PSU EAUM HHNO
duplicates drop PSU EAUM HHNO, force 
duplicates report PSU EAUM HHNO

save Q4_LFS_2022_Socio_Economic_Edited.dta, replace 

/* use Q4_LFS_Roster_Disability_2022.dta, clear 
sort HHNO
sum HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

save Q4_LFS_2022_Roster_Disability_Edited.dta, replace */


use Q4_LFS_Education_Employment_2022.dta, clear 
sort HHNO
sum HHNO
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

save Q4_LFS_2022_Education_Employment_Edited.dta, replace 


use Q4_LFS_Migration_2022.dta, clear 
sort HHNO
gen EMP_HRLN =  MGT_LN 
tab MGT_LN, missing
tab EMP_HRLN, missing
encode QUARTER, generate (QUARTER2)
drop QUARTER
rename QUARTER2 QUARTER 
order YEAR QUARTER
sum QUARTER
tab QUARTER
gen QUARTER3 = 2 if QUARTER == 1
label define QUARTERNEW 4 "4t"
label values QUARTER3 QUARTERNEW
drop QUARTER
rename QUARTER3 QUARTER
order YEAR QUARTER
tab QUARTER
duplicates report PSU EAUM HHNO EMP_HRLN
duplicates drop PSU EAUM HHNO EMP_HRLN, force
duplicates report PSU EAUM HHNO EMP_HRLN

sum HHNO 
save Q4_LFS_2022_Migration_Edited.dta, replace 



///// Q4 Merging //////

/* use Q4_LFS_2022_Roster_Disability_Edited.dta, clear 
sum HHNO EMP_HRLN
merge 1:1 PSU EAUM HHNO EMP_HRLN using Q4_LFS_2022_Education_Employment_Edited.dta
sum HHNO EMP_HRLN
rename _merge q4_merge_1
tab q4_merge_1 */


use Q4_LFS_2022_Education_Employment_Edited.dta, clear 
sum HHNO EMP_HRLN

merge 1:1 PSU EAUM HHNO EMP_HRLN using Q4_LFS_2022_Migration_Edited.dta
rename _merge q4_merge_2
drop if q4_merge_2 == 2
tab q4_merge_2


merge m:1 PSU EAUM HHNO using Q4_LFS_2022_Socio_Economic_Edited.dta
rename _merge q4_merge_3

save Q4_LFS_2022_All_Section_Merged.dta, replace 



use Q4_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
gen quarter = 4
order YEAR QUARTER quarter PSU EAUM HHNO EMP_HRLN 
save Q4_LFS_2022_All_Section_Merged.dta, replace 




use Q1_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
use Q2_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
use Q3_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN
use Q4_LFS_2022_All_Section_Merged.dta, clear
sum HHNO EMP_HRLN
sort PSU EAUM HHNO EMP_HRLN




**** Appending the datasets to create a Quarterly panel *******


use Q1_LFS_2022_All_Section_Merged.dta, clear
append using Q2_LFS_2022_All_Section_Merged.dta
append using Q3_LFS_2022_All_Section_Merged.dta
append using Q4_LFS_2022_All_Section_Merged.dta


save Q1_to_Q4_LFS_2022_All_Quarter_Merged.dta, replace 





********* Some descriptive statistics ********

use Q1_to_Q4_LFS_2022_All_Quarter_Merged.dta, clear 

egen uid = group(PSU EAUM HHNO EMP_HRLN), label


















