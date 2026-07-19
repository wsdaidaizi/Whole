# United Kingdom — UKHLS / Understanding Society

## Scope

The United Kingdom component uses Understanding Society / UKHLS waves a–o where outcome-specific items are available. Parent–child links use official relationship pointers and household relationship evidence. Proxy interviews are excluded in the repaired pipeline.

The covered domains are political interest, party attachment, democratic satisfaction, social trust, family traditionalism, family authority/parenting style, party direction, voting, and event-specific EU/Brexit attitudes. Religion and fine-grained Special Licence geography are not included in the locked evidence.

## General specification

\[
Y_{idrt}=\alpha+\beta P_{idrt}+\Gamma X_{idrt}+\delta_t+\phi_r+\varepsilon_{idrt}
\]

Models include child age and sex, wave fixed effects, public-region fixed effects, and—in selected specifications—child education and employment. The estimates are mainly contemporaneous conditional associations rather than temporally ordered transmission estimates.

## Standardized domain results

| Domain | Parent coefficient | SE | Observations |
|---|---:|---:|---:|
| Political interest | 0.269 | 0.006 | 89,375 |
| Party-identification strength | 0.194 | 0.008 | 33,770 |
| Democratic satisfaction | 0.215 | 0.008 | 17,441 |
| Social trust | 0.183 | 0.009 | 19,551 |
| Family traditionalism | 0.257 | 0.007 | 37,240 |
| Family authority / parenting style | 0.969 | 0.006 | 5,290 |
| EU/Brexit orientation | 0.462 | 0.023 | 2,027 |
| EU referendum score | 0.184 | 0.012 | 5,408 |

All eight audited domain scores show positive parent–child resemblance. Magnitudes are domain- and measurement-specific; the narrow family-authority scale should not be compared mechanically with broader political or trust measures.

## Party direction and voting

Among valid party identifiers, the any-parent right-wing association is 0.584 (SE 0.010; N=35,520), 0.553 with region fixed effects, and 0.563 with education/employment controls. A broad-denominator coding produces substantially smaller estimates because it answers a different population-level estimand.

For voting participation, the any-parent association is 0.159 (SE 0.004; N=112,910), 0.158 with region fixed effects, and 0.149 with education/employment controls.

Separate mother and father coefficients are descriptive only because a formal pooled equality test is not available in the locked output.

## Resources and regional context

Income tertiles, housing tenure, parent education, age/cohort, country group, and Brexit-period interactions are treated as exploratory families with BH adjustment. Strict party-direction results do not show robust income-tertile differences. Some coarse public-region proxy contrasts survive adjustment, but LAD or smaller-area models are not estimable without Special Licence geography.

## Interpretation

The UK case is inconsistent with a simple claim that a high-income, institutionally dense society eliminates family resemblance. Instead, resemblance remains broad but strongly domain- and measurement-specific. The estimates do not identify causal influence, and denominator harmonization is essential before cross-country comparison.
