sink("model_outputs.txt")
if (!requireNamespace("lme4", quietly = TRUE)) { 
  install.packages("lme4")
}
library(lme4)

# Fix file path - remove incorrect "xoxo/" directory
fmimlm <-read.table("motives_data.csv", header=T,sep=',')
print(summary(fmimlm))

###Primary Analyses

##Mean levels of accuracy, normativity, positivity, and assumed similarity (Table 3)

#Traits and motives
summary(lmer(RATINGc ~ TSELFc + SMEANc  + SDMEANc+ PSELFc + (TSELFc + SMEANc  + SDMEANc  + PSELFc  | PID),data= fmimlm) )

#Traits only - note that in some of the following models have model convergence error messages due to the low random intercept variance - this was kept within the models when removal impacted estimation of the distinctive accuracy random effect variance. The fixed effect results were consistent in both models.
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc  + ( TSELFc +  SMEANc + SDMEANc + PSELFc  | PID) ,data= subset(fmimlm, fmimlm$motive ==0)) )

#Motives only
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc  +  (TSELFc + SMEANc  + SDMEANc + PSELFc   | PID) ,data= subset(fmimlm, fmimlm$motive ==1)) )

##Comparing traits vs. motives (Table 4)
summary(lmer(RATINGc ~ TSELFc* motive + SMEANc * motive + SDMEANc*motive +PSELFc * motive +  (TSELFc + SMEANc  + SDMEANc + PSELFc | PID),data= fmimlm) )

##Role of item visibility (Table 4)

#does item observability predict impressions?
summary(lmer(RATINGc ~ TSELFc* OMEANc + SMEANc * OMEANc + SDMEANc * OMEANc + PSELFc * OMEANc +(TSELFc  + SMEANc   + SDMEANc + PSELFc | PID),data= fmimlm) )

#does controlling for item observability reduce differences between trait and motive impressions? (Combined Analyses)

# Fix variable name: PSELF should be PSELFc to match other models
summary(lmer(RATINGc ~ TSELFc* motive + SMEANc * motive + SDMEANc * motive+ PSELFc * motive+TSELFc* OMEANc + SMEANc * OMEANc + SDMEANc * OMEANc+ PSELFc * OMEANc + (TSELFc + SDMEANc + SMEANc  + PSELFc   | PID),data= fmimlm) )


##Links with friendship quality (Table 5)

#Perceiver-rated
#Links for traits and difference for trait vs. motives (Motive variable coding: 0 = trait, 1 = motive):
summary(lmer(RATINGc ~ TSELFc* pfriendqz*motive +SMEANc* pfriendqz *motive +SDMEANc* pfriendqz *motive + PSELFc* pfriendqz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* pfriendqz* motive + SMEANc* pfriendqz * motive +SDMEANc* pfriendqz * motive +PSELFc* pfriendqz * motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Target-rated
#Links for traits and difference for trait vs. motives:
summary(lmer(RATINGc ~ TSELFc* tfriendqz*motive + SMEANc* tfriendqz *motive +SDMEANc* tfriendqz *motive +PSELFc* tfriendqz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | PID),data= fmimlm) )

#Links for motives:
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* tfriendqz* motive + SMEANc* tfriendqz * motive +SDMEANc* tfriendqz * motive +PSELFc* tfriendqz * motive +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | PID),data= fmimlm) )

###Additional and supplemental analyses

##Other friendship characteristcs (Foonote 3)

#Friendship length 
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lmer(RATINGc ~ TSELFc* PRELLengthz*motive +SMEANc* PRELLengthz *motive +SDMEANc* PRELLengthz *motive + PSELFc* PRELLengthz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* PRELLengthz* motive + SMEANc* PRELLengthz * motive +SDMEANc* PRELLengthz * motive +PSELFc* PRELLengthz * motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lmer(RATINGc ~ TSELFc* TRELLengthz*motive + SMEANc* TRELLengthz *motive +SDMEANc* TRELLengthz *motive +PSELFc* TRELLengthz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | PID),data= fmimlm) )

#Links for motives:
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* TRELLengthz* motive + SMEANc* TRELLengthz * motive +SDMEANc* TRELLengthz * motive +PSELFc* TRELLengthz * motive +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | PID),data= fmimlm) )

#Quality controlling for friendship length
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lmer(RATINGc ~ TSELFc* pfriendqz*motive +SMEANc* pfriendqz *motive +SDMEANc* pfriendqz *motive + PSELFc* pfriendqz *motive + TSELFc* PRELLengthz*motive +SMEANc* PRELLengthz *motive +SDMEANc* PRELLengthz *motive + PSELFc* PRELLengthz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* pfriendqz* motive + SMEANc* pfriendqz * motive +SDMEANc* pfriendqz * motive +PSELFc* pfriendqz * motive +TSELFc* PRELLengthz* motive + SMEANc* PRELLengthz * motive +SDMEANc* PRELLengthz * motive +PSELFc* PRELLengthz * motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lmer(RATINGc ~ TSELFc* tfriendqz*motive + SMEANc* tfriendqz *motive +SDMEANc* tfriendqz *motive +PSELFc* tfriendqz *motive +TSELFc* TRELLengthz*motive + SMEANc* TRELLengthz *motive +SDMEANc* TRELLengthz *motive +PSELFc* TRELLengthz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | PID),data= fmimlm) )

