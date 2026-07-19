version 16.0
clear all
set more off
capture log close _all

capture confirm file "reproducibility/stata_manual/00_config.do"
if _rc {
    di as error "Copy 00_config_template.do to 00_config.do and edit it."
    exit 601
}
do "reproducibility/stata_manual/00_config.do"
log using "$OUTDIR/01_regional_moderation_check.log", text replace
use "$REG_DATA", clear

foreach v in $REG_Y $REG_PARENT $REG_MOD $REG_REGION $REG_CLUSTER $REG_CONTROLS {
    capture confirm variable `v'
    if _rc {
        di as error "Required/configured variable missing: `v'"
        exit 111
    }
}
if "$REG_WAVE"!="" {
    capture confirm variable $REG_WAVE
    if _rc exit 111
}

quietly count if !missing($REG_Y,$REG_PARENT,$REG_MOD,$REG_REGION,$REG_CLUSTER)
if r(N)<100 {
    di as error "Fewer than 100 complete focal observations."
    exit 2001
}
egen byte __tagcluster=tag($REG_CLUSTER) if !missing($REG_CLUSTER)
quietly count if __tagcluster
local G=r(N)
drop __tagcluster
if `G'<30 {
    di as error "Too few clusters: `G'"
    exit 2001
}

datasignature set, reset
datasignature report
quietly summarize $REG_PARENT, meanonly
gen double __parent_c=$REG_PARENT-r(mean)
quietly summarize $REG_MOD, meanonly
if r(sd)<=0 | missing(r(sd)) {
    di as error "Moderator has no usable variation."
    exit 459
}
gen double __mod_z=($REG_MOD-r(mean))/r(sd)

local FE "i.$REG_REGION"
local WFE ""
if "$REG_WAVE"!="" local WFE "i.$REG_WAVE"

regress $REG_Y c.__parent_c##c.__mod_z $REG_CONTROLS `FE' `WFE', vce(cluster $REG_CLUSTER)
estimates store REG_CONT
local b=_b[c.__parent_c#c.__mod_z]
local se=_se[c.__parent_c#c.__mod_z]
local p=2*ttail(e(df_r),abs(`b'/`se'))
local crit=invttail(e(df_r),.025)
local lo=`b'-`crit'*`se'
local hi=`b'+`crit'*`se'
local N=e(N)

margins, dydx(__parent_c) at(__mod_z=(-1 0 1))
marginsplot, name(regional_simple_slopes, replace) ///
    title("Parent-child slope by regional context") ///
    ytitle("Marginal effect of parent attitude") ///
    xtitle("Regional context (SD)")
graph export "$OUTDIR/regional_simple_slopes.png", replace width(2400)

regress $REG_Y c.__parent_c##i.$REG_REGION $REG_CONTROLS `WFE', vce(cluster $REG_CLUSTER)
testparm c.__parent_c#i.$REG_REGION
local jointp=r(p)

tempname ph
postfile `ph' str40 model str80 term double beta se ci_low ci_high p N clusters using "$OUTDIR/regional_moderation_results.dta", replace
post `ph' ("continuous_moderation") ("parent_x_context_z") (`b') (`se') (`lo') (`hi') (`p') (`N') (`G')
post `ph' ("categorical_region_test") ("joint_parent_x_region") (.) (.) (.) (.) (`jointp') (e(N)) (`G')
postclose `ph'
preserve
use "$OUTDIR/regional_moderation_results.dta", clear
export delimited using "$OUTDIR/regional_moderation_results.csv", replace
restore

di as result "Regional moderation verification completed."
log close
