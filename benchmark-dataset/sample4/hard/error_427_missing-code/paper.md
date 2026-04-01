## Full Text

REPLY
The True Role That Suppressor Effects Play in Condition-Based
Regression Analysis: None. A Reply to Fiedler (2021)
Sarah Humberg1, Michael Dufner2, 3, Felix D. Schönbrodt4, Katharina Geukes1, Roos Hutteman5,
Maarten H. W. van Zalk6, Jaap J. A. Denissen5, Steffen Nestler1, and Mitja D. Back1
1 Department of Psychology, University of Münster
2 Department of Psychology and Psychotherapy, Witten/Herdecke University
3 Department of Psychology, University of Leipzig
4 Department of Psychology, Ludwig-Maximilians-Universität München
5 Department of Developmental Psychology, Utrecht University
6 Department of Psychology, University of Osnabrück
Condition-based regression analysis (CRA) is a statistical method for testing self-enhancement effects. That
is, CRA indicates whether, in a set of empirical data, people with higher values on the directed discrepancy
self-view S minus reality criterion R (i.e., S-R) tend to have higher values on some outcome variable (e.g.,
happiness). In a critical comment, Fiedler (2021) claims that CRA yields inaccurate conclusions in data with
a suppressor effect. Here, we show that Fiedler’s critique is unwarranted. All data that are simulated in his
comment show a positive association between S-R and H, which is accurately detected by CRA. By
construction, CRA indicates an association between S-R and H only when it is present in the data. In contrast
to Fiedler’s claim, it also yields valid conclusions when the outcome variable is related only to the self-view
or when there is a suppressor effect. Our clariﬁcations provide guidance for evaluating Fiedler’s comment,
clear up with the common heuristic that suppressor effects are always problematic, and assist readers in fully
understanding CRA.
Keywords: condition-based regression analysis, self-enhancement, suppressor effect, positivity of self-view
In Humberg et al. (2018), we established condition-based regression
analysis (CRA) as a statistical method for investigating the (mal)-
adaptive effects of self-enhancement (SE). Fiedler (2021) claims that
CRA yields inaccurate conclusions when a suppressor effect is present
in the data. Here, we show that Fiedler’s critique is unwarranted.
The Aim and Logic of CRA
For decades, researchers in social and personality psychology
have been interested in exploring the consequences of SE. To this
aim, they typically deﬁned the psychological construct SE1 as the
directed discrepancy S-R between people’s self-view S and their
This document is copyrighted by the American Psychological Association or one of its allied publishers.
This article is intended solely for the personal use of the individual user and is not to be disseminated broadly.
Sarah Humberg
https://orcid.org/0000-0002-7891-3622
Felix D. Schönbrodt
https://orcid.org/0000-0002-8282-3910
Katharina Geukes
https://orcid.org/0000-0002-7424-306X
Maarten H. W. van Zalk
https://orcid.org/0000-0002-0185-8805
Jaap J. A. Denissen
https://orcid.org/0000-0002-6282-4107
Mitja D. Back
https://orcid.org/0000-0003-2186-1558
Supplemental materials for this article can be found at https://osf.io/fbshg/.
Sarah Humberg played lead role in project administration, software,
visualization and writing of original draft. Michael Dufner played equal
role in writing of review and editing. Felix D. Schönbrodt played equal role
in visualization and writing of review and editing. Katharina Geukes played
equal role in writing of review and editing. Roos Hutteman played equal role
in writing of review and editing. Maarten H. W. van Zalk played equal role in
writing of review and editing. Jaap J. A. Denissen played equal role in writing
of review and editing. Steffen Nestler played equal role in writing of review
and editing. Mitja D. Back played equal role in writing of review and editing.
Correspondence concerning this article should be addressed to Sarah
Humberg, Department of Psychology, University of Münster, Fliednerstr.
21, 48149 Münster, Germany. Email: sarah.humberg@wwu.de
1 Within this response, we remain consistent with the conceptual and
mathematical notation in our article that introduced CRA (Humberg et al.,
2018), which sometimes differs from the terminology that Fiedler used.
Whenever we consider it vital to support readers in making the match
between our original terminology and his, we provide additional comments
in footnotes.
To begin, the deﬁnition of SE stated here matches the one in Humberg
et al. (2018) and is the deﬁnition of SE that implies the applicability of the
version of CRA that Fiedler criticizes (see Humberg et al., 2018, for
variants of CRA that ﬁt other common deﬁnitions of SE). The deﬁnition
diverges from the terminology in Fiedler’s comment, where the term
“self-enhancement (SE)” labels an expected association between the
construct SE and happiness and also the result of the statistical index
r(S-R)H.
Journal of Personality and Social Psychology:
Personality Processes and Individual Differences
© 2022 American Psychological Association
2022, Vol. 123, No. 4, 884–888
ISSN: 0022-3514
https://doi.org/10.1037/pspp0000428
884

