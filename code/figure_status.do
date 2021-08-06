/*

		style codes
		
		
		- Social groups are identified by markers.
		
		
		Noble: 
			S
		Iw HS:
			O
		Top20:
			T
		Iw LS:
			D

		- Data sources:
		
		Solid: primary
		
		Dash: secondary
		
		Dot : trend
		
		
		- Data sources are identified by line colors.
		
		Doctors: maroon
		
		Tech phd: navy
		
		Tech degree: ltblue
		
		Patent:  dkgreen
		
		Wiw: olive_teal
		
		Trend:  red


*/

* sizes
local legend_size = "small"
local y_label_size = "small"
local x_label_size = "small"
local titlesize = "small"



* trend style
local trendcolor = "red"
local trendpattern = "dot"

* data source style
local source_primary = "solid"
local source_secondary = "dash"

* palette

local dr_color = "maroon"
local bme_color = "navy"
local techug_color = "ltblue"
local patent_color = "dkgreen"
local wiw_color = "olive_teal"


/* set social group specific locals */

if ("`1'"=="onlytop") {

	local elite_groups="noble iw_hs"
	local sg1 = "noble"
	local sg2 = "iw_hs"
	local sg1_caption = "..y surnames"
	local sg2_caption = "Interwar high status"
	local sgsymbol1 = "S"
	local sgsymbol2 = "O"

/* all markers
	local y_scale = "-.2" +  `"""'+".82"+`"""'+  ///
		" -.3 " +   `"""'+".74"+`"""'+ ///
		" -.4 " +   `"""'+".67"+`"""'+  ///
		" -.5 " +   `"""'+".61"+`"""'+ ///
		" -.6 " +   `"""'+".55"+`"""'+ ///
		" -.7 "	+   `"""'+".50"+`"""'+ ///
		" -.8 "	+   `"""'+".45"+`"""'+ ///
		" -.9 "	+	`"""'+".41"+`"""'+ ///
		" -1 "	+	`"""'+".37"+`"""'+ ///
		" -1.1 "+	`"""'+".33"+`"""'+ ///
		" -1.2 "+	`"""'+".30"+`"""'+ /// 
		" -1.3 "+	`"""'+".27"+`"""'
*/	
	* every second marker
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

}


