# Manual Stata verification

This folder contains independent, parameterized checks for the focal regional-moderation and DHS models. The scripts export aggregate estimates only.

## Use

1. Copy `00_config_template.do` to `00_config.do`.
2. Map disclosure-safe input files and variable names.
3. From the repository root run:

```stata
do reproducibility/stata_manual/01_regional_moderation_check.do
do reproducibility/stata_manual/02_dhs_baseline_exploration_check.do
```

Stata 16+ is recommended for the optional `meta` block.

The scripts fail on missing variables, a non-unique configured DHS dyad key, invalid 0-5 indices, insufficient observations/clusters, or a moderator without variation. They log the data signature, coefficient, clustered SE, confidence interval, p-value, N, and cluster count. They do not export row-level DHS data or coordinates.
