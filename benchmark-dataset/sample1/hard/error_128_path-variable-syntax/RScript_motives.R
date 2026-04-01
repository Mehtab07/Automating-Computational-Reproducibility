sink("model_outputs.txt")
library(lme4)

fmimlm <-read.table("data/motives_data.csv", header=T,sep=',')
print(summary(fmimlm))

###Primary Analyses

##Mean levels of accuracy, normativity, positivity, and assumed similarity (Table 3)

#Traits and motives
summary(lm(RATINGc ~ TSELFc + SMEANc  + SDMEANc+ PSELFc + (TSELFc + SMEANc  + SDMEANc  + PSELFc  | .),data= fmimlm) )

#Traits only - note that in some of the following models have model convergence error messages due to the low random intercept variance - this was kept within the models when removal impacted estimation of the distinctive accuracy random effect variance. The fixed effect results were consistent in both models.
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc  + ( TSELFc +  SMEANc + SDMEANc + PSELFc  | .) ,data= subset(fmimlm, fmimlm$motive ==0)) )

#Motives only
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc  +  (TSELFc + SMEANc  + SDMEANc + PSELFc   | .) ,data= subset(fmimlm, fmimlm$motive ==1)) )

##Comparing traits vs. motives (Table 4)
summary(lm(RATINGc ~ TSELFc* motive + SMEANc * motive + SDMEANc*motive +PSELFc * motive +  (TSELFc + SMEANc  + SDMEANc + PSELFc | .),data= fmimlm) )

##Role of item visibility (Table 4)

#does item observability predict impressions?
summary(lm(RATINGc ~ TSELFc* OMEANc + SMEANc * OMEANc + SDMEANc * OMEANc + PSELFc * OMEANc +(TSELFc  + SMEANc   + SDMEANc + PSELFc | .),data= fmimlm) )

#does controlling for item observability reduce differences between trait and motive impressions? (Combined Analyses)

summary(lm(RATINGc ~ TSELFc* motive + SMEANc * motive + SDMEANc * motive+ PSELFc * motive+TSELFc* OMEANc + SMEANc * OMEANc + SDMEANc * OMEANc+ PSELFc * OMEANc + (TSELFc + SDMEANc + SMEANc  + PSELF   | .),data= fmimlm) )


##Links with .ship quality (Table 5)

#Perceiver-rated
#Links for traits and difference for trait vs. motives (Motive variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* fendqz*motive +SMEANc* fendqz *motive +SDMEANc* fendqz *motive + PSELFc* fendqz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* fendqz* trait + SMEANc* fendqz * trait +SDMEANc* fendqz * trait +PSELFc* fendqz * trait +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Target-rated
#Links for traits and difference for trait vs. motives:
summary(lm(RATINGc ~ TSELFc* tfriendqz*motive + SMEANc* tfriendqz *motive +SDMEANc* tfriendqz *motive +PSELFc* tfriendqz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | .),data= fmimlm) )

#Links for motives:
summary(lm(RATINGc ~ TSELFc* tfriendqz* trait + SMEANc* tfriendqz * trait +SDMEANc* tfriendqz * trait +PSELFc* tfriendqz * trait +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | .),data= fmimlm) )

###Additional and supplemental analyses

##Other friendship characteristcs (Foonote 3)

#Friendship length 
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* PRELLengthz*motive +SMEANc* PRELLengthz *motive +SDMEANc* PRELLengthz *motive + PSELFc* PRELLengthz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* PRELLengthz* trait + SMEANc* PRELLengthz * trait +SDMEANc* PRELLengthz * trait +PSELFc* PRELLengthz * trait +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lm(RATINGc ~ TSELFc* TRELLengthz*motive + SMEANc* TRELLengthz *motive +SDMEANc* TRELLengthz *motive +PSELFc* TRELLengthz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | .),data= fmimlm) )

