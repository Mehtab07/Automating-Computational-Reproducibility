if (!requireNamespace("psych", quietly = TRUE)) {
  install.packages("psych") # Install psych package if not already installed
}
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
sink("Flip_Analysis_Output.txt")
df <- read.table( "Flip_Data_MainAnalyses.txt", header = TRUE )
summary( df ) # for an overview

#- Descriptive information (see paragraph Sample in the Method section ):

psych::describe( df[,c("age_t1", "sex_t1","no_daily")] )

#- ######################################
#-  Analyses reported in the main text
#- ######################################

#- ---------------------------
#-     Compute alphas etc.
#- ---------------------------

names_n <- c("csd_state_nervous","csd_state_relaxed","csd_state_irritable")
names_e <- c("csd_state_assertive","csd_state_unsociable","csd_state_shy","csd_state_outgoing") # Fixed: was "sociable", should be "outgoing" based on paper
names_o <- c("csd_state_curious","csd_state_creative","csd_state_witty")
names_a <- c("csd_state_hostile","csd_state_compliant","csd_state_sensitive",
	"csd_state_friendly","csd_state_cynical","csd_state_helpful")
names_c <- c("csd_state_diligent","csd_state_organised","csd_state_negligent")
names_persd <- c( names_n, names_e, names_o, names_a, names_c ) 

psych::alpha(df[,names_n])$total$raw_alpha # 0.878
psych::alpha(df[,names_e])$total$raw_alpha # 0.869
psych::alpha(df[,names_o])$total$raw_alpha # 0.900
psych::alpha(df[,names_a])$total$raw_alpha # 0.872
psych::alpha(df[,names_c])$total$raw_alpha # 0.889
psych::alpha(df[,names_persd])$total$raw_alpha # 0.967

df$n_csd <- rowMeans( df[,names_n] ) # Fixed: syntax error - missing <- and parentheses
df$e_csd <- rowMeans( df[,names_e])
df$o_csd <- rowMeans( df[,names_o])
df$a_csd <- rowMeans( df[,names_a])
df$c_csd <- rowMeans( df[,names_c])
df$per_csd <- rowMeans( df[,names_persd])

#- compute alpha of simpson task:

names_simsd <- paste( "csd_sim", c(1:10), sep = "") 
psych::alpha(df[,names_simsd])$total$raw_alpha # 0.829
df$simpson_csd <- rowMeans( df[,names_simsd]) 

#- ------------------------------------------------------
#-  Correlations between variability measures (Table 1)
#- ------------------------------------------------------

names_var <- c("sccs","csd_nob","simpson_csd","n_csd","e_csd","o_csd","a_csd","c_csd",
	"per_csd","csd_state_selfesteem")
psych::describe( df[,names_var] )[,c("mean","sd")]
psych::corr.test( df[,names_var] )

# transport table:
tab <- psych::describe( df[,names_var] )[,c("mean","sd")]
tab <- cbind( tab, psych::corr.test( df[,names_var] )$r )
tab <- round( tab, 2 )
colnames( tab ) <- c("M","SD", paste( c(1:length(names_var)), ".", sep = "" ) )
rownames( tab ) <- c("SCC","Neutral Objects","Simpson Task","Daily neuroticism","Daily extraversion",
 "Daily openness","Daily agreeableness","Daily conscientious.","Daily personality","Daily self-esteem" )
tab
#write.table( tab, "Table1.txt", row.names=T, col.names=T, sep =";")

#- ---------------------------------------------------------------------------------------------
#-  Correlations and partial-correlations between variability and well-being measures (Table 3)
#- ---------------------------------------------------------------------------------------------

psych::corr.test( df[,c( names_var[-1],"rses","swls","pa","na")] )

