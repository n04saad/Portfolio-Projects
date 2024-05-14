use "/Users/saad/Documents/LFS 23/Q1_to_Q4_LFS_2022_All_Quarter_Merged.dta"

*** Cleaning and Creating the Monthly Income for Individual ***

replace MJ_15C= 0 if MJ_15C==.
replace SJ_05C= 0 if SJ_05C==.


gen monthly_income = MJ_15C + SJ_05C


sort quarter PSU EAUM HHNO EMP_HRLN




*** Creating the overall Sample Weight Variable ***

replace wgt_lfs2022Q4Adj= 0 if wgt_lfs2022Q4Adj==.
replace wgt_lfs2022Q3Adj = 0 if wgt_lfs2022Q3Adj ==.
replace wgt_lfs2022Q2Adj = 0 if wgt_lfs2022Q2Adj ==.
replace wgt_lfs2022Q1Adj = 0 if wgt_lfs2022Q1Adj ==.
gen lfs_wgt= wgt_lfs2022Q4Adj + wgt_lfs2022Q3Adj+ wgt_lfs2022Q2Adj + wgt_lfs2022Q1Adj



*** Cleaning Some Human Errors ***

drop if DIV_CODE== 1
drop if DIV_CODE== 26
drop if DIV_CODE== 2
drop if DIV_CODE== 44



*** Taking Sample Weight into Account by DIVISION ***

ssc install ineqdeco

ineqdeco monthly_income [pw= lfs_wgt] , by(DIV_CODE)




*** Estimating Palma Ratio ***

ssc install sumdist

sumdist monthly_income [pw = lfs_wgt], ngp(10)

di "Palma ratio = "  r(sh10) / (r(sh1) + r(sh2) + r(sh3) + r(sh4))
di "Palma ratio = "  r(sh10) / r(cush4)



*** Estimating Lorenz Curve ***

ssc install lorenz

lorenz estimate monthly_income [pw = lfs_wgt]

lorenz graph, aspectratio(1) xlabel(, grid)

graph export lorez.png


*** Squared Mean Deviation ***

