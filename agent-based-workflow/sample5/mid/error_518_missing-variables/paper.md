## Methods

Direct assessment of IMS:
•
experimental in-person
setting
•
with human partner
•
using
kinematic measures
Indirect assessment of IMS:
•
with non-human
animations, digital
characters, virtual partners
•
subjective measure of
IMS (i.e., questionnaires,
observational measures)
Sample
Presence of both control
group and ASD group
Only ASD participants,
neurotypical individuals
with autistic traits
or siblings
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
04

one or more observers’ ofﬂine coding. From this consideration derives
the choice of including kinematic but not subjective measures (i.e., video
coding made by an observer) but rather include precise measures of
movement synchronization. Indeed, although a human observer could
detect synchrony happening during interaction, the quantiﬁcation of
such subtle movement dynamics that characterize the construct of
interest would be more accurate and precise if coded by a computer
rather than a human. On the other hand, video-based and/or sensor-
based tracking of kinematic patterns offer a more objective and precise
method for assessing motor synchrony. Using technology and
algorithms to track and analyze movement synchrony also reduces
potential biases and subjectivity associated with human observer coding.
Moreover, studies were eligible for inclusion if the sample consisted
of both an ASD and control group. The deﬁnition of control group as
an inclusion criterion was intended to have at least two types of dyads
to compare, which very often turned out to be TD-ASD vs TD-TD, but
could have embraced ASD-ASD dyads as well. In fact, the idea is that in
order to explore how synchrony works in autism we needed to
compare it with non-autism. Notably, the presence of both ASD and
TD groups in each study that was included is necessary for effect size
calculation purposes. Unfortunately, only n = 1 paper compared TD-
TD with ASD-ASD dyads (60) and we therefore excluded these data
from our analyses to conduct the meta-analysis on a more
homogeneous corpus of studies, whilst its content was included in
our systematic review. The interaction dynamics are in fact
hypothesized to be different here and to test this we would need
more studies with this type of dyad and run moderation analyses, but
unfortunately this was not the case. To minimize heterogeneity of
populations, we excluded studies that recruited participants without
ASD (i.e., siblings of ASD people or neurotypical individuals with
autistic traits). As we were not interested in intervention effects, we
included works that aimed at training IMS but used pre-treatment
measures in our meta-analysis.
Crucially, it is necessary to ﬁnd a balance between narrowing the
focus on a speciﬁc construct and including studies that looked at that
construct with different methods, or that focused on speciﬁc sub-
components (e.g. spontaneous or instructed synchrony, with different
partners). Motor synchrony occurs in a variety of contexts, which can
vary from less to more naturalistic. As we will see, this is reﬂected in
the variety of tasks adopted to study the phenomena. Across tasks
and contexts, an important differentiation is made between
“instructed” and “spontaneous” synchrony, which has been
discussed in the literature and deﬁned in the introductory part of
our paper. We chose not to set constraints as for the type of task and
type of synchrony since IMS itself encompasses a range of nuances,
and all of them are of equal value in contributing to the big picture. If
we did otherwise, we would miss useful information that would
enable a better understanding of how the phenomenon of interest
works. Given our interest towards the analysis of motor synchrony in
human social interactions, we excluded studies assessing synchrony
towards non-human animations, digital characters, or virtual
partners, whilst including in-person human interactions.
The literature selection process is illustrated in the PRISMA ﬂow
diagram (Figure 1). Sixteen studies are included in the systematic review,
while thirteen studies were ultimately selected for meta-analyses.
2.3 Data extraction
For each paper included, the following information was
extracted and registered in a purposely built form:
•
authors, publication year, DOI, country;
•
sample size, M:F r atio, age (range,
mean,
standard deviation);
•
means and standard deviations of outcome measure (IMS),
separately for ASD and TD groups;
•
experimental conditions, task(s) used to evaluate IMS, type
of synchrony (spontaneous or instructed), number and type
of measures.
FIGURE 1
Flow diagram (following PRISMA guidelines).
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
05

All extracted information was recorded by the third author and
checked by the second author. Some of the included papers did not
contain all the information that was required to perform the
analyses, thus corresponding authors were separately contacted by
the ﬁrst author to retrieve speciﬁc missing values.
Crucially, in many studies the authors presented the
participants with batteries of tasks, not all of which aimed to
assess interpersonal motor synchrony. For this reason, we
considered data only from the tasks that were relevant for our
research question.
Importantly, when the selected studies included measures of
asynchrony and reaction times, a subsequent transformation of the
values was necessary to ensure the meaningful interpretability of
effect sizes [e.g., (61–63)]. Speciﬁcally, these measures were
transformed to the negative of their absolute values, establishing a
framework where lower numerical values corresponded to reduced
synchrony. For instance, Yoo and Kim (62) measured asynchrony
centered on the difference between the onset timing of tapping and
cueing; consequently, values approaching zero denoted heightened
synchrony, while both positive and negative values indicated
varying degrees of asynchrony. To obtain a measure that was
representative of synchrony and comparable to the others, we
computed absolute values and subsequently reversed them to
negative. Similarly, Fulceri et al. (61) speciﬁed that their measure
of reaction times revolved around the difference, in milliseconds,
between the Child Start Time and the Experimenter Start Time;
hence, lower values in this context indicated heightened synchrony.
Therefore, when handling reaction times (61, 63) or their coefﬁcient
of variation (61), we also applied negation of the absolute value, as
higher values in this context would otherwise denote asynchrony
rather than of synchrony.
2.4 Statistical approach and analyses
2.4.1 Effect size
Multiple measures were adopted to assess IMS in each study,
meaning a multitude of instruments and measurement scales being
used to assess our outcome measure. As stated in [Borenstein et al.
(64), pp.25], raw mean differences in this case would not be
appropriate to combine the different results, while the
Standardized Mean Difference (d) would provide an effect size
index that is comparable across studies. Given the low to medium
sample size of the considered studies, to estimate d we used the
Hedges’ g, an unbiased estimator that gives less distort results than
the usual Cohen’s d [(64), pp.27]. To calculate the Hedge’s g, the
‘metafor::escalc’ function was used (65). To this point, each study
had multiple effect sizes. These reﬂect a variety of collected
measurements that relate to multiple angles of observation of the
same phenomenon of interest capturing several different facets.
However, considering these effect sizes separately would not be
appropriate, as the measurements they come from are
interdependent (i.e., same study). For this reason, it becomes
necessary to aggregate the effect sizes into a composite one that
quantiﬁes our outcome measure weighting for the multiplicity of
measures that contribute to it. To account for the non-
independency of the effect sizes within each study, we computed
an aggregated effect size for each study adopting the method
suggested by [Borenstein et al. (64), Chapter 24]. To this end, we
used the ‘Mad::agg’ function (66). To use this method the
correlation among outcomes should be known. As this was not
the case for our selected studies, we ran three meta-analyses
hypothesizing three plausible correlations to evaluate whether our
results changed accordingly, as suggested by Borenstein et al. (64).
The same method was used, for example, in Benavides-Varela et al.
(67). Given that the outcomes that were aggregated within each
study were similar from a theoretical point of view it seems
conceivable to us that they correlate strongly. We indicated as
most plausible the value of r = .50 based on Cohen (68) guidelines,
in which a correlation effect of r = .50 is referred to as a large effect
and therefore we hereby report analyses on this speciﬁc case. The
same set of analyses with r = .30 and r = .70 can be found in the
Supplementary Materials.
2.4.2 Statistical analyses
The analyses were conducted with R software (69). In
particular, the ‘metafor’ package (65) was used to perform the
meta-analysis and the subsequent analyses to deepen the obtained
results. A random-effects meta-analytical approach was chosen due
to the number of different laboratories involved and the high
variability in effect size indices. After running the random-effects
models, we explored the heterogeneity between studies through
inspection of forest plot and evaluation of the Q-statistics (70).
Heterogeneity between the studies is indicated by signiﬁcant values
of Q-statistics, which are distributed like the chi-square under the
null hypothesis of homogeneity. To evaluate the extent of
heterogeneity, we considered the I2 (71) and t indexes, as well as
the prediction intervals (72). Although I2 is commonly reported in
meta-analyses as a measure of heterogeneity, it does not tell us how
much the true effects vary but what proportion of the variance in the
observed effects reﬂects variance in true effects rather than sampling
error (73). The estimated amount of total heterogeneity underlying
distribution of true effect sizes is provided by t2, the between-study
variance of the effect size across the population of studies.
Importantly, by looking at t (squared root of estimated t2) we
can quantify the between-study standard deviation.
Complementarily, the prediction interval indicates the range of
value within which the true effect of a new and unique study will fall
in 95% of cases (74).
2.4.3 Sensitivity analysis and evaluation of
publication bias
Various model diagnostic procedures are available to identify
outliers and/or inﬂuential studies, and for conducting sensitivity
analyses, which are recommended to assess whether the ﬁndings are
robust to the decisions made in the process of obtaining them (75).
As the main objective of a meta-analysis is to provide a reasonable
summary of the effect sizes of a body of empirical studies, the
presence of such outliers may distort the conclusions of a meta-
analysis. Moreover, if the conclusions of a meta-analysis hinge on
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
06

