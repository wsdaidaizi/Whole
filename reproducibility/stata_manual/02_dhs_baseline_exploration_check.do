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
log using "$OUTDIR/02_dhs_baseline_exploration_check.log", text replace
use "$DHS_DATA", clear

local required "$DHS_SURVEY $DHS_DYADID $DHS_DAUGHTER $DHS_MOTHER $DHS_DAGE $DHS_MAGE $DHS_ADMIN1 $DHS_PSU $DHS_WEALTH $DHS_URBAN $DHS_HHSIZE $DHS_MEDU $DHS_DEDU"
foreach v of local required {
    capture confirm variable `v'
    if _rc {
        di as error "Required DHS variable missing: `v'"
        exit 111
    }
}
capture isid $DHS_SURVEY $DHS_DYADID
if _rc {
    di as error "Survey-by-dyad key is not unique."
    duplicates report $DHS_SURVEY $DHS_DYADID
    exit 459
}
capture assert inrange($DHS_DAUGHTER,0,5) if !missing($DHS_DAUGHTER)
if _rc {
    di as error "Daughter index outside 0-5. Keep Congo three-item data separate."
    exit 459
}
capture assert inrange($DHS_MOTHER,0,5) if !missing($DHS_MOTHER)
if _rc {
    di as error "Mother index outside 0-5. Keep Congo three-item data separate."
    exit 459
}

egen long __survey_admin1=group($DHS_SURVEY $DHS_ADMIN1), missing
egen long __survey_psu=group($DHS_SURVEY $DHS_PSU), missing
gen double __dage2=$DHS_DAGE^2
gen double __mage2=$DHS_MAGE^2
datasignature set, reset
datasignature report

