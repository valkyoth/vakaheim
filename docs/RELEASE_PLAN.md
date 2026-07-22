# Vakaheim Release Plan To 1.0

Status: planning document

This is the canonical version plan. Vakaheim is security-sensitive evidence
infrastructure, so every milestone is intentionally small enough to review,
test, pentest, and stop cleanly. Split a milestone or add a patch release when
its scope no longer fits one safe implementation pass.

Tags use:

```text
v0.N.0      milestone release
v0.N.P      tightly scoped correction or hardening release
v1.0.0-rc.N exact production candidate
v1.0.0      unchanged promotion of the approved candidate
```

No crate may be published during this plan unless the future SDK exception is
explicitly approved at its own milestone. A version number is not publishing
authority.

## Required Release Evidence

Every release requires:

- one bounded goal and explicit non-goals;
- implementation, tests, documentation, and release notes;
- threat-model, dependency, unsafe, data-flow, and compatibility deltas;
- `scripts/checks.sh`, cargo-deny, cargo-audit, SBOM, and freshness evidence;
- milestone-specific negative, adversarial, portability, upgrade, recovery,
  performance, conformance, fuzz, formal, or concurrency evidence as relevant;
- no unresolved critical or high security finding;
- exact-commit pentest and a permanent passing report;
- a clean statement of known limitations and unsupported capabilities.

Verification listed below is additive to repository-wide gates. It never
replaces them.

## Pentest Handoff

When a milestone's code and clean tests are complete, stop and state:

```text
vX.Y.Z implementation stop reached. Run pentest for this exact commit.
```

Temporary findings use root `PENTEST.md`. Fix findings, add regression tests,
remove the temporary file, rerun every gate, and retest. Only then add
`security/pentest/vX.Y.Z.md` with `Status: PASS` and the exact reviewed commit.
The report-only commit must be the direct child of the reviewed commit. Do not
tag, publish, push, deploy, or create a release unless explicitly requested.

## Phase A — Constitutional Foundation

### v0.1.0 — Architecture Constitution

Status: in implementation

Goal: establish the repository and security laws before product code grows.

Deliverables:

- Rust workspace, Vakaheim facade, core and checked-byte boundary crates;
- `no_std`, unsafe, dependency, publishing, modularity, platform, and release
  policies;
- threat model, architecture, implementation plan, version plan, README,
  security process, GitHub files, CI, release notes, and test scripts;
- Rust 1.97.1 and current security-tool/action pins.

Verification:

- compile, test, lint, doc, `no_std`, target-family, manifest-source,
  no-publication, root-documentation, file-length, and shell checks;
- cargo-deny, cargo-audit, SBOM check, and live tool freshness check;
- review that no operational SIEM capability is claimed.

Exit criteria: all constitutional gates pass and limitations are explicit.
`v0.1.0 implementation stop reached. Run pentest for this exact commit.`

### v0.2.0 — Checked Byte Primitives

Status: planned

Goal: safely consume hostile byte streams without casts or panics.

Deliverables:

- checked cursor, exact slicing, explicit endian integers, bounded varints;
- stable structured errors, source ranges, remaining/position accounting;
- no allocation, unsafe code, indexing, unchecked arithmetic, or hidden panic.

Verification:

- exhaustive boundary tables for every width and offset;
- truncation, overflow, non-canonical varint, trailing-input, and chunk tests;
- fuzz/property comparison against simple reference decoders.

Exit criteria: all cursor operations are bounded, deterministic, and
panic-free. `v0.2.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.3.0 — Identity And Time Primitives

Status: planned

Goal: define stable identity and honest temporal foundations.

Deliverables:

- record, tenant, source, instance, batch, schema, parser, and policy IDs;
- source/observation/ingest/normalization/effective time types;
- duration, clock offset, uncertainty, ordering confidence, and checked math.

Verification:

- construction, ordering, wrap, overflow, skew, and conversion tests;
- cross-endian and pointer-width compile checks;
- Kani-ready bounded arithmetic contracts.

Exit criteria: identities cannot be confused and time arithmetic fails closed.
`v0.3.0 implementation stop reached. Run pentest for this exact commit.`

### v0.4.0 — Streaming Parser Framework

Status: planned

Goal: establish a bounded incremental parser contract.

Deliverables:

- probe/begin/push/finish lifecycle and explicit limits;
- partial input, multiple records, malformed fields, unknown fields, and
  truncation states;
- parser identity/version, warnings, source ranges, and test harness.

Verification:

- every input split point, empty chunk, repeated finish, and reset sequence;
- state-machine fuzzing and no-progress-loop detection;
- allocation, recursion, record, field, and output limit tests.

Exit criteria: parsers can be independently fuzzed and cannot request
unbounded work. `v0.4.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.5.0 — Event Envelope

Status: planned

Goal: represent source observations without losing uncertainty or extensions.

Deliverables:

- borrowed and bounded owned observation envelopes;
- typed values, field identifiers, time bundle, integrity and policy slots;
- known/unknown/unavailable/redacted/not-applicable/conflicted/malformed value
  states and observed/asserted/derived/inferred claim states.

Verification:

- maximum-field/value tests, borrowed-owned equivalence, and redaction tests;
- unknown extension preservation and invalid state-combination rejection;
- compile tests for `no_std` and optional `alloc` boundaries.

Exit criteria: envelope semantics are explicit and forward compatible.
`v0.5.0 implementation stop reached. Run pentest for this exact commit.`

### v0.6.0 — Provenance And Source Capsules

Status: planned

Goal: make every interpreted value traceable to source evidence.

Deliverables:

- source capsule metadata, raw digest/location, content type and format;
- parser/mapping lineage, supporting byte ranges, warnings, unrepresented
  fields, and raw-retention modes;
- provenance-chain validation and bounded lineage depth.

Verification:

- exact-range, overlapping-range, digest-binding, and retention-policy tests;
- mutation and lineage-cycle rejection;
- replay fixtures proving interpretations point to original evidence.

Exit criteria: normalized output cannot silently detach from its source.
`v0.6.0 implementation stop reached. Run pentest for this exact commit.`

### v0.7.0 — Canonical Binary Codec

Status: planned

Goal: encode internal portable values deterministically and versionably.

Deliverables:

- documented field framing, canonical integers, nesting, and version headers;
- streaming decode, exact consumption, unknown-field preservation;
- explicit size/depth/item limits and compatibility fixtures.

Verification:

- canonical and non-canonical corpus, round trips, all split points;
- fuzz encode/decode, mutation, truncation, and allocation-budget tests;
- byte-for-byte deterministic vectors across supported target families.

Exit criteria: one value has one canonical encoding per format version.
`v0.7.0 implementation stop reached. Run pentest for this exact commit.`

### v0.8.0 — Policy Labels

Status: planned

Goal: attach enforceable governance context to evidence.

Deliverables:

- tenant, classification, residency, retention, privacy, releasability, and
  purpose labels;
- monotonic merge rules, explicit conflicts, redaction and movement decisions;
- deny-by-default policy evaluation contract.

Verification:

- cross-tenant, downgrade, conflict, missing-label, and purpose tests;
- policy lattice properties and information-flow cases;
- adversarial attempts to erase restrictive labels.

Exit criteria: policy cannot be weakened by merge or omission.
`v0.8.0 implementation stop reached. Run pentest for this exact commit.`

### v0.9.0 — Bounded Memory Structures

Status: planned

Goal: provide predictable memory and overload behavior.

Deliverables:

- fixed queues, bounded maps/sets, buffer pools, priority lanes, and counters;
- high/low watermarks, explicit overflow results, backpressure signals;
- fair capacity partitioning so one source cannot consume all resources.