the data of only one or two inﬂuential studies, then the robustness
of the conclusions are called into question (76). The evaluation of
outliers and inﬂuential cases is particularly useful in cases like ours
that are characterized by a low number of studies and where,
therefore, even a single study can have a strong effect on the
estimated effect-size. Since a single outlying study could be the
source of heterogeneity, a recommended method to identify
suspicious cases is the leave-one-out method, which consists in
repeatedly ﬁtting the speciﬁed model, leaving out one study at a
time. Using the’leave1out’ function we explored to which extent
model parameters change when each study is removed from the
sample. The basic rationale behind identifying inﬂuential data is
that when single units are omitted from the data, models based on
these data should not produce substantially different estimates.
Furthermore, we used Cook’s distance to estimate the inﬂuence of
each data point on model parameters, evaluating inﬂuential cases.
More speciﬁcally, Cook’s distance provides further information to
identify inﬂuential data points and complements the information
collected by the previously mentioned method as it quantiﬁes the
change in the meta-analysis parameters when each single study is
removed from the sample (indeed, high values of Cook’s distance
indicate strong inﬂuence on meta-analysis parameters). The
sensitivity analysis we conducted provides a more informative
picture for the reader by transparently clarifying the weight each
study has on the ﬁnal effect size estimate. We further evaluated the
publication bias by means of the funnel plot and using the trim and
ﬁll method, a nonparametric data augmentation technique which
estimates and adjusts the estimates for the potential number and
effect size of missing studies (77, 78).
3 Results
3.1 Systematic review
Although studies show that humans have a natural propensity
to align their behavior during interactions (for review see 2, 6, 13),
the processes by which IMS is achieved could be more or less
explicit. The distinction between spontaneous and instructed
synchrony has been recently scrutinized by Howard et al. (79),
whose ﬁndings underscored that while instructions failed to
enhance synchronization accuracy in adults, they did improve
accuracy among children. One could wonder whether this also
applies to the body of literature in the autism ﬁeld. On the one hand,
instructions should support synchrony as driving participants’
attention to the process itself and thus encouraging an active
effort to achieve it, but they could also be an obstacle whereby
verbal comprehension is limited. On the other hand, spontaneous
paradigms would shed light on low-level synchronization abilities
observable across the whole spectrum.
In the following subsections we delve into the n = 16 studies that
were eligible for review. First, we separately delineate the empirical
ﬁndings pertaining to spontaneous and instructed IMS in dyads
where at least one member is in the autism spectrum; second, we
summarize the measures that were employed to assess synchrony
across the studies. A schematic overview of each study can be found
in Table 2.
3.1.1 Spontaneous IMS
In a dyadic and naturalistic situation with a neurotypical adult,
preschoolers and children with ASD exhibited reduced
synchronization compared to their neurotypical peers (56, 61, 62,
81, 88, 89). Activities could include story reading, drumming, hand
clapping or cooperative games, which were purposely set for
children to be engaged in an ecological interactive setting.
Reduced spontaneous synchronization was also observed during
seated neuropsychological testing and natural conversation in
children (90) as well as in adult conversations (86). The ability to
synchronize with the interaction partner also seems to be negatively
correlated with autistic traits from early ages. In fact, Chen et al.
(81) found that autistic traits especially in the areas of social skills,
communication, and attention switching measured in the ASD
sample are associated with reduced IMS.
One could argue that the quantity and quality of movements
might explain the differences found between groups. Relatedly, Noel
et al. (90) measured movement complexity, duration, and quantity
during the task to shed light on speciﬁc patterns of motion.
Although higher complexity (i.e., non-stereotyped, non-rhythmic,
and not easily predictable) of movements was found in the TD vs
ASD group, no correlation emerged between IMS and any of the
examined factors (90). In line, Georgescu et al. (86) found that the
reduced alignment if the dyad included at least one ASD participant
was not due to the quantity of movement produced, which did not
differ between groups (86). This corpus of research suggests intra-
individual atypicalities in motor abilities not to be enough to explain
the reduction in IMS observed in ASD-TD dyads. Differences in
movement planning could on the other hand inﬂuence IMS. In fact,
in a cooperative joint action task children with ASD showed
reduced coordination with the adult especially when the
destination of the movement was not known beforehand,
suggesting that they struggled more to achieve IMS when having
to rely solely on kinematic features of other’s movement in the
absence of a visual goal (61).
Diminished attention toward the interaction partner could
weaken IMS. Intuitively, the visual anchor of the other supports
IMS as allowing continuous monitoring and adjustment of one’s
movements to the counterpart’s. In fact, studies show enhanced
IMS when visibility of the partner is optimal and decreased when it
is not (81, 84). Crucially though, the content of the activity could
scaffold social attention itself. For instance, when engaged in a book
sharing activity with their caregivers, ASD children devoted less
visual attention to the other their TD peers, but this was attenuated
when using a musical book rather than a picture book, suggesting
musical activity to scaffold mutual engagement (56). Similarly,
Glass and Yuill (60) found that the level of IMS varied across
groups based on the task type. They involved ASD-ASD and TD-
TD children pairs in two joint tablet-based activities and found that
the two groups exhibited comparable IMS in the one activity that
was not designed to deliberately stimulate interaction, while
demonstrating lower IMS in the one activity that was designed to
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
07

TABLE 2 Overview of the studies included in the systematic review.
Authors,
Year
Task
Measure
Dyads
Type of
Synchrony
Take home message
Brezis et al.
(2017) (80)
Mirroring each other while
moving handles along parallel
tracks: alternate leading, following,
or joint improvisation with no
pre-speciﬁed roles
Percentage and duration of
Co-Conﬁdent periods
Adult-adult
Instructed
ASD participants showed less periods of
synchrony, particularly in the follower role,
compared to when they were leading, or no
speciﬁc roles were established. Overall, they also
showed shorter periods of synchrony. General
motor abilities among ASD participants
accounted for some, but not all, of their reduced
synchrony in the follower role. General social
skills did not predict IMS levels.
Chen et
al. (81)
Preschoolers were invited to play
with their teacher using some toys
such as blocks, a set of toys for
cooking, and two magnetic robots
Windowed cross-
correlation of body
movements time series
(head, trunk, right arm)
computed by means of an
automated human pose
estimator. Based on videos,
the authors segmented
episodes of two-ways
interaction from one-way
adult engagement only.
Child-
teacher
Spontaneous
Diminished synchrony was observed in both TD
and ASD when only adults exhibited social
engagement compared to situations where both
adults and children interacted. In two-way
interactions, the ASD group displayed decreased
IMS in the upper body and trunk compared to
the TD group, whereas during one-way adult
engagement, the ASD group exhibited heightened
IMS in the head.
Delaherche
et al. (82)
Participants had to build a puppet
from multiple elements together
with their therapist, in three
conditions: when seeing the
therapist performing actions,
when hearing instructions on how
to put the puppet together, when
giving instructions.
Windowed cross-
correlation of motion
energy time series (ROIs:
child, therapist - each had
global, posture,
hands regions)
Child-adult
Instructed
The presence of a folding screen obstructing
others’ sight in the conditions where the child
only heard or gave instructions made
synchronization harder especially for the ASD
children, in fact the TD group tended to be more
in sync with the therapist’s movement despite the
folding screen.
Fitzpatrick et
al.
(2013) (83)
Social synchronization: the
experimenter demonstrates several
movements directed to objects,
own body or space, then asks the
child to do them together
Relative phase to calculate
the frequency of
occurrence in each relative
phase region
Child-adult
Instructed
The ASD group showed reduced simultaneous
synchronization only in object-directed
movements. There is no clear evidence on
whether IMS is impaired in autism.
Fitzpatrick et
al.
(2016) (84)
Pendulum coordination paradigm:
adolescents swung the pendulum
with the dominant hand while
facing the parents swinging the
pendulum with the non-
dominant hand
Circular variance of
relative phase
Adolescent-
parent
Instructed
ASD adolescents showed less synchronization in
both spontaneous and intentional
interpersonal coordination.
Fitzpatrick et
al.
(2017) (85)
Social synchronization: the
experimenter demonstrates several
movements directed to objects,
own body or space, then asks the
child to do them together
Weighted coherence from
the time series movements
of the child
and experimenter
Child-adult
Instructed
ASD children exhibited lower social
synchronization ability than TD children in all
types of social motor synchronization tasks. The
ASD group performed drumming movements
that were slower and more variable in both
spacing and timing than TD.
Fulceri et al.
(2018) (61)
Cooperative joint action: the child
had to move their arm to insert a
“banana” coin into a “monkey”
box that was moved by the
experimenter, thus coordinating
with the
experimenter’s movement.
Reaction times, Coefﬁcient
of variation of reaction
times, Movement time,
Asynchrony of reaching
Child-adult
Spontaneous
ASD children showed reduced coordination with
the adult as captured by some kinematic
parameters, especially when the ﬁnal destination
of the movement was not known beforehand.
Georgescu et
al.
(2020) (86)
Guided conversations (i.e., a
cooperative or competitive
conversation on an
instructed topic)
Windowed cross-lagged
correlations of the motion
energy time series (ROIs:
head and body of
each participant)
Adult-adult
Spontaneous
In a conversational setting, dyads with at least
one ASD participant, compared to TD-only
dyads, showed reduced interpersonal motor
synchrony. This was not due to the quantity of
movement produced, which did not differ
between groups.
(Continued)
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
08

TABLE 2 Continued
Authors,
Year
Task
Measure
Dyads
Type of
Synchrony
Take home message
Glass et al.
(2023) (60)
Tablet-based games where
participants had to cooperate to
ﬁnd the matching colors in a
series of dots (Colors, designed
with no additional design features
to facilitate collaboration) and
match and sort pictures based on
their categories (Connect,
designed to support collaboration
by facilitating engagement and
other-awareness)
Windowed cross-lagged
correlations of the motion
energy time series
Child-child
Spontaneous
In both the shared tablet activities — Connect
and Colors — the neurotypical group exhibited
comparable motor synchrony to the autistic
group in Colors, yet demonstrated lower IMS in
Connect. Interestingly, the autistic group
maintained similar IMS levels across both
activities, indicating that within speciﬁc social
contexts and task types, autistic children exhibit
comparable or even heightened synchronization
abilities compared to neurotypical children.
Kawasaki et
al.
(2017) (87)
Social synchronization:
participants were instructed to tap
two keys back and forth at a time
interval equal to that of the
partner. The tapping tempo was
not predetermined nor directed
Rates of synchronized
tapping (based on
tapping intervals)
Adult-adult
Instructed
ASD adults had lower rates of synchronization
with TD partners. Synchronization rate was
correlated with autism severity. Differences in
theta activity measured by EEG were also found
in the ASD group. Potential associations between
theta activity, synchronization rate, and symptom
severity are discussed.
Kruppa et al.
(2021) (63)
Computer based game, in which
participants had to cooperate or
compete to press a button and
make a dolphin jump, and catch
the ball
Mean of the absolute
differences in response
times of each dyad
Child-
parent,
child-
stranger
Instructed
Overall, higher synchrony occurred during
competition compared to cooperation, and with
the stranger compared to the parent. ASD
children were less synchronous than TD
children, across conditions and partners. No
group differences were observed at the neural
level (wavelet coherence from fNIRS signals).
Lampi et al.
(2020) (88)
Interpersonal hand-clapping
Weighted coherence from
the time-series movements
Child-adult
Spontaneous
In the ASD group, poorer IMS was associated
with higher levels of Restricted and
Repetitive Behaviors.
Liu et al.
(2021) (56)
Caregiver-child dyads are involved
in a musical (song) and non-
musical (picture) book-
sharing activity
Windowed cross-
correlation of motion
energy time-series (ROIs:
child, adult)
Child-
caregiver
(either
parent
or other)
Spontaneous
ASD children showed lower motor synchrony
with their caregiver compared to their typically
developing peers, regardless of the shared book
being musical or non-musical.
Marsh et al.
(2013) (89)
A parent read a storybook to the
child while sitting in their own
rocking chair and rocking
throughout to a set tempo.
Children sit on their own rocking
chairs while listening.
Continuous relative phase
to calculate the average
amount of time the dyad
spent in a given
relative phase
Child-
parent
Spontaneous
ASD children exhibited signiﬁcantly less in-phase
rocking with their parents than TD children, thus
showing reduced spontaneous synchronization.
The authors argue that unintentional low-level
motor synchronization could contribute to core
impairments observed in autism (i.e., engage in
joint attention, joint action, and mimicry)
Noel et al.
(2018) (90)
Non-verbal synchrony (i.e., head,
hand, trunk) during seated
neuropsychological testing and
natural conversation
Pearson correlation of
motion energy time-series
(ROIs: head, hand, trunk
of each participant)
Child-adult
Spontaneous
ASD children, compared to TD, showed reduced
motor synchrony with the adult, and reduced
complexity for head and hand movements.
However, no correlations were found between
interpersonal synchrony and the complexity of
movements, multisensory integration, or general
movement characteristics.
Yoo et al.
(2018) (62)
Participants were instructed to
drum on a pad while the
experimenter was also drumming
on a separate pad. A rhythmic
auditory cue was available to the
participant in one condition.
Asynchrony
(synchronization errors)
measured by calculating
the difference between the
onset timing of tapping
and the onset timing of
the cueing in milliseconds
Child-adult
Spontaneous
When comparing a baseline ability to
synchronize to an auditory rhythmic cue, ASD
and TD perform similarly. An overall reduced
ability to synchronize in the interpersonal
condition is found in ASD compared to TD,
however in both groups synchronization
improved when the interpersonal condition was
also accompanied by a rhythmic auditory cue.
The highest variability was observed in ASD
during the interpersonal synchronization task
without auditory cueing.
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
09