value on some reality criterion2 R, and posited an association
between SE = S-R and some outcome of interest.
As a concrete example, suppose that Researcher X deﬁnes SE as
S-R and suggests a positive effect of SE = S-R on people’s
happiness. Aiming to put her theory to an empirical test, Researcher
X translates it into a corresponding expectation about measurable
variables: She expects that the higher an individual’s value of SE =
S-R is, the higher will his/her happiness value H be. That is, she
expects that “people with higher S-R tend to have higher H”—
which we here call “S-R effect pattern.” CRA is a statistical method
that can inform Researcher X whether the expected S-R effect
pattern is present in her data. Because an S-R effect pattern is an
association between three variables at a time (S, R, H), CRA is based
on a model that can mirror such three-dimensional associations:
H = c0 + c1S + c2R + ε:
(1)
The CRA method speciﬁes that, after Researcher X has estimated
the regression in Equation 1, she can conclude that the data show an
S-R effect pattern if the estimated coefﬁcients satisfy two conditions:
c1 must be signiﬁcantly positive and c2 must be signiﬁcantly negative.
Figure
1A
shows
the
data
assessed
by
Researcher
X
(see osf.io/fbshg for the R code to reproduce all simulated data,
plots, and results from this article). Each person’s self-rating S,
his/her criterion value R, and his/her happiness value H determines
the position of his/her dot in the three-dimensional coordinate
system. Eyeballing the raw data in Figure 1A shows that people
with higher S-R values tend to have higher H: People whose self-
view exceeds their criterion value by a lot (e.g., Tom with S = 1.4,
R = −0.4) tend to be happier than people whose self-view is about
accurate (Ann, S = −1.7, R = −1.2), and the latter are happier
than people whose self-view is far behind their criterion value
(Sam, S = −1.6, R = 0.2). CRA correctly supports this visual
impression of the trend in the data (see Figure 1C for the graph).
The estimated coefﬁcients (c1 = .5, c2 = −.2) satisfy the conditions
c1 > 0 and c2 < 0. That is, the data in Figure 1A show an S-R effect
pattern and CRA correctly detects this.
More generally, the CRA conditions “c1 > 0 and c2 < 0” ensure that
CRA accurately detects S-R effect patterns in any data that show such
a trend. This is because the CRA conditions are a direct translation of
the expected pattern into a corresponding statistical representation.
When we expect an S-R effect pattern, we expect that, for two
individuals with equal R values, the person with the higher self-
view S is happier, because he/she is the person with higher SE = S-R.
This expectation translates into c1 > 0, because the math of multiple
regression implies that c1 is the association between S and H
conditional on R (i.e., in a hypothetical subsample of people with
the same R). Additionally, we expect that, for two individuals with
equal S values, the person with the lower R is happier, because he/she
is the one with higher SE in this case. The statistical representation is
c2 < 0, because c2 is the association between R and H conditional on S.
Hence, basic mathematical facts of multiple regression imply that
the CRA conditions (c1 > 0, c2 < 0) exactly represent an expected S-R
effect pattern. In particular, this logic ensures that CRA indicates an S-
R effect pattern if and only if S-R is systematically related to H
(irrespective of any additional main effects of S and R, which are also
allowed for). It thereby solves the major limitation of the traditional
approach, which relies on the correlation between the difference
scores S-R and H (r(S-R)H) and has frequently indicated an S-R effect
pattern when the outcome was in fact only systematically related to
the positivity of people’s self-views (PSV) but not to the discrepancy
S-R (Humberg et al., 2018)—that is, when the data show a “PSV effect
only pattern.”3 CRA avoids this mistake. For example, the data in
Figure 1B contradict an S-R effect pattern because people with
different levels of SE are about equally happy. In contrast to the
traditional approach, CRA accurately detects this, as the coefﬁcients
(c1 = .6, c2 = 0; see Figure 1D) do not satisfy the CRA conditions.
In sum, the logic behind CRA ensures that when the CRA
conditions are satisﬁed, one can conclude that “people with higher
S-R tend to have higher H” in the data at hand. Beyond the
conceptual proof just described (see also Humberg et al., 2018),
this fact can also be backed up mathematically (Supplement B at osf
.io/4p88b) and visually (Supplement H at osf.io/4p88b).
Fiedler’s Critique of CRA
Fiedler’s comment focuses on data with a correlational structure
that implies a suppressor effect, namely, rSR > 0, rSH > 0, and
rRH = 0. We will refer to this structure as a “PPZ-correlation-
structure” (PPZ = Positive rSR—Positive rSH—Zero rRH). Fiedler
observes that CRA indicates an S-R effect pattern for data with a
PPZ-correlation-structure because the correlations imply c1 > 0 and
c2 < 0 (see osf.io/fbshg for the mathematical proof and open code
that reproduces Fiedler’s simulation). The cooccurrence of a zero
correlation rRH = 0 and a negative regression weight of R (c2 < 0) is
commonly labeled a “suppressor effect.”
Fiedler concludes that his observation “necessarily falsiﬁes the
CRA” (p. 793) because “the regression pattern that CRA presumes
to rule out a positive self-view account indeed follows necessarily
from a suppressor effect entailed in a positive self-view account”
(Abstract). That is, Fiedler claims that a PPZ-correlation-structure
implies a PSV effect only pattern and thereby contradicts an S-R
effect pattern. Researcher X’s data (Figure 1A) is a counter example
that proves this argument and thereby Fiedler’s conclusion about
CRA invalid. The data do have a PPZ-correlation-structure (rSR = .4,
rSH = .4, rRH = 0) and thereby satisﬁes the premise of the argument.
However, as explained above, it shows an S-R effect pattern and not
a PSV effect only pattern, thereby violating the assumed implica-
tion. Researcher X’s conclusion that “people with higher S-R tend to
have higher H” is correct.
More generally, all data with a PPZ-correlation-structure show an
S-R effect pattern that is accurately detected with CRA. For an
empirical demonstration of this fact, readers can use the R code at
osf.io/fbshg to inspect (inﬁnitely many) examples with arbitrary PPZ-
correlation-structures (see the ﬁle ComF_SOM.pdf at osf.io/fbshg
for guidance). More importantly, it is a general principle that follows
from two basic mathematical facts: First, all data with a PPZ-
correlation-structure (rSR > 0, rSH > 0, rRH = 0) has coefﬁcients
This document is copyrighted by the American Psychological Association or one of its allied publishers.
This article is intended solely for the personal use of the individual user and is not to be disseminated broadly.
2 Fiedler denotes the reality criterion R as “O.” We stick with the original
notation from the CRA article to avoid confusion with the number zero.
3 We use the term PSV in its original sense (the psychological construct
“positivity of self-view”; Humberg et al., 2018), which conﬂicts with
Fiedler’s deﬁnition as a pattern of correlations, “PSV (rSH > 0; [rRH] = 0),”
p. 793. Moreover, the PSV effect only pattern described here and in
Humberg et al. (2018) does not match the “PSV pattern” that Fiedler deﬁnes
as a pattern of correlations, “PSV pattern (rSH > 0; [rRH] = 0; [rSR] > 0),”
p. 793; Fiedler’s “PSV pattern” is a “PPZ-correlation-structure” in the
notation introduced below.
REPLY TO FIEDLER
885

