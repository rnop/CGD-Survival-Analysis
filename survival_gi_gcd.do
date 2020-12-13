*Question 4

clear
use "C:\Users\nopro\Desktop\UON\BIOS6940\Assignment 4\Q4_V15.dta" 

stset time1 time1 
tab treatment _st, row

tab time1

tab time1 if time1!=0
tab time2 if time2!=0

gen infection = _st
gen time_to_infection = timetofollow + cond(missing(time1), 0, time1)


drop _st _d _t _t0
stset time_to_infection infection



*Kaplan-Meier survival function
sts list, by(treatment)

stsum, by(treatment)
sts graph, by(treatment)

sts test treatment

stcox i.treatment i.sex age heightcm weightkg i.patterninheritance i.corticosteroiduse ///
	  i.antibioticuse i.center
estimates store A

stcox i.treatment i.sex age i.patterninheritance i.corticosteroiduse ///
	  i.antibioticuse i.center
estimates store B

lrtest A B

stcox i.treatment i.sex age i.patterninheritance i.corticosteroiduse ///
	  i.antibioticuse
estimates store C
lrtest B C

stcox i.treatment i.sex age i.patterninheritance ///
	  i.antibioticuse i.center
estimates store D
lrtest B D

stcox i.treatment i.sex age i.patterninheritance ///
	  i.center
estimates store E
lrtest D E


stcox i.treatment i.sex age i.patterninheritance i.center
estat phtest
	  