#Links for motives:
summary(lm(RATINGc ~ TSELFc* TRELLengthz* trait + SMEANc* TRELLengthz * trait +SDMEANc* TRELLengthz * trait +PSELFc* TRELLengthz * trait +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | .),data= fmimlm) )

#Quality controlling for friendship length
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* fendqz*motive +SMEANc* fendqz *motive +SDMEANc* fendqz *motive + PSELFc* fendqz *motive + TSELFc* PRELLengthz*motive +SMEANc* PRELLengthz *motive +SDMEANc* PRELLengthz *motive + PSELFc* PRELLengthz *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* fendqz* trait + SMEANc* fendqz * trait +SDMEANc* fendqz * trait +PSELFc* fendqz * trait +TSELFc* PRELLengthz* trait + SMEANc* PRELLengthz * trait +SDMEANc* PRELLengthz * trait +PSELFc* PRELLengthz * trait +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lm(RATINGc ~ TSELFc* tfriendqz*motive + SMEANc* tfriendqz *motive +SDMEANc* tfriendqz *motive +PSELFc* tfriendqz *motive +TSELFc* TRELLengthz*motive + SMEANc* TRELLengthz *motive +SDMEANc* TRELLengthz *motive +PSELFc* TRELLengthz *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | .),data= fmimlm) )

#Links for motives:
summary(lm(RATINGc ~ TSELFc* tfriendqz* trait + SMEANc* tfriendqz * trait +SDMEANc* tfriendqz * trait +PSELFc* tfriendqz * trait + TSELFc* TRELLengthz* trait + SMEANc* TRELLengthz * trait +SDMEANc* TRELLengthz * trait +PSELFc* TRELLengthz * trait +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | .),data= fmimlm) )


##closeness
#Perceiver-rated
#Difference for trait vs. motives and links for traits (Motive variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* pclosez*motive +SMEANc* pclosez *motive +SDMEANc* pclosez *motive + PSELFc* pclosez *motive +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )

#Links for motives (Trait variable coding: 0 = trait, 1 = motive):
summary(lm(RATINGc ~ TSELFc* pclosez* trait + SMEANc* pclosez * trait +SDMEANc* pclosez * trait +PSELFc* pclosez * trait +  (0 + TSELFc + SMEANc +SDMEANc +PSELFc       | .),data= fmimlm) )


#Target-rated
#Difference for trait vs. motives and links for traits:
summary(lm(RATINGc ~ TSELFc* tclosez*motive + SMEANc* tclosez *motive +SDMEANc* tclosez *motive +PSELFc* tclosez *motive +  (0 + TSELFc + SMEANc  +SDMEANc+PSELFc       | .),data= fmimlm) )

#Links for motives:
summary(lm(RATINGc ~ TSELFc* tclosez* trait + SMEANc* tclosez * trait +SDMEANc* tclosez * trait +PSELFc* tclosez * trait +  (0 + TSELFc + SMEANc+SDMEANc  +PSELFc       | .),data= fmimlm) )

##Target*Perceiver friendship quality interaction (Footnote 4)

#Overall
summary(lm(RATINGc ~ TSELFc* fendqz* tfriendqz + SMEANc* fendqz * tfriendqz +SDMEANc* fendqz * tfriendqz +PSELFc* fendqz * tfriendqz +  (0 + TSELFc + SMEANc  + SDMEANc +PSELFc       | .),data= fmimlm) )

#Difference for trait vs. motives and links for traits:
summary(lm(RATINGc ~ TSELFc* fendqz* tfriendqz*motive + SMEANc* fendqz * tfriendqz*motive + SDMEANc* fendqz * tfriendqz*motive + PSELFc* fendqz * tfriendqz*motive   + (0 + TSELFc + SMEANc + SDMEANc +PSELFc       | .),data= fmimlm) )

