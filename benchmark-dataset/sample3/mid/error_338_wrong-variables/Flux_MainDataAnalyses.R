library(psych)

########################################
#
#     This is R Code to do the
#		main analyses for XX, XX, 
#
#	 This code is licensed under a 
#      CC-BY4.0 license and was 
#        written by X. XXXX
#
########################################

#- Import data:
sink("Flux_Analysis_Output.txt")
df <- read.table( "Flux_Data_MainAnalyses.txt", header = T )
summary( df ) # for an overview

#- Descriptive information (see paragraph Sample in the Method section ):

psych::describe( df[,c("age_t1", "sex","no_daily")] )

#- ----------------------------------------------
#-  Correlations variability measures (Table 2)
#- ----------------------------------------------

#- Reliability of the variability measures ( note: the split-half reliability of
#  the neutral object task is computed with an extra R-code ):

names_ <- c("csd_state_bfi_n")
names_ <- c("csd_state_ial_pa","csd_state_ial_fg","csd_state_ial_hi","csd_state_ial_no")
names_ <- c("csd_state_bfi_o")
names_ <- c("csd_state_ial_de","csd_state_ial_jk","csd_state_ial_lm","csd_state_ial_bc")
names_ <- c("csd_state_bfi_c")
names_persd <- c( names_n, names_e, names_o, names_a, names_c ) 

psych::alpha(df[,names_e])$total$raw_alpha # 0.87
psych::alpha(df[,names_a])$total$raw_alpha # 0.87
psych::alpha(df[,names_persd])$total$raw_alpha # 0.97

df$n_csd <- df[,names_n]
df$e_csd <- rowMeans( df[,names_e])
df$o_csd <- df[,names_o]
df$a_csd <- rowMeans( df[,names_a])
df$c_csd <- df[,names_c]
df$per_csd <- rowMeans( df[,names_persd])

names_psd <- c("csd_state_pa_1","csd_state_pa_2","csd_state_pa_3","csd_state_pa_4")
psych::alpha(df[,names_pasd])$total$raw_alpha # 0.92
df$pa_cd <- rowMeans( df[,names_psd])

names_ns <- c("csd_state_na_1","csd_state_na_2","csd_state_na_3")
psych::alpha(df[,names_nasd])$total$raw_alpha # 0.82
df$na_csd <- rowMeans( df[,names_])

names_simsd_t1 <- paste( "csd_sim", c(1:10), "_t1", sep = "") 
psych::alpha(df[,names_simsd_t1])$total$raw_alpha # 0.83
df$simpson_csd_t1 <- rowMeans( df[,names_simsd_t1]) 

names_simsd_t2 <- paste( "csd_sim", c(1:10), "_t2", sep = "") 
psych::alpha(df[,names_simsd_t2])$total$raw_alpha # 0.88
df$simpson_csd_t2 <- rowMeans( df[,names_simsd_t2]) 

#- -------------------------------------------------------------
#-  Correlations between variability measures (Table 2)
#- -------------------------------------------------------------

names_var <- c("sccs_t1","sccs_t2","csd_nob_t1","csd_nob_t2","simpson_csd_t1","simpson_csd_t2",
	"n_csd","e_csd","o_csd","a_csd","c_csd","per_csd","pa_csd","na_csd", "csd_state_se")
psych::describe( df[,names_var] )[,c("mean","sd")]
psych::corr.test( df[,names_var] )

# transport table:
tab <- psych::describe( df[,names_var] )[,c("mean","sd")]
tab <- cbind( tab, psych::corr.test( df[,names_var] )$r )
tab <- round( tab, 2 )
colnames( tab ) <- c("M","SD", paste( c(1:length(names_var)), ".", sep = "" ) )
rownames( tab ) <- c("SCC T1","SCC T2","NO T1","NO T2","ST T1","ST T2",
	"Daily N","Daily E","Daily O","Daily A","Daily C","Daily Pers.","Daily PA",
	"Daily NA","Daily SE" )
tab
#write.table( tab, "Table2.txt", row.names=T, col.names=T, sep =";")

#- -------------------------------------------------------------
#-  Correlations and partial correlations between variability and well-being measures (Table 4)
#- -------------------------------------------------------------

psych::corr.test( df[,c( names_var[-c(1:2)],"rses","swls","pa","na","jsat","ucla")] )

# transport table:
tab <- psych::corr.test( df[,c( names_var[-c(1:2)],"rses","swls","pa",
	"na","jsat","ucla")] )$r[,c("rses","swls","pa","na","jsat","ucla")]