#Links for motives:
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* tfriendqz* motive + SMEANc* tfriendqz * motive +SDMEANc* tfriendqz * motive +PSELFc* tfriendqz * motive + TSELFc* TRELLengthz* motive + SMEANc* TRELLengthz * motive +SDMEANc* TRELLengthz * motive +PSELFc* TRELLengthz * motive +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | PID),data= fmimlm) )


##closeness
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lmer(RATINGc ~ TSELFc* pclosez*motive +SMEANc* pclosez *motive +SDMEANc* pclosez *motive + PSELFc* pclosez *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* pclosez* motive + SMEANc* pclosez * motive +SDMEANc* pclosez * motive +PSELFc* pclosez * motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | PID),data= fmimlm) )


#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lmer(RATINGc ~ TSELFc* tclosez*motive + SMEANc* tclosez *motive +SDMEANc* tclosez *motive +PSELFc* tclosez *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | PID),data= fmimlm) )

#Links for motives:
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* tclosez* motive + SMEANc* tclosez * motive +SDMEANc* tclosez * motive +PSELFc* tclosez * motive +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | PID),data= fmimlm) )

##Target*Perceiver friendship quality interaction (Footnote 4)

#Overall
summary(lmer(RATINGc ~ TSELFc* pfriendqz* tfriendqz + SMEANc* pfriendqz * tfriendqz +SDMEANc* pfriendqz * tfriendqz +PSELFc* pfriendqz * tfriendqz +  (0 + TSELFc + SMEANc  + SDMEANc +PSELFc       | PID),data= fmimlm) )

#Difference for trait vs. motives and links for traits:
summary(lmer(RATINGc ~ TSELFc* pfriendqz* tfriendqz*motive + SMEANc* pfriendqz * tfriendqz*motive + SDMEANc* pfriendqz * tfriendqz*motive + PSELFc* pfriendqz * tfriendqz*motive   + (0 + TSELFc + SMEANc + SDMEANc +PSELFc       | PID),data= fmimlm) )

#Links for motives:
# Fix variable name: trait should be motive to match the coding description
summary(lmer(RATINGc ~ TSELFc* pfriendqz* tfriendqz*motive + SMEANc* pfriendqz * tfriendqz* motive + SDMEANc* pfriendqz * tfriendqz* motive + PSELFc* pfriendqz * tfriendqz* motive   + (0 + TSELFc + SMEANc + SDMEANc +PSELFc       | PID),data= fmimlm) )


##individual trait and motive analyses (Supplementary Online Materials - Table S1)
#levels for each trait
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$AG == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$EX == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$NE == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$OP == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$CO == 1 ) ))

#levels for each motive
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$SP == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$DA == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$AFG == 1 ) ))
# Fix duplicate SDMEANc term
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$AE == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$AI == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$ST == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$MA == 1 ) ))
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+(TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$MRB == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc + (TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$MRG == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc +(TSELFc + PSELFc + SMEANc + SDMEANc    | PID)  ,data= subset(fmimlm, fmimlm$KC == 1 ) ))

#comparisons to average for each trait
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* EX + SMEANc* EX + SDMEANc* EX +PSELFc* EX + (TSELFc + SMEANc + SDMEANc +PSELFc    | PID),data= subset(fmimlm, fmimlm$motive == 0 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* OP + SMEANc* OP + SDMEANc* OP +PSELFc*OP+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | PID),data= subset(fmimlm, fmimlm$motive == 0   ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* AG + SMEANc* AG + SDMEANc* AG +PSELFc*AG + (TSELFc + SMEANc + SDMEANc   +PSELFc  | PID),data= subset(fmimlm, fmimlm$motive == 0 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* NE + SMEANc* NE + SDMEANc* NE +PSELFc*NE+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | PID),data= subset(fmimlm, fmimlm$motive == 0  ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* CO + SMEANc* CO + SDMEANc* CO+PSELFc*CO+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | PID), data= subset(fmimlm,fmimlm$motive == 0  ) ))

#comparisons to average for each motive
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* SP + SMEANc * SP + SDMEANc* SP + PSELFc*SP+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID),data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* DA + SMEANc* DA + SDMEANc* DA + PSELFc*DA + (TSELFc + SMEANc + SDMEANc    + PSELFc | PID),data= subset(fmimlm, fmimlm$motive == 1  ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* AFG + SMEANc* AFG + SDMEANc* AFG + PSELFc*AFG+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* AE + SMEANc* AE + SDMEANc* AE + PSELFc*AE+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* AI + SMEANc* AI + SDMEANc* AI + PSELFc*AI+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm,fmimlm$motive == 1) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* ST + SMEANc* ST + SDMEANc* ST + PSELFc*ST+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* MA + SMEANc* MA + SDMEANc* MA + PSELFc*MA+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID)  ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* MRB + SMEANc* MRB + SDMEANc* MRB + PSELFc*MRB + (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* MRG + SMEANc* MRG + SDMEANc* MRG + PSELFc*MRG+ (TSELFc + SMEANc + SDMEANc    + PSELFc | PID) ,data= subset(fmimlm, fmimlm$motive == 1  ) ))
# Fix variable name: SDMEAN should be SDMEANc
summary(lmer(RATINGc ~ TSELFc* KC + SMEANc* KC + SDMEANc* KC + PSELFc*KC + (TSELFc + SMEANc + SDMEANc    + PSELFc | PID),data= subset(fmimlm, fmimlm$motive == 1  ) ))
sink()