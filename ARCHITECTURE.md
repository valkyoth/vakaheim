# Vakaheim Architecture

Status: constitutional baseline for version 0.1.0

Vakaheim is a distributed security evidence, reasoning, detection,
investigation, and response platform. Its foundational transformation is:

```text
observations -> immutable facts -> explainable findings -> incidents
             -> approved, bounded, reversible actions
```

This document records architecture laws. The detailed product sequence lives
in [the implementation plan](docs/IMPLEMENTATION_PLAN.md) and
[the release plan](docs/RELEASE_PLAN.md).

## Trust Model

Vakaheim assumes all of the following can be hostile, malformed, compromised,
stale, incomplete, or misleading:

- source bytes and source clocks;
- endpoints, relays, connectors, tenants, analysts, and administrators;
- rules, schemas, mappings, components, and configuration updates;
- networks, filesystems, storage media, cluster peers, and backups;
- imported standards content and future AI output.

Trust is explicit, scoped, authenticated, authorized, recorded, and revocable.
No subsystem receives ambient authority merely because it runs inside the
Vakaheim deployment.

## Core / Alloc / Std Layering

The architecture uses three environmental layers:

1. `core`: allocation-free deterministic types and algorithms.
2. `core + alloc`: bounded owned values, syntax trees, plans, and state where
   an allocator is explicit and acceptable.
3. `std`: operating-system, filesystem, networking, UI, process, and host
   integration.

Portable security logic defaults to `#![no_std]`. A crate may use `std` only
when its purpose is an explicit host boundary. The dependency direction is
one-way: host adapters depend on portable contracts; portable contracts never
depend on host adapters.

## Product Planes

```text
Analyst plane
    search | timeline | graph | cases | reports | rule studio
                         |
Incident and response plane
    findings | correlation | incidents | SOAR | approvals
                         |
Query and detection plane
    streaming | historical | temporal | graph | behavioral
                         |
Security fact plane
    typed facts | entities | relationships | provenance | policy
                         |
Ingestion and routing plane
    validation | batching | deduplication | spool | relays
                         |
Sensor plane
    Linux | Windows | macOS | BSD | cloud | identity | network
```

Identity, policy, keys, audit, control, health, and cluster functions cut
across every plane.

## Evidence Model

The internal model distinguishes:

- an observation reported by a source;
- an immutable typed fact derived from observations;
- an entity such as a device, identity, process, file, service, or resource;
- an evidence-backed relationship between entities;
- an immutable finding produced by a particular rule and state transition;
- a mutable incident or case that references immutable evidence;
- a typed action request with approval and lifecycle state;
- a telemetry-gap fact describing missing, delayed, suppressed, corrupt, or
  inaccessible evidence.

Every observation and fact carries source, tenant, sequence, time,
uncertainty, parser, mapping, integrity, policy, residency, retention, and
provenance data. Source time, observation time, ingest time, normalization
time, effective time, clock uncertainty, and ordering confidence remain
distinct.

Truth values distinguish known, unknown, unavailable, redacted, not
applicable, conflicted, and malformed. Claims distinguish observed,
source-asserted, derived, inferred, and analyst-asserted.

## Untrusted Byte Law

Untrusted bytes are never reinterpreted with raw pointer casts or assumed to
match Rust ABI layout. Parsers use checked cursors with:

- bounds checks before access;
- checked arithmetic before position or length changes;
- explicit endianness;
- structured, stable errors;
- bounded depth, items, input, output, and allocation;
- exact-consumption and trailing-data policies;
- source byte ranges retained for provenance;
- no panic on malformed input.

Any future unsafe optimization must live behind an explicit boundary and prove
semantic equivalence to the safe implementation.

## Data-Loss Law

Vakaheim never silently discards telemetry. Edge policy has three explicit
states: preserve, summarize, or suppress. Suppression requires a signed,
time-limited policy and emits durable evidence describing what was suppressed,
why, by whom, and under what capacity conditions. Security-control,
authentication, privilege, process-creation, health, and integrity evidence is
non-suppressible by default.

Delivery uses at-least-once transport, stable source sequences, deterministic
identifiers, persistent checkpoints, idempotent storage, and replay-safe
detection. Acknowledgement levels state exactly how far an event progressed.

## Storage Law

The system builds an append-only security segment format and does not require
an external database. Segments are versioned, bounded, checksummed,
cryptographically digested, linked, authenticated, tenant-scoped, repairable,
and independently verifiable. Indexes are never more authoritative than their
source segments.

Retention, deletion, legal hold, compaction, backup, export, restore, repair,
and migration are auditable lifecycle operations. Encryption separates data
access from key access and supports key rotation and crypto-shredding.

## Detection And Response Law

High-volume detection uses deterministic, bounded, validated IR. Wasm is for
optional complex detection, enrichment, connectors, reporting, and response.
Wasm receives no ambient filesystem, process, network, environment, clock,
randomness, secret, or cross-tenant access and runs inside an additional OS or
process sandbox.

Findings retain exact rule package, state transition, aggregation, evidence,
uncertainty, completeness, confidence, severity, and worker identity. They can
be replayed deterministically.

Response actions are typed, scoped, idempotent, authenticated, authorized,
audited, bounded, verifiable, and compensatable where possible. Arbitrary
shell execution is prohibited by default. Destructive or high-impact actions
require human or two-person approval.

## AI Law

AI is optional and outside the trusted correctness path. It may draft queries,
rules, tests, explanations, summaries, and response proposals. It may not
activate rules, change collection, suppress telemetry, change retention, close
incidents, grant access, obtain unapproved evidence, or execute actions.

Every AI artifact is provenance-bound and passes the same validation,
simulation, review, signing, shadow, and canary process as a human artifact.

## Crate Boundary Law

Create a crate when at least one of these differs:

- `no_std`, `alloc`, or `std` environment;
- operating-system or architecture support;
- privilege level or unsafe-code allowance;
- parser/fuzzer/formal-verification target;
- public API stability or licensing;
- security boundary or threat model;
- dependency policy or release lifecycle.

Rust source files must not exceed 500 lines. The limit is a repository hygiene
gate in addition to architectural metrics such as complexity, unsafe surface,
panic paths, allocation paths, lock order, fan-out, fuzz coverage, and public
API size.

## Dependency Law

The current repository permits no third-party runtime, build, or development
crates. Workspace path dependencies are the only admitted dependencies. Cargo
tools used by CI are pinned independently and do not enter product artifacts.

If a future requirement cannot be implemented safely without a third-party
primitive, work stops for an explicit architecture and security decision. No
dependency is admitted implicitly. Cryptographic primitives are never invented
casually; their eventual implementation or provider boundary requires a
dedicated audited plan.

## Platform Law

The portable core supports Linux, Windows, macOS, BSD, Android, iOS, and future
Aesynx integration by avoiding OS, allocator, endian, architecture, filesystem,
network, and async-runtime assumptions. OS collectors and privileged helpers
remain separate crates and processes where practical.

Current support means the foundation compiles on representative targets. It
does not claim that collectors or a complete product exist.

## Release Law

Every release has one bounded goal, explicit deliverables, additive
verification, known limitations, release notes, and an exact implementation
stop. No tag is permitted before exact-commit pentest evidence passes and all
findings are remediated.

No current crate is publishable. Only a future explicitly approved SDK may use
`MIT OR Apache-2.0` and crates.io; all other crates stay EUPL-1.2 and private.