tab <- round( tab[ rownames( tab ) %in% names_var[-c(1:2)], ], 2 )
colnames( tab ) <- c("SE","LS","PA","NA","JS","UCLA")
rownames( tab ) <- c("NO T1","NO T2","ST T1","ST T2",
	"Daily N","Daily E","Daily O","Daily A","Daily C","Daily Pers.","Daily PA",
	"Daily NA","Daily SE" )
tab
#write.table( tab, "Table4.txt", row.names=T, col.names=T, sep = ";")

res <- psych::partial.r( df, x = c("n_csd","e_csd","o_csd","a_csd","c_csd",
	"per_csd","pa_csd","na_csd","csd_state_se","rses","swls",
	"pa","na","jsat","ucla"), y = c("csd_nob_t1","simpson_csd_t1") )
res 
psych::corr.p( res ,  = 91 ) # because n = 93

# transport table:
tab2 <- psych::partial.r( df, x = c("n_csd","e_csd","o_csd","a_csd","c_csd",
	"per_csd","pa_csd","na_csd","csd_state_se","rses","swls",
	"pa","na","jsat","ucla"), y = c("csd_nob_t1","simpson_csd_t1") )[,c("rses","swls","pa","na","jsat","ucla")]
tab2 <- round( tab2[ rownams( tab2 ) %in% c("n_csd","e_csd","o_csd","a_csd","c_csd",
	"per_csd","pa_csd","na_csd","csd_state_se"), ], 2 )
colnames( tab2 ) <- c("SE","LS","PA","NA","JS","UCLA")
rownames( tab2 ) <- c("Daily N","Daily E","Daily O","Daily A","Daily C","Daily Pers.","Daily PA",
	"Daily NA","Daily SE" )
tab2
#write.table( tab2, "Table6.txt", row.names=T, col.names=T, sep = ";")

#- ######################
#-    Extra analyses I
#- ######################

df2 <- read.table( "Flux_Data_ExtraAnalyses.txt", header = TRUE )
df2 <- merge( df2, df, by = "id" )

#- correlations between csd_mean and averaged csds for Big Five traits (not mentioned
#  in the text):

psych::corr.test( df2$e_csd,df2$csd_mean_ )
psych::corr.test( df2$a_csd,df2$csd_mean_)
psych::corr.test( df2$pa_csd,df2$csd_mean_p )
psych::corr.test( df2$na_csd,df2$csd_mean_ )

#- correlations between variability and well-being measures:

names_var <- c("sccs_t1","sccs_t2","csd_nob_t1","csd_nob_t2","simpson_csd_t1","simpson_csd_t2",
	"csd_mean_e","csd_mean_a","csd_mean_pa","csd_mean_na","rses","swls",
	"pa","na","jsat","ucla")
psych::corr.test( df2[,names_var] )

# transport table:
tab <- psych::corr.test( df2[,names_var] )$r[,c("csd_mean_e","csd_mean_a","csd_mean_pa","csd_mean_na")]
tab <- round( tab[ rownames( tab ) %in% c("sccs_t1","sccs_t2","csd_nob_t1","csd_nob_t2",
	"simpson_csd_t1","simpson_csd_t2","rses","swls","pa","na","jsat","ucla"), ], 2 )
rownames( tab ) <- c("SCC T1","SCC T2","NO T1","NO T2","ST T1","ST T2",
	"SE","LS","PA","NA","JS","UCLA")
colnames( tab ) <- c("Daily E","Daily A","Daily PA","Daily NA")
tab
#write.table( tab, "Appendix1_TableA3.txt", row.names=T, col.names=T, sep = ";")

#- Partial-Correlations between variability and well-being measures

res <- psych::partial.r( df2, x = c("csd_mean_e","csd_mean_a","csd_mean_pa","csd_mean_na","rses","swls",
	"pa","na","jsat","ucla"), y = c("csd_nob_t1","simpson_csd_t1") )
res 
psych::corr.p( res , n = 91 ) # because n = 93

# transport table:
tab2 <- psych::partial.r( df2, x = c("csd_mean_e","csd_mean_a","csd_mean_pa","csd_mean_na","rses","swls",
	"pa","na","jsat","ucla"), y = c("csd_nob_t1","simpson_csd_t1") )[,c("csd_mean_e","csd_mean_a",
    "csd_mean_pa","csd_mean_na")]
tab2 <- round( tab2[ rownames( tab2 ) %in% c("rses","swls","pa","na","jsat","ucla"), ], 2 )
rownames(tab2) <- c("SE", "LS", "PA", "NA", "JS", "UCLA")
colnames( tab2 ) <- c("Daily E","Daily A","Daily PA","Daily NA")
tab2
#write.table( tab2, "Appendix1_TableA4.txt", row.names=T, col.names=T, sep = ";")
sink()