
****** High Frequency Check For UNDP Priority Enterprise Survey Bangladesh, 2024 ******
****** Written By: Niamul Hasan Saad ******

import excel "/Users/saad/Downloads/UNDP_Priority_Sector_Enterprise_Survey_Final_Version_-_all_versions_-_English_ENG_-_2024-06-03-10-19-54.xlsx", sheet("UNDP Priority Sector Enterpr...") firstrow clear



**** Trunket the data as required, Just change the date in the td parenthesis ****

drop if today < td(30may2024)

**** Checks for Outliers of the variables and returns the values that are above and below 3 standard deviation ****
**** Note: Only put numeric variables in the "varlist" in the below loop ****

foreach i of varlist AH AJ AL BB BH B42Whatwasthetotalannuals BP DE DG DI DK DM DO DQ DS LR {

egen z_`i' = std(`i')
sort z_`i'
list LY Companyname _index `i' z_`i' if abs(z_`i') > 3 & z_`i'!=.

}
*


***** The below portion checks if Domestic sales and Direct and Indirect Export sums up to 100, If the sum is not 100 the following code will report the enumerators, company name as well as where the data is erroneous *****

replace B61Whatoftheannualsales=0 if B61Whatoftheannualsales==.
replace B62Whatoftheannualsales=0 if B62Whatoftheannualsales==.
replace B63Whatoftheannualsales=0 if B63Whatoftheannualsales==.

gen B6_1 = B61Whatoftheannualsales + B62Whatoftheannualsales + B63Whatoftheannualsales
list LY Companyname _index B61Whatoftheannualsales B62Whatoftheannualsales B63Whatoftheannualsales B6_1 if B6_1 != 100
