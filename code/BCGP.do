/*


	This do-file creates the figures in Bukowski, Clark, Gáspár and Pető (2021) 
	- "Social mobility and political regimes".
	
	- "assumption" in the argument refers to assumed 1% eliteness
	- "calculation" in the argument refers to eliteness calculated from data
*/

* set working directory
cap cd "/Users/attilagaspar/Dropbox/social mobility (1)/public_repository/code"

* set up environment for outputs
cap mkdir ../figures
cap mkdir ../figures/assumption
cap mkdir ../figures/calculation
cap mkdir ../tables
cap mkdir ../tables/descriptives
cap mkdir ../tables/descriptives/assumption
cap mkdir ../tables/descriptives/calculation

* TABLES
* descriptive statistics
do table_elitshare.do assumption
do table_elitshare.do calculation

* FIGURES
* basic status convergence figures - Figures 2,3,5,6,8,9
do status_trends_by_group.do calculation
do status_trends_by_group.do assumption

* robustness check for within-family transmission of status among doctors - Figure 4
do robustness_medical_dinasties.do

* comparing non-roma to roma - Figure 7
do combined_status_vs_roma.do calculation
do combined_status_vs_roma.do assumption

* social vs political status (Academy, Representatives) Figures 10-13
do representation_figure_social_status_vs_political_status.do


* FINALIZING OUTPUTS
* copy main figures and rename them to conform paper notation

shell cp ../figures/calculation/status_graph_doctors_onlytop_noroma.pdf ../figures/Fig2.pdf
shell cp ../figures/calculation/status_graph_doctors_onlybottom_noroma.pdf ../figures/Fig3.pdf
shell cp ../figures/calculation/status_graph_tech_onlytop_noroma.pdf ../figures/Fig5.pdf
shell cp ../figures/calculation/status_graph_tech_onlybottom_noroma.pdf ../figures/Fig6.pdf
shell cp ../figures/calculation/combined_status_graph_nonroma_vs_roma.pdf ../figures/Fig7.pdf
shell cp ../figures/calculation/status_graph_general_onlytop_noroma.pdf ../figures/Fig8.pdf
shell cp ../figures/calculation/status_graph_general_onlybottom_noroma.pdf ../figures/Fig9.pdf
shell cp ../figures/medical_dinasties.pdf ../figures/Fig4.pdf
shell cp ../figures/social_vs_political1945_reps_high.pdf ../figures/Fig10.pdf
shell cp ../figures/social_vs_political1945_reps_low.pdf ../figures/Fig11.pdf
shell cp ../figures/social_vs_political1945_mta_high.pdf  ../figures/Fig12.pdf
shell cp ../figures/social_vs_political1945_mta_low.pdf  ../figures/Fig13.pdf