encourage collaboration and other-awareness. Notably, autistic
children maintained consistent synchronization levels across both
activities, suggesting that in speciﬁc social contexts, they may
possess comparable or heightened synchronization skills (60). To
our knowledge, only one other study looked at ASD-ASD dyads
compared to ASD-TD and TD-TD, but did not ﬁnd an advantage of
neurodevelopmentally homogeneous (over heterogeneous) dyads
on IMS (86). Given the controversial results of these two pivotal
studies (60, 86) further research is needed to examine whether IMS
in ASD-ASD dyads is or is not enhanced, and which factors
contribute to such differences.
3.1.2 Instructed IMS
Motor synchrony is not only a spontaneous mechanism that
facilitates interactions with each other on an implicit level, but it is
also a state that can be pursued intentionally and consciously,
enabling us to achieve speciﬁc goals in shared activities such as
sports, singing and music, as well as play and everyday activities.
Literature suggests that this ability to voluntarily synchronize with
others is reduced in people with ASD from childhood to adulthood
(63, 80, 82–85, 87).
Some studies asked children to perform a series of actions
(either directed to objects, their body, or space) together with the
experimenter and suggested that the target of a movement might
also play a role in one’s ability to synchronize. In fact, children with
ASD showed lower synchronization abilities only in object-directed
movements (83). However, a further implementation of the same
experiment found reduced synchronization in all types of IMS tasks
for the ASD compared to TD children (85). The ability to
voluntarily synchronize with others has also been found
decreased in adolescents with ASD (84) and seems to persist into
adulthood. When instructed to tap two keys back and forth at the
same tempo as that of the partner’s, adult dyads with one ASD
participant showed lower rates of synchronization (87). In line with
literature on spontaneous IMS, movement features do not seem
enough to explain reduced voluntary synchrony. Although slower
and more variable movements in both spacing and timing were
observed in ASD, this only partially related to IMS (85). Similarly,
Brezis et al. (80) found that general motor abilities among
participants with autism accounted for some, but not all, of their
reduced synchrony especially when situated in the follower role. In
the same study, results highlight shorter periods of synchrony in
ASD compared to TD dyads, regardless of leading, following, or
having no pre-speciﬁed role within the interaction (80).
Ultimately, a ﬁrst effort has been done to explore the neural
dynamics that underpin IMS during instructed interaction,
although results appear controversial. More speciﬁcally, Kruppa
et al. (63) used fNIRS to explore brain-to-brain dynamics during a
joint task (cooperative and competitive) and found no group
differences although lower IMS emerged behaviorally for the ASD
group. When looking at individual neural activity with EEG during
a cooperative tapping task, Kawasaki et al. (87) found higher theta-
activity in the frontal cortex in ASD, that was however related to
severity of ASD and difﬁculty to adapt to other’s irregular behaviors
rather than performance on the task itself. Further research is
necessary to shed light on the neural underpinnings of IMS,
especially in autism.
3.1.3 Description of measures adopted to
assess IMS
3.1.3.1 Continuous relative phase
This measure is used in Fitzpatrick et al. (83, 84) and Marsh
et al. (89). It describes the phase space relation between two
segments as it evolves throughout the movement [for review,
(91)]. More speciﬁcally, it measures the angle between two
rhythms in a cycle, meaning that identical movements have 0°
relative phase (in-phase) and opposite movements have 180° phase
(anti-phase). This is done throughout the duration of a movement,
resulting in a time series. In Fitzpatrick et al. (83) 9 relative phases
were deﬁned (from 0° to 180°, by 20°) and their frequency of
occurrence (in percentage) has been computed to evaluate the
predominance of in-phase or anti-phase movements. A similar
approach has been used in Marsh et al. (89): each rocking
segment was weighted by its relative length and 9 relative phases
were considered, in 20° increments arrayed from in-phase (10°
either side of 0°) to anti-phase (10° either side of 180°). From this
measure, the authors calculated the average amount of time a dyad
spends in a given relative phase. Continuous relative phase was also
used in Fitzpatrick et al. (84) to further compute the circular
variance, which indicated the proportion of same relative phases
in the two individuals’ time series. The circular variance of
continuous relative phase is a proportion on a 0-1 continuum
where 1 means perfect synchrony and 0 absence of synchrony.
3.1.3.2 Motion energy
Motion energy is an automatic frame-differencing method to
quantify movement dynamics by detecting the amount of pixel
changes between consecutive frames (92). One or more regions of
interest (ROIs) in which motion energy is computed are usually
identiﬁed. This measure is used in Liu et al. (56), Georgescu et al.
(86), Noel et al. (90) and Glass and Yuill (60). Different ROIs have been
selected by different groups: Liu et al. (56), as well as Glass and Yuill (60)
selected 2 ROIs only (corresponding to each person) as being interested
in a whole-body coordination, while other groups chose to differentiate
between multiple ROIs within each individual [i.e., head and body in
Georgescu et al. (86); head, hand, trunk in Noel et al. (90)]. After motion
energy is extracted, researchers aiming to assess the strength of the
relationship between the two individuals’ movements commonly
calculate a correlation. Among the studies included in the present
meta-analysis, the correlation can either be a Pearson correlation for
each epoch (~30s) or a windowed cross-correlation of time series (~5s
window) usually followed by a Fisher’s transformation to allow between-
conditions comparisons. Correlation coefﬁcients are then averaged to
obtain a ﬁnal value rather than one value for each time segment.
3.1.3.3 Weighted coherence
The weighted coherence has been deﬁned as the proportion of
shared variance between two systems over an entire band offrequencies
(93) and thus consists in the estimated correlation between partners’
movements. This measure is used in Lampi et al. (88) and Fitzpatrick
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
10