# transport table:
tab <- psych::corr.test( df[,c( names_var[-1],"rses","swls","pa","na")] )$r[,c("rses","swls","pa","na")]
tab <- round( tab[ rownames( tab ) %in% names_var[-1], ], 2 )
colnames( tab ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect")
rownames( tab ) <- c("Neutral Objects","Simpson Task","Daily neuroticism","Daily extraversion",
 "Daily openness","Daily agreeableness","Daily conscientious.","Daily personality","Daily self-esteem" )
tab
#write.table( tab, "Table3.txt", row.names=T, col.names=T, sep = ";")

#- Partial-Correlations:

res <- psych::partial.r( df, x = c("n_csd","e_csd","o_csd","a_csd","c_csd","per_csd","csd_state_selfesteem",
	"rses","swls","pa","na"), y = c("csd_nob","simpson_csd") )
res 
psych::corr.p( res , n = 94 ) # because n = 96

# transport table:
tab2 <- psych::partial.r( df, x = c("n_csd","e_csd","o_csd","a_csd","c_csd","per_csd","csd_state_selfesteem",
	"rses","swls","pa","na"), y = c("csd_nob","simpson_csd") )[,c("rses","swls","pa","na")]
tab2 <- round( tab2[ rownames( tab2 ) %in% c("n_csd","e_csd","o_csd","a_csd","c_csd","per_csd",
	"csd_state_selfesteem"), ], 2 )
colnames( tab2 ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect") # Fixed: missing parentheses around vector
rownames( tab2 ) <- c("Daily neuroticism","Daily extraversion","Daily openness",
	"Daily agreeableness","Daily conscientious.","Daily personality","Daily self-esteem" )
tab2
#write.table( tab2, "Table5.txt", row.names=T, col.names=T, sep = ";")

#- ######################
#-    Extra analyses I
#- ######################

df2 <- read.table( "Flip_Data_ExtraAnalyses.txt", header = TRUE )
df2 <- merge( df2, df, by = "id" )

#- correlations between csd_mean and averaged csds for Big Five traits 
#  (mentioned in the text in Appendix A):

psych::corr.test( df2$n_csd,df2$csd_mean_n )
psych::corr.test( df2$e_csd,df2$csd_mean_e )
psych::corr.test( df2$o_csd,df2$csd_mean_o )
psych::corr.test( df2$a_csd,df2$csd_mean_a )
psych::corr.test( df2$c_csd,df2$csd_mean_c )

#- correlations between variability and well-being measures:

names_var <- c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c", 
	"sccs","csd_nob","simpson_csd","rses","swls","pa","na")
psych::corr.test( df2[,names_var] )

# transport table:
tab <- psych::corr.test( df2[, names_var] )$r[,c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c")]
tab <- round( tab[ rownames( tab ) %in% c("sccs","csd_nob","simpson_csd",
	"rses","swls","pa","na"), ], 2 )
rownames( tab ) <- c("SCC","Neutral Objects","Simpson Task","Self-Est.","Life Sat.","Pos. Affect","Neg. Affect")
colnames( tab ) <- c("Daily Ave. Ne.","Daily Ave. Ex.","Daily Ave. Op.","Daily Ave. Ag.","Daily Ave. Co.")
tab
#write.table( tab, "Appendix1_TableA1.txt", row.names=T, col.names=T, sep = ";")

#- Partial-Correlations between variability and well-being measures

res <- psych::partial.r( df2, x = c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c", 
	"rses","swls","pa","na"), y = c("csd_nob","simpson_csd") ) # Fixed: function name was "partialr", should be "partial.r"
res 
psych::corr.p( res , n = 94 ) # because n = 96

# transport table:
tab2 <- psych::partial.r( df2, x = c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c", 
	"rses","swls","pa","na"), y = c("csd_nob","simpson_csd") )[,c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c")]
tab2 <- round( tab2[ rownames( tab2 ) %in% c("sccs","csd_nob","simpson_csd","rses","swls","pa","na"), ], 2 )
rownames( tab2 ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect") # Fixed: missing parentheses around vector
colnames( tab2 ) <- c("Daily Ave. Ne.","Daily Ave. Ex.","Daily Ave. Op.","Daily Ave. Ag.","Daily Ave. Co.")
tab2
#write.table( tab2, "Appendix1_TableA2.txt", row.names=T, col.names=T, sep = ";")
sink()