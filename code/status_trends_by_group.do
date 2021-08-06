
/*

	
		this script generates the main figures, where we calculate rho by group



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



foreach s1 in "onlytop" "onlybottom" {

	foreach s2 in "all" "noroma" {
	
		foreach s3 in "doctors" "tech" "general" {
		
			do figure_status.do `s1' `s2' `s3'
			graph export ../figures/`1'/status_graph_`s3'_`s1'_`s2'.png, replace
			
			graph export ../figures/`1'/status_graph_`s3'_`s1'_`s2'.pdf, replace

		}
	
	}

}