et al. (85). In both studies, motion tracking systems were used, and a
correlation coefﬁcient has been computed throughout the time series
across the frequency band from 0 to 2 Hz. As the authors stated, the
weighted coherence is a weighted average measure of the correlation of
the two time-series across this frequency range and spans between 0 and
1 (85). The more values are close to zero, the less dyad is in-synch;
conversely, values close to 1 increasingly indicate synchrony
of movements.
3.1.3.4 Other measures
Brezis et al. (80) analyzed the percentage and duration of co-
conﬁdent periods, that are motion segments lasting from 0.2 to 8 sec
during which high synchrony with little jitter (i.e., smooth
movement) is observed. Fulceri et al. (61) adopted three different
measures to assess the extent to which dyads manifested movement
synchrony: reaction times, coefﬁcient of variation of reaction times
and asynchrony of reaching. The ﬁrst refers to the difference
between child and experimenter’s movement start time; the
second corresponds to the ratio between the standard deviation
and the mean of the reaction time; the third is the difference
between the child and experimenter’s movement duration; the
last consists in the time delay between experimenter and child’s
movement end time. Similarly, Yoo and Kim (62) used the
difference between participant’s onset of tapping and external
cueing (i.e., other’s onset of tapping in their interpersonal
synchrony condition), while Kruppa et al. (63) averaged the
absolute differences in response times of each dyad. Another
measure of synchrony that has been used by Kawasaki et al. (87)
consists of rates of synchronized tapping.
3.2 Meta-analysis
3.2.1 Participant details and descriptive statistics
of included studies
Descriptives of the selected works can be found in Table 3. All
the included studies were conducted between 2013 and 2021. The
age range considered spans from children to adolescents and adults.
Most research came from the USA (n = 8 out of 13) and involved a
participant-experimenter interaction (n = 7), while some studies
involved caregiver-child (n = 4) or a participant-participant (n = 2)
dyad. Only one study further included a child-stranger dyad as a
separate condition from parent-child. The type of synchrony
investigated also varies (n = 7 spontaneous, n = 6 instructed).
3.2.2 Random-effects model meta-analysis
The random effects meta-analysis showed a large aggregated
effect size (Hedge’s g = .85, p < 0.001, 95% CI[.35, 1.35], 95% PI[-.89,
2.60]). Although the estimated effect size could be considered large,
the wide width of the conﬁdence interval suggests that also small to
medium effect sizes should be considered consistent with the
observed data. The heterogeneity was signiﬁcant Q(12) = 89.78, p
<.0001, with high values of the I2 index (I2 = 90.06%), t = 0.85 and
PI[-.89,2.60]. Importantly, whilst CI quantiﬁes the accuracy of the
mean and indicates where the mean effect is likely to be, PI
quantiﬁes the dispersion (or distribution) of effect estimates (73,
74). In our case, if 95% CI[.35, 1.35] indicates the uncertainty
around the estimate of the average effect of IMS across the two
populations, 95% PI[-.89,2.60] indicates this as the range of value
within which the true effect of a new and unique study will fall in
95% of cases, further highlighting the variability of the phenomena
of interest. This is also evident from the is between-study standard
deviation we found (t), which is particularly high when compared
to the values commonly reported in meta-analysis pertaining to the
psychology domain (94). In Figure 2, forest plot shows the
aggregated effect sizes for each study as well as the estimate of the
common effect size and the prediction interval.
A moderation analysis on the random-effect model was
performed to explore whether the type of synchrony
(spontaneous vs instructed) inﬂuenced effect size estimates. No
statistically signiﬁcant results emerged: QM(1) = 0.64, p = 0.42.
The set of analyses hereby presented are in line with those
conducted with the other hypothesized correlations of r =.30 and r
=.70, which results are summarized in Table 4 (see SM for details).
3.2.3 Sensitivity analysis and evaluation of
publication bias
Sensitivity analysis using the leave-one-out method was
performed to evaluate inﬂuential studies that may distort the
effect size estimate. Results are reported in Table 5 and depict the
study from Liu et al. (56) as more inﬂuential than others, decreasing
the effect size estimate. In line, Cook’s distance indicates that the
study from Liu et al. (56) is away from the others (Figure 3).
Although heterogeneity would importantly decrease if excluding
this study, the effect size estimate would still be considered large and
the conﬁdence interval would nevertheless include high values,
therefore we decided not to exclude the study.
To manage publication bias statistically, we graphically
analyzed the funnel plot, drawn after the trim-and-ﬁll method
was implemented (Figure 4).
When accounting for publication bias via the trim-and-ﬁll method,
an even larger effect size (Hedge’s g = 1.17, p < 0.001, 95% CI[.73, 1.60])
was observed. Also, signiﬁcant heterogeneity emerged Q(17)=130.30,
p<.0001, with high values of the I2 index (I2 = 89.40%), t = 0.88 and PI
[-.60, 2.94]. The added studies trend in the direction of the
hypothesized effect, contrary to the expectation in case of publication
bias. Hence, in this case taking publication bias into account even
increases the effect size estimate. This may be due to the relatively
limited number of studies considered, which does not allow for an
appropriate assessment of the publication bias, and especially to the
study by Liu et al. (56), which has an extremely high effect size. Overall,
results from the trim and ﬁll methods do not rule out the presence of
publication bias, although they should be taken with caution.
We further performed a sensitivity analysis to evaluate whether our
results changed according to several imputed plausible correlations, as
suggested by Borenstein et al. (64). The same method was used, for
example, in Benavides-Varela et al. (67). Importantly, all three
correlations and the corresponding three meta-analyses (respectively,
r = .30, r = .50 and r = .70) ultimately lead to essentially the same results
as shown in the Supplementary Material. In conclusion, although we
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
11

TABLE 3
Descriptive statistics of the studies included in the meta-analysis.
ID
Authors
Country
Group
n
dyads
Interaction
partner
M/
F ratio
Age
Type
of Synchrony
es
var
range
mean
sd
values refer to
1
Brezis et al. (80)
Israel
Control
35
experimenter
28:7
19 - 45
25.9
6.37
n = 69 adults
(n = 35 TD and n = 34 ASD)
instructed
0.66
0.04
ASD
34
31:3
20 - 45
28.6
6.26
2
Fitzpatrick et
al. (83)
USA
Control
3
experimenter
1:2
4 - 5.6
4.8
0.75
n = 8 children
(n = 3 TD, n = 5 ASD)
instructed
0.21
0.34
ASD
5
4:1
5 - 7.4
6.21
1.17
3
Fitzpatrick et
al. (85)
USA
Control
27
experimenter
21:6
6.33
- 10.8
8.24
1.46
n = 50 children
(n = 27 TD, n = 23 ASD)
instructed
1.00
0.05
ASD
23
20:3
6.08
- 10.75
8.08
1.44
4
Fitzpatrick et
al. (84)
USA
Control
9
parent (n = 18)
7:2
12 - 16
14.44
1.13
n = 18 adolescents
(n = 9 TD, n = 9 ASD)
instructed
0.34
0.13
ASD
9
8:1
12 - 17
13.67
1.94
5
Fulceri et al. (61)
Italy
Control
11
experimenter
9:2
6.3 - 9.8
7.57
0.71
n = 22 children
(n = 11 TD, n = 11 ASD)
spontaneous
0.88
0.11
ASD
11
10:1
5.11
- 10.3
7.82
1.32
6
Georgescu et
al. (86)
Germany
Control
10
other participants
17:12
33 - 51
41.8
8.86
average dyad values of
TD-TD (n = 20 TD) and ASD-TD (n = 9 ASD,
n = 9 TD)
spontaneous
0.83
0.12
ASD
9
5:4
30 - 51
40.72
10.45
7
Kawasaki et
al. (87)
USA
Control
24
other participants
(TD had two sessions)
12:12
18.9
- 32.1
25.6
6.6
n = 48 adults
(n = 24 ASD and n = 24 TD)
instructed
0.83
0.09
ASD
24
14:10
22 - 36.4
29.2
7.2
8
Kruppa et
al. (63)
Germany
Control
41
parent (n = 59), stranger (n
= 32)
18:23
8 - 18
12.66
2.79
n = 59 children
(n = 41 TD, n = 18 ASD)
instructed
0.62
0.06
ASD
18
18:0
8 - 18
13.54
2.96
9
Lampi et al. (88)
USA
Control
47
experimenter
34:13
6 - 10
7.85
1.49
n = 97 children
(n = 47 TD, n = 50 ASD)
spontaneous
0.83
0.03
ASD
50
34:7
6 - 10
8.02
1.44
10
Liu et al. (56)
USA
Control
16
caregiver (n = 29)
10:6
1.66
- 4.33
2.99
0.7
n = 29 preschoolers
(n = 16 TD, n = 13 ASD)
spontaneous
3.78
0.11
ASD
13
10:3
1.75
- 5.75
3.88
0.85
11
Marsh et al. (89)
USA
Control
7
parent (n = 14)
4:3
2.8 - 4.6
3.75
0.12
n = 14 children
(n = 7 TD, n = 7 ASD)
spontaneous
0.21
0.31
ASD
7
5:2
3.8 - 4.1
3.94
0.74
(Continued)
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
12

ﬁnd the correlation of.50 to be the most plausible, the results remain the
same even when imputing the other correlations, thus indicating the
robustness of our results.
4 Discussion
Our results suggest there are indeed differences in the extent to
which ASD-TD compared to TD-TD dyads synchronize at a motor
level during interpersonal interactions. Although this is consistent
across studies and supported by the large effect size that emerged
from the meta-analysis, the examined literature also depicts a multitude
of different tasks and measures used to capture IMS in a quite broad age
range and with different interactive partners. Interestingly, the
conﬁdence and prediction intervals from the meta-analysis suggest
that small to medium effect sizes could also be plausible, highlighting
the relevance of discussing the possible reasons for such uncertainty in
spite of a clear direction of the effect. In the following subsections, we
will thoroughly investigate potential sources of heterogeneity in our
results, drawing upon ﬁndings included in our systematic review. This
comprehensive exploration aims to provide insights into the factors
contributing to variations in IMS and paves the way for positive
proposals on what future research can do to ﬁll the gaps in the
existing literature, speciﬁcally encompassing both the intra-personal
and inter-personal foundations of IMS.
4.1 Heterogeneity of measures:
deciphering what movements tell
Given the variability of IMS measures employed in the body of
literature reviewed here, one may ask whether they quantify similar
characteristics of IMS. For instance, some authors used continuous
relative phase to compute (i) the percentage of in-phase segments
(83), (ii) the average amount of time a dyad spends in a given
relative phase (89) or (iii) the circular variance of relative phase
(84). Some other authors computed motion energy across deﬁned
regions of interest and subsequent dyadic cross-correlations (56, 86,
90), and yet others have assessed synchrony by means of weighted
coherence (85, 88). Many other measures have also been employed,
such as the percentage and duration of co-conﬁdent periods (80),
reaction times, coefﬁcient of variation of reaction times, movement
time and asynchrony of reaching (61), differences of response times
(62, 63) and rates of synchronized tapping (87).
As suggested by Schoenherr et al. (95), the speciﬁc aspect of
synchrony being measured relies on the algorithm employed and the
resulting score utilized. Accordingly, the literature on the ﬁeld of
motor development indicates that different motor parameters are
associated with distinct neural activities and inﬂuenced by various
factors such as cognitive, metacognitive, sensory, and social processes
(96–98). However, speciﬁc mappings between measurement methods
and underlying aspects of IMS require further investigation. If we
take acceleration – a motor parameter related to movement
smoothness – as an example, we can see how different measures
tap into its multiple facets. By looking at the rate of acceleration
change over time (99, 100), reach-to-grasp movement smoothness is
TABLE 3
Continued
ID
Authors
Country
Group
n
dyads
Interaction
partner
M/
F ratio
Age
Type
of Synchrony
es
var
range
mean
sd
values refer to
12
Noel et al. (90)
USA
Control
15
experimenter
11:4
8.9 - 14.5
10.94
2.13
n = 27 children
(n = 15 TD, n = 12 ASD)
spontaneous
0.24
0.11
ASD
12
8:4
7.9 - 16.5
12.2
3.75
13
Yoo et al. (62)
Korea
Control
42
experimenter
23:19
11 - 16
13.5
0.8
n = 52 children
(n = 42 TD, n = 10 ASD)
spontaneous
0.44
0.08
ASD
10
10:0
11 - 16
13.4
1.4
Note that the number of dyads refers to the statistical units. For instance, Kruppa et al. (63) had children participants interacting with one of their parents and a stranger. Only children’s age contributed to the values reported in the table and the two interactions were treated
as separate conditions in the present analysis. In two cases, adult participants interacted with each other and therefore the age values reported here refer to all the people involved in interactions. The age values reported for Georgescu et al. (86) are dyadic, meaning that they
come from the average age values of the two components for each pair. Those reported for Kawasaki et al. (87), refer to the TD and ASD participants separately as detailed in the table.
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
13