Verification:

- zero/one/full/overflow/reuse tests and allocator-failure simulations;
- state-machine/property tests for ownership and conservation;
- deterministic overload and starvation scenarios.

Exit criteria: every structure has an explicit maximum and overflow outcome.
`v0.9.0 implementation stop reached. Run pentest for this exact commit.`

### v0.10.0 — Foundation Security Audit

Status: planned

Goal: freeze the first portable foundation after independent review.

Deliverables:

- complete format/API documentation and compatibility corpus;
- fuzz, Miri, applicable Kani, unsafe/dependency evidence, and design review;
- remediation releases as needed before later planes depend on foundations.

Verification:

- sustained fuzz campaign and full malformed-input corpus;
- cross-target deterministic vectors and semver/API review;
- external design and implementation pentest.

Exit criteria: foundation findings are remediated and interfaces are safe to
build upon. `v0.10.0 implementation stop reached. Run pentest for this exact
commit.`

## Phase B — Security Fact Model And Interoperability

### v0.12.0 — Entity Model

Status: planned

Goal: represent stable and partially stable security subjects.

Deliverables:

- user, account, device, process, file, service, workload, certificate,
  endpoint, domain, cloud resource, application, and session entities;
- scoped identity, aliases, confidence, validity, and source-backed attributes;
- bounded entity references without accidental cross-tenant equality.

Verification:

- identity collision, alias conflict, tenant isolation, and lifetime tests;
- uncertain/malformed attribute handling and canonical codec vectors;
- entity fixture coverage for every category.

Exit criteria: entities are evidence-backed and tenant-safe.
`v0.12.0 implementation stop reached. Run pentest for this exact commit.`

### v0.14.0 — Relationship Model

Status: planned

Goal: connect entities with evidence-backed temporal relationships.

Deliverables:

- typed directed relationships, validity intervals, confidence, provenance;
- parent, login, connection, creation, modification, execution, resolution,
  membership, role, download, and communication relationships;
- explicit contradictory and superseded relationship states.

Verification:

- endpoint/type/tenant/interval validation and contradiction tests;
- graph-cycle and high-fanout resource bounds;
- source-evidence replay for relationship construction.

Exit criteria: a relationship cannot exist without valid endpoints and
provenance. `v0.14.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.16.0 — Schema Registry

Status: planned

Goal: version facts and fields without erasing source meaning.

Deliverables:

- field dictionary, event classes, profiles, extensions, constraints;
- schema identity/version, validation, compatibility rules, migration plans;
- immutable registry snapshots and unknown-schema behavior.

Verification:

- forward/backward compatibility, duplicate/redefinition, and migration tests;
- hostile deep/wide schema and cycle/resource tests;
- registry snapshot deterministic encoding.

Exit criteria: schema evolution is explicit, bounded, and replayable.
`v0.16.0 implementation stop reached. Run pentest for this exact commit.`

### v0.18.0 — OCSF Compatibility

Status: planned

Goal: support OCSF without treating it as Vakaheim's internal truth.

Deliverables:

- versioned import/export mappings for selected core classes;
- explicit loss, unknown-field, source-extension, and mapping-version reports;
- pinned conformance fixtures and provenance binding.

Verification:

- bidirectional lossless cases and declared lossy cases;
- malformed, future-version, duplicate, and oversized OCSF inputs;
- fixture comparisons against pinned official schema material.

Exit criteria: compatibility never silently claims a lossless mapping.
`v0.18.0 implementation stop reached. Run pentest for this exact commit.`

### v0.20.0 — OpenTelemetry And Parser SDK

Status: planned

Goal: expose a safe parser boundary and OTLP log compatibility.

Deliverables:

- OTLP log mapping with resource/scope/time/severity/body semantics;
- private parser SDK, example parser, limits, lifecycle, error and test APIs;
- external-parser security model and version negotiation.

Verification:

- OTLP fixture, attribute-loss, timestamp, duplicate, and limit tests;
- SDK compile tests, example fuzzing, and compatibility checks;
- untrusted parser failure and resource-isolation scenarios.

Exit criteria: parser extensions cannot bypass common validation or evidence
lineage. `v0.20.0 implementation stop reached. Run pentest for this exact
commit.`

## Phase C — Ingestion And Transport

### v0.22.0 — Local Ingestion Pipeline

Status: planned

Goal: receive, parse, normalize, route, and observe events in one process.

Deliverables:

- bounded stage queues and explicit stage outcomes;
- source authentication placeholder, capsule, parsing, normalization, policy,
  partition, durable-boundary and telemetry-gap contracts;
- per-source budgets, backpressure, metrics, and cancellation.

Verification:

- end-to-end fixtures, duplicate, reorder, malformed, cancel, and overload;
- no-silent-loss accounting and queue-conservation properties;
- performance baseline with exact dataset/configuration.

Exit criteria: every accepted input has a terminal recorded outcome.
`v0.22.0 implementation stop reached. Run pentest for this exact commit.`

### v0.24.0 — Native File Ingestion

Status: planned

Goal: tail files safely across supported hosted systems.

Deliverables:

- bounded reads, checkpoints, identity, rotation/truncation detection;
- multiline framing, encoding policy, partial-record handling, permissions;
- symlink/path/race protections and explicit inaccessible-source health.

Verification:

- rotate, copytruncate, replace, delete, permission, partial-write, reboot;
- path traversal, symlink race, huge line, invalid encoding, disk fault tests;
- Linux/Windows/macOS/BSD adapter smoke where available.

Exit criteria: file lifecycle changes cannot silently duplicate or lose data.
`v0.24.0 implementation stop reached. Run pentest for this exact commit.`

### v0.26.0 — Syslog

Status: planned

Goal: ingest bounded standards-aware syslog over datagrams and streams.

Deliverables:

- RFC framing variants, UDP/TCP/TLS adapter contracts, source identity;
- structured data and legacy parsing with exact raw preservation;
- per-source rate/size/concurrency limits and malformed-message evidence.

Verification:

- standards corpus, split/coalesced frame, spoof/replay, truncation, Unicode;
- packet loss, backpressure, connection churn, slow sender, oversized input;
- parser/network fuzzing and interoperability smoke.

Exit criteria: syslog ambiguity and transport loss are visible and bounded.
`v0.26.0 implementation stop reached. Run pentest for this exact commit.`

### v0.28.0 — JSON Ingestion

Status: planned

Goal: parse JSON logs without general serialization dependencies.

Deliverables:

- first-party streaming JSON and JSON Lines parser;
- bounded nesting, width, string/number length, allocation, duplicate-key and
  Unicode policies;
- source ranges, exact number/text preservation, and framed JSON mode.

Verification:

- JSON conformance and hostile corpus, every chunk boundary, deep/wide inputs;
- duplicate, invalid Unicode/escape/number, trailing and multi-value cases;
- sustained fuzzing and differential tests against pinned references.

Exit criteria: JSON parsing is bounded, deterministic, and panic-free.
`v0.28.0 implementation stop reached. Run pentest for this exact commit.`

### v0.30.0 — OTLP And OCSF Endpoints

Status: planned

Goal: expose authenticated network ingestion for compatibility formats.

Deliverables:

- source registration, authentication, schema/mapping selection, limits;
- bounded requests, batches, errors, timeouts, cancellation, idempotency;
- protocol-version and acknowledgement negotiation.

Verification:

- auth bypass, cross-tenant, replay, duplicate, downgrade, slow-client tests;
- protocol conformance, malformed frame, batch limit, disconnect recovery;
- interoperability with representative senders.

Exit criteria: endpoint input cannot bypass source, tenant, limit, or lineage
controls. `v0.30.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.32.0 — Agent Spool

