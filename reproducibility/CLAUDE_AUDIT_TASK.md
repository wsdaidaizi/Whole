# Claude Code audit task

Execute this task; do not only propose a plan.

## Goal

Build and audit a minimal, disclosure-safe reproducibility package for this repository. Scope is limited to:

1. contextual/regional moderation models across different settings;
2. DHS mother-daughter baseline, geographic moderation, and prespecified exploration;
3. independent manual Stata checks.

Do not upload raw survey files, row-level derived data, exact DHS coordinates, restricted geography, credentials, private absolute paths, caches, environments, or obsolete branches.

## Skills

Use the AERS router at `brycewang-stanford/Auto-Empirical-Research-Skills`. Read its root `SKILL.md`, then load only `stata-data-audit`, `stata-replication`, `stata-publication-qa`, `stata-toolkit`, and `aer-replication`. Also run the official Claude Code `code-review` plugin or an equivalent read-only reviewer. The authoring agent may not be the final approving agent.

## Local projects to inspect

Read the current handoff/model-registry files first in the DHS workspaces under `/Users/admin/Desktop/dhs/`, including `new_data_all`, `all_country_mother_daughter_replication`, `all_country_geographic_moderation_models`, `geographic_data_infrastructure`, `mother_daughter_attitude_manuscript`, and `country_expansion`. Then inspect the source-verified moderation entry points for CFPS China, IFLS Indonesia, MxFLS Mexico, NIDS South Africa, Taiwan PSFD, and UKHLS.

## Minimal target

Create only exact runnable entry scripts plus necessary small helpers under:

```text
reproducibility/
  README.md
  CODE_MANIFEST.csv
  MODEL_SPEC_REGISTRY.csv
  audit/
    AUDIT_REPORT.md
    NUMERIC_RECONCILIATION.csv
    DISCLOSURE_CHECK.md
    FILE_HASHES.sha256
  moderation/{china,indonesia,mexico,south_africa,taiwan,united_kingdom}/
  dhs/{build_dyads,baseline,geographic_moderation,exploration}/
  stata_manual/
```

Regional coverage must include multiple scales/settings where exact code exists: China province/household, Indonesia origin kabupaten/kota, Mexico municipality, South Africa district, Taiwan township/county, UK public-region proxies, and DHS PSU/local context. Do not imply UK LAD access.

## DHS minimum

- PR key `hv001 hv002 hvidx`; IR key `v001 v002 v003`; mother pointer `hv112`.
- Both women are distinct direct IR respondents in the same household.
- `v744a`-`v744e` recoded to rejection; 8/missing stays missing; complete-item rule. Congo three-item module remains separate.
- M0 bivariate.
- MA quadratic daughter/mother ages plus survey-specific admin1 FE.
- MB wealth quintile, urban/rural, household size.
- MC mother education.
- MD daughter education, labelled potential overcontrol.
- DHS PSU clustered SE; unweighted main model; daughter IR weighting as sensitivity.
- Locked moderators: population density, built environment, SMOD/urban form, night lights, local HDI.
- Separate exploratory block. Include the zero-light/VIIRS hinge only when its exact historical construction and sample are recovered; never reverse-engineer a desired result.
- Country/survey results plus supported combined/meta-analytic summary.
- BH-FDR within declared families; retain all eligible estimates.

## Verification gates

A model is verified only when the authoritative input, sample, variable coding, formula, FE, weights, clustering, fresh rerun, beta, SE, N, and clusters all reconcile. Default same-software tolerance is `1e-8`; any looser tolerance requires a written numerical reason. Classify each model as `EXACT PASS`, `NUMERIC PASS WITH EXPLAINED TOLERANCE`, `FAILED`, `NOT SOURCE-VERIFIED`, or `NOT PUBLICLY RELEASABLE`. A failed rerun is not a substantive null.

`MODEL_SPEC_REGISTRY.csv` must record project/domain, inputs, outcome, parent measure, moderator and scale, controls, FE, estimator, weights, clustering, sample rule, focal term, N/clusters, source script/output, benchmark beta/SE/p, tolerance, and verification status.

## Git workflow

Work on branch `audit/minimal-moderation-dhs-stata`; do not push directly to `main`. Run tests, inspect the diff, push, and open a PR. The PR body must list uploaded files, exact passes/failures, Stata version and executed `.do` files, disclosure scan, unresolved limitations, and clean-rerun commands. Update the project handoff at the end.
