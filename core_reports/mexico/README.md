# Mexico — MxFLS / ENNVIH

## Scope and design

The Mexico component uses linked parent–child observations from the Mexican Family Life Survey in 2005 and 2009. The available domains are general values and social norms:

- general trustworthiness;
- wallet-return honesty;
- law-abiding conduct;
- anti-cheating norms.

Municipality manufacturing context comes from INEGI SAIC Histórico. DMSP night lights, GHSL built share, and WorldPop density are treated as urban-economic robustness measures rather than direct manufacturing measures.

## Baseline specification

\[
Y_{irt}=\alpha+\beta P_{irt}+\Gamma X_{irt}+\delta_t+\phi_r+\varepsilon_{irt}
\]

Controls include child age, sex, education, and employment; maternal and paternal age and education; and survey stratum. Models include wave and state fixed effects, use municipality-clustered standard errors, and are unweighted.

## Core baseline results

| Outcome | Parent coefficient | Clustered SE | N | Municipalities |
|---|---:|---:|---:|---:|
| General trustworthiness | 0.192 | 0.030 | 9,624 | 166 |
| Wallet-return honesty | 0.315 | 0.017 | 9,518 | 166 |
| Law-abiding norm | 0.189 | 0.020 | 9,627 | 166 |
| Anti-cheating norm | 0.178 | 0.024 | 9,627 | 166 |

All four domains show positive adjusted parent–child resemblance. Wallet-return honesty has the largest association.

## Manufacturing moderation

The parent-attitude × municipality manufacturing-share interactions are negative in all four domains, but none is statistically supported after multiple-testing adjustment:

| Outcome | Interaction | Raw p | BH q |
|---|---:|---:|---:|
| General trustworthiness | -0.053 | 0.810 | 0.810 |
| Wallet-return honesty | -0.033 | 0.771 | 0.810 |
| Law-abiding norm | -0.191 | 0.125 | 0.498 |
| Anti-cheating norm | -0.143 | 0.320 | 0.639 |

This does not support a general claim that municipality manufacturing weakens family resemblance.

## Local-slope diagnostic

At the municipality level, the anti-cheating slope is lower where manufacturing employment is higher in both unweighted and dyad-count-weighted second-stage models (BH q=0.027). This remains an exploratory association based on estimated local slopes; it is not evidence of a causal industrialization mechanism.

## Interpretation

Mexico provides broad baseline replication across general-value domains, alongside weak and outcome-specific contextual moderation. Urban and manufacturing proxies should not be treated as interchangeable measures of modernization.