shown to be inﬂuenced by factors like the presence or absence of the
target object, its orientation, and the plane of movement (101). In
turns, neural measures could reveal that movement acceleration
aligns with coherent activation of contralateral primary motor
(M1) hand area and involves dorsolateral prefrontal cortex
(DLPFC) and posterior parietal cortex (PPC) for goal-directed
action planning and sensorimotor integration/movement
monitoring (102). Such accurate mapping is far from being
available in relation to IMS. Although there is currently a lack of
comprehensive literature elucidating the exact meaning of each
measure in relation to different aspects of IMS, it is crucial to
exercise caution when combining different measures. Without a
clear understanding of which speciﬁc aspects of IMS each
measurement or task taps into, the interpretation and comparison
of effect sizes across studies can be challenging. To ensure meaningful
comparisons, future research should aim to bridge this gap in
knowledge by investigating the relationships between speciﬁc
measurement methods, the underlying aspects of IMS they capture,
and the resulting variation in observed effect sizes.
4.2 Context matters: towards
naturalistic interactions
The experimental context might also modulate individuals’ ability
to synchronize with others. As the systematic review showed,
researchers relied on a variety of tasks that span from ecological and
spontaneous activities to more controlled experimental contexts. One
could argue that the uncertainty linked to the effect size may relate to
the extent to which the interaction under consideration was ecological.
For example, the study with the largest effect was also the study using
the least structured paradigm (i.e., shared reading activity; 56).
Remarkably enough, this study turns out to be the most inﬂuential
according to sensitivity analyses to the extent that removing it from
the analyses would importantly reduce the between-study
heterogeneity, while the effect size would remain large. Such a
scenario supports the idea that the type of task is indeed what
makes this study different from others, although the phenomena it
measures is the same, and that taking the context into account could
also be key in the study of differences in the ability to synchronize with
others. While the large effect size found by Liu et al. (56) might suggest
an overestimation of the true effect, it could also be that we are dealing
with a general underestimation of the effect size by the other studies
due to a more controlled experimental setting that perhaps does not
always capture the complexity of human exchanges. As highlighted by
multiple authors, synchrony also depends on task demands and the
context in which it is elicited (3, 60, 79).
Since individuals on the autism spectrum seem less sensitive to
changes in the social context while aligning with others (3), they
could possibly beneﬁt from controlled settings while experiencing
enhanced difﬁculties in a daily life context. If this was the case,
controlled contexts might be an important arena to train IMS
FIGURE 2
Forest plot for random-effects model meta-analysis. Note that positive Hedges’ g indicates higher IMS in the comparison group (TD-TD dyads). The
dotted line represents the prediction interval.
TABLE 4 Summary of results from the three meta-analyses (see SM for details).
Correlation
Hedge’s g
I2
t
CI
PI
r = .30
0.85
92.19%
0.86
[0.35;1.35]
[-0.91;2.61]
r = .50
0.85
90.06%
0.85
[0.35;1.35]
[-0.89;2.60]
r = .70
0.86
88.11%
0.85
[0.36;1.36]
[-0.88;2.59]
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
14

especially at early developmental stages, with a view of progressively
expanding to less structured and more ecological situations in
which possible cascading effects on higher-order social skills
could be observed. Indeed, reduced IMS has been suggested as a
proxy for social difﬁculties observed in autism, while the alignment
of bodies has been shown to enhance social exchanges (103). On a
continuum from more naturalistic to controlled setting, one could
also suggest exploring differences between synchronizing with real
vs virtual partners. In fact, literature shows differences between
human and non-human or digital interactions. For instance, social
interactions in VR come with less nuanced non-verbal cues. This
has been shown to lead to changed regulation of interpersonal
behaviors in neurotypical individuals but not in people on the
autism spectrum (57). Exploring motor synchronization abilities of
individuals within the autism spectrum with non-social or less
social partners, such as avatars or digital characters (53, 55) holds
relevance for gaining understanding of human interactions,
particularly in light of potential differences in IMS associated with
the double-empathy problem, as well as on how to enhance motor
synchronization abilities with cascading effects on socio-
cognitive outcomes.
The extent to which experimental settings reﬂect naturalistic
interactions may also be reﬂected in the type of synchrony elicited.
We did not ﬁnd any effect of type of synchrony in our moderation
analyses nor conﬂicting results in the systematic review, but this
might be due to the low number of studies available. Whether the
spontaneous vs induced IMS modulate the effect under
investigation remains therefore an open question. As Howard
et al. (79) interestingly highlighted, instructed synchrony could be
particularly beneﬁcial for children. In their study, they showed that
TABLE 5 Sensitivity analyses with Leave-One-Out method.
Authors
Hedge’s g
I2
t
CI
PI
Brezis et al. (80)
0.87
90.08
0.90
[0.32; 1.42]
[-0.98; 2.72]
Fitzpatrick et al. (83)
0.89
91.03
0.88
[0.37; 1.42]
[-0.90; 2.69]
Fitzpatrick et al. (84)
0.90
90.89
0.88
[0.36; 1.43]
[-0.92; 2.71]
Fitzpatrick et al. (85)
0.84
90.54
0.90
[0.29; 1.39]
[-1.01; 2.69]
Fulceri et al. (61)
0.85
91.12
0.90
[0.31; 1.39]
[-1,00; 2.69]
Georgescu et al. (86)
0.85
91.15
0.90
[0.31; 1.40]
[-0.99; 2.70]
Kawasaki et al. (87)
0.85
91.00
0.90
[0.31; 1.40]
[-0.99; 2.70]
Kruppa et al. (63)
0.87
90.69
0.90
[0.33; 1.42]
[-0.97; 2.72]
Lampi et al. (88)
0.85
90.00
0.91
[0.31; 1.40]
[-1,00; 2.71]
Liu et al. (56)
0.69
0.00
0.00
[0.53; 0.84]
[0.53; 0.84]
Marsh et al. (89)
0.90
91.01
0.88
[0.37; 1.42]
[-0.90; 2.69]
Noel et al. (90)
0.90
90.67
0.88
[0.37; 1.44]
[-0.89; 2.70]
Yoo et al. (62)
0.89
90.68
0.89
[0.35; 1.43]
[-0.94; 2.72]
FIGURE 3
Sensitivity analyses with Cook’s distance. Note that IDs follow alphabetical order of included studies. See Table 1 for speciﬁcations.
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
15

although social bonding remained consistent across both groups
irrespective of synchrony type, a heightened sense of social
closeness correlated positively with increased synchronization
accuracy in children only (79). While the limited sample of the
current review and meta-analysis did not allow to explore any effect
of age, exploring the interaction between the type of synchrony
elicited and participants’ age in the context of autism and typical
development could constitute an interesting avenue to understand
the origins of diversity. Participants’ age in the included studies
spans from 2 to 51 years and analyzing possible developmental
changes would provide crucial insights on the reasons behind
diversity across the lifespan and in ASD.
4.3 Beyond the individual: an interactive,
inter-personal account of IMS in autism
Most studies have only investigated IMS in ASD-TD vs TD-TD
dyads, with an implicit assumption of diversity in ASD compared to
TD. Indeed, reduced synchrony in ASD-TD dyads is almost always
attributed to intra-individual characteristics of autism and to the
autistic member of the interaction. For example, symptom severity
seems negatively correlated with IMS, in turns predictive of improved
social cognition (85, 104). As autistic traits increase in neurotypical
adults, both spontaneous (49) and induced IMS decrease and this
appears to be modulated by motor difﬁculties (51), as previously
found in ASD population (80). This well-established approach fails to
consider that the neurotypical member of the dyad might itself face
challenges in synchronizing with the neurodiverse member. In line, a
growing number of researchers and members of the autism
community emphasizes how deﬁcit-based research on autism
neglects that misattunement between individuals with and without
ASD is bidirectional and multifaceted, with difﬁculties in interactions
coming from differences in experiencing the world, rather than
autistic deﬁcits (45, 105).
In attempting to explain what may be the reasons that lead to
impaired motor synchrony in ASD-TD dyads, it is crucial to consider
that it is not necessarily the ASD member that has to some extent an
impairment in the ability to synchronize, but that the TD member
itself may have difﬁculty synchronizing with the ASD member
because there are differences in sensorimotor and cognitive
functioning that do not facilitate decoding the signals that the
other is sending, as if each is tuned to different communication
frequencies, or speaks different languages. In other words, we suggest
that individuals tend to synchronize more with those who enable
them to make more accurate predictions more easily.
For example, Noel et al. (90) showed diversity in levels of motor
complexity (stereotyping, rhythmicity, predictability) in individuals in
the spectrum or neurotypicals, and although the authors did not ﬁnd a
correlation between this factor and levels of motor synchrony at the
dyadic level, it is possible that similarity in this parameter contributes
to better synchronization. This means that if there is consistency in the
level of motor complexity of the two interacting individuals, they will
be able to make more accurate predictions and thus synchronize more
easily. To put it simpler, imagine two people trying to have a
conversation, but they speak different languages. It would be
challenging for them to understand each other and ﬁnd common
ground. Similarly, when two individuals with different sensorimotor,
cognitive, socio-emotional, and relational characteristics interact, there
can be a signiﬁcant gap between their understanding of each other.
The same logic can be applied to sensory as well as motor functioning,
that is, if there is similarity in the perception of multisensory cues from
the external (as well as internal) world of the interacting individuals, it
will be more immediate to synchronize because the decoding of the
multisensory cues sent by the other will be easier, somewhat like
speaking the same language. The more the interactive rhythm can be
grasped and decoded similarly among the individuals who are
interacting as a shared communication channel, the more they will
manifest high levels of synchrony. Similarities in sensorimotor
functioning contribute to a form of ingroup which, to note, does
not necessarily correspond with a diagnostic label but rather with a
constellation of functional modalities (106).
Even though reduced IMS has been also found in ASD-ASD
dyads (86), deeper investigations would shed light on whether sharing
similar experiences of the world support synchronization with one
another. This hypothesis is supported by preliminary evidence
FIGURE 4
Funnel plot with trim-and-ﬁll method.
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
16

