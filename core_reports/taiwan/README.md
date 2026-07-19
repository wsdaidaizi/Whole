# Taiwan — PSFD 2022/2024

## Scope

The Taiwan component uses 2,070 linked parent–child dyads from the 2022 and 2024 Panel Study of Family Dynamics. The outcome is a detraditionalized gender-role/family-value score derived from item `e03z10`; higher values indicate a more egalitarian view that rejects the idea that the husband should earn while the wife cares for the family.

## Main specification

\[
Y_i=\alpha+\beta P_i+X_i'\gamma+\lambda_t+\varepsilon_i
\]

Controls include child age, gender, education category; parent age, gender, education category; parent-reported residential distance; and survey-year fixed effects. Standard errors are clustered by household ID. County/city fixed effects are added in selected robustness models.

## Main results

| Model | Parent coefficient | SE | N | Main additions |
|---|---:|---:|---:|---|
| M1 | 0.115 | 0.026 | 2,070 | Year FE only |
| M2 | 0.060 | 0.022 | 2,040 | Child, parent, education, distance controls |
| M5 | 0.050 | 0.023 | 1,903 | Selected context main effects |
| M2C | 0.053 | 0.023 | 1,908 | County/city FE |
| M5C | 0.051 | 0.023 | 1,903 | Context main effects + county/city FE |

The adjusted parent coefficient is modest but stable at approximately 0.05–0.06 across the main specifications.

## Contextual moderation

Prespecified township/county interactions cover income, density, high-tech agglomeration, house-price pressure, female labor-force participation, manufacturing, services, political climate, aging, migration, and related context measures. No focal interaction survives BH-FDR correction. Urban–rural interaction tests are also not supported.

The main implication is that contextual characteristics more often correlate with children’s attitude levels than with a stable change in the parent–child slope.

## Gender-pair results

Adjusted subgroup coefficients are approximately:

- mother–daughter: 0.055;
- mother–son: 0.080;
- father–daughter: 0.070;
- father–son: 0.012.

Formal pooled interaction tests do not support systematic differences by parent gender, child gender, or same-gender pairing.

## Geographic diagnostics

County and township local-slope estimates are threshold-based and often imprecise. No eligible local slope survives BH correction, and the final package reports no significant spatial autocorrelation. Shrinkage substantially contracts extreme local estimates, so counties and townships should not be ranked by raw coefficients.

## Interpretation

Taiwan supports a stable but limited adjusted parent–child association in one family/gender-value item. The evidence does not support a general contextual weakening or strengthening mechanism, and it does not identify causal transmission.
