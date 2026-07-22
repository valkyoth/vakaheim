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
| `v0.1.0`–`v0.20.8` | constitution, trusted time, usable crypto/text, evidence/facts, local authority, runtime/TLS, device keys/PKI, raw quarantine, diagnostics, and system-wide objectives |
| `v0.22.0`–`v0.40.0` | ingestion conservation, Protobuf/compression, HTTP/2/gRPC, split OTLP/OCSF endpoints, secure transport, backfill/reprocessing, and hardening |
| `v0.41.0`–`v0.60.0` | stable-media storage, raw evidence, integrity/key lifecycle, local backup/restore, migration/reindex, and correctly scoped local multi-terabyte proof |
| `v0.65.0`–`v0.100.0` | VQL authority/planning/admission, joins/operators, cold catalog/rehydration, graph/live semantics, side-channel controls, and hardening |
| `v0.110.0`–`v0.200.0` | deterministic detection/state, split behavioral families, entity-risk ledger, intelligence lifecycle/matching, ATT&CK, interoperability, and rollout |
| `v0.205.0`–`v0.267.0` | common sensor continuity and privilege boundary, native platforms, Kubernetes, and future Aesynx portability |
| `v0.270.0`–`v0.342.0` | base SDK/API sequence, credential vault, isolated connector host, independently tested provider families, integrity content, and notification outbox |
| `v0.345.0`–`v0.405.0` | analyst workflow, case API, simulated then authenticated live forensics, split authentication, authorization/audit, confidential cases, and split UIs |
| `v0.407.0`–`v0.455.0` | Wasm, bound actions, trigger/storm/kill controls, unknown-outcome dispatch, response API, independently tested action families, and recovery |
| `v0.459.0`–`v0.484.0` | expanded state matrix/shared replication, consensus-backed control activation, state HA, active-write quorum durability, distributed query, SRE/DR, and scale campaign |
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
- cryptography, text, runtime, TLS, raw evidence, transport, API and Wasm
  substrates precede their consumers and each can block the roadmap on an
  unacceptable zero-third-party feasibility result;
- provider contracts never substitute for a usable provider: trusted time,
  baseline crypto, device/spool keys, PKI and connector credentials each have
  concrete lifecycle and failure milestones;
- storage and query admission are designed for worst-case work and multi-tenant
  isolation before large-scale deployment;
- early storage scale claims are local; cluster node, quorum, evacuation and
  multi-region claims begin only after their Stage K implementations;
- detection execution identity contains every semantic input and never depends
  on ambient state;
- behavior, entity-risk accumulation and threat-intelligence matching have
  separate deterministic state and evidence contracts;
- response approval binds the exact effect plan, with reversible,
  compensatable, and irreversible recovery classes;
- uncertain external effects use durable dispatch and reconciliation rather
  than assuming a timeout means failure or safe retry;
- automation triggers are admitted through cooldown/concurrency/recursion and
  per-target controls with scoped kill switches;
- each mutable operational-state class has its own consistency, fencing,
  replication, RPO and RTO contract instead of being forced through metadata
  consensus;
- static control dissemination precedes consensus, but distributed activation
  and `DurableQuorum` claims wait for consensus and active-write replication;
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