tempname bp mp ip
postfile `bp' str32 survey str24 model double beta se ci_low ci_high p N psu using "$OUTDIR/dhs_baseline_results.dta", replace
postfile `mp' str32 survey str40 moderator double beta se ci_low ci_high p N psu using "$OUTDIR/dhs_moderation_results.dta", replace
postfile `ip' str32 survey str20 item double beta se ci_low ci_high p N psu using "$OUTDIR/dhs_item_results.dta", replace

levelsof $DHS_SURVEY, local(surveys)
foreach s of local surveys {
    quietly count if $DHS_SURVEY==`s' & !missing($DHS_DAUGHTER,$DHS_MOTHER,$DHS_DAGE,$DHS_MAGE,__survey_admin1,__survey_psu)
    local ns=r(N)
    egen byte __tagpsu=tag(__survey_psu) if $DHS_SURVEY==`s' & !missing($DHS_DAUGHTER,$DHS_MOTHER,$DHS_DAGE,$DHS_MAGE,__survey_admin1,__survey_psu)
    quietly count if __tagpsu
    local gs=r(N)
    drop __tagpsu
    if `ns'<$MIN_N | `gs'<$MIN_PSU {
        di as error "Skipping survey `s': N=`ns', PSU=`gs'."
        continue
    }
    local SNAME "`s'"

    quietly count if $DHS_SURVEY==`s' & $DHS_DAUGHTER==5
    local dceil=r(N)/`ns'
    quietly count if $DHS_SURVEY==`s' & $DHS_MOTHER==5
    local mceil=r(N)/`ns'
    di as text "Survey `SNAME': N=`ns', PSU=`gs', daughter ceiling=" %6.3f `dceil' ", mother ceiling=" %6.3f `mceil'

    * M0, MA, MB, MC, MD.
    quietly regress $DHS_DAUGHTER c.$DHS_MOTHER if $DHS_SURVEY==`s', vce(cluster __survey_psu)
    local b=_b[$DHS_MOTHER]
    local se=_se[$DHS_MOTHER]
    local p=2*ttail(e(df_r),abs(`b'/`se'))
    local c=invttail(e(df_r),.025)
    post `bp' ("`SNAME'") ("M0") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')

    quietly regress $DHS_DAUGHTER c.$DHS_MOTHER c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 if $DHS_SURVEY==`s', vce(cluster __survey_psu)
    local b=_b[$DHS_MOTHER]
    local se=_se[$DHS_MOTHER]
    local p=2*ttail(e(df_r),abs(`b'/`se'))
    local c=invttail(e(df_r),.025)
    post `bp' ("`SNAME'") ("MA") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')

    quietly summarize $DHS_DAUGHTER if $DHS_SURVEY==`s', meanonly
    local dmu=r(mean)
    local dsd=r(sd)
    quietly summarize $DHS_MOTHER if $DHS_SURVEY==`s', meanonly
    local mmu=r(mean)
    local msd=r(sd)
    if `dsd'>0 & `msd'>0 {
        tempvar dz mz
        gen double `dz'=($DHS_DAUGHTER-`dmu')/`dsd' if $DHS_SURVEY==`s'
        gen double `mz'=($DHS_MOTHER-`mmu')/`msd' if $DHS_SURVEY==`s'
        quietly regress `dz' c.`mz' c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 if $DHS_SURVEY==`s', vce(cluster __survey_psu)
        local b=_b[`mz']
        local se=_se[`mz']
        local p=2*ttail(e(df_r),abs(`b'/`se'))
        local c=invttail(e(df_r),.025)
        post `bp' ("`SNAME'") ("MA_standardized") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')
        drop `dz' `mz'
    }

    capture confirm variable $DHS_WEIGHT
    if !_rc {
        quietly count if $DHS_SURVEY==`s' & $DHS_WEIGHT>0 & !missing($DHS_WEIGHT)
        if r(N)>=$MIN_N {
            quietly regress $DHS_DAUGHTER c.$DHS_MOTHER c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 [pw=$DHS_WEIGHT] if $DHS_SURVEY==`s' & $DHS_WEIGHT>0, vce(cluster __survey_psu)
            local b=_b[$DHS_MOTHER]
            local se=_se[$DHS_MOTHER]
            local p=2*ttail(e(df_r),abs(`b'/`se'))
            local c=invttail(e(df_r),.025)
            post `bp' ("`SNAME'") ("MA_weighted") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')
        }
    }

    quietly regress $DHS_DAUGHTER c.$DHS_MOTHER c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 i.$DHS_WEALTH i.$DHS_URBAN c.$DHS_HHSIZE if $DHS_SURVEY==`s', vce(cluster __survey_psu)
    local b=_b[$DHS_MOTHER]
    local se=_se[$DHS_MOTHER]
    local p=2*ttail(e(df_r),abs(`b'/`se'))
    local c=invttail(e(df_r),.025)
    post `bp' ("`SNAME'") ("MB") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')

    quietly regress $DHS_DAUGHTER c.$DHS_MOTHER c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 i.$DHS_WEALTH i.$DHS_URBAN c.$DHS_HHSIZE c.$DHS_MEDU if $DHS_SURVEY==`s', vce(cluster __survey_psu)
    local b=_b[$DHS_MOTHER]
    local se=_se[$DHS_MOTHER]
    local p=2*ttail(e(df_r),abs(`b'/`se'))
    local c=invttail(e(df_r),.025)
    post `bp' ("`SNAME'") ("MC") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')

    quietly regress $DHS_DAUGHTER c.$DHS_MOTHER c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 i.$DHS_WEALTH i.$DHS_URBAN c.$DHS_HHSIZE c.$DHS_MEDU c.$DHS_DEDU if $DHS_SURVEY==`s', vce(cluster __survey_psu)
    local b=_b[$DHS_MOTHER]
    local se=_se[$DHS_MOTHER]
    local p=2*ttail(e(df_r),abs(`b'/`se'))
    local c=invttail(e(df_r),.025)
    post `bp' ("`SNAME'") ("MD_overcontrol") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')

    * Paired item-level MA checks.
    local nd: word count $DHS_DITEMS
    local nm: word count $DHS_MITEMS
    if `nd'==`nm' & `nd'>0 {
        forvalues j=1/`nd' {
            local dy: word `j' of $DHS_DITEMS
            local mo: word `j' of $DHS_MITEMS
            capture confirm variable `dy'
            if _rc continue
            capture confirm variable `mo'
            if _rc continue
            quietly regress `dy' c.`mo' c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 if $DHS_SURVEY==`s', vce(cluster __survey_psu)
            local b=_b[`mo']
            local se=_se[`mo']
            local p=2*ttail(e(df_r),abs(`b'/`se'))
            local c=invttail(e(df_r),.025)
            post `ip' ("`SNAME'") ("`dy'") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')
        }
    }

    * Locked geographic interactions; keep all eligible estimates.
    foreach z in $DHS_MODS {
        capture confirm variable `z'
        if _rc continue
        quietly summarize `z' if $DHS_SURVEY==`s', meanonly
        if r(N)<$MIN_N | r(sd)<=0 | missing(r(sd)) continue
        tempvar zz
        gen double `zz'=(`z'-r(mean))/r(sd) if $DHS_SURVEY==`s'
        quietly regress $DHS_DAUGHTER c.$DHS_MOTHER##c.`zz' c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 if $DHS_SURVEY==`s', vce(cluster __survey_psu)
        local term "c.$DHS_MOTHER#c.`zz'"
        local b=_b[`term']
        local se=_se[`term']
        local p=2*ttail(e(df_r),abs(`b'/`se'))
        local c=invttail(e(df_r),.025)
        post `mp' ("`SNAME'") ("`z'") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')
        drop `zz'
    }

    * Explicitly exploratory zero-light/positive-light hinge.
    capture confirm variable $DHS_NTL
    if !_rc {
        tempvar zero pos posz
        gen byte `zero'=($DHS_NTL<=0) if $DHS_SURVEY==`s' & !missing($DHS_NTL)
        gen double `pos'=max($DHS_NTL,0) if $DHS_SURVEY==`s' & !missing($DHS_NTL)
        quietly summarize `pos' if $DHS_SURVEY==`s' & `pos'>0, meanonly
        if r(N)>=50 & r(sd)>0 & !missing(r(sd)) {
            gen double `posz'=(`pos'-r(mean))/r(sd) if $DHS_SURVEY==`s'
            quietly regress $DHS_DAUGHTER c.$DHS_MOTHER##i.`zero' c.$DHS_MOTHER##c.`posz' c.$DHS_DAGE c.__dage2 c.$DHS_MAGE c.__mage2 i.__survey_admin1 if $DHS_SURVEY==`s', vce(cluster __survey_psu)
            local term "1.`zero'#c.$DHS_MOTHER"
            capture local b=_b[`term']
            if !_rc {
                local se=_se[`term']
                local p=2*ttail(e(df_r),abs(`b'/`se'))
                local c=invttail(e(df_r),.025)
                post `mp' ("`SNAME'") ("zero_light_parent_slope_shift") (`b') (`se') (`b'-`c'*`se') (`b'+`c'*`se') (`p') (e(N)) (`gs')
            }
        }
        capture drop `zero' `pos' `posz'
    }
}
postclose `bp'
postclose `mp'
postclose `ip'

* BH-FDR within the displayed moderator and item families.
foreach stem in dhs_moderation_results dhs_item_results {
    preserve
    use "$OUTDIR/`stem'.dta", clear
    drop if missing(p)
    sort p
    gen long rank=_n
    gen double q_raw=p*_N/rank
    gsort -rank
    gen double q_bh=q_raw
    replace q_bh=min(q_raw,q_bh[_n-1]) if _n>1
    replace q_bh=min(q_bh,1)
    sort rank
    drop q_raw rank
    save "$OUTDIR/`stem'.dta", replace
    export delimited using "$OUTDIR/`stem'.csv", replace
    restore
}

preserve
use "$OUTDIR/dhs_baseline_results.dta", clear
export delimited using "$OUTDIR/dhs_baseline_results.csv", replace
keep if model=="MA" & !missing(beta,se)
count
if r(N)>=2 {
    meta set beta se, studylabel(survey)
    meta summarize, random(reml)
}
restore

di as result "DHS manual verification completed."
log close
