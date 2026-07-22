# Vakaheim Version Plan

The canonical, fully detailed version plan is
[RELEASE_PLAN.md](RELEASE_PLAN.md). It contains the status, goal, deliverables,
verification, and exact pentest exit criteria for every implementation stop
from 0.1.0 through the unchanged 1.0.0 release candidate promotion.

This separate index exists so references to a “version plan” and a “release
plan” resolve to the same authoritative schedule rather than drifting copies.

## Versioning Context

Vakaheim uses small security review stops, not calendar promises. Minor version
numbers intentionally leave room for newly discovered work. A patch milestone
such as `v0.6.1` can add a narrowly scoped prerequisite without renumbering the
roadmap or weakening an earlier gate.

The sequence remains:

| Range | Context |
| --- | --- |
| `v0.1.0`–`v0.20.1` | constitutional rules, checked foundations, evidence claims, identity, schema governance, and pinned protocol fixtures |
| `v0.22.0`–`v0.40.0` | ingestion conservation, acknowledgement truth, source continuity, overload, and transport security |
| `v0.41.0`–`v0.60.0` | stable-media storage, manifests, scheduling, snapshots, indexes, migration, disaster reindex, and early multi-terabyte proof |
| `v0.65.0`–`v0.100.0` | VQL parsing, capabilities, authorization barriers, worst-case admission, isolation, joins, graph/live semantics, and query hardening |
| `v0.110.0`–`v0.200.0` | deterministic detection, bounded state, evidence bundles, placement equivalence, risk, intelligence, ATT&CK coverage, and rollout |
| `v0.205.0`–`v0.267.0` | common sensor continuity and privilege boundary, native platforms, Kubernetes, and future Aesynx portability |
| `v0.270.0`–`v0.330.0` | private SDK, connector boundary, cloud-specific profiles, assets/vulnerabilities, identity/SaaS, TAXII, network evidence, and source assurance |
| `v0.345.0`–`v0.405.0` | analyst workflow, forensic acquisition/vault, reporting, authentication, authorization, independent audit, confidential cases, and UI |
| `v0.410.0`–`v0.455.0` | Component Model validation, registry/provenance, bounded Wasm host, cryptographically bound actions, approvals, simulation, effects, and recovery |
| `v0.460.0`–`v0.480.0` | control plane, explicit authenticated-CFT model, formal consensus, replication, evacuation, tenant isolation, federation, SRE, and disaster recovery |
| `v0.485.0`–`v0.500.0` | optional proposal-only AI, privacy, multi-terabyte performance, verification, independent assessment, beta, and stable-candidate gates |
| `v1.0.0-rc.N`–`v1.0.0` | exact-candidate audit, production proof, and unchanged promotion |

## Cross-Cutting Strengthening

The completeness review added explicit ownership without replacing the original
architecture:

- evidence integrity, authenticity, availability, reconstructability, and
  source truth are separate claims;
- ingestion must conserve every accepted item into a terminal outcome, tell the
  truth about acknowledgements, reserve an impairment lane, and state where a
  source protocol cannot prove continuity;
- protocol names are backed by pinned normative profiles and fixtures rather
  than broad compatibility claims;
- storage and query admission are designed for worst-case work and multi-tenant
  isolation before large-scale deployment;
- detection execution identity contains every semantic input and never depends
  on ambient state;
- response approval binds the exact effect plan, with reversible,
  compensatable, and irreversible recovery classes;
- cluster safety is authenticated crash-fault tolerance. A compromised voting
  quorum is outside the safety claim and is handled through explicit containment
  and recovery controls, not mislabeled Byzantine tolerance.

## Non-Negotiable Boundaries

Every detailed milestone inherits the repository constitution: latest approved
stable Rust (currently pinned to 1.97.1 until a tested update), `no_std`-first
core crates, no source file above 500 lines, no unsafe code by default, no
third-party crates, no crates.io publication, and exact-commit security testing.
The review suggestion to relax the third-party rule was deliberately not
adopted. `v0.10.1` instead requires proof that host and environment boundaries
remain honest and fail closed under that constraint.
