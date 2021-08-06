/*

	This do file generates the main descriptive table ("Social status of surname types")
	Table 1 in submitted draft.

*/


* load population shares
use  ../data/population_control_ipolated.dta, clear


gen y10=floor(year/10)*10
collapse (mean) *_ip, by(y10)
merge 1:1 y10 using "../data/roma_share_y10", gen(merge_roma)
tempfile pop
save `pop'

* load elite shares

use ../data/anal_bme_y10_`1'.dta, clear
merge 1:1 y10 using ../data/anal_doctor_y10_`1'.dta, gen(merge_dr)
merge 1:1 y10 using ../data/anal_techug_y10_`1'.dta , gen(merge_techug)
merge 1:1 y10 using ../data/anal_patents_y10_`1'.dta, gen(merge_patents)
merge 1:1 y10 using ../data/anal_wiw_y10_`1'.dta, gen(merge_wiw)
merge 1:1 y10 using ../data/anal_mta2_y10_`1'.dta , gen(merge_mta)
merge 1:1 y10 using ../data/anal_reps_y10_`1'.dta , gen(merge_reps)

merge 1:1 y10 using `pop', gen(merge_pop)
tsset y10

* study sample
keep if y10>=1940&y10<=2010

* label decade
label define decade 1940 "1940-49" ///
					1950 "1950-59" ///
					1960 "1960-69" ///
					1970 "1970-79" ///
					1980 "1980-89" ///
					1990 "1990-99" ///
					2000 "2000-09" ///
					2010 "2010-19"
la val y10 decade

* create panel A
preserve
	keep y10 nobility_ip iw_hs_ip  top20_ip iw_ls_ip roma2_ip
	decode y10, gen(y10d)
	drop y10
	rename y10 y10
	order y10 nobility_ip iw_hs_ip  top20_ip iw_ls_ip roma2_ip
	
	foreach v of varlist *_ip {
		replace `v'=round(`v'*1000)/1000
		format `v' %4.3f
		tostring `v', force replace
		*replace `v'=substr(`v',1,5)
	}
	
	*dataout  , tex save(proba) replace 
	export excel using "../tables/descriptives/table1_PanelA_group_popshares.xlsx",replace
restore


* create panel A without the Roma
preserve
	keep y10 nobility_ip iw_hs_ip  top20_ip iw_ls_ip roma_share_predicted 
	foreach v of varlist nobility_ip iw_hs_ip  top20_ip iw_ls_ip {
		replace `v' = `v'/(1-roma_share)
	}
	decode y10, gen(y10d)
	drop y10
	rename y10 y10
	order y10 nobility_ip iw_hs_ip  top20_ip iw_ls_ip roma_share_predicted 
	
	foreach v of varlist *_ip roma_share_predicted {
		replace `v'=round(`v'*1000)/1000
		format `v' %4.3f
		tostring `v', force replace
		*replace `v'=substr(`v',1,5)
	}
	
	*dataout  , tex save(proba) replace 
	export excel using "../tables/descriptives/table1_PanelA_group_popshares_noroma.xlsx",replace
restore



foreach s in "dr" "bme" "techug" "patents" "wiw"  "mta" "reps" {


	* create relative rep figure for whole population (Panel B)
		
	preserve
		keep y10 relative_rep_noble_`s'  relative_rep_iw_hs_`s' relative_rep_top20_`s'  relative_rep_iw_ls_`s' relative_rep_roma2_`s' 
		decode y10, gen(y10d)
		drop y10
		rename y10 y10
		order y10 relative_rep_noble_`s'  relative_rep_iw_hs_`s' relative_rep_top20_`s'  relative_rep_iw_ls_`s' relative_rep_roma2_`s' 
		
		foreach v of varlist relative_rep* {
			replace `v'=round(`v'*100)/100
			*format `v' %4.2f
			tostring `v', force replace
			replace `v'="0"+`v' if substr(`v',1,1)=="."
			replace `v'=substr(`v',1,4)
		}
		
		export excel using "../tables/descriptives/`1'/table1_PanelB_relative_rep_`s'_wholepop.xlsx",replace
	restore
	
	* create relative rep figure for non-roma population (Panel B)

	*relative_rep_noble_nr_
	preserve
		keep y10 relative_rep_noble_nr_`s'  relative_rep_iw_hs_nr_`s' relative_rep_top20_nr_`s'  relative_rep_iw_ls_nr_`s' relative_rep_roma2_nr_`s' 
		decode y10, gen(y10d)
		drop y10
		rename y10 y10
		order y10 relative_rep_noble_nr_`s'  relative_rep_iw_hs_nr_`s' relative_rep_top20_nr_`s'  relative_rep_iw_ls_nr_`s' relative_rep_roma2_nr_`s' 
		
		foreach v of varlist relative_rep* {
			replace `v'=round(`v'*100)/100
			*format `v' %4.2f
			tostring `v', force replace
			replace `v'="0"+`v' if substr(`v',1,1)=="."
			replace `v'=substr(`v',1,4)
		}
		
		export excel using "../tables/descriptives/`1'/table1_PanelB_relative_rep_`s'_noroma.xlsx",replace
	restore
	
	
	foreach s in "dr" "bme" "techug" "patents" "wiw"  "mta" "reps" {

	* implied socialstatus table (Panel C) for whole population 

	preserve
		keep y10 noble_mean_pop_`s'  iw_hs_mean_pop_`s' top20_mean_pop_`s'  iw_ls_mean_pop_`s' roma2_mean_pop_`s' 
		decode y10, gen(y10d)
		drop y10
		rename y10 y10
		order y10 noble_mean_pop_`s'  iw_hs_mean_pop_`s' top20_mean_pop_`s'  iw_ls_mean_pop_`s' roma2_mean_pop_`s' 
		
		foreach v of varlist *_mean_pop* {
			replace `v'=round(`v'*100)/100
			*format `v' %4.2f
			tostring `v', force replace
			replace `v'="0"+`v' if substr(`v',1,1)=="."
			replace `v'=substr(`v',1,4)
		}
		
		export excel using "../tables/descriptives/`1'/table1_PanelC_status_wholepop_`s'.xlsx",replace
	restore
	
	* implied socialstatus table (Panel C) for not roma population

	
	preserve
		keep y10 noble_mean_pop_nr_`s'  iw_hs_mean_pop_nr_`s' top20_mean_pop_nr_`s'  iw_ls_mean_pop_nr_`s' roma2_mean_pop_nr_`s' 
		decode y10, gen(y10d)
		drop y10
		rename y10 y10
		order y10 noble_mean_pop_nr_`s'  iw_hs_mean_pop_nr_`s' top20_mean_pop_nr_`s'  iw_ls_mean_pop_nr_`s' roma2_mean_pop_nr_`s' 
		
		foreach v of varlist *_mean_pop_nr_* {
			replace `v'=round(`v'*100)/100
			*format `v' %4.2f
			tostring `v', force replace
			replace `v'="0"+`v' if substr(`v',1,1)=="."
			replace `v'=substr(`v',1,4)
		}
		
		export excel using "../tables/descriptives/`1'/table1_PanelC_status_noroma_`s'.xlsx",replace
	restore
	
}
	
}




