


* sizes
local legend_size = "small"
local y_label_size = "small"
local x_label_size = "small"
local titlesize = "small"


use ../data/anal_mta2_year.dta , clear
merge 1:1 year using ../data/anal_doctor_year.dta , gen(merge_doctors)
merge 1:1 year using ../data/anal_reps_year.dta , gen(merge_reps)


gen postcomm = 0

local break_at=1996
replace postcomm = 1 if year>=`break_at'
gen t = year-`break_at'

keep if year>=1945

twoway   		(lfitci relative_rep_highstat_nr_dr  year if t<=0,ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick)  lcolor(black) )   ///
					(lfitci relative_rep_highstat_nr_dr  year if t>0, ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick) lcolor(black)   ) ///
					(scatter relative_rep_highstat_nr_dr  year , mcolor(gray)  lpattern(dot)  ) ///
					(connected relative_rep_highstat_nr_reps  year , mcolor(black) msymbol(D) lpattern(dot) lcolor(black)  ), ///	
					xline(1996.5 , lcolor(gs12) lpattern(dash) )  /// 
					xline(1990, lcolor(gs12) lpattern(dash)  )  /// 
					xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
						xtitle("Decade", size(`titlesize')) ///
					ylabel(0 1 2 3 4 5 6) ///
					graphregion(color(white)) ///
					leg( size(`legend_size') region(style(none))  order(5 "High status in doctors (pooled)"   6 "High status in Parliament" )) ///
					ytitle("Relative representation", size(`titlesize'))
					
					
graph export ../figures/social_vs_political1945_reps_high.pdf, replace


twoway   		(lfitci relative_rep_highstat_nr_dr  year if t<=0,ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick)  lcolor(black) )   ///
					(lfitci relative_rep_highstat_nr_dr  year if t>0, ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick) lcolor(black)   ) ///
					(scatter relative_rep_highstat_nr_dr  year , mcolor(gray)  lpattern(dot)  ) ///
					(connected relative_rep_highstat_nr_mta2  year , mcolor(black) msymbol(D) lpattern(dot) lcolor(black)  ), ///	
					xline(1996.5 , lcolor(gs12) lpattern(dash) )  /// 
					xline(1990, lcolor(gs12) lpattern(dash)  )  /// 
					xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
						xtitle("Decade", size(`titlesize')) ///
					ylabel(0 1 2 3 4 5 6 7 8) ///
					graphregion(color(white)) ///
					leg( size(`legend_size') region(style(none))   order(5 "High status in doctors (pooled)"   6 "High status in Academy of Sciences" )) ///
					ytitle("Relative representation", size(`titlesize'))
					

graph export ../figures/social_vs_political1945_mta_high.pdf, replace




twoway   		(lfitci relative_rep_lowstat_nr_dr  year if t<=0,ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick)  lcolor(black) )   ///
					(lfitci relative_rep_lowstat_nr_dr  year if t>0, ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick) lcolor(black)   ) ///
					(scatter relative_rep_lowstat_nr_dr  year , mcolor(gray)  lpattern(dot)  ) ///
					(connected relative_rep_lowstat_nr_reps  year , mcolor(black) msymbol(D) lpattern(dot) lcolor(black)  ), ///	
					xline(1996.5 , lcolor(gs12) lpattern(dash) )  /// 
					xline(1990, lcolor(gs12) lpattern(dash)  )  /// 
					xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
						xtitle("Decade", size(`titlesize')) ///
					ylabel(0 0.25 0.5 0.75 1) ///
					graphregion(color(white)) ///
					leg( size(`legend_size')  region(style(none))  order(5 "Low status in doctors (pooled)"   6 "Low status in Parliament" )) ///
					ytitle("Relative representation", size(`titlesize'))
					

graph export ../figures/social_vs_political1945_reps_low.pdf, replace

twoway   		(lfitci relative_rep_lowstat_nr_dr  year if t<=0,ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick)  lcolor(black) )   ///
					(lfitci relative_rep_lowstat_nr_dr  year if t>0, ciplot(rline) blcolor(gray) blpattern(dash) blwidth(thin)   clwidth(medthick) lcolor(black)   ) ///
					(scatter relative_rep_lowstat_nr_dr  year , mcolor(gray)  lpattern(dot)  ) ///
					(connected relative_rep_lowstat_nr_mta2  year , mcolor(black) msymbol(D) lpattern(dot) lcolor(black)  ), ///	
					xline(1996.5 , lcolor(gs12) lpattern(dash) )  /// 
					xline(1990, lcolor(gs12) lpattern(dash)  )  /// 
					xlabel(1955 "1950-59" 1965 "1960-69" 1975 "1970-79" 1985 "1980-89" 1995 "1990-99" 2005 "2000-09" 2015 "2010-19", labsize(`x_label_size')) ///
						xtitle("Decade", size(`titlesize')) ///
					ylabel(0 0.25 0.5 0.75 1) ///
					graphregion(color(white)) ///
					leg( size(`legend_size') region(style(none))  order(5 "Low status in doctors (pooled)"   6 "Low status in Academy of Sciences" )) ///
					ytitle("Relative representation", size(`titlesize'))
					

graph export ../figures/social_vs_political1945_mta_low.pdf, replace


