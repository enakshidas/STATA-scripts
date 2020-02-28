
. sysuse nlsw88.dta, clear
(NLSW, 1988 extract)

. codebook age
* to obtain descriptive statistics of variable "age", mean and standard deviation values, 
* number of unique and missing values. 
 
. gen agesq=(age)^2
. sum agesq
* to generate a new variable defined by squared function and display its descriptive statistics

. gen weeklywage=wage*hours
. codebook weeklywage

. gen logweeklywage=log(weeklywage)
. hist weeklywage
(bin=33, start=4.64573, width=48.584177)
*to create histogram with crtain specifications

. hist logweeklywage
(bin=33, start=1.5359485, width=.17717426)

. gen Rwage=round(wage)
. tab Rwage
* to display frequency and cummulative distribution
. graph hbar wage,over(occupation)

drop if consumption_index==.
*to drop missing values of variable consumption_index

gen log_consumption=log(consumption_index)
gen d_agric=0
*to generate a new variable log_consumption

replace d_agric=1 if primary_sector==1
*to assign certain value to a variable as a process of generating a variable and 
*converting it to a categorical variable 

gen agri_farm= d_agric*farm_proportion

reg log_consumption sector income fcs agri_farm bank dwelling_connected asset_index hhsize num_child remittances i.zone
*to build a regression model where variable log_consumptionis dependent variable and all other variables are independent variables

correlate log_consumption income hhsize bank fcs agri_farm dwelling_connected remittances
*to obtain correlation coefficients of independent variables in above regession model to understand 
*by how much the dependent variable changes with a unit change in the independent variable 