c1 > 0 and c2 < 0 (see osf.io/fbshg for the proof). Second, c1 is the
association between S and H conditional on R, and c2 is the associa-
tion between R and H conditional on S. As shown above, this second
fact implies that the coefﬁcient pattern “c1 > 0 and c2 < 0” is one-to-
one correspondent to an S-R effect pattern: All data with c1 > 0 and c2
< 0, including but not limited to data with a PPZ-correlation-structure,
show an S-R effect pattern and CRA accurately detects this.
This implies that Fiedler’s critique of CRA is unjustiﬁed. CRA
provides valid conclusions about S-R effect patterns, also in data
with a suppressor effect.
We learned during the review phase for this article that many
readers seek further explanation at this point, because they extracted
(implicit) arguments from Fiedler’s comment that seem yet unad-
dressed. We will now provide clariﬁcations about suppressor effects
and about CRA that clear up these remaining uncertainties.
Clariﬁcations About Suppressor Effects
To many researchers, suppressor effects seem problematic per se.
This “bad guy” heuristic presumably stems from the verbal imagery in
This document is copyrighted by the American Psychological Association or one of its allied publishers.
This article is intended solely for the personal use of the individual user and is not to be disseminated broadly.
Figure 1
Example Data and Corresponding Graphs of the Fitted Regression Models (Equation 1)
Note.
PSV = people’s self-views. Panel A highlights an example person with a high value of S-R (Tom), a person whose
S-R value is near zero (Ann), and a person with a very low, negative value of S-R (Sam). For each data set, we drew N = 100,000
cases to ensure that the sample correlations matched the correlations that were speciﬁed for the population. The plots with raw
data show a random selection of 50 cases. The R code that can be used to generate the data and reproduce all plots and results is
provided at osf.io/fbshg. The estimated models are: Panel C: H = 0.5S−0.2R; Panel D: H = 0.6S + 0R. See the online article for
the color version of this ﬁgure.
886
HUMBERG ET AL.