provided by Glass and Yuill (60) in their recent work. One could
however argue that the ability to synchronize with others is inherently
related to one’s social skills. In the present work we have not been able
to include social skills as a moderator due to the limited data
available; however future research should carefully consider this
factor. Indeed, independently from being on the autism spectrum
or not, individual differences in social skills might relate to differences
in the ability to synchronize with others, with possible bidirectional
inﬂuences. This perspective would be particularly relevant to gain
insights on intra-personal characteristics contributing to IMS
regardless of neurodevelopmental conditions.
Embracing a Bayesian view, the process of synchronization with
each other can be viewed as a nonlinear probabilistic combination
of social and internal cues, and by the principle of resource
optimization, the individual will tend to align more closely with
those who allow him or her to make more accurate predictions
more easily (39, 40). The concept of similarity (inter-individual
level) in functional characteristics (intra-individual level, i.e.,
sensorimotor, cognitive, socio-emotional functioning) between
two interacting individuals facilitates a more accurate prediction
of each other’s intentions and actions, promoting a smoother
synchronization process. The commonality in internal models
and representations could in fact contribute to greater accuracy of
individuals’ prior, with increasingly less need to update the
predictive model in light of new information. In other words, by
reducing the initial self-other gap, similarity enables more accurate
priors and a more efﬁcient convergence of the predictive model that
in turns scaffolds the synchronization process.
5 Conclusions and future directions
Both our systematic review and meta-analysis shows that ASD-
TD dyads, compared to TD-TD dyads, manifest reduced
synchronization of their behaviors during social interactions,
although high uncertainty emerged as for the true effect size.
Although it is reasonable to believe that many intra-personal (e.g.,
age, sensorimotor, social, and cognitive proﬁles) and inter-personal
factors (e.g., type of synchrony, similarity between the dyad
members) may contribute to reduced IMS found in ASD-TD
exchanges, from the available literature it is not possible to draw
conclusive inferences because they are hardly accounted for.
To our knowledge, this is the ﬁrst meta-analytic study on the
topic and crucially contributes to the ﬁeld providing a ﬁrst effort
towards a quantitative synthesis, but the results should be taken
with caution given the limitations herein the available literature (i.e.,
few studies, diverse samples, various measures, theoretical bias in
favor of deﬁcit-based accounts of autism). The conduction of multi-
site studies appears a feasible solution to solve the disparities across
studies that emerged with the present work, as the use of common
protocols and measures would allow a more precise evaluation of
the phenomena of interest, especially including more consistent and
focused age ranges that would the investigation of its developmental
trajectories. Importantly, the current work paves the way for future
research exploring IMS in ASD social interactions, which could
improve perceived social connection and well-being.
6 Supplementary Information
The codes to reproduce the analyses reported in this article and
in the SM have been made publicly available via the Open Science
Framework (OSF) at the following URL: https://osf.io/dqjyh/.
SM include statistical analyses performed with r = .30 and r =
.70. In addition, the online repository includes: R directory to run
the analyses, raw dataset for analyses, dataset including information
of each selected study, dataset used to compile the PRISMA ﬂow
diagram and plain R code syntax to reproduce the analysis results
reported in the paper.
Data availability statement
The original contributions presented in the study are included
in the article/Supplementary Material. Further inquiries can be
directed to the corresponding author.
Author contributions
LC: Conceptualization, Data curation, Formal Analysis,
Investigation, Methodology, Visualization, Writing – original
draft. IV: Conceptualization, Data curation, Investigation,
Methodology, Writing – original draft. GM: Data curation,
Investigation, Writing – review & editing. GA: Formal Analysis,
Methodology, Supervision, Writing – review & editing. TF:
Conceptualization, Funding acquisition, Methodology,
Supervision, Writing – review & editing.
Funding
The author(s) declare ﬁnancial support was received for the
research, authorship, and/or publication of this article. TF was
supported by Pro Beneﬁcentia Stiftung (Liechtenstein).

## Acknowledgments

We would like to thank all the authors from each original article
who kindly shared their data. We truly believe that their
collaboration allowed us to provide a complex picture of this
increasingly important research topic. This manuscript has been
released as a PrePrint at: https://doi.org/10.31234/osf.io/
a6pg4 (107).
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
17

Conﬂict of interest
The authors declare that the research was conducted in the
absence of any commercial or ﬁnancial relationships that could be
construed as a potential conﬂict of interest.
Publisher’s note
All claims expressed in this article are solely those of the authors
and do not necessarily represent those of their afﬁliated
organizations, or those of the publisher, the editors and the
reviewers. Any product that may be evaluated in this article, or
claim that may be made by its manufacturer, is not guaranteed or
endorsed by the publisher.
Supplementary material
The Supplementary Material for this article can be found online
at: https://www.frontiersin.org/articles/10.3389/fpsyt.2024.1355068/
full#supplementary-material

## References

1. Ackerman JM, Bargh JA. Two to tango: Automatic social coordination and the
role of felt effort. In: Bruya B, editor. Effortless attention: A new perspective in the
cognitive science of attention and action. Cambridge, MA: MIT Press Scholarship
Online (2010). p. 335–71. doi: 10.7551/mitpress/9780262013840.003.0015
2. Mayo O, Gordon I. In and out of synchrony—Behavioral and physiological
dynamics of dyadic interpersonal coordination. Psychophysiology (2020) 57(6):e13574.
doi: 10.1111/psyp.13574
3. McNaughton KA, Redcay E. Interpersonal synchrony in autism. Curr Psychiatry
Rep (2020) 22(3):12. doi: 10.1007/s11920-020-1135-8
4. Wass SV, Whitehorn M, Haresign IM, Phillips E, Leong V. Interpersonal neural
entrainment during early social interaction. Trends Cogn Sci (2020) 24(4):329–42.
doi: 10.1016/j.tics.2020.01.006
5. Rauchbauer B, Grosbras M-H. Developmental trajectory of interpersonal motor
alignment: positive social effects and link to social cognition. Neurosci Biobehav Rev
(2020) 118:411–25. doi: 10.1016/j.neubiorev.2020.07.032
6. Ayache J, Connor A, Marks S, Kuss DJ, Rhodes D, Sumich A, et al. Exploring the
“dark matter” of social interaction: Systematic review of a decade of research in spontaneous
interpersonal coordination. Front Psychol (2021) 12:718237. doi: 10.3389/fpsyg.2021.718237
7. Chartrand TL, Lakin JL. The antecedents and consequences of human behavioral
mimicry. Annu Rev Psychol (2013) 64:285–308. doi: 10.1146/annurev-psych-113011-
143754
8. Sebanz N, Bekkering H, Knoblich G. Joint action: bodies and minds moving
together. Trends Cogn Sci (2006) 10(2):70–6. doi: 10.1016/j.tics.2005.12.009
9. Miles LK, Nind LK, Macrae CN. The rhythm of rapport: interpersonal synchrony
and social perception. J Exp Soc Psychol (2009) 45(3):585–9. doi: 10.1016/
j.jesp.2009.02.002
10. Rabinowitch T-C, Meltzoff AN. Synchronized movement experience enhances
peer cooperation in preschool children. J Exp Child Psychol (2017) 160:21–32.
doi: 10.1016/j.jecp.2017.03.001
11. Cirelli LK, Einarson KM, Trainor LJ. Interpersonal synchrony increases
prosocial behavior in infants. Dev Sci (2014) 17(6):1003–11. doi: 10.1111/desc.12193
12. Keller PE, Novembre G, Hove MJ. Rhythm in joint action: psychological and
neurophysiological mechanisms for real-time interpersonal coordination. Philos Trans
R Soc B: Biol Sci (2014) 369(1658):20130394. doi: 10.1098/rstb.2013.0394
13. Hoehl S, Fairhurst M, Schirmer A. Interactional synchrony: Signals, mechanisms
and beneﬁts. Soc Cogn Affect Neurosci (2021) 16(1–2):5–18. doi: 10.1093/scan/nsaa024
14. Bowsher-Murray C, Gerson S, Von dem Hagen E, Jones CR. The components of
interpersonal synchrony in the typical population and in autism: A Conceptual
analysis. Front Psychol (2022) 13:897015. doi: 10.3389/fpsyg.2022.897015
15. Tarabulsy GM, Tessier R, Kappas A. Contingency detection and the contingent
organization of behavior in interactions: Implications for socioemotional development
in infancy. psychol Bull (1996) 120(1):25–41. doi: 10.1037/0033-2909.120.1.25
16. Feldman R. Parent–infant synchrony and the construction of shared timing;
physiological precursors, developmental outcomes, and risk conditions. J Child Psychol
Psychiatry (2007) 48(3–4):329–54. doi: 10.1111/j.1469-7610.2006.01701.x
17. Feldman R, Eidelman AI. Maternal postpartum behavior and the emergence of
infant–mother and infant–father synchrony in preterm and full-term infants: The role of
neonatal vagal tone. Dev Psychobiology (2007) 49(3):290–302. doi: 10.1002/dev.20220
18. Brandi M-L, Kaifel D, Bolis D, Schilbach L. The interactive self – a review on
simulating social interactions to understand the mechanisms of social agency. I-Com
(2019) 18(1):17–31. doi: 10.1515/icom-2018-0018
19. Pecenka N, Keller PE. The role of temporal prediction abilities in interpersonal
sensorimotor synchronization. Exp Brain Res (2011) 211(3):505–15. doi: 10.1007/
s00221-011-2616-0
20. Cross L, Turgeon M, Atherton G. How moving together binds us together: The
social consequences of interpersonal entrainment and group processes. Open Psychol
(2019) 1(1):273–302. doi: 10.1515/psych-2018-0018
21. Cirelli LK. How interpersonal synchrony facilitates early prosocial behavior.
Curr Opin Psychol (2018) 20:35–9. doi: 10.1016/j.copsyc.2017.08.009
22. Tunçgenç B, Cohen E. Interpersonal movement synchrony facilitates pro-social
behavior in children’s peer-play. Dev Sci (2018) 21(1):e12505. doi: 10.1111/desc.12505
23. Rennung M, Göritz AS. Prosocial consequences of interpersonal synchrony: A
Meta-Analysis. Z für Psychol (2016) 224(3):168–89. doi: 10.1027/2151-2604/a000252
24. Vicaria IM, Dickens L. Meta-analyses of the intra-and interpersonal outcomes of
interpersonal coordination. J Nonverbal Behav (2016) 40:335–61. doi: 10.1007/s10919-
016-0238-8
25. Mogan R, Fischer R, Bulbulia JA. To be in synchrony or not? A meta-analysis of
synchrony's effects on behavior, perception, cognition and affect. J Exp Soc Psychol
(2017) 72:13–20. doi: 10.1016/j.jesp.2017.03.009
26. Hu Y, Cheng X, Pan Y, Hu Y. The intrapersonal and interpersonal consequences
of interpersonal synchrony. Acta Psychologica (2022) 224:103513. doi: 10.1016/
j.actpsy.2022.103513
27. Kokal I, Engel A, Kirschner S, Keysers C. Synchronized drumming enhances
activity in the caudate and facilitates prosocial commitment-if the rhythm comes easily.
PloS One (2011) 6(11):e27272. doi: 10.1371/journal.pone.0027272
28. Rabinowitch TC, Knafo-Noam A. Synchronous rhythmic interaction enhances
children’s perceived similarity and closeness towards each other. PloS One (2015) 10(4):
e0120878. doi: 10.1371/journal.pone.0120878
29. Wiltermuth SS, Heath C. Synchrony and cooperation. psychol Sci (2009) 20
(1):1–5. doi: 10.1111/j.1467-9280.2008.02253.x
30. Lang M, Bahna V, Shaver JH, Reddish P, Xygalatas D. Sync to link: Endorphin-
mediated synchrony effects on cooperation. Biol Psychol (2017) 127:191–7.
doi: 10.1016/j.biopsycho.2017.06.001
31. Tarr B, Launay J, Dunbar RIM. ). Music and social bonding: “Self-other”
merging and neurohormonal mechanisms. Front Psychol (2014) 5:1096. doi: 10.3389/
fpsyg.2014.01096
32. Hatﬁeld E, Cacioppo JT, Rapson RL. Emotional contagion. Curr Dir psychol Sci
(1993) 2(3):96–100. doi: 10.1111/1467-8721.ep10770953
33. Miles LK, Nind LK, Henderson Z, Macrae CN. Moving memories: Behavioral
synchrony and memory for self and others. J Exp Soc Psychol (2010) 46(2):457–60.
doi: 10.1016/j.jesp.2009.12.006
34. Macrae CN, Duffy OK, Miles LK, Lawrence J. A case of hand waving: Action
synchrony and person perception. Cognition (2008) 109(1):152–6. doi: 10.1016/
j.cognition.2008.07.007
35. American Psychiatric Association. Diagnostic and statistical manual of mental
disorders, 5th ed. Arlington, VA (2013). doi: 10.1176/appi.books.9780890425596.
36. Milton DE. On the ontological status of autism: The ‘double empathy problem’.
Disability Soc (2012) 27(6):883–7. doi: 10.1080/09687599.2012.710008
37. Scholkmann F, Holper L, Wolf U, Wolf M. A new methodical approach in
neuroscience: assessing inter-personal brain coupling using functional near-infrared
imaging (fNIRI) hyperscanning. Front Hum Neurosci (2013) 7:813. doi: 10.3389/
fnhum.2013.00813
38. Bolis D, Balsters J, Wenderoth N, Becchio C, Schilbach L. Beyond autism:
Introducing the dialectical misattunement hypothesis and a Bayesian account of
intersubjectivity. Psychopathology (2018) 50(6):355–72. doi: 10.1159/000484353
39. Shamay-Tsoory SG, Saporta N, Marton-Alper IZ, Gvirts HZ. Herding brains: a
core neural mechanism for social alignment. Trends Cogn Sci (2019) 23(3):174–86.
doi: 10.1016/j.tics.2019.01.002
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
18