Status: planned

Goal: preserve endpoint telemetry through disconnects and restarts.

Deliverables:

- encrypted append-only local segments, sequence checkpoints, priority lanes;
- crash recovery, expiry, quota partitioning, key rotation, tamper evidence;
- remote capacity/health reporting and explicit loss policy.

Verification:

- power loss at every write phase, corruption, disk full, rollback, expiry;
- noisy-source isolation, key loss/rotation, replay and duplicate recovery;
- multi-day capacity model and performance evidence.

Exit criteria: spool recovery has no silent loss or unauthorized disclosure.
`v0.32.0 implementation stop reached. Run pentest for this exact commit.`

### v0.34.0 — Batching And Acknowledgement

Status: planned

Goal: make delivery progress and durability explicit.

Deliverables:

- batch IDs, source sequences, resumable transfer and persistent checkpoints;
- idempotent writes, deduplication windows and acknowledgement levels;
- Received/Validated/DurableLocal/DurableQuorum/Indexed/DetectionProcessed.

Verification:

- reconnect at every acknowledgement, duplicate storms, reordered batches;
- checkpoint corruption, window expiry, retry exhaustion and partial writes;
- end-to-end invariant that acknowledged levels match durable state.

Exit criteria: no exactly-once fiction; retries are safe and progress is
honest. `v0.34.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.36.0 — Enrollment And Secure Transport

Status: planned

Goal: authenticate agents and rotate trust without lockout or downgrade.

Deliverables:

- bootstrap/enrollment identity, certificate and key lifecycle interfaces;
- mutual authentication, protocol negotiation, trust-root rollover;
- revocation, short-lived credentials, replay and downgrade protection.

Verification:

- unauthorized enrollment, token replay, stale/revoked identity, rollover;
- cross-tenant certificate, clock skew, interrupted rotation, downgrade;
- external transport and enrollment pentest.

Exit criteria: sources and servers mutually authenticate under a documented
failure model. `v0.36.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.38.0 — Relay

Status: planned

Goal: buffer and route many sources under local policy and disconnection.

Deliverables:

- multi-source routing, priority, spool, health, configuration epochs;
- tenant/source isolation, backpressure propagation, disconnected operation;
- preserve/summarize/suppress policy evidence.

Verification:

- route loops, policy mismatch, partition, upstream failover, saturation;
- tenant fairness, restart, configuration rollback and long disconnect;
- throughput/latency and loss-accounting evidence.

Exit criteria: the relay remains fail-closed, bounded, and auditable.
`v0.38.0 implementation stop reached. Run pentest for this exact commit.`

### v0.40.0 — Ingestion Security Milestone

Status: planned

Goal: harden the complete ingestion path before storage format commitment.

Deliverables:

- load, malformed-input, packet-loss, replay and long-duration campaigns;
- parser, endpoint, spool, enrollment, transport and relay review;
- remediations, operational limits, runbooks and failure evidence.

Verification:

- cross-component fuzzing and attack-scenario replay;
- resource-exhaustion, fault injection, upgrade and rollback tests;
- independent ingestion pentest.

Exit criteria: all ingestion findings are remediated and silent-loss claims are
evidence-backed. `v0.40.0 implementation stop reached. Run pentest for this
exact commit.`

## Phase D — Security-Native Storage

### v0.42.0 — Security Segment Format

Status: planned

Goal: specify immutable durable security-fact segments.

Deliverables:

- header, tenant/partition/time bounds, dictionaries, page directories;
- raw-capsule references, index directory, integrity/encryption metadata;
- atomic commit footer, version negotiation, scanner and repair boundaries.

Verification:

- canonical vectors, truncation at every byte, corrupt offsets/counts/lengths;
- parser fuzzing, cross-endian targets, unknown-version behavior;
- format design and forensic recoverability review.

Exit criteria: the format is bounded and parseable without trusting offsets.
`v0.42.0 implementation stop reached. Run pentest for this exact commit.`

### v0.44.0 — Write-Ahead Log And Recovery

Status: planned

Goal: make writes crash-safe and replay deterministic.

Deliverables:

- WAL records, transaction/commit markers, sequence and checksum rules;
- replay, torn-write detection, idempotent recovery, truncation/repair policy;
- fsync/durability adapter contract for supported hosted systems.

Verification:

- power loss at every write and sync point, disk-full and partial-sector tests;
- duplicate/reordered/corrupt/stale WAL and replay determinism;
- recovery model/property tests and real-filesystem smoke.

Exit criteria: committed and uncommitted states are unambiguous after crash.
`v0.44.0 implementation stop reached. Run pentest for this exact commit.`

### v0.46.0 — Column Encodings

Status: planned

Goal: encode security columns compactly without decoder ambiguity.

Deliverables:

- plain, delta, timestamp delta-of-delta, run-length, bit-pack, dictionary,
  boolean bitmap and raw byte pages;
- per-page limits/statistics, fallback encoding and exact value semantics;
- relationship and raw-reference page layouts.

Verification:

- round trip for extrema and distributions, malformed bit widths/dictionaries;
- fuzz/differential codec tests, corruption localization, budget enforcement;
- published compression/CPU baseline on security datasets.

Exit criteria: every codec is deterministic, bounded and corruption-aware.
`v0.46.0 implementation stop reached. Run pentest for this exact commit.`

### v0.48.0 — Primary Indexes

Status: planned

Goal: accelerate common filters without making indexes authoritative.

Deliverables:

- time, tenant, partition, class, source, numeric range, dictionary, bitmap;
- versioned index metadata, selectivity statistics and rebuild paths;
- safe fallback to segment scan on absence or invalidity.

Verification:

- result equivalence with full scans and corrupted/missing/stale index tests;
- boundary/range/cardinality and adversarial selectivity cases;
- build/query resource and performance budgets.

Exit criteria: index use never changes query truth or bypasses policy.
`v0.48.0 implementation stop reached. Run pentest for this exact commit.`

### v0.50.0 — Security Indexes

Status: planned

Goal: index security-specific values and relationships safely.

Deliverables:

- exact/token/prefix/suffix text, IP prefix, port/protocol, hash/identifier;
- entity adjacency, relationship type and finding/incident references;
- sensitive-index policy, encryption/transform hooks and collision semantics.

Verification:

- Unicode/token, IP family/prefix, hash collision, high-degree graph tests;
- scan equivalence, leakage analysis and authorization filtering;
- fuzzed index readers and hostile query-cost cases.

Exit criteria: security indexes are correct, bounded and policy-aware.
`v0.50.0 implementation stop reached. Run pentest for this exact commit.`

### v0.55.0 — Integrity And Encryption

Status: planned

Goal: detect tampering and protect tenant evidence at rest.

Deliverables:

- per-block checksum/digest, Merkle root, segment linkage, writer identity;
- authenticated encryption provider boundary, tenant/segment key hierarchy;
- rotation, wrapping, verification CLI, crypto-shred and hardware-key hooks.

Verification:

- corruption at every structure, swap/replay/rollback and wrong-key tests;
- known-answer/provider conformance, rotation interruption and metadata auth;
- cryptographic design review and storage pentest.

Exit criteria: modified, substituted or unauthenticated data fails closed.
`v0.55.0 implementation stop reached. Run pentest for this exact commit.`

### v0.60.0 — Retention, Compaction And Cold Data

Status: planned

Goal: enforce lifecycle policy without erasing auditability.

Deliverables:

- tenant/source/field/classification/incident/geography/purpose retention;
- legal hold, auditable deletion, compaction and expired-data proofs;
- cold segment/export adapters, backup interaction and repair/reindex flows.

