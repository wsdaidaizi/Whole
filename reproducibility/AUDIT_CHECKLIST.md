# Empirical audit checklist

## Model fidelity

- [ ] Authoritative script and input identified.
- [ ] Sample construction reproduced from authoritative inputs.
- [ ] Parent-child linkage keys verified.
- [ ] Outcome and parent-measure direction verified.
- [ ] Moderator definition, year, spatial scale, and standardization verified.
- [ ] Controls, fixed effects, weights, estimator, and clustering match.
- [ ] Missingness/listwise-deletion order matches.
- [ ] Beta, SE, p, CI, N, and cluster counts reconcile.
- [ ] Nonsignificant and failed results remain visible.
- [ ] Multiple-testing family matches the locked declaration.

## Regional moderation

- [ ] Main effects and interaction included.
- [ ] Simple slopes evaluated at interpretable moderator values.
- [ ] Region-slope differences use formal interaction tests.
- [ ] Local slopes are not ranked when intervals or reliability are weak.
- [ ] Proxy variables are not renamed as causal mechanisms.

## DHS

- [ ] `hv001 hv002 hvidx` matches `v001 v002 v003`.
- [ ] `hv112` points to a distinct direct-respondent mother.
- [ ] `v744a`-`v744e` are correctly recoded to rejection.
- [ ] Complete-item rule and Congo three-item exception documented.
- [ ] Admin1 FE and PSU clustering are survey-specific.
- [ ] Daughter education is labelled potential overcontrol.
- [ ] Moderator coverage and year gap are audited.
- [ ] Zero-light diagnostic is explicitly exploratory.
- [ ] Country-specific and combined estimates are not conflated.

## Public disclosure

- [ ] No row-level microdata.
- [ ] No exact coordinates or restricted geographies.
- [ ] No credentials, tokens, emails, or private paths.
- [ ] No prohibited licence material.
- [ ] No giant outputs, caches, environments, or archives.
- [ ] Aggregate releases satisfy applicable disclosure rules.
