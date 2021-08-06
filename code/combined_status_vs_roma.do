
/*

			COMBINED STATUS FIGURE WITH EDUCATIONAL ELITES (doctors, tech phds, tech ugs)
*/

/*

	solid: doctors
		square: ..y
		diamond: highszat
		
		X : top20
		+ : lowstat
		
		roma: triangle
		
		
	dashdot : bme


*/



use ../data/anal_bme_y10_`1'.dta, clear
merge 1:1 y10 using ../data/anal_doctor_y10_`1'.dta, gen(merge_dr)
merge 1:1 y10 using ../data/anal_techug_y10_`1'.dta , gen(merge_techug)
merge 1:1 y10 using ../data/anal_patents_y10_`1'.dta, gen(merge_patents)
merge 1:1 y10 using ../data/anal_wiw_y10_`1'.dta, gen(merge_wiw)

* set time
keep if y10>=1950
replace y10 = y10 + 5
drop if y10==2025
gen t = y10-1950



local dr_color = "maroon"
local bme_color = "navy"
local techug_color = "ltblue"
local noble_group_marker = "S"
local top20_group_marker = "T"
local roma2_group_marker = "X"
local normal_size = "medium"
local roma_size = "vlarge"
local doctor_pattern = "solid"
local phd_pattern = "shortdash"
local ugrad_pattern = "longdash"
local legend_size = "small"
local y_label_size = "small"
local x_label_size = "small"
local titlesize = "small"


graph twoway connected ///
	noble_mean_pop_dr  ///
	noble_mean_pop_bme  ///
	noble_mean_pop_techug  ///
	top20_mean_pop_dr  ///
	top20_mean_pop_bme  ///
	top20_mean_pop_techug  ///
	roma2_mean_pop_dr  ///
	roma2_mean_pop_bme  ///
	roma2_mean_pop_techug  ///
	y10 ,  ///
	lpattern(`doctor_pattern' `phd_pattern' `ugrad_pattern' `doctor_pattern' `phd_pattern' `ugrad_pattern' `doctor_pattern' `phd_pattern' `ugrad_pattern' ) ///
	lcolor(`dr_color' `bme_color' `techug_color' `dr_color' `bme_color' `techug_color' `dr_color' `bme_color' `techug_color' ) ///
	mcolor(`dr_color' `bme_color' `techug_color' `dr_color' `bme_color' `techug_color' `dr_color' `bme_color' `techug_color' ) ///
	msize("large" "medium" "small" "large" "medium" "small" "huge" "vlarge" "large") ///
	msymbol(`noble_group_marker'  `noble_group_marker'  `noble_group_marker' `top20_group_marker'  `top20_group_marker'  `top20_group_marker' `roma2_group_marker'  `roma2_group_marker'  `roma2_group_marker' ) ///
	leg( region(style(none))  position(7) col(4) size(`legend_size') ///
	label(1 "..y surnames (MD)")  ///	
	label( 2 "(Tech. PhD)")  ///
	label( 3 "(Tech. master)")  ///
	label( 4 "Top 20 surnames (MD)")  ///
	label( 5 "(Tech. PhD)") ///
	label( 6 "(Tech. master)") ///
	label( 7 "Roma-associated (MD)")  ///
	label( 8 "(Tech. PhD)") ///
	label( 9 "(Tech. master)") ///
	justification(right) ///
	symysize(vsmall) symxsize(0.2cm)   ///
		order ( 1 4 7 10 2 5 8 11 3 6 9 12) forcesize)  ///
	xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
	ytitle("Status advantage relative to population", size(`titlesize')) xtitle("Decade", size(`titlesize')) ///
	ylabel(-1 -0.5 0 0.5 1 , labsize(`y_label_size')) yscale(titlegap(*10)) graphregion(color(white))


graph export ../figures/`1'/combined_status_graph_nonroma_vs_roma.png, replace
graph export ../figures/`1'/combined_status_graph_nonroma_vs_roma.pdf, replace