40. Koban L, Ramamoorthy A, Konvalinka I. Why do we fall into sync with others?
Interpersonal synchronization and the brain’s optimization principle. Soc Neurosci
(2019) 14(1):1–9. doi: 10.1080/17470919.2017.1400463
41. Tarr B, Launay J, Dunbar RI. Silent disco: dancing in synchrony leads to elevated
pain thresholds and social closeness. Evol Hum Behav (2016) 37(5):343–9. doi: 10.1016/
j.evolhumbehav.2016.02.004
42. Kühn S, Müller BC, van der Leij A, Dijksterhuis A, Brass M, van Baaren RB.
Neural correlates of emotional synchrony. Soc Cogn Affect Neurosci (2011) 6(3):368–74.
doi: 10.1093/scan/nsq044
43. Milton D, Gurbuz E, Lopez B. The ‘double empathy problem’: Ten years on.
Autism (2022) 26(8):1901–3. doi: 10.1177/13623613221129123
44. Djalovski A, Dumas G, Kinreich S, Feldman R. Human attachments shape
interbrain synchrony toward efﬁcient performance of social goals. Neuroimage (2021)
226:117600. doi: 10.1016/j.neuroimage.2020.117600
45. Bolis D, Lahnakoski JM, Seidel D, Tamm J, Schilbach L. Interpersonal similarity
of autistic traits predicts friendship quality. Soc Cogn Affect Neurosci (2021) 16(1-
2):222–31. doi: 10.1093/scan/nsaa147
46. Chen YL, Senande LL, Thorsen M, Patten K. Peer preferences and
characteristics of same-group and cross-group social interactions among autistic
and non-autistic adolescents. Autism (2021) 25(7):1885–900. doi: 10.1177/
13623613211005918
47. Gammer I, Bedford R, Elsabbagh M, Garwood H, Pasco G, Tucker L, et al.
Behavioural markers for autism in infancy: scores on the autism observational scale for
infants in a prospective study of at-risk siblings. Infant Behav Dev (2015) 38:107–15.
doi: 10.1016/j.infbeh.2014.12.017
48. Yirmiya N, Gamliel I, Pilowsky T, Feldman R, Baron-Cohen S, Sigman M. The
development of siblings of children with autism at 4 and 14 months: Social engagement,
communication, and cognition. J Child Psychol Psychiatry Allied Disciplines (2006) 47
(5):511–23. doi: 10.1111/j.1469-7610.2005.01528.x
49. Cheng M, Kato M, Tseng C. Gender and autistic traits modulate implicit motor
synchrony. PloS One (2017) 12(9):e0184083. doi: 10.1371/journal.pone.0184083
50. Mukai K, Miura A, Kudo K, Tsutsui S. The effect of pairing individuals with
different social skills on interpersonal motor coordination. Front Psychol (2018) 9:1708.
doi: 10.3389/fpsyg.2018.01708
51. Granner-Shuman M, Dahan A, Yozevitch R, Gvirts Problovski HZ. The
association among autistic traits, interactional synchrony and typical pattern of
motor planning and execution in neurotypical individuals. Symmetry (2021) 13
(6):1034. doi: 10.3390/sym13061034
52. Nakano T, Kato N, Kitazawa S. Lack of eyeblink entrainments in autism
spectrum disorders. Neuropsychologia (2011) 49(9):2784–90. doi: 10.1016/
j.neuropsychologia.2011.06.007
53. Xavier J, Gauthier S, Cohen D, Zahoui M, Chetouani M, Villa F, et al.
Interpersonal synchronization, motor coordination, and control are impaired during
a dynamic imitation task in children with autism spectrum disorder. Front Psychol
(2018) 9:1467. doi: 10.3389/fpsyg.2018.01467
54. Xavier J, Guedjou H, Anzalone SM, Boucenna S, Guigon E, Chetouani M, et al.
Toward a motor signature in autism: Studies from human-machine interaction.
L’Encéphale (2019) 45(2):182–7. doi: 10.1016/j.encep.2018.08.002
55. Baillin F, Lefebvre A, Pedoux A, Beauxis Y, Engemann DA, Maruani A, et al.
Interactive psychometrics for autism with the human dynamic clamp: interpersonal
synchrony from sensorimotor to sociocognitive domains. Front Psychiatry (2020)
11:510366. doi: 10.3389/fpsyt.2020.510366
56. Liu Q, Wang Q, Li X, Gong X, Luo X, Yin T, et al. Social synchronization during
joint attention in children with autism spectrum disorder. Autism Res (2021) 14
(10):2120–30. doi: 10.1002/aur.2553
57. Simões M, Mouga S, Pereira AC, de Carvalho P, Oliveira G, Castelo-Branco M.
Virtual reality immersion rescales regulation of interpersonal distance in controls but
not in autism spectrum disorder. J Autism Dev Disord (2020) 50(12):4317–28.
doi: 10.1007/s10803-020-04484-6
58. Della Longa L, Valori I, Farroni T. Interpersonal affective touch in a virtual
world: feeling the social presence of others to overcome loneliness. Front Psychol (2022)
12:795283. doi: 10.3389/fpsyg.2021.795283
59. Page MJ, McKenzie JE, Bossuyt PM, Boutron I, Hoffmann TC, Mulrow CD, et al.
The PRISMA 2020 statement: An updated guideline for reporting systematic reviews.
Systematic Rev (2021) 10(1):89. doi: 10.1186/s13643-021-01626-4
60. Glass D, Yuill N. Moving together: social motor synchrony in autistic peer
partners depends on partner and activity type. J Autism Dev Disord (2023) 1–17.
doi: 10.1007/s10803-023-05917-8
61. Fulceri F, Tonacci A, Lucaferro A, Apicella F, Narzisi A, Vincenti G, et al.
Interpersonal motor coordination during joint actions in children with and without
autism spectrum disorder: the role of motor information. Res Dev Disabil (2018) 80:13–
23. doi: 10.1016/j.ridd.2018.05.018
62. Yoo GE, Kim SJ. Dyadic drum playing and social skills: Implications for rhythm-
mediated intervention for children with autism spectrum disorder. J Music Ther (2018)
55(3):340–75. doi: 10.1093/jmt/thy013
63. Kruppa JA, Reindl V, Gerloff C, Oberwelland Weiss E, Prinz J, Herpertz-
Dahlmann B, et al. Brain and motor synchrony in children and adolescents with
ASD—a fNIRS hyperscanning study. Soc Cogn Affect Neurosci (2021) 16(1–2):103–16.
doi: 10.1093/scan/nsaa092
64. Borenstein M, Hedges LV, Higgins JP, Rothstein HR. Introduction to meta-
analysis. Chichester, West Sussex, England: John Wiley & Sons (2009). doi: 10.1002/
9780470743386
65. Viechtbauer W. Conducting meta-analyses in R with the metafor package. J Stat
Software (2010) 36:1–48. doi: 10.18637/jss.v036.i03
66. Del Re AC, Hoyt WT. MAd: Meta-Analysis with Mean Differences. R package
version 0.8–2. 2014. (2014). Available at: https://cran.r-project.org/package=MAd.
67. Benavides-Varela S, Callegher CZ, Fagiolini B, Leo I, Altoè G, Lucangeli D.
Effectiveness of digital-based interventions for children with mathematical learning
difﬁculties: A meta-analysis. Comput Educ (2020) 157:103953. doi: 10.1016/
j.compedu.2020.103953
68. Cohen J. Statistical power analysis for the behavioral sciences. 2nd ed. New York:
Routledge (1988). doi: 10.4324/9780203771587
69. R Core Team. R: A language and environment for statistical computing. Vienna,
Austria: R Foundation for Statistical Computing (2022). Available at: https://www.R-
project.org/.
70. Hedges LV, Olkin I. Statistical methods for meta-analysis. Orlando, Florida:
Academic Press (1985).
71. Higgins JPT, Thompson SG. Quantifying heterogeneity in a meta-analysis. Stat
Med (2002) 21(11):1539–58. doi: 10.1002/sim.1186
72. Borenstein M. Common mistakes in meta-analysis: And how to avoid them. New
Jersey, USA: Biostat, Inc. (2019).
73. Borenstein M. In a meta-analysis, the I-squared statistic does not tell us how
much the effect size varies. J Clin Epidemiol (2022) 152:281–4. doi: 10.1016/
j.jclinepi.2022.10.003
74. Chiolero A, Santschi V, Burnand B, Platt RW, Paradis G. Meta-analyses: with
conﬁdence or prediction intervals? Eur J Epidemiol (2012) 27:823–5. doi: 10.1007/
s10654-012-9738-y
75. Viechtbauer W. Model checking in meta-analysis. In: Schmid CH, Stijnen T,
White IR, editors. Handbook of meta-analysis. Boca Raton, FL: CRC Press (2021). p.
219–54. doi: 10.1201/9781315119403
76. Viechtbauer W, Cheung MWL. Outlier and inﬂuence diagnostics for meta-
analysis. Res Synthesis Methods (2010) 1(2):112–25. doi: 10.1002/jrsm.11
77. Duval S, Tweedie R. Trim and ﬁll: a simple funnel-plot–based method of testing
and adjusting for publication bias in meta-analysis. Biometrics (2000) 56(2):455–63.
doi: 10.1111/j.0006-341X.2000.00455.x
78. Rothstein HR, Sutton AJ, Borenstein M. Publication bias in meta-analysis:
Prevention, assessment and adjustments. Chichester, UK: Wiley & Sons (2005) p. 1–7.
79. Howard EM, Ropar D, Newport R, Tunçgenç B. Social context facilitates
visuomotor synchrony and bonding in children and adults. Sci Rep (2021) 11
(1):22869. doi: 10.1038/s41598-021-02372-2
80. Brezis R-S, Noy L, Alony T, Gotlieb R, Cohen R, Golland Y, et al. Patterns of
joint improvisation in adults with autism spectrum disorder. Front Psychol (2017)
8:1790. doi: 10.3389/fpsyg.2017.01790
81. Chen X, Chen J, Liao M, Wang G. Early onset of impairments of interpersonal
motor synchrony in preschool-aged children with autism spectrum disorder. J Autism
Dev Disord (2023) 53(6):2314–27. doi: 10.1007/s10803-022-05472-8
82. Delaherche E, Chetouani M, Bigouret F, Xavier J, Plaza M, Cohen D. Assessment
of the communicative and coordination skills of children with autism spectrum
disorders and typically developing children using social signal processing. Res
Autism Spectr Disord (2013) 7(6):741–56. doi: 10.1016/j.rasd.2013.02.003
83. Fitzpatrick P, Diorio R, Richardson MJ, Schmidt RC. Dynamical methods for
evaluating the time-dependent unfolding of social coordination in children with
autism. Front Integr Neurosci (2013) 7:21. doi: 10.3389/fnint.2013.00021
84. Fitzpatrick P, Frazier JA, Cochran DM, Mitchell T, Coleman C. Impairments of
social motor synchrony evident in autism spectrum disorder. Front Psychol (2016)
7:1323. doi: 10.3389/fpsyg.2016.01323
85. Fitzpatrick P, Romero V, Amaral JL, Duncan A, Barnard H, Richardson MJ, et al.
Evaluating the importance of social motor synchronization and motor skill for
understanding autism. Autism Res (2017) 10(10):1687–99. doi: 10.1002/aur.1808
86. Georgescu AL, Koeroglu S, Hamilton AF, Vogeley K, Falter-Wagner CM,
Tschacher W. Reduced nonverbal interpersonal synchrony in autism spectrum
disorder independent of partner diagnosis: A motion energy study. Mol Autism
(2020) 11(1):11. doi: 10.1186/s13229-019-0305-1
87. Kawasaki M, Kitajo K, Fukao K, Murai T, Yamaguchi Y, Funabiki Y. Frontal
theta activation during motor synchronization in autism. Sci Rep (2017) 7(1):15034.
doi: 10.1038/s41598-017-14508-4
88. Lampi A, Fitzpatrick P, Romero V, Amaral J, Schmidt RC. Understanding the
inﬂuence of social and motor context on the co-occurring frequency of restricted and
repetitive behaviors in autism. J Autism Dev Disord (2020) 50(5):1479–96. doi: 10.1007/
s10803-018-3698-3
89. Marsh K, Isenhower R, Richardson M, Helt M, Verbalis A, Schmidt R, et al.
Autism and social disconnection in interpersonal rocking. Front Integr Neurosci (2013)
7:4. doi: 10.3389/fnint.2013.00004
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
19

