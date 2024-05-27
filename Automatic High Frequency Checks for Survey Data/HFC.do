sysuse auto.dta, clear



***** Just add all the numeric variables after the word "varlist" below to get outliers that are ±3 Standard Deviation above or below ****
***** Instruction:: Make sure to include the * sign at the bottom with the for loop when you run the selected part ****

foreach i of varlist price mpg rep78 headroom trunk weight length turn displacement gear_ratio {

egen z_`i' = std(`i')
sort z_`i'
list make price z_`i' if abs(z_`i') > 3 & z_`i'!=.

}
*