the psychological literature that often portrays a suppressor effect as
an active creature that is messing around in the data, “suppressing” or
“absorbing” parts of the variables’ variances. The heuristic is often
coupled with the idea that correlations and regression weights can be
compared in terms of how “true” they are or that one of them could
causally “produce” the other and thereby render it spurious or alter its
meaning.
However, the “bad guy” heuristic and the involved ideas are not
supported by the statistical literature. Instead, methodologists
emphasized that, to make a reasoned claim that the suppressor
effect is problematic in a given situation, one must rationally explain
why this attribute of the data affects the conclusion (e.g., Cohen
et al., 2002). For the case of CRA, such an argument would need to
explain why the zero correlation rRH = 0 in combination with c2 < 0
affects the meaning of the regression weights or why it contradicts
an S-R effect pattern. Interestingly, Fiedler’s comment does not
provide such an argument. And in fact, such an argument cannot
exist because it would contradict basic mathematical principles.
Correlations and regression weights are descriptions of empirical
data. Both of them are equally “true” information about the data and
none of them can causally “produce” the other. Neither the suppres-
sor effect (“rRH = 0 and c2 < 0”) nor the observation that rRH = 0 can
inﬂuence the math of regression analysis, the trustworthiness of c2,
or its interpretation as the association between R and H conditional
on S, and (together with a respective fact about c1) this is sufﬁcient
for the CRA logic to work.
It also makes sense conceptually that suppressor effects play no
role for the detection of S-R effect patterns. Fiedler’s argument bases
on the assumption that bivariate correlations (e.g., rRH = 0 in a PPZ-
correlation-structure) can inform about the presence or absence of an
S-R effect pattern. By deﬁnition, however, research on the con-
sequences of SE aims to reveal how different constellations of two
variables (the directed discrepancy between S and R) are related to a
third one (happiness): The aim is to understand the interrelations
between three variables at a time. Examining the correlation
between two of the variables (e.g., rRH) is not decisive for this
aim; just like univariate information (e.g., mean[X] = 5) is not
informative to understand bivariate associations (see osf.io/fbshg for
an empirical illustration of this fact). Instead, a multivariate
approach is needed, which is offered by CRA.
In sum, the suppressor effect is not a “bad guy,” but a descriptive
attribute of the data. It plays no role in investigations of S-R effect
patterns because it touches neither the logic of CRA, nor the
phenomenon of interest.
Clariﬁcations About CRA
During the review process, we also encountered uncertainties
about what CRA can be expected to accomplish. In brief, CRA is
a statistical method that detects a speciﬁc pattern in empirical
data. It is applicable when researchers expect that their data show
a linear discrepancy effect pattern—a linear association between
two variables’ directed discrepancy X-Y and a third variable Z. In
SE research, this is the case when one claims that, for chosen
assessments of a self-view variable S, a reality criterion R, and an
outcome variable H, people with higher discrepancy scores S-R
should tend to have higher values of H. Note that an expected
linear association between SE and H translates to this linear
discrepancy effect pattern (“S-R related to H”) only if SE is
operationalized as the algebraic difference S-R. Whereas this is
the common choice, the ﬁeld has yet not reached a consensus on
whether S-R or other operationalizations best reﬂect the theoreti-
cal construct SE (see Humberg et al., 2018, for an overview).
Researchers who prefer a different operationalization (e.g., the
residuals in the regression S = b0 + b1R + e, which implies
SE = e = S −bb1R −bb0) will not expect a linear discrepancy effect
pattern but a different pattern (e.g., “people with higher values of
S −bb1R −bb0 tend to have higher H”), whose detection requires a
respectively adapted version of CRA (see the supplement of
Humberg et al., 2018).
Relatedly, a reviewer suggested that maybe Fiedler’s conception
of an SE effect excludes a suppressor effect by deﬁnition. This
alternative hypothesis could be tested by combining CRA with tests
of the bivariate correlations; but please note that we consider it
conceptually implausible to include an assumption about a two-
dimensional association (e.g., between R and H) into the deﬁnition
of a three-dimensional phenomenon (SE effect). In any case, the
validity of CRA can be evaluated only by examining whether CRA
accurately detects an S-R effect pattern (“S-R related to H”)—the
empirical pattern it was designed to detect.
Above, we explained that and why this is the case: CRA yields
valid conclusions about the presence of an S-R effect pattern. CRA
thereby provides a crucial advantage over the correlational ap-
proaches (i.e., testing the correlation between S-R and H) that
were used to this aim in the past and that often indicated an S-R
effect pattern when the data in fact contradicted it. Given that the
correct classiﬁcation of empirical patterns is an integral element of
every empirical study, we are convinced that CRA will prove its
value for empirical research on the consequences of SE.
At the same time, CRA, like every statistical method, does not
inform about the causal psychological processes that generated a
detected S-R effect pattern. The ﬁeld of SE research is in full swing
to develop theoretical accounts about the behavioral expression and
social perception processes underlying the consequences of SE (see
Humberg et al., 2019, for an overview), and these developments will
certainly continue for several years to come.
Final Remarks
If we may phrase a prediction about which kinds of contributions
will most rapidly move the ﬁeld forward in the next years, it will be
establishments and reﬁnements of (a) a consensus about the theo-
retical construct SE and the terminology used to describe it, (b)
process-focused theoretical accounts on its psychological conse-
quences, and (c) empirical methods that put the theories’ predictions
to an unbiased critical test. We are looking forward to these
conceptual, theoretical, and empirical enrichments—and, of course,
to observing CRA serve its purpose whenever a discrepancy
hypothesis enters the stage.
References
Cohen, J., Cohen, P., West, S. G., & Aiken, L. S. (2002). Applied multiple
regression/correlation analysis for the behavioral sciences (3rd ed.).
Routledge https://doi.org/10.4324/9780203774441
Fiedler, K. (2021). Suppressor effects in self-enhancement research: A
critical comment on condition-based regression analysis. Journal of
Personality and Social Psychology, 121(4), 792–795. https://doi.org/10
.1037/pspa0000273
This document is copyrighted by the American Psychological Association or one of its allied publishers.
This article is intended solely for the personal use of the individual user and is not to be disseminated broadly.
REPLY TO FIEDLER
887

