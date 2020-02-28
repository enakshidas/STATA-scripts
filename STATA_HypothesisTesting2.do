
* Open the data file
 sysuse UdaipurJPAL-2, clear


describe
tostring child_id, replace
describe
*to turn the “child_id” variable from float to  string rather than replacing it

sum post_total_w
sort post_total_w
br child_id post_total_w schid
*to obtain descriptive statistics of variable "post_total_w" like frequency, range minimum value and display all values"

ci means pre_math_v, level(90)
* to construct a 90% confidence interval for Verbal Pretest Math Score variable

ci means pre_lang_v, level(95)
* to construct a 95% confidence interval for Verbal Pretest Language Score variable

codebook pre_math_w pre_lang_w
br pre_math_w pre_lang_w
* to obtain comparative descriptive statistics of two variables and display them using single command line

ttest pre_math_w == pre_lang_w
*to run t-test and interpret findings
*         judging from the means of each variable, students do better on the
*         pre-math test (42.0932) than on the pre-language test (18.3703). The
*         statistical significance (1-tailed P-value) of the paired t-test
*         (Pr(T > t) under Ha: mean(diff) > 0) is 0.0000 (i.e. p < 0.05), it can be concluded that
*         there is a statistically significant difference between the mean
*         (pre_math_w) and mean (pre_lang_w). In other words, students do better
*         on the math than on the language.

ci means post_total_w post_math_w post_lang_w, level(99)
* to construct a 99% confidence intervals for the Written Posttest Scores
*    (total, math, language) in one line of code

codebook pre_writ post_writ
gen lit=1 if pre_writ==1 & post_writ==1
codebook lit
* to create a new indicator variable that will equal 1 if and
*    only if a child has been evaluated both times by a written test. This will
*    distinguish children who have been literate the entire time of the experiment.


* i. Conduct t-tests to find out if the experiment has been successful. Limit
*    your selection to just the students who took written exams. Are the
*    language test scores the same for students in the control group and the
*    treatment group?
codebook schooltreated
sum post_lang_w if schooltreated == 0
sum post_lang_w if schooltreated == 1
*to compare language test svores between control and treatment groups

ttest post_lang_w, by(schooltreated)
* to conduct left-tailed hypothesis test, the left-tailed
*         probability - the difference between mean(0) and mean(1) is negative
*         - is 0.0001; since that is less than 0.05, we can reject the null
*         hypothesis. In words, at the 5% significance level, the data provide
*         sufficient evidence to conclude that the mean written post language
*         test score of treatment group is higher than that of control group.

* j. Consider the students in the control group. For students who took the
*    verbal test, are their total scores the same before and after?
ttest pre_total_v == post_total_v if schooltreated == 0

* to conduct test of statistical significance (2-tailed P-value) between results before and after the test.
*         (Pr(T > t) under Ha: mean(diff) != 0) is 0.0000. As the P-value is
*         less than 0.05 (i.e. p < 0.05), it can be concluded that there is a
*         statistically significant difference between the mean (pre_total_v)
*         and mean (post_total_v). In other words, students' total scores are
*         different between pre-test and post-test.

hist post_math_v if schid == 5131, freq discrete
*to present results in a histogram