Verification:

- overlapping policy, hold, expiry, interrupted compaction, restore and purge;
- unauthorized deletion, resurrection, stale index and key-destruction tests;
- lifecycle performance and forensic audit review.

Exit criteria: lifecycle actions are authorized, durable and independently
verifiable. `v0.60.0 implementation stop reached. Run pentest for this exact
commit.`

## Phase E — VQL Query And Reasoning

### v0.65.0 — VQL Lexer And Parser

Status: planned

Goal: parse a stable bounded security query language.

Deliverables:

- VQL grammar for search, pipelines, temporal, graph and live constructs;
- dependency-free lexer/parser, source spans, diagnostics, recovery and limits;
- syntax corpus, grammar versioning and reserved extension mechanism.

Verification:

- valid/invalid corpus, all token boundaries, deep/wide/long hostile inputs;
- lexer/parser fuzzing, no-progress and diagnostic stability tests;
- grammar ambiguity and Unicode/security review.

Exit criteria: arbitrary query text parses or rejects within explicit budgets.
`v0.65.0 implementation stop reached. Run pentest for this exact commit.`

### v0.70.0 — VQL Type Checker

Status: planned

Goal: reject ambiguous or unsafe queries before planning.

Deliverables:

- schema/field/function/type resolution and typed AST;
- uncertainty, missing/redacted values, time, entities and policy-label types;
- stable diagnostics and bounded inference.

Verification:

- positive/negative type matrices and schema-version compatibility;
- tenant/policy type confusion, coercion and inference exhaustion tests;
- property tests that typed nodes satisfy declared invariants.

Exit criteria: execution receives only explicit well-typed semantics.
`v0.70.0 implementation stop reached. Run pentest for this exact commit.`

### v0.75.0 — Logical Planner

Status: planned

Goal: normalize typed queries into inspectable policy-aware plans.

Deliverables:

- filters, projection, aggregate, join, window, temporal and graph operators;
- authorization and residency rewrites before physical planning;
- deterministic normalization, completeness requirements and plan limits.

Verification:

- logical equivalence fixtures and rewrite-order tests;
- authorization/residency bypass and plan-explosion adversarial cases;
- differential results against a simple reference interpreter.

Exit criteria: every logical plan displays policy and completeness effects.
`v0.75.0 implementation stop reached. Run pentest for this exact commit.`

### v0.80.0 — Single-Node Execution

Status: planned

Goal: execute bounded queries over local immutable segments.

Deliverables:

- scans, filters, projections, aggregates, joins and result streaming;
- memory/work/time/output budgets, cancellation and backpressure;
- storage-level authorization recheck and structured partial/failure results.

Verification:

- reference-result comparison, cancel at every operator, disk/index faults;
- memory, CPU, output and join/cardinality exhaustion tests;
- benchmark suite with plans, data, indexes and exact commit.

Exit criteria: queries cannot exceed policy or resource budgets silently.
`v0.80.0 implementation stop reached. Run pentest for this exact commit.`

### v0.85.0 — Temporal Operations

Status: planned

Goal: reason honestly over event time, late data and uncertainty.

Deliverables:

- event-time windows, watermarks, late-arrival policy and retractions;
- ordered/partially ordered sequences, negative conditions and timeouts;
- bitemporal `as_of` perspective and clock uncertainty propagation.

Verification:

- skew, reorder, late, duplicate, missing and boundary-time scenarios;
- deterministic replay and watermark/state expiry properties;
- adversarial long-window/state exhaustion tests.

Exit criteria: temporal results state ordering confidence and late-data impact.
`v0.85.0 implementation stop reached. Run pentest for this exact commit.`

### v0.90.0 — Graph Operations

Status: planned

Goal: query evidence-backed entity paths within strict limits.

Deliverables:

- typed traversal, direction, relationship validity and path constraints;
- depth/fanout/visited/work budgets and evidence-returning paths;
- policy filtering and incomplete/subgraph result semantics.

Verification:

- cyclic, high-degree, disconnected, contradictory and cross-tenant graphs;
- traversal/reference equivalence and cost-adversarial cases;
- policy-label propagation and redacted-path tests.

Exit criteria: graph traversal is bounded and never leaks a hidden edge.
`v0.90.0 implementation stop reached. Run pentest for this exact commit.`

### v0.95.0 — Live, Historical And Explanation Modes

Status: planned

Goal: unify watch, historical perspective and honest query explanations.

Deliverables:

- live subscriptions/checkpoints, saved queries and historical `as_of`;
- logical/physical/cost/policy/completeness explain output;
- indexes/segments/regions/redactions/gaps/approximations in results.

Verification:

- resume/reconnect/replay, configuration epoch and late-data tests;
- explanation/result consistency and information-leak review;
- live overload, cancellation and subscriber fairness.

Exit criteria: users can see why a result exists and why it may be incomplete.
`v0.95.0 implementation stop reached. Run pentest for this exact commit.`

### v0.100.0 — Query Security Milestone

Status: planned

Goal: harden the complete query stack before detection depends on it.

Deliverables:

- parser/planner fuzzing, authorization and residency campaign;
- adversarial cost, corrupted index/segment, cancellation and concurrency tests;
- remediation, operator limits and external query review.

Verification:

- sustained full-stack fuzz and attack query corpus;
- cross-tenant red-team scenarios and performance denial tests;
- independent query-language/engine pentest.

Exit criteria: query findings are remediated and policy enforcement is
defense-in-depth. `v0.100.0 implementation stop reached. Run pentest for this
exact commit.`

## Phase F — Detection

### v0.110.0 — Signed Rule Packages

Status: planned

Goal: make a rule a reviewable immutable package, not loose text.

Deliverables:

- manifest, source, compiled IR, schema/telemetry needs, resource budgets;
- ATT&CK mapping, severity/confidence/suppression, tests and simulation evidence;
- author/reviewer/build provenance, digest, signature and lifecycle states.

Verification:

- missing/mismatched/tampered component and signature tests;
- version/capability negotiation and hostile manifest limits;
- reproducible package build and independent verification.

Exit criteria: no rule executes unless its complete package validates.
`v0.110.0 implementation stop reached. Run pentest for this exact commit.`

### v0.120.0 — Predicate Detection

Status: planned

Goal: execute deterministic stateless rules at high volume.

Deliverables:

- field load, typed compare, contains, prefix/suffix, list/range/existence;
- bounded content matching, instruction/fuel/memory/output limits;
- finding construction with supporting evidence and completeness requirements.

Verification:

- instruction semantics, missing/redacted/malformed fields, hostile content;
- IR validator fuzzing and reference-interpreter comparison;
- throughput/latency budgets and deterministic cross-target vectors.

Exit criteria: invalid or over-budget IR is rejected before execution.
`v0.120.0 implementation stop reached. Run pentest for this exact commit.`

### v0.130.0 — Temporal Automata

Status: planned

Goal: detect bounded sequences and absence over time.

Deliverables:

- finite states, branches, sequences, negative conditions, timeouts, expiry;
- explicit partition keys, late-event semantics and transition evidence;
- compile-time state/work bounds.

Verification:

- exhaustive small-machine transitions and model-based tests;
- reorder/duplicate/late/gap/timeout and state-explosion attacks;
- deterministic replay under restart/checkpoint boundaries.

Exit criteria: every automaton has bounded state and explicit expiry.
`v0.130.0 implementation stop reached. Run pentest for this exact commit.`

### v0.140.0 — Detection State Store

Status: planned

Goal: persist detection state without changing rule semantics.

Deliverables:

- partitioned state, checkpoint, recovery, version, quota and eviction policy;
- per-rule/tenant/entity budgets and backpressure/health evidence;
- rule upgrade/migration and replay-safe state transitions.