90. Noel J-P, De Niear MA, Lazzara NS, Wallace MT. Uncoupling between
multisensory temporal function and nonverbal turn-taking in autism spectrum
disorder. IEEE Trans Cogn Dev Syst (2018) 10(4):973–82. doi: 10.1109/
TCDS.2017.2778141
91. Lamb PF, Stöckl M. On the use of continuous relative phase: Review of current
approaches and outline for a new standard. Clin Biomechanics (2014) 29(5):484–93.
doi: 10.1016/j.clinbiomech.2014.03.008
92. Ramseyer FT. Motion energy analysis (MEA): A primer on the assessment of
motion from video. J Couns Psychol (2020) 67(4):536–49. doi: 10.1037/cou0000407
93. Porges SW, Bohrer RE, Cheung MN, Drasgow F, McCabe PM, Keren G. New
time-series statistic for detecting rhythmic co-occurrence in the frequency domain: The
weighted coherence and its application to psychophysiological research. psychol Bull
(1980) 88(3):580–7. doi: 10.1037/0033-2909.88.3.580
94. Van Erp S, Verhagen J, Grasman RP, Wagenmakers EJ. Estimates of between-
study heterogeneity for 705 meta-analyses reported in Psychological Bulletin from
1990–2013. J Open Psychol Data (2017) 5(1):4. doi: 10.5334/jopd.33
95. Schoenherr D, Paulick J, Worrack S, Strauss BM, Rubel JA, Schwartz B, et al.
Quantiﬁcation of nonverbal synchrony using linear time series analysis methods: Lack
of convergent validity and evidence for facets of synchrony. Behav Res Methods (2019)
51:361–83. doi: 10.3758/s13428-018-1139-z
96. Angeli A, Valori I, Farroni T, Marﬁa G. Reaching to inhibit a prepotent response:
A wearable 3-axis accelerometer kinematic analysis. PloS One (2021) 16(7):e0254514.
doi: 10.1371/journal.pone.0254514
97. Valori I, Della Longa L, Angeli A, Marﬁa G, Farroni T. Reduced motor planning
underlying inhibition of prepotent responses in children with ADHD. Sci Rep (2022) 12
(1):18202. doi: 10.1038/s41598-022-22318-6
98. Valori I, Carnevali L, Farroni T. Agency and reward across development and in
autism: A free-choice paradigm. PloS One (2023) 18(4):e0284407. doi: 10.1371/
journal.pone.0284407
99. Flash T, Hogan N. The coordination of arm movements: an experimentally
conﬁrmed mathematical model. J Neurosci (1985) 5(7):1688–703. doi: 10.1523/
JNEUROSCI.05-07-01688.1985
100. Iuppariello L, D'addio G, Lanzillo B, Balbi P, Andreozzi E, Improta G, et al. A
novel approach to estimate the upper limb reaching movement in three-dimensional
space. Inf Med Unlocked (2019) 15:100155. doi: 10.1016/j.imu.2019.01.005
101. Wisneski KJ, Johnson MJ. Quantifying kinematics of purposeful movements to
real, imagined, or absent functional objects: implications for modelling trajectories for
robot-assisted ADL tasks. J NeuroEngineering Rehabil (2007) 4:1–14. doi: 10.1186/
1743-0003-4-7
102. Bourguignon M, Jousmäki V, de Beeck MO, Van Bogaert P, Goldman S, De
Tiège X. Neuronal network coherent with hand kinematics during fast repetitive hand
movements. Neuroimage (2012) 59(2):1684–91. doi: 10.1016/j.neuroimage.2011.09.022
103. Peper C, van der Wal SJ, Begeer S. Autism in action: reduced bodily
connectedness during social interactions? Front Psychol (2016) 7:1862. doi: 10.3389/
fpsyg.2016.01862
104. Zampella CJ, Csumitta KD, Simon E, Bennetto L. Interactional synchrony and
its association with social and communication ability in children with and without
autism spectrum disorder. J Autism Dev Disord (2020) 50(9):3195–206. doi: 10.1007/
s10803-020-04412-8
105. Davis R, Crompton CJ. What do new ﬁndings about social interaction in
autistic adults mean for neurodevelopmental research? Perspect psychol Sci (2021) 16
(3):649–53. doi: 10.1177/1745691620958010
106. Farroni T, Valori I, Carnevali L. Multimedia interventions for neurodiversity:
Leveraging insights from developmental cognitive neuroscience to build an innovative
practice. Brain Sci (2022) 12(2):147. doi: 10.3390/brainsci12020147
107. Carnevali L, Valori I, Mason G, Altoè G, Farroni T. Interpersonal motor
synchrony in autism: a systematic review and meta-analysis. PsyArXiv (2022).
doi: 10.31234/osf.io/a6pg4
Carnevali et al.
10.3389/fpsyt.2024.1355068
Frontiers in Psychiatry
frontiersin.org
20