summarize monthly_income, meanonly
local mean_income = r(mean)
gen squared_deviation = (monthly_income - `mean_income')^2
summarize squared_deviation, meanonly
local mean_squared_deviation = r(mean)
di "Mean Squared Deviation = " r(mean)


*** Mean root deviation of Income ***

summarize monthly_income, meanonly
local mean_income = r(mean)

gen squared_deviation = (monthly_income - r(mean))^2

gen sqrt_var = sqrt(squared_deviation)

local nobs = r(N)

local mean_root_deviation = sqrt_var / `nobs'

display "Mean root deviation of monthly-income: " `mean_root_deviation'




*** Relative Mean Deviation ***

ssc install inequal7
inequal7 monthly_income


*** Correcting Human Error ***

gen district_code = DISTRICT

replace district_code = subinstr(district_code, " ", "", .)

replace district_code = subinstr(district_code, "BARISHAL", "Barishal", .)
replace district_code = subinstr(district_code, "BARISHAL", "BORISHAL", .)
replace district_code = subinstr(district_code, "BORISHAL", "Barishal", .)
replace district_code = subinstr(district_code, "bhola", "Bhola", .)
replace district_code = subinstr(district_code, "BANDARBAN", "Bandarban", .)
replace district_code = subinstr(district_code, "BOGURA", "Bogura", .)
replace district_code = subinstr(district_code, "BUGURA", "Bogura", .)
replace district_code = subinstr(district_code, "Bugura", "Bogura", .)
replace district_code = subinstr(district_code, "BRAHMANBARIA", "Brahmanbaria", .)
replace district_code = subinstr(district_code, "chandpur", "Chandpur", .)
replace district_code = subinstr(district_code, "CHANDPUR02", "Chandpur", .)
replace district_code = subinstr(district_code, "CHAPAINAWABGANJ", "Chapainababganj", .)
replace district_code = subinstr(district_code, "Chattogramো", "Chattogram", .)
replace district_code = subinstr(district_code, "CHITTAGONG", "Chattogram", .)
replace district_code = subinstr(district_code, "Chittagong", "Chattogram", .)
replace district_code = subinstr(district_code, "Chottagram", "Chattogram", .)
replace district_code = subinstr(district_code, "CHUADANGA", "Chuadanga", .)
replace district_code = subinstr(district_code, "COXSBAZAR", "Cox's Bazar", .)
replace district_code = subinstr(district_code, "Cox'sBazar", "Cox's Bazar", .)
replace district_code = subinstr(district_code, "COMILKA", "Cumilla", .)
replace district_code = subinstr(district_code, "CUMILLA", "Cumilla", .)
replace district_code = subinstr(district_code, "cumilla", "Cumilla", .)
replace district_code = subinstr(district_code, "FENI", "Feni", .)
replace district_code = subinstr(district_code, "gaibandha", "Gaibandha", .)
replace district_code = subinstr(district_code, "GOPALGONJ", "Gopalganj", .)
replace district_code = subinstr(district_code, "Habigonj", "Habiganj", .)
replace district_code = subinstr(district_code, "JAMALPUR", "Jamalpur", .)
replace district_code = subinstr(district_code, "JESHORE", "Jashore", .)
replace district_code = subinstr(district_code, "Jhalakarti", "Jhalokati", .)
replace district_code = subinstr(district_code, "JHALAKATI", "Jhalokati", .)
replace district_code = subinstr(district_code, "Jhalakati", "Jhalokati", .)
replace district_code = subinstr(district_code, "JOYPURHAT", "Joypurhat", .)
replace district_code = subinstr(district_code, "joypurhat", "Joypurhat", .)
replace district_code = subinstr(district_code, "KHAGRACHARI", "Khagrachhari", .)
replace district_code = subinstr(district_code, "KHAGRACHHARI", "Khagrachhari", .)
replace district_code = subinstr(district_code, "KHULNA", "Khulna", .)
replace district_code = subinstr(district_code, "khulna", "Khulna", .)
replace district_code = subinstr(district_code, "KISHORGANJ", "Kishoreganj", .)
replace district_code = subinstr(district_code, "Kishorganj", "Kishoreganj", .)
replace district_code = subinstr(district_code, "Kurigram02", "Kurigram", .)
replace district_code = subinstr(district_code, "kushtia", "Kushtia", .)
replace district_code = subinstr(district_code, "LALMONIRHAT", "Lalmonirhat", .)
replace district_code = subinstr(district_code, "lalmonirhat", "Lalmonirhat", .)
replace district_code = subinstr(district_code, "MADARIPUR", "Madaripur", .)
replace district_code = subinstr(district_code, "madaripur", "Madaripur", .)
replace district_code = subinstr(district_code, "magura", "Magura", .)
replace district_code = subinstr(district_code, "manikganj", "Manikganj", .)
replace district_code = subinstr(district_code, "MOULVIBAZAR", "Moulvibazar", .)
replace district_code = subinstr(district_code, "mymensingh", "Mymensingh", .)
replace district_code = subinstr(district_code, "NAOGAON", "Naogaon", .)
replace district_code = subinstr(district_code, "NARAIL", "Narail", .)
replace district_code = subinstr(district_code, "NARAYANGANJ", "Narayanganj", .)
replace district_code = subinstr(district_code, "NETRAKONA", "Netrakona", .)
replace district_code = subinstr(district_code, "NETROKONA", "Netrakona", .)
replace district_code = subinstr(district_code, "PANCHAGARH", "Panchagarh", .)
replace district_code = subinstr(district_code, "PATUAKHALI", "Patuakhali", .)
replace district_code = subinstr(district_code, "PATUAKHILE", "Patuakhali", .)
replace district_code = subinstr(district_code, "RAJBARI", "Rajbari", .)
replace district_code = subinstr(district_code, "RAJSHAHI", "Rajshahi", .)
replace district_code = subinstr(district_code, "rajshahi", "Rajshahi", .)
replace district_code = subinstr(district_code, "RRAJSHAHI", "Rajshahi", .)
replace district_code = subinstr(district_code, "RRajshahi", "Rajshahi", .)
replace district_code = subinstr(district_code, "RANGAMATI", "Rangamati", .)
replace district_code = subinstr(district_code, "RANGPUR", "Rangpur", .)
replace district_code = subinstr(district_code, "SARIATPUR", "Shariatpur", .)
replace district_code = subinstr(district_code, "SHARIATPUR", "Shariatpur", .)
replace district_code = subinstr(district_code, "SHORIATPUR", "Shariatpur", .)
replace district_code = subinstr(district_code, "SORIATPUR", "Shariatpur", .)
replace district_code = subinstr(district_code, "SATKHIRA", "Satkhira", .)
replace district_code = subinstr(district_code, "Sirajganj01", "Sirajganj", .)
replace district_code = subinstr(district_code, "SUNAMGANJ", "Sunamganj", .)
replace district_code = subinstr(district_code, "sunamgonj", "Sunamganj", .)
replace district_code = subinstr(district_code, "SYLHET", "Sylhet", .)
replace district_code = subinstr(district_code, "sylhet", "Sylhet", .)
replace district_code = subinstr(district_code, "Sylhet01", "Sylhet", .)
replace district_code = subinstr(district_code, "Sylhet02", "Sylhet", .)
replace district_code = subinstr(district_code, "TANGAIL", "Tangail", .)
replace district_code = subinstr(district_code, "Tangail02", "Tangail", .)
replace district_code = subinstr(district_code, "THAKURGAON", "Thakurgaon", .)
replace district_code = subinstr(district_code, "ADARSHOSADAR", "Cumilla", .)
replace district_code = subinstr(district_code, "PIRGACHHA", "Rangpur", .)



drop if district_code== "৩০"
drop if district_code== "0"

encode district_code, generate(DISTRICT_CODE)


*** District Wise Decomposition for the ARCGIS***

ineqdeco monthly_income [pw= lfs_wgt] , by(DISTRICT_CODE)