Verification:

- crash/corrupt/stale/partial checkpoint, rebalance and quota tests;
- state isolation, exhaustion, deterministic recovery and rule rollback;
- long-duration state/expiry performance campaign.

Exit criteria: state loss or eviction is visible and never silently alters a
finding. `v0.140.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.150.0 — Findings And Evidence Bundles

Status: planned

Goal: emit immutable, explainable, replayable detection conclusions.

Deliverables:

- rule digest/version/parameters, facts, capsule refs and state transitions;
- aggregates, entity paths, gaps, uncertainty, confidence and severity reasons;
- worker identity, execution time, canonical digest and replay contract.

Verification:

- deterministic replay, tamper, missing-evidence and redaction cases;
- confidence/severity decomposition and bundle limit tests;
- independent verifier comparisons.

Exit criteria: every finding proves exactly why it fired and what was missing.
`v0.150.0 implementation stop reached. Run pentest for this exact commit.`

### v0.160.0 — Entity And Graph Detection

Status: planned

Goal: detect cross-source relationships and attack paths.

Deliverables:

- bounded entity resolution, relationship patterns and graph state;
- evidence/confidence-aware joins and policy-safe path detection;
- partition-placement requirements and incomplete-graph semantics.

Verification:

- alias/collision/conflict, cyclic/high-fanout and cross-tenant cases;
- deterministic path evidence and placement equivalence;
- state/resource exhaustion and false-merge attack scenarios.

Exit criteria: graph findings retain source-backed resolution decisions.
`v0.160.0 implementation stop reached. Run pentest for this exact commit.`

### v0.170.0 — Behavioral Engine

Status: planned

Goal: add transparent replayable behavioral analytics.

Deliverables:

- rarity, robust baseline, seasonality, peer groups, change points, sketches;
- transition/graph novelty, identity geography, drift and health evidence;
- tenant-local versioned models with explicit bounds and explanations.

Verification:

- fixed datasets with hand-calculated results and replay stability;
- poisoning, sparse/cold-start, drift, clock, peer manipulation and overflow;
- false-positive/negative and resource-budget evaluation.

Exit criteria: no opaque model output is treated as authoritative evidence.
`v0.170.0 implementation stop reached. Run pentest for this exact commit.`

### v0.180.0 — Detection Content Interoperability

Status: planned

Goal: import external content without bypassing Vakaheim validation.

Deliverables:

- versioned Sigma mapping, STIX intelligence, ATT&CK content and list imports;
- explicit unsupported/lossy semantics and source/version provenance;
- compiled-package validation, tests and review workflow for imported content.

Verification:

- pinned official fixtures, malformed/hostile content and semantic-loss cases;
- version upgrades/downgrades, duplicate/conflict and resource limits;
- imported-versus-native simulation comparison.

Exit criteria: external content follows the same package, test and rollout
gates. `v0.180.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.190.0 — Rule Simulation And Rollout

Status: planned

Goal: change detection safely with historical and staged evidence.

Deliverables:

- unit/adversarial tests, historical simulation and comparison reports;
- draft/validated/tested/shadow/canary/active/quarantined lifecycle;
- tenant/region/group/source/percentage/time rollout and rollback thresholds.

Verification:

- old/new deterministic comparisons and canary fault/noise/load scenarios;
- unauthorized activation, stale signature, rollback and configuration drift;
- operational rehearsal with audit evidence.

Exit criteria: no rule can move from proposal to active without review and
staged gates. `v0.190.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.200.0 — Detection Security Milestone

Status: planned

Goal: harden detection correctness, availability and false-negative controls.

Deliverables:

- deterministic replay campaign and hostile rule/state/content corpus;
- state exhaustion, missed telemetry, partition and rollback exercises;
- detection-placement, behavioral and evidence-bundle review/remediation.

Verification:

- sustained rule/IR/state fuzz and attack-scenario replay;
- controlled false-positive/false-negative security evaluation;
- independent detection architecture and implementation pentest.

Exit criteria: findings are remediated and replay/completeness claims hold.
`v0.200.0 implementation stop reached. Run pentest for this exact commit.`

## Phase G — Native Operating-System Sensors

### v0.210.0 — Linux Base Agent

Status: planned

Goal: collect core Linux security evidence with least privilege.

Deliverables:

- journald/syslog, audit, process, authentication, service, package, file and
  network/container context;
- unprivileged agent, small privileged helper boundary, spool and health;
- installation, permissions, upgrade, rollback and non-eBPF operation.

Verification:

- supported distribution/kernel matrices and real attack scenarios;
- privilege loss, audit impairment, rotation, namespace, overload and reboot;
- agent resource/performance and independent Linux pentest.

Exit criteria: Linux collection gaps and privilege loss are first-class facts.
`v0.210.0 implementation stop reached. Run pentest for this exact commit.`

### v0.220.0 — Linux eBPF Sensor

Status: planned

Goal: add optional bounded kernel-assisted process/network telemetry.

Deliverables:

- BTF-aware versioned records and minimal privileged loader;
- verifier-friendly bounded probes/maps, detach health and hot replacement;
- explicit capability detection and non-eBPF fallback.

Verification:

- kernel/verifier/capability matrix, attach/detach/update/failure tests;
- malformed ring data, map pressure, loss accounting and hostile workloads;
- kernel/userspace boundary security review and pentest.

Exit criteria: eBPF failure never disables the base agent silently.
`v0.220.0 implementation stop reached. Run pentest for this exact commit.`

### v0.230.0 — Windows Base Agent

Status: planned

Goal: collect core Windows security evidence through documented interfaces.

Deliverables:

- Event Log, ETW, process, authentication, service, registry and scheduled task;
- low-privilege service/optional helper separation, spool, health and packaging;
- provider/session loss, permission and security-control impairment evidence.

Verification:

- supported Windows matrix and real attack scenarios;
- ETW/Event Log gaps, reboot, upgrade, privilege, overload and corruption;
- performance and independent Windows agent pentest.

Exit criteria: Windows evidence continuity and missing providers are visible.
`v0.230.0 implementation stop reached. Run pentest for this exact commit.`

### v0.240.0 — Windows Advanced Telemetry

Status: planned

Goal: add network, scripting, WMI and security-control visibility safely.

Deliverables:

- network metadata, PowerShell/scripting, WMI and security-product health;
- optional driver boundary only for evidence unavailable through safe APIs;
- response adapter contracts without generic command execution.

Verification:

- evasion, provider disable, high-volume script/network and WMI scenarios;
- optional-driver install/remove/failure and no-driver fallback;
- dedicated privileged-boundary review and pentest.

Exit criteria: advanced collection cannot weaken the base agent security model.
`v0.240.0 implementation stop reached. Run pentest for this exact commit.`

### v0.250.0 — macOS Agent

Status: planned

Goal: collect macOS security evidence with explicit entitlement health.

Deliverables:

- Endpoint Security, Unified Logging, FSEvents, persistence and network metadata;
- system extension packaging, spool, permissions/entitlement health;
- fallback and unsupported-event reporting.

Verification:

- supported macOS matrix, event/auth response and attack scenarios;
- entitlement loss, extension update, sleep/reboot, event drops and overload;
- resource evidence and independent macOS pentest.

Exit criteria: absent permissions or dropped ES messages cannot look healthy.
`v0.250.0 implementation stop reached. Run pentest for this exact commit.`

### v0.255.0 — Mobile Adapters

Status: planned

Goal: support Android and iOS within their sandbox and privacy constraints.

Deliverables:

- portable SDK integration and platform-permitted application/device telemetry;
- bounded offline spool, enrollment, privacy labels and lifecycle health;
- explicit unsupported capabilities, background and permission state.

Verification:

- supported Android/iOS version/device simulators and selected real devices;
- permission revoke, background suspension, storage pressure, upgrade, clock;
- mobile privacy/security review and pentest.

Exit criteria: mobile adapters make no desktop-level collection claim and
report every visibility limit. `v0.255.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.260.0 — BSD And Kubernetes Sensors

