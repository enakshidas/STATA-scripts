

*drop if farm_proportion==.
drop if dwelling_connected==.
drop if fcs==.
drop if remittances==.	
*cleaning dataset and dropping missing values

	tabstat hhsize num_child head_sex head_age, by(sector)
	tabstat hhsize num_child head_sex head_age, by(sector) stat(mean min max)
*descibing sample characteristics of household characteristics of poor Nigerian households

	tab dwelling_connected if sector==1
	tab dwelling_connected if sector==2

	tab electricity_source if sector==1
	tab electricity_source if sector==2
	tab electricity_source 
*describing energy profile and usage of Nigerian households and displaying it


    tabstat consumption_index fcs csi_index, by(sector)
	tabstat consumption_index fcs fcs_profile csi_index, by(sector)
	
	tab fcs_profile if sector==1
	tab fcs_profile if sector==2

	tabstat consumption_index income
	tabstat consumption_index income, by(sector)
**	to display onsumption and income characteristics


/*	a.The Government of Nigeria has identified two consumption-based poverty lines, 
	one defined as “ultra-poor” at 230 Naira a month and the other defined as “poor” 
	at 500 Naira a month. */

	gen ultra_poor=0
	replace ultra_poor=1 if consumption_index<=230
	gen poor=0
	replace poor=1 if consumption_index<=500
	
	* Uing consumption expenditure data to measure poverty

	tab poor
	tab ultra_poor

	* There are  67.62% of households that are poor, 53.82% ultra-poor
	
	prtest poor==.51
	prtest poor==.51, level(99)
	* Reject H0. 
	* According to our results we can assure at the 95% level of confidence, that the
	* proportion of “poor” households in Nigeria is higher than 
	
	gen d_agric=0
	replace d_agric=1 if primary_sector==1
	reg consumption_index sector income farm_proportion bank dwelling_connected asset_index fcs hhsize num_child remittances d_agric i.zone
	
	predict yhat
*to develop and predict a model for consumption index as explained by changes in different variables