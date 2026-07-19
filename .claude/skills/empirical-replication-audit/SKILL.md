---
name: empirical-replication-audit
description: Audit empirical social-science code, especially Stata/Python replication, regional moderation, DHS mother-daughter linkage, numeric reconciliation, disclosure safety, and publication-result fidelity. Use when asked to audit, replicate, verify, upload the reproducibility core, or create manual Stata checks.
---

# Empirical Replication Audit

## Routing

1. Read the repository handoff and model registry.
2. Use the AERS root router and load only relevant child skills:
   - stata-data-audit
   - stata-replication
   - stata-publication-qa
   - stata-toolkit
   - aer-replication
3. Use a separate read-only code-review agent for final review.

## Non-negotiable gates

- Trace every focal estimate to input, sample rule, variable coding, model formula, FE, weights, and clustering.
- Rerun from authoritative inputs; never validate from publication tables alone.
- Reconcile beta, SE, N, and clusters against locked benchmarks.
- Keep failures and nonsignificant estimates visible.
- Do not upload row-level microdata, exact coordinates, restricted geography, credentials, or absolute local paths.
- Treat cross-sectional parent-child estimates as descriptive conditional associations unless a causal design is independently established.

## Deliverables

- `AUDIT_REPORT.md`
- `NUMERIC_RECONCILIATION.csv`
- `MODEL_SPEC_REGISTRY.csv`
- `DISCLOSURE_CHECK.md`
- `FILE_HASHES.sha256`
- minimal runnable code
- manual Stata verification `.do` files
- reviewable PR, never a direct push to the default branch

## Review protocol

Authoring agent and approving agent must be different. Final classification is one of:

- EXACT PASS
- NUMERIC PASS WITH EXPLAINED TOLERANCE
- FAILED
- NOT SOURCE-VERIFIED
- NOT PUBLICLY RELEASABLE