Status: planned

Goal: add BSD host and Kubernetes workload evidence.

Deliverables:

- FreeBSD/OpenBSD syslog, audit/OpenBSM, kqueue, process accounting and pf;
- Kubernetes audit, workload identity, admission, RBAC, exec, image and network;
- common fact/spool/transport semantics and capability-health reporting.

Verification:

- supported BSD and Kubernetes matrices and representative attacks;
- audit/API loss, workload churn, identity reuse, overload and upgrade;
- cross-context entity-resolution and tenant-isolation review.

Exit criteria: platform differences are explicit without format fragmentation.
`v0.260.0 implementation stop reached. Run pentest for this exact commit.`

## Phase H — SDK, Connectors And Source Assurance

### v0.270.0 — Private Rust SDK Preview

Status: planned

Goal: stabilize an in-workspace SDK without publishing it.

Deliverables:

- `no_std` types/events and `alloc` query/rule/playbook surfaces;
- `std` blocking and poll-based client, version/capability negotiation;
- stable errors, IDs, pagination, resume, cancellation and audit metadata.

Verification:

- API/feature/semver compile tests and protocol compatibility matrix;
- unknown field/enum, timeout, retry/idempotency and partial-stream tests;
- package-content check proving `publish = false`.

Exit criteria: the SDK is usable internally but remains unpublishable.
`v0.270.0 implementation stop reached. Run pentest for this exact commit.`

### v0.280.0 — Connector SDK

Status: planned

Goal: give connectors a typed, bounded, testable lifecycle.

Deliverables:

- discovery, checkpoint, poll/push, rate limit, retry and health contracts;
- secret handles, network allowlists, tenant/source identity and simulator;
- capability manifest, versioning and source-capsule requirements.

Verification:

- malicious connector, secret misuse, cross-tenant, retry storm and checkpoint;
- mock server/fault simulator and conformance suite;
- capability/egress isolation security review.

Exit criteria: connectors cannot obtain ambient secrets or network authority.
`v0.280.0 implementation stop reached. Run pentest for this exact commit.`

### v0.290.0 — Cloud Audit Connectors

Status: planned

Goal: ingest major cloud control-plane and resource audit evidence.

Deliverables:

- compute, identity, storage, networking and control-plane source adapters;
- pagination, checkpoint, eventual consistency, rate and regional semantics;
- source-native preservation and common entity mappings.

Verification:

- provider fixtures, duplicate/late/missing page, throttle and credential tests;
- cross-account/tenant/region and partial-permission completeness;
- live sandbox interoperability and connector pentest.

Exit criteria: cloud collection states exactly which accounts/regions/actions
are visible. `v0.290.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.300.0 — Identity And SaaS Connectors

Status: planned

Goal: ingest identity, productivity, source-code and ticketing evidence.

Deliverables:

- major IdP/SaaS adapters and generic bounded API polling;
- user/session/application/token/entity mapping and source-native capsules;
- checkpoint, webhook verification, permissions and rate health.

Verification:

- webhook spoof/replay, deleted account, renamed identity, paging and throttle;
- least-privilege scopes, secret rotation and tenant separation;
- representative provider interoperability and pentest.

Exit criteria: identity ambiguity and permission-limited visibility are
reported. `v0.300.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.315.0 — Network-Security Ingestion

Status: planned

Goal: ingest common network and security-device telemetry.

Deliverables:

- flow, DNS, DHCP, VPN, firewall, proxy, email-security and IDS formats;
- bounded high-volume parsing, identity correlation and source health;
- timestamps, sampling, truncation and sensor-loss semantics.

Verification:

- format corpus/fuzzing, spoofed/truncated/fragmented and volume attacks;
- sampling/completeness, address reuse/NAT and clock/order scenarios;
- throughput benchmarks and parser pentest.

Exit criteria: sampled or incomplete network evidence is never presented as
complete. `v0.315.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.330.0 — Adaptive Collection And Source Assurance

Status: planned

Goal: detect missing evidence and safely request temporary collection changes.

Deliverables:

- gap facts for source loss, rate anomalies, sequence, clocks, parser errors,
  detachments, permission loss, spool/backpressure, retention and replication;
- completeness scoring from concrete evidence;
- signed bounded collection escalation, approval, expiry and auto-reversion.

Verification:

- every impairment signal, false-health, flapping and correlated outage;
- unauthorized/unbounded/stale escalation and failed reversion;
- dashboards/query/finding completeness consistency.

Exit criteria: Vakaheim can distinguish no suspicious evidence from no
visibility. `v0.330.0 implementation stop reached. Run pentest for this exact
commit.`

## Phase I — Analyst Product

### v0.345.0 — Alert Routing

Status: planned

Goal: route immutable findings into controlled analyst workflows.

Deliverables:

- finding deduplication/grouping, alert identity/state and ownership;
- tenant/team routing, priority, notification, escalation and SLA policy;
- governed suppression with reason, approval, expiry and full audit.

Verification:

- duplicate storms, route loops, stale ownership, SLA and notification faults;
- suppression bypass/expiry and cross-tenant access tests;
- load/fairness and audit-completeness scenarios.

Exit criteria: mutable alerts never alter their immutable source findings.
`v0.345.0 implementation stop reached. Run pentest for this exact commit.`

### v0.360.0 — Incident Graph

Status: planned

Goal: group findings and entities into explainable reversible incidents.

Deliverables:

- automatic/manual grouping, entity timelines, hypotheses and relationships;
- grouping evidence/reason, confidence, split/merge/revert and audit;
- shared entity, infrastructure, time, attack path, campaign and session rules.

Verification:

- false merge/split, cross-tenant, high-volume and contradictory evidence;
- deterministic grouping and exact reversible history;
- authorization/redaction propagation through incident graph.

Exit criteria: every automatic grouping decision is explainable and reversible.
`v0.360.0 implementation stop reached. Run pentest for this exact commit.`

### v0.375.0 — Case Management

Status: planned

Goal: support complete investigation workflow without mutating evidence.

Deliverables:

- assignment, priority, status, tasks, comments, timeline, evidence and SLAs;
- approval requests, playbook runs, legal hold, external tickets and history;
- optimistic concurrency, audit identity and policy-aware collaboration.

Verification:

- concurrent edits, stale clients, permission change, retention/legal hold;
- attachment tamper, audit omission, cross-tenant and workflow-state tests;
- realistic incident-response tabletop and recovery.

Exit criteria: case history is complete while source evidence remains
immutable. `v0.375.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.390.0 — Forensic Reporting

Status: planned

Goal: export verifiable evidence and investigation reports.

Deliverables:

- chain-of-custody records, evidence packages, signed reports and verifier;
- redaction, legal hold, policy-aware export and external-ticket linkage;
- deterministic report inputs and source/finding/case citations.

Verification:

- tamper, omission, reorder, partial export and wrong-policy tests;
- independent offline verification and cross-platform package handling;
- forensic/legal workflow review and pentest.

