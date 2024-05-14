use "/Users/saad/Documents/Time series assignment/2/tsdata.dta"

// Converting the data into a time series dataset
tsset Year

// taking the first difference of the variables M2 and CPI

generate fd_M2 = D.M2
generate fd_CPI = D.CPI


// Augmented Dickey-Fuller Test on the first difference of CPI and M2

dfuller fd_M2, lags(0)
dfuller fd_CPI, lags(0)


// Finding Money Growth Rate and Inflation from M2 and CPI respectively
generate MGR = (M2-L.M2)*100/L.M2


generate Inflation = (CPI-L.CPI)*100/L.CPI



// ACF and PACF of fd_M2 and fd_CPI. 

ac fd_M2, name(ac_of_fdm2)
pac fd_M2, name(pac_of_fdm2)

graph combine ac_of_fdm2 pac_of_fdm2
graph export acf_pacf_m2.png

ac fd_CPI, name(ac_of_cpi)
pac fd_CPI, name(pac_of_cpi)

graph combine ac_of_cpi pac_of_cpi
graph export acf_pacf_cpi.png
 

// VAR model for CPI and M2

varbasic fd_M2 fd_CPI 
varsoc 

var fd_M2 fd_CPI, lags(1)


// Impulse Response Function 

irf graph irf, irf(varbasic) impulse(fd_CPI) response(fd_M2)