Humberg, S., Dufner, M., Schönbrodt, F. D., Geukes, K., Hutteman, R.,
Küfner, A. C. P., van Zalk, M. H. W., Denissen, J. J. A., Nestler, S., & Back,
M. D. (2019). Is accurate, positive, or inﬂated self-perception most advan-
tageous for psychological adjustment? A competitive test of key hypothe-
ses. Journal of Personality and Social Psychology, 116(5), 835–859.
https://doi.org/10.1037/pspp0000204
Humberg, S., Dufner, M., Schönbrodt, F. D., Geukes, K., Hutteman, R., van
Zalk, M. H. W., Denissen, J. J. A., Nestler, S., & Back, M. D. (2018).
Enhanced versus simply positive: A new condition-based regression
analysis to disentangle effects of self-enhancement from effects of posi-
tivity of self-view. Journal of Personality and Social Psychology, 114(2),
303–322. https://doi.org/10.1037/pspp0000134
Received September 23, 2021
Revision received May 5, 2022
Accepted May 20, 2022 ▪
This document is copyrighted by the American Psychological Association or one of its allied publishers.
This article is intended solely for the personal use of the individual user and is not to be disseminated broadly.
E-Mail Notification of Your Latest Issue Online!
Would you like to know when the next issue of your favorite APA journal will be available
online? This service is now available to you. Sign up at https://my.apa.org/portal/alerts/ and you will
be notified by e-mail when issues of interest to you become available!
888
HUMBERG ET AL.