Exit criteria: recipients can independently validate package integrity and
scope. `v0.390.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.405.0 — Analyst And Administration UI

Status: planned

Goal: expose complete product workflows through policy-safe interfaces.

Deliverables:

- search/query/live/event/raw/entity/timeline/graph/incident/case/report views;
- rule studio, simulation, rollout, source assurance, fleet and storage views;
- tenant, identity, role, policy, key, schema, backup, upgrade and audit admin.

Verification:

- browser security, session, CSRF, XSS, injection, clickjacking and CSP tests;
- authorization/redaction at every view/action and accessible workflows;
- end-to-end analyst/admin scenarios and UI pentest.

Exit criteria: the UI never replaces server-side enforcement or generated
evidence explanations. `v0.405.0 implementation stop reached. Run pentest for
this exact commit.`

## Phase J — Wasm And SOAR

### v0.420.0 — Wasm ABI And Read-Only Host

Status: planned

Goal: run optional read-only extensions without ambient authority.

Deliverables:

- WIT capability worlds, signed manifests and component validation;
- fuel, wall time, memory, output, host-call and concurrency limits;
- isolated worker process/OS sandbox and evidence-only handles.

Verification:

- malformed module/component, capability forgery, escape and confused deputy;
- fuel/memory/output/host-call exhaustion, cancellation and worker crash;
- differential sandbox review and independent Wasm-host pentest.

Exit criteria: the Wasm runtime is defense-in-depth, bounded and read-only.
`v0.420.0 implementation stop reached. Run pentest for this exact commit.`

### v0.430.0 — Playbook Engine

Status: planned

Goal: model response workflows as typed auditable state machines.

Deliverables:

- proposed/policy/approval/scheduled/running/verifying/completed/failure and
  compensation/cancel states;
- typed steps, branching, waits, retries, deadlines, idempotency and recovery;
- immutable execution audit and deterministic dry-run plan.

Verification:

- exhaustive small-workflow transitions and crash/retry/cancel at every state;
- duplicate delivery, stale approval, timeout and compensation failures;
- workflow fuzz/model checking and replay.

Exit criteria: no workflow step executes from an invalid or unaudited state.
`v0.430.0 implementation stop reached. Run pentest for this exact commit.`

### v0.440.0 — Capabilities And Secret Handles

Status: planned

Goal: grant extensions only narrow unforgeable operation authority.

Deliverables:

- tenant/incident/action-scoped handles, expiry and revocation;
- sign/fetch-short-token/authenticated-call secret operations;
- per-component network allowlists, identity, quotas and full audit.

Verification:

- handle forgery/reuse/leak/cross-tenant, stale/revoked and scope confusion;
- DNS/rebinding/redirect/egress bypass and secret-exfiltration tests;
- formal authorization properties and pentest.

Exit criteria: long-lived secrets and ambient connectors are not exposed.
`v0.440.0 implementation stop reached. Run pentest for this exact commit.`

### v0.450.0 — Response Actions

Status: planned

Goal: execute specific controlled response with approval and verification.

Deliverables:

- endpoint, identity, network, cloud, credential, evidence and ticket actions;
- automatic/human/two-person/prohibited approval policy;
- idempotency, verification, retry, compensation, dry run and canary.

Verification:

- unauthorized/destructive/wrong-target, duplicate, race and stale context;
- approval bypass/collusion, failed verification and compensation scenarios;
- red-team response worker/connectors and independent pentest.

Exit criteria: arbitrary command execution remains prohibited and every side
effect is scoped and verified. `v0.450.0 implementation stop reached. Run
pentest for this exact commit.`

## Phase K — Control Plane, Cluster And Federation

### v0.460.0 — Control Plane

Status: planned

Goal: distribute immutable signed configuration epochs safely.

Deliverables:

- node/fleet identity, trust roots, config, schema, parser, rule and component
  registries, policy, tenant, storage and upgrade metadata;
- current/previous epoch, validation, activation, rollback, drift and audit;
- bootstrap, break-glass and least-privilege administration.

Verification:

- unauthorized/stale/tampered/partial epoch and split configuration;
- rollover, rollback, drift, break-glass and compromised admin scenarios;
- control-plane API/UI pentest.

Exit criteria: nodes cannot activate unauthenticated or invalid configuration.
`v0.460.0 implementation stop reached. Run pentest for this exact commit.`

### v0.465.0 — Metadata Consensus

Status: planned

Goal: replicate small control metadata under a documented crash-fault model.

Deliverables:

- leader election, log, commit, snapshot, membership change and stale-leader
  protection;
- formal executable model aligned with implementation;
- bounded messages/storage, authentication and operational recovery.

Verification:

- model checking, deterministic network schedules and fault injection;
- partition, reorder, duplicate, crash/restart, snapshot and membership races;
- implementation/model trace comparison and consensus pentest.

Exit criteria: safety properties hold for the documented fault assumptions.
`v0.465.0 implementation stop reached. Run pentest for this exact commit.`

### v0.470.0 — Data Replication

Status: planned

Goal: replicate immutable data with explicit durability and repair.

Deliverables:

- partition placement, quorum acknowledgement, rack awareness and bandwidth
  priorities;
- authenticated segment transfer, integrity comparison, repair and rebalance;
- lag, under-replication, corruption and unavailable-partition evidence.

Verification:

- node/rack loss, partition, stale/corrupt replica, rebuild and rebalance;
- quorum/RPO invariants, acknowledgement truth and split-brain scenarios;
- load/chaos campaign and storage-cluster pentest.

Exit criteria: committed durability claims match the exact failure model.
`v0.470.0 implementation stop reached. Run pentest for this exact commit.`

### v0.475.0 — Multi-Tenancy And Federated Query

Status: planned

Goal: query across nodes/regions without violating tenant or sovereignty policy.

Deliverables:

- tenant isolation, regional policy, signed distributed plans and capabilities;
- pushdown, aggregate/redacted/finding/evidence-reference/denied result types;
- partial, unavailable, policy-limited and completeness semantics.

Verification:

- cross-tenant/region/field/purpose attacks and compromised worker;
- partition, stale policy, partial result, retry and duplicate subplan;
- distributed authorization proof tests and federation pentest.

Exit criteria: policy-limited results can never appear globally complete.
`v0.475.0 implementation stop reached. Run pentest for this exact commit.`

### v0.480.0 — Multi-Region And Disaster Recovery

Status: planned

Goal: survive regional failure and operate offline or air-gapped.

Deliverables:

- region-aware placement, asynchronous replication, failover and sovereignty;
- backup/restore/repair/reindex/migration, offline update and trust bundles;
- rolling upgrade, deterministic rollback and full disaster runbooks.

Verification:

- region loss, total network partition, stale backup, corrupt media and key loss;
- air-gap import/export, rolling mixed-version and rollback rehearsals;
- independent disaster recovery exercise and multi-region pentest.

Exit criteria: recovery objectives, data loss and unavailable evidence are
measured honestly. `v0.480.0 implementation stop reached. Run pentest for this
exact commit.`

## Phase L — Completion And Hardening

### v0.485.0 — Optional AI Assistance

Status: planned

Goal: add audited proposal-only AI outside the trusted correctness path.

Deliverables:

- query/rule/test drafting, explanations, summaries and response suggestions;
- explicit evidence selection, redaction, tenant boundaries, citations/audit;
- local-model adapter, provider policy and complete disable switch.

Verification:

- prompt injection, evidence exfiltration, cross-tenant, false citation and
  fact/inference confusion;
- attempted direct action/rule activation and disabled-mode proof;
- AI threat-model review and pentest.

Exit criteria: AI output cannot mutate authoritative state without normal human
gates. `v0.485.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.490.0 — Privacy And Compliance Controls

Status: planned

Goal: enforce field, purpose, residency and retention policy end to end.

Deliverables:

- field redaction/tokenization, purpose limitation, residency placement;
- access reports, retention/deletion proofs and privacy workflows;
- independent policy/audit validation and operator documentation.