if ("`1'"=="onlybottom") {

	local social_groups="top20 iw_ls"
	local sg1 = "top20"
	local sg2 = "iw_ls"
	local sg1_caption = "Top 20 surnames"
	local sg2_caption = "Interwar low status"	
	local sgsymbol1 = "T"
	local sgsymbol2 = "D"
	*local y_scale = "-.25(0.05)0"
	
	
	
	* all markers
	local y_scale = "1.5" +  `"""'+".22"+`"""'+  ///
		" 1.7 " +   `"""'+".18"+`"""'+ ///
		" 1.9 " +   `"""'+".15"+`"""'+  ///
		" 2.1 " +   `"""'+".12"+`"""'+ ///
		" 2.3 " +   `"""'+".10"+`"""'+ ///
		" 2.5 "	+   `"""'+".08"+`"""'+ ///
		" 2.7 "	+   `"""'+".07"+`"""'+ ///
		" 2.9 "	+	`"""'+".06"+`"""'+ ///
		" 3.1 "	+	`"""'+".05"+`"""'
	
}

/* set population baseline */

if ("`2'"=="all") {

	local baseline="pop"
	if ("`1'"=="onlybottom") {
		local y_caption = "Status disadvantage relative to population"
	}
	if ("`1'"=="onlytop") {
		local y_caption = "Status advantage relative to population"
	}
}

if ("`2'"=="noroma") {

	local baseline="pop_nr"
	if ("`1'"=="onlybottom") {
		local y_caption = "Status disadvantage relative to non-Romani population"
	}
	if ("`1'"=="onlytop") {
		local y_caption = "Status advantage relative to non-Romani population"
	}

}


/* set elite group specific locals */

if ("`3'"=="doctors") {

	* calculate status coefficients 
	local varno = 0
	foreach s in  "log_`sg1'_mean_`baseline'_dr" "log_`sg2'_mean_`baseline'_dr" {
	
		local varno = `varno'+1
		reg `s' c.t, rob
		local lb = _b[t]
		local rho`varno' = floor(exp(`lb')^30*100)
		replace `s'=-1*`s' if "`1'"=="onlybottom"   // convert back to disadvantage for visuals
		
	}
	
	* verify locals
	
	disp "social group1: `sg1', social group2: `sg2', population: `baseline'" 
	
	* make graph
	graph twoway (connect log_`sg1'_mean_`baseline'_dr y10, lpattern(`source_primary') msymbol(`sgsymbol1') msize(medium) lcolor(`dr_color') lwidth(thin) mcolor(`dr_color')) ///
		 (connect log_`sg2'_mean_`baseline'_dr  y10, lpattern(`source_primary') msymbol(`sgsymbol2') msize(medium) lcolor(`dr_color') lwidth(thin) mcolor(`dr_color')) ///
		 (lfit log_`sg1'_mean_`baseline'_dr y10 , alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///
		 (lfit log_`sg2'_mean_`baseline'_dr y10 , alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')), ///			 
	leg(col(2) size(`legend_size') region(style(none))  ///
	label(1 "`sg1_caption', ρ=0.`rho1'")  ///	
	label(2 "`sg2_caption', ρ=0.`rho2'")  ///
	symysize(vsmall) symxsize(0.2cm)   ///
		order ( 1 2) forcesize) ///
	xtitle("Decade", size(`titlesize')) ///
	ytitle("`y_caption'", size(`titlesize')) ///
	xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
	ylabel(`y_scale' , labsize(`y_label_size')) yscale(titlegap(*10)) graphregion(color(white))

}

if ("`3'"=="tech") {

	* calculate status coefficients 
	local varno = 0
	foreach s in  "log_`sg1'_mean_`baseline'_bme" "log_`sg2'_mean_`baseline'_bme" "log_`sg1'_mean_`baseline'_techug" "log_`sg2'_mean_`baseline'_techug" {
	
		local varno = `varno'+1
		reg `s' c.t, rob
		local lb = _b[t]
		local rho`varno' = floor(exp(`lb')^30*100)
		replace `s'=-1*`s' if "`1'"=="onlybottom"   // convert back to disadvantage for visuals
		
	}

	
	graph twoway (connect log_`sg1'_mean_`baseline'_bme y10, lpattern(`source_primary') msymbol(`sgsymbol1') msize(medium) lcolor(`bme_color') lwidth(thin) mcolor(`bme_color')) ///
			 (connect log_`sg2'_mean_`baseline'_bme  y10, lpattern(`source_primary') msymbol(`sgsymbol2') msize(medium) lcolor(`bme_color') lwidth(thin) mcolor(`bme_color')) ///
			 (connect log_`sg1'_mean_`baseline'_techug y10, lpattern(`source_secondary') msymbol(`sgsymbol1') msize(medium) lcolor(`techug_color') lwidth(thin) mcolor(`techug_color')) ///
			 (connect log_`sg2'_mean_`baseline'_techug  y10, lpattern(`source_secondary') msymbol(`sgsymbol2') msize(medium) lcolor(`techug_color') lwidth(thin) mcolor(`techug_color')) ///			 
			 (lfit log_`sg1'_mean_`baseline'_bme y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///
			 (lfit log_`sg2'_mean_`baseline'_bme y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///		
			 (lfit log_`sg1'_mean_`baseline'_techug y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///
			 (lfit log_`sg2'_mean_`baseline'_techug y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')), ///				 
	leg(col(2) size(`legend_size') region(style(none))  ///
	label(1 "`sg1_caption' (PhD), ρ=0.`rho1'")  ///	
	label(2 "`sg2_caption' (PhD), ρ=0.`rho2'")  ///
	label(3 "`sg1_caption' (master), ρ=0.`rho3'")  ///	
	label(4 "`sg2_caption' (master), ρ=0.`rho4'")  ///	
	symysize(vsmall) symxsize(0.2cm)   ///
		order ( 1 2 3 4) forcesize) ///
	xtitle("Decade", size(`titlesize')) ///
	ytitle("`y_caption'", size(`titlesize')) ///
	xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99"  2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
	ylabel(`y_scale', labsize(`y_label_size')) yscale(titlegap(*10)) graphregion(color(white)) 
	

}


if ("`3'"=="general") {

	local elite_groups="wiw patents"
	
	* calculate status coefficients 
	local varno = 0
	foreach s in  "log_`sg1'_mean_`baseline'_patents" "log_`sg2'_mean_`baseline'_patents" "log_`sg1'_mean_`baseline'_wiw" "log_`sg2'_mean_`baseline'_wiw" {
	
		local varno = `varno'+1
		reg `s' c.t, rob
		local lb = _b[t]
		local rho`varno' = floor(exp(`lb')^30*100)
		replace `s'=-1*`s' if "`1'"=="onlybottom"   // convert back to disadvantage for visuals
		
	}
	
	graph twoway (connect log_`sg1'_mean_`baseline'_patents y10, lpattern(`source_primary') msymbol(`sgsymbol1') msize(medium) lcolor(`patent_color') lwidth(thin) mcolor(`patent_color')) ///
			 (connect log_`sg2'_mean_`baseline'_patents  y10, lpattern(`source_primary') msymbol(`sgsymbol2') msize(medium) lcolor(`patent_color') lwidth(thin) mcolor(`patent_color')) ///
			 (connect log_`sg1'_mean_`baseline'_wiw y10, lpattern(`source_secondary') msymbol(`sgsymbol1') msize(medium) lcolor(`wiw_color') lwidth(thin) mcolor(`wiw_color')) ///
			 (connect log_`sg2'_mean_`baseline'_wiw  y10, lpattern(`source_secondary') msymbol(`sgsymbol2') msize(medium) lcolor(`wiw_color') lwidth(thin) mcolor(`wiw_color')) ///			 
			 (lfit log_`sg1'_mean_`baseline'_patents y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///
			 (lfit log_`sg2'_mean_`baseline'_patents y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///		
			 (lfit log_`sg1'_mean_`baseline'_wiw y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')) ///
			 (lfit log_`sg2'_mean_`baseline'_wiw y10, alwidth(none) lcolor(`trendcolor') lpattern(`trendpattern')), ///				 
	leg(col(2) size(`legend_size') region(style(none))  ///
	label(1 "`sg1_caption' (Inventors), ρ=0.`rho1'")  ///	
	label(2 "`sg2_caption' (Inventors), ρ=0.`rho2'")  ///
	label(3 "`sg1_caption' (Who is Who), ρ=0.`rho3'")  ///	
	label(4 "`sg2_caption' (Who is Who), ρ=0.`rho4'")  ///		
	symysize(vsmall) symxsize(0.2cm)   ///
		order ( 1 2 3 4) forcesize) ///
	xtitle("Decade", size(`titlesize')) ///
	ytitle("`y_caption'", size(`titlesize')) ///
	xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
	ylabel(`y_scale' , labsize(`y_label_size')) yscale(titlegap(*10)) graphregion(color(white)) 


	

}

