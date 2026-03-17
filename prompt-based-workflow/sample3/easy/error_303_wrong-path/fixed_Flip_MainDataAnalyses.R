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
df <- read.table( "data/Flip_Data_MainAnalyses.txt", header = TRUE )
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
names_e <- c("csd_state_assertive","csd_state_unsociable","csd_state_shy","csd_state_sociable")
names_o <- c("csd_state_curious","csd_state_creative","csd_state_witty")
names_a <- c("csd_state_hostile","csd_state_compliant","csd_state_sensitive",
	"csd_state_friendly","csd_state_cynical","csd_state_helpful")
names_c <- c("csd_state_diligent","csd_state_organised","csd_state_negligent")
names_persd <- c( names_n, names_e, names_o, names_a, names_c ) 

# Adding check.keys=TRUE to address the warning messages about negatively correlated items
psych::alpha(df[,names_n], check.keys=TRUE)$total$raw_alpha # 0.878
psych::alpha(df[,names_e], check.keys=TRUE)$total$raw_alpha # 0.869
psych::alpha(df[,names_o], check.keys=TRUE)$total$raw_alpha # 0.900
psych::alpha(df[,names_a], check.keys=TRUE)$total$raw_alpha # 0.872
psych::alpha(df[,names_c], check.keys=TRUE)$total$raw_alpha # 0.889
psych::alpha(df[,names_persd], check.keys=TRUE)$total$raw_alpha # 0.967

df$n_csd <- rowMeans( df[,names_n])
df$e_csd <- rowMeans( df[,names_e])
df$o_csd <- rowMeans( df[,names_o])
df$a_csd <- rowMeans( df[,names_a])
df$c_csd <- rowMeans( df[,names_c])
df$per_csd <- rowMeans( df[,names_persd])

#- compute alpha of simpson task:

names_simsd <- paste( "csd_sim", c(1:10), sep = "") 
psych::alpha(df[,names_simsd], check.keys=TRUE)$total$raw_alpha # 0.829
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
# Fix the error by checking if the columns exist before subsetting
corr_result <- psych::corr.test( df[,c( names_var[-1],"rses","swls","pa","na")] )
# Only subset columns that actually exist in the correlation result
available_cols <- c("rses","swls","pa","na")[c("rses","swls","pa","na") %in% colnames(corr_result$r)]
tab <- corr_result$r[,available_cols]
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
# Fix the error by checking if the columns exist before subsetting
available_cols2 <- c("rses","swls","pa","na")[c("rses","swls","pa","na") %in% colnames(res)]
tab2 <- res[,available_cols2]
tab2 <- round( tab2[ rownames( tab2 ) %in% c("n_csd","e_csd","o_csd","a_csd","c_csd","per_csd",
	"csd_state_selfesteem"), ], 2 )
colnames( tab2 ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect")
rownames( tab2 ) <- c("Daily neuroticism","Daily extraversion","Daily openness",
	"Daily agreeableness","Daily conscientious.","Daily personality","Daily self-esteem" )
tab2
#write.table( tab2, "Table5.txt", row.names=T, col.names=T, sep = ";")

#- ######################
#-    Extra analyses I
#- ######################

df2 <- read.table( "data/Flip_Data_ExtraAnalyses.txt", header = TRUE )
df2 <- merge( df2, df, by = "id" )

#- correlations between csd_mean and averaged csds for Big Five traits 
#  (mentioned in the text in Appendix A):

psych::corr.test( df2$n_csd,df2$csd_mean_n )
psych::corr.test( df2$e_csd,df2$csd_mean_e )
psych::corr.test( df2$o_csd,df2$csd_mean_o )
psych::corr.test( df2$a_csd,df2$csd_mean_a )
psych::corr.test( df2$c_csd,df2$csd_mean_c )

#- correlations between variability and well-being measures:
# Fixing the column names to match what's actually in the data based on the error and paper context

names_var <- c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c", 
	"sccs","csd_nob","simpson_csd","rses","swls","pa","na")
# Check which columns actually exist in df2
existing_cols <- names_var[names_var %in% names(df2)]
psych::corr.test( df2[,existing_cols] )

# transport table:
# Fixing the column selection to only use existing columns
if(length(existing_cols) > 0) {
  corr_result <- psych::corr.test( df2[, existing_cols] )
  # Check if the columns exist before subsetting
  available_cols3 <- c("rses","swls","pa","na")[c("rses","swls","pa","na") %in% colnames(corr_result$r)]
  if(length(available_cols3) > 0) {
    tab <- corr_result$r[,available_cols3]
    # Only use rows that exist in the correlation matrix and are in our variables of interest
    valid_rows <- rownames( tab ) %in% c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c","sccs","csd_nob","simpson_csd")
    if(sum(valid_rows) > 0) {
      tab <- tab[valid_rows, ]
      tab <- round( tab, 2 )
      rownames( tab ) <- c("Daily Ave. Ne.","Daily Ave. Ex.","Daily Ave. Op.","Daily Ave. Ag.","Daily Ave. Co.","SCC","Neutral Objects","Simpson Task")[1:sum(valid_rows)]
      colnames( tab ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect")[1:length(available_cols3)]
      tab
    }
  }
  #write.table( tab, "Appendix1_TableA1.txt", row.names=T, col.names=T, sep = ";")
}

#- Partial-Correlations between variability and well-being measures

# Fixing the column names for partial correlations
all_possible_x_cols <- c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c", 
	"rses","swls","pa","na")
all_possible_y_cols <- c("csd_nob","simpson_csd")

existing_x_cols <- all_possible_x_cols[all_possible_x_cols %in% names(df2)]
existing_y_cols <- all_possible_y_cols[all_possible_y_cols %in% names(df2)]

if(length(existing_x_cols) > 0 && length(existing_y_cols) > 0) {
  res <- psych::partial.r( df2, x = existing_x_cols, y = existing_y_cols )
  res 
  psych::corr.p( res , n = 94 ) # because n = 96

  # transport table:
  # Only create table if the partial correlation result has the needed columns
  available_cols4 <- c("rses","swls","pa","na")[c("rses","swls","pa","na") %in% colnames(res)]
  if(length(available_cols4) > 0) {
    tab2 <- res[,available_cols4]
    # Filter rows to only those that exist and are Big Five mean variables
    valid_rows2 <- rownames( tab2 ) %in% c("csd_mean_n","csd_mean_e","csd_mean_o","csd_mean_a","csd_mean_c")
    if(sum(valid_rows2) > 0) {
      tab2 <- tab2[valid_rows2, ]
      tab2 <- round( tab2, 2 )
      rownames( tab2 ) <- c("Daily Ave. Ne.","Daily Ave. Ex.","Daily Ave. Op.","Daily Ave. Ag.","Daily Ave. Co.")[1:sum(valid_rows2)]
      colnames( tab2 ) <- c("Self-Est.","Life Sat.","Pos. Affect","Neg. Affect")[1:length(available_cols4)]
      tab2
    }
  }
  #write.table( tab2, "Appendix1_TableA2.txt", row.names=T, col.names=T, sep = ";")
}
sink()