Verification:

- policy matrix across ingest/storage/query/detection/case/export/AI/response;
- inference, aggregation, cache/index/export/backup leakage scenarios;
- independent privacy and compliance assessment/pentest.

Exit criteria: policy enforcement is consistent across every product plane.
`v0.490.0 implementation stop reached. Run pentest for this exact commit.`

### v0.492.0 — Performance Campaign

Status: planned

Goal: prove production targets on published reproducible reference systems.

Deliverables:

- endpoint CPU/memory, ingest throughput/burst, detection/query latency;
- cluster scale, failover, spool, evidence verification and recovery results;
- hardware, OS, flags, data, schemas, rules, indexes, replication and commits.

Verification:

- repeated cold/warm/steady/burst/failure runs and statistical reporting;
- resource exhaustion, noisy neighbor and regression thresholds;
- independent result reproduction.

Exit criteria: every performance claim has reproducible evidence and no hidden
loss. `v0.492.0 implementation stop reached. Run pentest for this exact commit.`

### v0.494.0 — Verification Campaign

Status: planned

Goal: exercise full-product correctness and failure behavior.

Deliverables:

- sustained fuzz, Kani, Loom/deterministic concurrency, Miri and conformance;
- chaos, corruption, power-loss, disk-full, network, clock and attack replay;
- protocol/format/API compatibility and reproducible-build evidence.

Verification:

- all verification suites at release duration and published coverage gaps;
- mutation testing or equivalent test-effectiveness sampling;
- independent review of residual unverifiable assumptions.

Exit criteria: critical invariants have multiple independent evidence forms.
`v0.494.0 implementation stop reached. Run pentest for this exact commit.`

### v0.496.0 — Independent Security Assessment

Status: planned

Goal: obtain full external assessment before public beta.

Deliverables:

- architecture, source, crypto, storage, cluster, agent, UI/API, Wasm/SOAR,
  supply-chain and operational assessment;
- critical/high/medium remediation and regression evidence;
- public-safe summary plus private finding archive.

Verification:

- retest every finding on exact remediation commits;
- rerun complete release and performance/verification campaigns;
- no unresolved critical or high finding.

Exit criteria: assessment is complete and all release-blocking findings pass
retest. `v0.496.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.497.0 — SDK Publication Admission

Status: planned

Goal: decide whether the single public SDK is safe to publish later.

Deliverables:

- binding package list (default one `vakaheim-sdk`), API/semver/license review;
- `MIT OR Apache-2.0` exception only for approved SDK package;
- package contents, provenance, docs, compatibility and revocation plan;
- explicit decision; rejection keeps every crate private.

Verification:

- clean-room consumer builds, minimal/all features and older-client protocol;
- package secret/internal-file/dependency/source audit;
- independent SDK API/security review.

Exit criteria: publication remains disabled unless an affirmative maintainer
decision and all evidence exist. `v0.497.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.498.0 — Public Beta

Status: planned

Goal: operate production-like deployments with complete support tooling.

Deliverables:

- single-node, cluster, multi-region, air-gap and upgrade beta deployments;
- migration, backup/recovery, operator, security, developer, detector and IR
  documentation;
- issue triage, compatibility freeze candidates and support procedures.

Verification:

- long-duration operation and real operator/analyst exercises;
- clean install, scale, failure, migration, upgrade and rollback rehearsals;
- beta finding remediation and exact-commit pentest.

Exit criteria: production-like beta evidence has no unresolved release blocker.
`v0.498.0 implementation stop reached. Run pentest for this exact commit.`

### v0.499.0 — Release Candidate Freeze

Status: planned

Goal: freeze product scope and all compatibility surfaces.

Deliverables:

- feature/API/wire/storage/rule/package/schema/upgrade and CLI freeze;
- final dependency/unsafe/toolchain/action inventory and release documents;
- only security, correctness and release-blocking compatibility fixes allowed.

Verification:

- complete clean rebuild, all gates, package/archive diff and reproducibility;
- previous-version upgrade/rollback and all deployment topology rehearsal;
- full independent candidate pentest.

Exit criteria: any material fix creates a new candidate cycle.
`v0.499.0 implementation stop reached. Run pentest for this exact commit.`

### v0.500.0 — Feature-Complete Stable Candidate

Status: planned

Goal: demonstrate every 1.0 capability and gate before exact RC versioning.

Deliverables:

- complete product, platform, SDK, UI, cluster, operations and documentation;
- signed reproducible artifacts, SBOM/provenance and all audit evidence;
- final 1.0 acceptance checklist with no missing foundational capability.

Verification:

- full release/performance/verification/security campaigns on exact commit;
- installation, upgrade, rollback, recovery and disaster exercises;
- final independent full-product pentest and remediation.

Exit criteria: all 1.0 gates pass with no critical/high finding.
`v0.500.0 implementation stop reached. Run pentest for this exact commit.`

### v1.0.0-rc.1 — Exact Production Candidate

Status: planned

Goal: produce the exact artifacts eligible for unchanged stable promotion.

Deliverables:

- package versions, lockfile, SBOM, archives, checksums, signatures and
  provenance finalized on one commit;
- complete release notes, migration/support policy and audit/pentest reports;
- no feature or ordinary refactor changes.

Verification:

- artifact byte/checksum reproducibility and clean environment installation;
- all stable gates against exact candidate artifacts;
- independent exact-candidate pentest with no critical/high finding.

Exit criteria: candidate artifacts are approved and immutable. Any change
requires `rc.2` and repeated evidence. `v1.0.0-rc.1 implementation stop
reached. Run pentest for this exact commit.`

### v1.0.0 — Full Vakaheim Release

Status: planned

Goal: promote the unchanged approved release candidate as the first serious
production Vakaheim release.

Deliverables:

- stable tag targets the exact approved RC commit;
- checksums, packages, SBOM, provenance and signatures match the approved RC;
- production support, security response and maintenance process active.

Verification:

- cryptographic equality with approved RC artifacts and tag target;
- final metadata, documentation, CI and CodeQL default review;
- no code, manifest, lockfile or generated-evidence change since RC approval.

Exit criteria: every acceptance item below passes. Stable promotion requires
explicit maintainer authorization and never publishes internal crates.

## Final 1.0 Acceptance Checklist

- Linux, Windows, macOS, BSD, Android, iOS and Kubernetes support claims have
  real-system evidence; future Aesynx compatibility remains unblocked.
- Cloud, identity, network, syslog, OTLP, OCSF, JSON and file ingestion work.
- Source lineage, immutable facts, telemetry gaps and completeness are queryable.
- Storage survives crash, corruption, node/rack/region loss and rolling upgrade.
- Historical, live, temporal, graph and federated VQL queries work safely.
- Predicate, temporal, stateful, graph, behavioral and integrity detection work.
- Simulation, shadow, canary, rollback and deterministic finding replay work.
- Alerts, incidents, cases, evidence, legal hold and signed reports work.
- Wasm is capability-limited and OS-isolated; response requires correct approval,
  idempotency, verification and compensation.
- Multi-tenancy, field policy, residency and purpose enforcement pass independent
  assessment.
- Single-node, cluster, sovereign multi-region and air-gap operation are tested.
- Backup, restore, repair, reindex, migration, upgrade and rollback are complete.
- The SDK publication decision is explicit; internal crates remain unpublished.
- Analyst and administration interfaces and complete operator/developer/security
  documentation exist.
- No critical or high assessment finding remains.
- Wire, storage, rule-package, schema, SDK and public API formats are stable.
- Builds and release artifacts are reproducible, signed and provenance-bound.
