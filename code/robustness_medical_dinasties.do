/*


	this figure shows that the results are not driven by medical dinasties

*/


use "../data/anal_doctor_y10_assumption.dta", clear

* sizes
local legend_size = "small"
local y_label_size = "small"
local x_label_size = "small"
local titlesize = "small"

local trend_color = "red"
local dr_color = "maroon"
local dr50_color = "erose"


local female_size = "large" 
local combined_size = "medium"
local male_size = "small"

local female_pattern = "shortdash"
local combined_pattern = "solid"
local male_pattern = "longdash"


local noble_symbol = "S"
local top20_symbol = "T"
local noble_caption = "..y surnames"
local top20_caption = "Top 20 surnames"
local above_caption = "Status advantage relative to non-Romani population"
local below_caption = "Status disadvantage relative to non-Romani population"

local y_scale = "-.2" +  `"""'+".82"+`"""'+  ///
" -.4 " +   `"""'+".67"+`"""'+	///
" -.6 " +   `"""'+".55"+`"""'+ 	///
" -.8 "	+   `"""'+".45"+`"""'+ 	///
" -1 "	+	`"""'+".37"+`"""'+ 	///
" -1.2 "+	`"""'+".30"+`"""'+ 	///
" -1.4 "+	`"""'+".25"+`"""'+ 	///
" -1.6 "+	`"""'+".20"+`"""'+ 	///
" -1.8 "+	`"""'+".17"+`"""'+ 	///
" -2 "  +	`"""'+".14"+`"""'+ 	///
" -2.2 "+	`"""'+".11"+`"""'+ 	///
" -2.4 "+	`"""'+".09"+`"""'+ 	///
" -2.6 "+	`"""'+".07"+`"""'


keep if y10>1945

replace y10 = y10+5

drop if y10==2025

graph twoway  connected ///
	noble_mean_pop_nr_dr ///
	doc50_mean_pop_nr_dr    y10 ,  ///
	lpattern(solid solid )  ///
	msymbol(square  square    ) ///
	msize(medium large ) ///
	lcolor(`dr_color' `dr50_color'  ) ///
	lwidth(thin thin  ) ///
	mcolor(`dr_color' `dr50_color' ) ///
	graphregion(color(white)) ///
	leg( region(style(none)) col(4) size(small) ///
	label(1 "All ..y Surnames (medic.)")  ///	
		label(2 "1950-59 ..y Surnames (medic.)")  ///	
	justification(right) ///
	symysize(vsmall) symxsize(0.2cm) )  ///
	xtitle("Decade", size(`titlesize')) ///
	ytitle("Status advantage relative to population", size(`titlesize')) ///
	xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(small) valuelabel) ///
	ylabel(0 0.25 0.5 0.75 1 1.25, labsize(vsmall)) yscale(titlegap(*10))
	

graph export ../figures/medical_dinasties.png, replace


graph export ../figures/medical_dinasties.pdf, replace