#Links for motives:
summary(lm(RATINGc ~ TSELFc* fendqz* tfriendqz*trait + SMEANc* fendqz * tfriendqz* trait + SDMEANc* fendqz * tfriendqz* trait + PSELFc* fendqz * tfriendqz* trait   + (0 + TSELFc + SMEANc + SDMEANc +PSELFc       | .),data= fmimlm) )


##individual trait and motive analyses (Supplementary Online Materials - Table S1)
#levels for each trait
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc + PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$AG == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$EX == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$NE == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$OP == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$CO == 1 ) ))

#levels for each motive
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$SP == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$DA == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$AFG == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc+ SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$AE == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$AI == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$ST == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+ (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$MA == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEANc+ PSELFc+(TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$MRB == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEAN+ PSELFc + (TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$MRG == 1 ) ))
summary(lm(RATINGc ~ TSELFc + SMEANc + SDMEAN+ PSELFc +(TSELFc + PSELFc + SMEANc + SDMEANc    | .)  ,data= subset(fmimlm, fmimlm$KC == 1 ) ))

#comparisons to average for each trait
summary(lm(RATINGc ~ TSELFc* EX + SMEANc* EX + SDMEAN* EX +PSELFc* EX + (TSELFc + SMEANc + SDMEANc +PSELFc    | .),data= subset(fmimlm, fmimlm$motive == 0 ) ))
summary(lm(RATINGc ~ TSELFc* OP + SMEANc* OP + SDMEAN* OP +PSELFc*OP+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | .),data= subset(fmimlm, fmimlm$motive == 0   ) ))
summary(lm(RATINGc ~ TSELFc* AG + SMEANc* AG + SDMEAN* AG +PSELFc*AG + (TSELFc + SMEANc + SDMEANc   +PSELFc  | .),data= subset(fmimlm, fmimlm$motive == 0 ) ))
summary(lm(RATINGc ~ TSELFc* NE + SMEANc* NE + SDMEAN* NE +PSELFc*NE+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | .),data= subset(fmimlm, fmimlm$motive == 0  ) ))
summary(lm(RATINGc ~ TSELFc* CO + SMEANc* CO + SDMEAN* CO+PSELFc*CO+ (TSELFc + SMEANc + SDMEANc  +PSELFc   | .), data= subset(fmimlm,fmimlm$motive == 0  ) ))

#comparisons to average for each motive
summary(lm(RATINGc ~ TSELFc* SP + SMEANc * SP + SDMEAN* SP + PSELFc*SP+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .),data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* DA + SMEANc* DA + SDMEAN* DA + PSELFc*DA + (TSELFc + SMEANc + SDMEANc    + PSELFc | .),data= subset(fmimlm, fmimlm$motive == 1  ) ))
summary(lm(RATINGc ~ TSELFc* AFG + SMEANc* AFG + SDMEAN* AFG + PSELFc*AFG+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* AE + SMEANc* AE + SDMEAN* AE + PSELFc*AE+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* AI + SMEANc* AI + SDMEAN* AI + PSELFc*AI+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm,fmimlm$motive == 1) ))
summary(lm(RATINGc ~ TSELFc* ST + SMEANc* ST + SDMEAN* ST + PSELFc*ST+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* MA + SMEANc* MA + SDMEAN* MA + PSELFc*MA+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .)  ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* MRB + SMEANc* MRB + SDMEAN* MRB + PSELFc*MRB + (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm, fmimlm$motive == 1 ) ))
summary(lm(RATINGc ~ TSELFc* MRG + SMEANc* MRG + SDMEAN* MRG + PSELFc*MRG+ (TSELFc + SMEANc + SDMEANc    + PSELFc | .) ,data= subset(fmimlm, fmimlm$motive == 1  ) ))
summary(lm(RATINGc ~ TSELFc* KC + SMEANc* KC + SDMEAN* KC + PSELFc*KC + (TSELFc + SMEANc + SDMEANc    + PSELFc | .),data= subset(fmimlm, fmimlm$motive == 1  ) ))
sink()
