# African DHS — Mother–Daughter Family/Gender Norms

## Scope

This component links coresident mothers and daughters in Demographic and Health Surveys and studies rejection of wife-beating justification. The five common items concern whether wife beating is justified when a wife:

- goes out without telling her husband;
- neglects the children;
- argues with her husband;
- refuses sex;
- burns food.

Nine surveys use a common 0–5 rejection index. Congo has only three comparable items and is kept separate on its raw 0–3 scale.

## Linkage and model

The daughter PR key is `hv001 + hv002 + hvidx`, the IR key is `v001 + v002 + v003`, and `hv112` identifies the mother. Both women must be direct IR respondents, distinct persons, and members of the same household.

The primary adjusted model includes quadratic daughter and mother age terms and survey-specific admin1 fixed effects. Standard errors are clustered by DHS PSU. Wealth, residence, household size, mother education, and daughter education enter sequential sensitivity models; daughter education is labeled potential overcontrol. Main estimates are unweighted, with daughter IR weighting as sensitivity.

## Nine-country common five-item synthesis

| Country | Standardized beta | SE | Dyads |
|---|---:|---:|---:|
| Ethiopia | 0.368 | 0.030 | 1,311 |
| Ghana | 0.248 | 0.056 | 772 |
| Kenya | 0.245 | 0.027 | 1,846 |
| Malawi | 0.249 | 0.050 | 1,092 |
| Nigeria | 0.285 | 0.031 | 2,355 |
| Niger | 0.388 | 0.060 | 280 |
| Rwanda | 0.326 | 0.030 | 1,136 |
| Senegal | 0.274 | 0.046 | 901 |
| South Africa | 0.097 | 0.092 | 353 |
| **REML pooled** | **0.290** | **0.020** | **9 countries** |

The pooled 95% confidence interval is [0.250, 0.330], with I²=58.3%. All nine point estimates are positive, but the heterogeneity means that the pooled value is an average rather than a universal African coefficient.

Congo’s adjusted common-three-item coefficient is 0.305 (SE 0.053; N=434), with a standardized coefficient of 0.313.

## Adjustment and item robustness

Stepwise adjustment for wealth, urban/rural residence, household size, and education does not reverse the positive country patterns. Many item-level associations survive within-country BH correction, but ceiling concentration is substantial in several surveys and limits variation and precision.

## Geographic and shock moderation

Population density, built environment, urban form, night-time lights, local HDI, drought, conflict, and capacity measures produce localized or proxy-dependent results rather than a consistent cross-country mechanism. The country-specific Ethiopia pattern, for example, includes several negative built-environment interactions, but such estimates should not be generalized into a universal modernization effect.

## Interpretation

The defensible conclusion is broad mother–daughter resemblance in one family/gender-norm domain, combined with meaningful cross-country heterogeneity. The design is cross-sectional and coresident; it does not identify causal maternal transmission. Shared household and community environments, selective coresidence, reverse influence, and measurement error remain plausible.
