# South Africa — NIDS

## Scope and temporal design

The South Africa component uses NIDS waves 1–5 and a locked temporally ordered **Design A**:

- the parent response precedes the adult-child response;
- the child is younger than 18 at exposure and at least 18 at outcome;
- standard errors are clustered by child ID.

The covered domains include subjective income position, religiosity, life satisfaction, self-rated health, depressive symptoms, wallet trust, and related wellbeing measures.

## Model sequence

The main sequence estimates standardized adult-child outcomes on same-domain standardized parent measures.

- **M1:** timing and basic demographics;
- **M2:** parent and household background;
- **M3:** parent-wave, child-wave, origin-province, and population-group fixed effects;
- **M4:** additionally conditions on adult-child education and employment and is treated as a potentially post-treatment sensitivity.

Full models include child sex and age, parent age, elapsed years, parent education and employment, log baseline household income, household size, settlement type, and the listed fixed effects.

## Core results

### Subjective income position

| Parent | Model | Parent coefficient | SE | N |
|---|---|---:|---:|---:|
| Father | M1 | 0.223 | 0.027 | 1,656 |
| Father | M3 | 0.061 | 0.029 | 1,656 |
| Mother | M1 | 0.244 | 0.017 | 3,697 |
| Mother | M3 | 0.129 | 0.018 | 3,697 |
| Mother | M4 | 0.119 | 0.018 | 3,697 |

### Religiosity

| Parent | Model | Parent coefficient | SE | N |
|---|---|---:|---:|---:|
| Father | M1 | 0.063 | 0.021 | 1,672 |
| Father | M3 | 0.051 | 0.023 | 1,672 |
| Mother | M1 | 0.110 | 0.020 | 3,723 |
| Mother | M3 | 0.095 | 0.021 | 3,723 |
| Mother | M4 | 0.092 | 0.021 | 3,723 |

Subjective income position and religiosity provide the clearest temporally ordered parent–adult-child resemblance. Associations in life satisfaction, self-rated health, depressive symptoms, and trust are smaller or more uneven across parent types and specifications.

## Interpretation

The temporal ordering improves design clarity relative to same-wave comparisons, but it does not identify a causal parental effect. Persistent household conditions, stratification, selection into observed dyads, measurement error, and unobserved family characteristics remain possible explanations.

The mother and father coefficients should not be compared by significance alone; formal equality or interaction tests are required for claims about parent-type differences.
