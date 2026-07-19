version 16.0
clear all
set more off

* Copy to 00_config.do and edit. Never commit private absolute paths.
global OUTDIR "outputs/stata_manual"
cap mkdir "$OUTDIR"

* Regional moderation
global REG_DATA     "PATH/TO/disclosure_safe_regional_analysis.dta"
global REG_Y        "child_attitude"
global REG_PARENT   "parent_attitude"
global REG_MOD      "regional_context"
global REG_REGION   "region_id"
global REG_CLUSTER  "cluster_id"
global REG_WAVE     "wave"
global REG_CONTROLS "child_age child_female parent_age parent_female"

* DHS stacked mother-daughter dyads
global DHS_DATA     "PATH/TO/disclosure_safe_dhs_dyads.dta"
global DHS_SURVEY   "survey_id"
global DHS_DYADID   "dyad_id"
global DHS_DAUGHTER "daughter_index"
global DHS_MOTHER   "mother_index"
global DHS_DAGE     "daughter_age"
global DHS_MAGE     "mother_age"
global DHS_ADMIN1   "admin1"
global DHS_PSU      "psu"
global DHS_WEIGHT   "daughter_weight"
global DHS_WEALTH   "wealth_quintile"
global DHS_URBAN    "urban"
global DHS_HHSIZE   "household_size"
global DHS_MEDU     "mother_education"
global DHS_DEDU     "daughter_education"
global DHS_DITEMS   "d_v744a d_v744b d_v744c d_v744d d_v744e"
global DHS_MITEMS   "m_v744a m_v744b m_v744c m_v744d m_v744e"
global DHS_MODS     "population_density ghsl_built smod nightlight local_hdi"
global DHS_NTL      "nightlight"
global MIN_PSU      30
global MIN_N        100
