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
- exact-commit pentest, a permanent passing report, and a verifiable trusted-
  tester signature or attestation with an offline trust/revocation procedure;
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

## Completeness Review Register

The register prevents cross-cutting product obligations from disappearing
between phase summaries. It strengthens the existing sequence; it does not
replace or renumber it.

| Gap | Owning versions |
| --- | --- |
| Evidence integrity versus authenticity, availability, reconstruction, and source truth | `v0.6.1`, `v0.11.0`, `v0.150.0` |
| Cryptographic ownership, text identity, hosted runtime, TLS, and zero-third-party feasibility | `v0.4.1`, `v0.4.2`, `v0.10.1`, `v0.20.2`, `v0.20.3` plus every host/protocol/crypto/Wasm milestone |
| Fact conflicts, schema ownership, extension governance, and mapping loss | `v0.11.0`, `v0.15.0`, `v0.16.0`, `v0.20.1` |
| Deterministic identity resolution, asset inventory, ownership, exposure, and retirement | `v0.13.0`, `v0.298.0` |
| Local identities, trust/configuration/registries, authorization, capabilities, and audit schema before consumers | `v0.17.0`, `v0.19.0`, replicated at `v0.460.0` |
| Conservation, acknowledgement truth, raw quarantine, continuity, overload, backfill/reprocessing, and impairment lane | `v0.20.4`, `v0.22.0`, `v0.31.0`, `v0.39.0`, `v0.40.0` |
| Exact syslog, JSON, Protobuf/compression, HTTP/gRPC/browser, OTLP, OCSF, STIX/TAXII, and Wasm profiles | `v0.20.1`, `v0.26.0`, `v0.28.0`, `v0.29.0`–`v0.30.1`, `v0.306.0`, `v0.407.0`–`v0.410.0` |
| Database capacity, stable media, raw evidence, integrity, encryption, keys, migration, and correctly scoped early scale | `v0.41.0` through `v0.60.0`, especially `v0.53.0`–`v0.58.0` |
| Query authority, physical planning, worst-case admission, spill, joins, ordering, statistics/text, and side channels | `v0.72.0`, `v0.76.0`–`v0.84.0`, `v0.96.0` |
| Detection execution identity, fixed-point semantics, impairment, placement, threat intelligence, ATT&CK, and risk | `v0.115.0`, `v0.145.0`, `v0.165.0`, `v0.175.0`, `v0.178.0` |
| Common agent/helper boundary and platform-specific continuity evidence | `v0.205.0` through `v0.267.0` |
| API contract/service/client sequencing, connector isolation, provider profiles, integrity content, and notification outbox | `v0.270.0`–`v0.342.0` |
| Scoped forensic acquisition, confidential cases, split authentication, authorization, audit, and split UIs | `v0.382.0` through `v0.405.0` |
| Wasm core/Canonical ABI, component registry/host, bound actions, unknown outcomes, provider actions, and recovery | `v0.407.0` through `v0.455.0` |
| Operational-state matrix/HA, consensus, immutable replication, tenancy, federation, SRE, split DR, and distributed scale | `v0.459.0` through `v0.484.0` |

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
- trusted-tester identity, signature/attestation, trust-root, rotation,
  revocation, and offline report-verification contract.

Verification:

- compile, test, lint, doc, `no_std`, target-family, manifest-source,
  no-publication, root-documentation, file-length, and shell checks;
- cargo-deny, cargo-audit, SBOM check, and live tool freshness check;
- reject an unsigned, untrusted, revoked, wrong-commit, or unverifiable
  assessment report;
- review that no operational SIEM capability is claimed.

Exit criteria: all constitutional gates pass and limitations are explicit.
`v0.1.0 implementation stop reached. Run pentest for this exact commit.`

### v0.2.0 — Checked Byte Primitives

Status: planned

Goal: safely consume hostile byte streams without casts or panics.

Deliverables:

- checked cursor, exact slicing, explicit endian integers, bounded varints;
- fixed-width persistent lengths/offsets with checked conversion to `usize`;
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

### v0.4.1 — Cryptographic Provider Contracts And Trust Primitives

Status: planned

Goal: establish cryptographic ownership before any digest, signature,
authentication, or encryption consumer is implemented.

Deliverables:

- `no_std` provider contracts for hashes, MACs, signatures, AEAD, KDFs, key
  wrapping, entropy/CSPRNG, X.509 path validation and algorithm identifiers;
- algorithm-agility, domain-separation, constant-time, secret-lifetime and
  zeroization-limit rules, with narrow OS/hardware-provider adapter boundaries;
- first-party or OS-provider feasibility record, known-answer fixtures and
  unsupported-provider fail-closed behavior under the no-third-party rule.

Verification:

- known-answer, negative, cross-provider and provider-substitution tests;
- weak/unknown algorithm, bad entropy, malformed key/certificate and downgrade;
- timing-review harnesses, secret-debug/serialization rejection and cross-target
  equivalence.

Exit criteria: no later milestone invents cryptographic semantics or silently
falls back when an approved provider is unavailable. `v0.4.1 implementation
stop reached. Run pentest for this exact commit.`

### v0.4.2 — Text, Unicode And IDNA Profiles

Status: planned

Goal: define deterministic text identity before schemas, entities, network names
and indexes depend on it.

Deliverables:

- pinned Unicode/IDNA versions, UTF validation, normalization, case-folding,
  collation and confusable policies by field class;
- generated-table provenance, digest, license, reproducible generator and
  bounded lookup representation;
- no-third-party feasibility record and explicit byte-preserving fallback for
  semantics Vakaheim cannot safely implement.

Verification:

- official conformance fixtures, invalid encodings, normalization/case edge
  cases, IDNA/context/bidi and confusable attacks;
- generator reproducibility and generated-data drift checks;
- cross-target parser/entity/index equivalence.

Exit criteria: text equality and network-name interpretation are versioned,
bounded and consistent across product planes. `v0.4.2 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.6.1 — Evidence Claims And Mapping Outcome

Status: planned

Goal: distinguish byte integrity from authenticity, availability,
reconstructability, interpretation completeness, and source truth.

Deliverables:

- canonical bounded `MappingOutcome` with exact, lossless-normalized, lossy,
  partial, quarantined, unsupported, malformed, and policy-redacted states;
- one stable issue per loss/coercion/default/truncation/normalization with source
  range/path, target field, types, value digest, severity, and reversibility;
- raw-retained/digest-only/sampled/unavailable reconstruction states, source
  claim assurance, parent/output digests, policy/mapping epochs and replay needs.

Verification:

- digest-only evidence cannot claim reconstruction or source authenticity;
- duplicate/unknown fields, precision/timezone/unit loss, redaction, malformed
  encodings, array flattening and cardinality reduction fixtures;
- bounded issue count, provenance cycle/tamper and deterministic replay tests.

Exit criteria: every transformation states what it preserved, changed, lost,
or cannot prove. `v0.6.1 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.10.1 — Environment And Host Boundary Proof

Status: planned

Goal: prove the portable/host architecture before any `std` or privileged
adapter crate lands.

Deliverables:

- executable `core`, bounded-`alloc`, and explicit-`std` crate classifications;
- dependency-direction checks, allocator-failure behavior, custom-target build
  harness, and Aesynx allocator/clock interface contract;
- named host/FFI crate allowlists and future unsafe-boundary manifest without
  weakening unsafe prohibition in portable crates;
- zero-third-party feasibility template for cryptography, TLS, protocol,
  Unicode, compression, Wasm and OS milestones.

Verification:

- reject `std`/host dependency leakage into portable crates and unclassified
  host crates;
- allocator exhaustion, missing clock/random/IO provider and custom-target tests;
- reject registry/git dependencies and unsafe outside an explicit future
  milestone-bound allowlist.

Exit criteria: policy tooling can admit planned host crates without weakening
portable-core guarantees or the no-third-party rule. `v0.10.1 implementation
stop reached. Run pentest for this exact commit.`

## Phase B — Security Fact Model And Interoperability

### v0.11.0 — Canonical Fact And Conflict Model

Status: planned

Goal: define immutable fact identity, extension ownership, and contradiction
semantics before entity graphs depend on them.

Deliverables:

- canonical fact envelope, fact class, subject/object, validity, claim and
  evidence bindings;
- extension namespaces/owners, source precedence as explicit policy, negative
  evidence, conflict sets, supersession and non-destructive resolution;
- immutable decision lineage and migration/replay hooks.

Verification:

- conflicting, negative, duplicate, stale, redacted and cross-tenant facts;
- deterministic conflict grouping/resolution with policy-version evidence;
- unknown extension preservation and no silent winner/default behavior.

Exit criteria: disagreement remains represented and resolution never rewrites
source facts. `v0.11.0 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.13.0 — Identity Resolution And Asset Lifecycle

Status: planned

Goal: resolve entities deterministically and establish authoritative asset and
exposure posture without irreversible false merges.

Deliverables:

- tenant-scoped namespaces, alias validity, source precedence, negative
  evidence, match/non-match reasons and reversible merge decisions;
- asset ownership, criticality, lifecycle, retirement, ephemeral cloud/workload
  identity, CMDB reconciliation hooks and vulnerability/patch/exposure posture;
- complete resolution-decision and false-merge recovery lineage.

Verification:

- alias reuse, rename, recycled addresses/hostnames, clone, conflict, retirement
  and ephemeral-resource scenarios;
- false merge/split reversal without evidence loss and cross-tenant isolation;
- deterministic source-precedence and posture-staleness tests.

Exit criteria: asset and identity conclusions are reversible projections over
immutable evidence. `v0.13.0 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.15.0 — Schema Governance And Extension Ownership

Status: planned

Goal: govern schema authorship and conflicts before the registry executes
migrations.

Deliverables:

- namespace ownership, reviewer authority, compatibility class and deprecation
  policy;
- conflict-resolution, field semantic-change, extension collision and takeover
  rules;
- signed snapshot provenance and migration/downgrade decision records.

Verification:

- unauthorized namespace change, owner rotation, collision and semantic reuse;
- incompatible migration/downgrade and unknown extension tests;
- reproducible signed snapshot and reviewer-separation evidence.

Exit criteria: schema meaning cannot change through ambiguous ownership or
silent field reuse. `v0.15.0 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.17.0 — Local Control Plane And Audit Contract

Status: planned

Goal: provide local authority and configuration before ingestion, query,
sensors, connectors and rules consume it.

Deliverables:

- tenant, service, node and source identities plus trust-root lifecycle;
- immutable signed configuration epochs and local schema/parser/rule/component
  registry interfaces with validation, activation, rollback and drift evidence;
- canonical security audit-event schema, actor/context/result binding, sequence
  health and append-only local sink.

Verification:

- unauthorized, stale, partial, tampered and rollback epoch scenarios;
- trust-root rotation/revocation, identity confusion and registry substitution;
- audit omission/reorder/replay and fail-closed sink exhaustion.

Exit criteria: every early consumer receives identity, trust, configuration and
audit decisions from one versioned local model. `v0.17.0 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.19.0 — Portable Authorization And Capability Issuer

Status: planned

Goal: authorize local machine and service operations before VQL capabilities or
activation workflows require them.

Deliverables:

- deny-first policy evaluator over tenant, subject, resource, field, action,
  purpose, residency and immutable configuration epoch;
- signed, scoped, expiring, replay-resistant capability issuance and revocation;
- decision explanation and audit binding independent of future human federation
  or role-administration interfaces.

Verification:

- policy lattice/conflict, missing/stale attribute, cache invalidation and
  confused-deputy cases;
- capability forgery, attenuation, replay, expiry, revocation and cross-tenant;
- `no_std` deterministic decision vectors across targets.

Exit criteria: no query, registry or service action depends on an authorization
service scheduled after its consumer. `v0.19.0 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.20.1 — Normative Protocol Fixture Governance

Status: planned

Goal: make external protocol behavior versioned, reproducible, and reviewable.

Deliverables:

- checked-in fixture manifest with normative source, version/revision, digest,
  retrieval date, license and local provenance;
- positive interoperability, negative conformance, downgrade, malformed and
  old/new-version fixture classes;
- pinned profiles for syslog RFCs, RFC 8259 JSON, OTLP, OCSF schema snapshots,
  STIX/TAXII and later Component Model/WIT inputs.

Verification:

- fixture digest/license/source drift and unsupported-version checks;
- offline deterministic suite plus explicitly separate network freshness check;
- no behavior bound to an unpinned “latest” standard or schema.

Exit criteria: every external protocol milestone consumes pinned normative
evidence. `v0.20.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.20.2 — Hosted Runtime, Filesystem And Networking

Status: planned

Goal: supply bounded hosted execution without hiding a general runtime inside
ingestion, storage, query or connector milestones.

Deliverables:

- explicit thread pools, monotonic timers, deadlines, cancellation and shutdown;
- filesystem, sockets, DNS and epoll/kqueue/IOCP-style reactor adapter contracts;
- fairness, quotas, handle lifecycle, error mapping and a no-third-party
  feasibility record for each supported host family.

Verification:

- cancellation/race/model tests, descriptor exhaustion, clock change, partial IO,
  DNS abuse, slow peer and shutdown at every state;
- Linux, Windows, macOS and BSD conformance harnesses;
- prove portable crates cannot acquire ambient threads, files or networking.

Exit criteria: hosted consumers use one bounded lifecycle and cannot create a
hidden executor or ambient IO authority. `v0.20.2 implementation stop reached.
Run pentest for this exact commit.`

### v0.20.3 — TLS And Certificate Provider

Status: planned

Goal: implement secure channel and certificate semantics before authenticated
network ingestion.

Deliverables:

- pinned TLS profile, cipher/signature negotiation and mutual authentication;
- X.509 name/path/purpose/time validation, trust stores, revocation hooks,
  session resumption and key-update policy;
- first-party or narrow OS-provider feasibility decision and fail-closed
  capability behavior under the no-third-party rule.

Verification:

- protocol/certificate conformance, downgrade, truncation, replay, renegotiation,
  name/path/constraint and cross-tenant trust attacks;
- provider equivalence, unavailable/revoked trust source and clock-skew cases;
- interoperability with supported platform clients and servers.

Exit criteria: no network consumer claims confidentiality or peer identity
without this validated profile. `v0.20.3 implementation stop reached. Run
pentest for this exact commit.`

### v0.20.4 — Raw Capsule And Quarantine Spool

Status: planned

Goal: retain bounded raw evidence and rejected input before operational
ingestion begins.

Deliverables:

- append-only raw/quarantine records with source metadata, digest, reason,
  parser/mapping/policy identities and original/ingest times;
- quotas, retention, encryption-provider hooks, inspection authorization and
  terminal expiry/reprocess outcomes;
- crash-safe reference issuance and dangling-reference detection interface for
  the later raw-evidence store.

Verification:

- malformed/oversized input, crash, disk-full, corruption, expiry and quota;
- unauthorized inspection, cross-tenant reference and parser-loop attacks;
- conservation between accepted raw bytes and durable/quarantine/loss outcomes.

Exit criteria: ingestion cannot emit a raw reference to nowhere or hide a
quarantined record's lifecycle. `v0.20.4 implementation stop reached. Run
pentest for this exact commit.`

### v0.20.5 — Self-Observability And Diagnostic Events

Status: planned

Goal: make service health and impairment part of the evidence model before the
first long-running pipeline.

Deliverables:

- stable health, saturation, dependency, queue, loss and lifecycle event schema;
- reserved diagnostic path, local snapshot, redaction policy and support-bundle
  building blocks;
- recursion/cardinality limits so observing Vakaheim cannot overload Vakaheim.

Verification:

- every degraded/unverifiable state, false-green dependency, metric overflow,
  diagnostic-path exhaustion and restart;
- sensitive-data and cross-tenant leakage review;
- health event conservation under primary-pipeline overload.

Exit criteria: later services cannot introduce health semantics ad hoc, and
failure to observe health is itself visible. `v0.20.5 implementation stop
reached. Run pentest for this exact commit.`

## Phase C — Ingestion And Transport

### v0.22.0 — Local Ingestion Pipeline

Status: planned

Goal: receive, parse, normalize, route, and observe events in one process.

Deliverables:

- bounded stage queues and explicit stage outcomes;
- source authentication placeholder, capsule, parsing, normalization, policy,
  partition, durable-boundary and telemetry-gap contracts;
- per-source budgets, backpressure, metrics, and cancellation.
- terminal-outcome ledger proving conservation of counts and bytes as durable
  output, quarantine, summary/suppression/loss evidence, or pending work;
- reserved-capacity impairment lane and independently conserved health counters.

Verification:

- end-to-end fixtures, duplicate, reorder, malformed, cancel, and overload;
- no-silent-loss accounting and queue-conservation properties;
- acknowledgement-truth, source-instance/session sequence reset/gap/overlap/wrap,
  disk reserve, parser quarantine and pre-full backpressure tests;
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

- pinned RFC 5424, 5425, 5426 and 6587 profiles plus documented RFC 3164
  compatibility, UDP/TCP/TLS adapter contracts and source identity;
- structured data and legacy parsing with exact raw preservation;
- octet counting, BOM/UTF-8, structured-data escaping and truncation policy;
- per-source rate/size/concurrency limits and malformed-message evidence.

Verification:

- standards corpus, split/coalesced frame, spoof/replay, truncation, Unicode;
- packet loss, backpressure, connection churn, slow sender, oversized input;
- mark UDP and sequence-free continuity as unverifiable; exercise kernel/socket
  drop counters and never allow UDP to satisfy a zero-loss source SLO;
- parser/network fuzzing and interoperability smoke.

Exit criteria: syslog ambiguity and transport loss are visible and bounded.
`v0.26.0 implementation stop reached. Run pentest for this exact commit.`

### v0.28.0 — JSON Ingestion

Status: planned

Goal: parse JSON logs without general serialization dependencies.

Deliverables:

- first-party streaming RFC 8259 JSON and JSON Lines parser;
- bounded nesting, width, string/number length, allocation, duplicate-key and
  Unicode policies;
- source ranges, exact number/text preservation, and framed JSON mode.
- explicit separation between source semantics and any canonicalization.

Verification:

- JSON conformance and hostile corpus, every chunk boundary, deep/wide inputs;
- duplicate, invalid Unicode/escape/number, trailing and multi-value cases;
- sustained fuzzing and differential tests against pinned references.

Exit criteria: JSON parsing is bounded, deterministic, and panic-free.
`v0.28.0 implementation stop reached. Run pentest for this exact commit.`

### v0.29.0 — Protobuf And Compression Substrate

Status: planned

Goal: implement bounded wire encoding and compression before OTLP consumes
them.

Deliverables:

- first-party streaming Protobuf wire decoder/encoder with unknown-field and
  canonical limit policy;
- bounded gzip/DEFLATE profile, expansion-ratio/output/work limits and explicit
  unsupported-compression behavior;
- generated-schema provenance and zero-third-party feasibility records.

Verification:

- official/pinned vectors, malformed varints/groups/lengths, duplicate fields,
  recursion and schema-skew tests;
- truncated/corrupt/compression-bomb and cross-chunk fuzz campaigns;
- differential/reference fixtures and cross-target deterministic encoding.

Exit criteria: OTLP cannot hide Protobuf or decompression risk inside an
endpoint milestone. `v0.29.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.29.1 — HTTP/2 And gRPC Transport Substrate

Status: planned

Goal: provide bounded authenticated request/stream semantics before OTLP and
later APIs use them.

Deliverables:

- pinned HTTP/2 framing/state, HPACK limits and gRPC message/status/deadline
  profiles over the approved TLS/runtime providers;
- flow control, concurrency, cancellation, keepalive, content-type and trailer
  policy;
- no-third-party feasibility decision and explicit unsupported-feature list.

Verification:

- state-machine/model tests, malformed frames/headers, rapid reset, flow-control
  deadlock, compression abuse, slow peer and cancellation races;
- gRPC interoperability and old/new profile fixtures;
- connection/stream/tenant resource-isolation pentest.

Exit criteria: endpoint milestones consume a tested transport and cannot expand
its protocol surface implicitly. `v0.29.1 implementation stop reached. Run
pentest for this exact commit.`

### v0.29.2 — HTTP Client And Browser Service Substrate

Status: planned

Goal: own bounded connector HTTP clients and browser-facing service behavior
before API, connector and UI milestones consume them.

Deliverables:

- pinned HTTP/1.1 plus applicable HTTP/2 client/server profiles with strict
  framing, headers, body, redirect, proxy and connection limits;
- DNS/IP rebinding defenses, origin/host policy, cookies, cache controls, CSP,
  CORS and secure static-asset delivery contracts;
- first-party implementation and no-third-party feasibility record over the
  approved runtime/TLS providers.

Verification:

- request/response smuggling, splitting, ambiguous length, redirect/proxy loop,
  rebinding, slow peer and decompression abuse;
- origin/host/cookie/cache/CORS/CSP and cross-tenant service confusion;
- client/server interoperability, differential parser fuzzing and browser/API
  security review.

Exit criteria: connectors and UIs cannot introduce ad hoc HTTP stacks or ambient
network policy. `v0.29.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.30.0 — OTLP Endpoint

Status: planned

Goal: expose authenticated OTLP log ingestion over the pinned transport stack.

Deliverables:

- source registration, authentication, schema/mapping selection, limits;
- bounded requests, batches, errors, timeouts, cancellation, idempotency;
- protocol-version and acknowledgement negotiation.
- pinned OTLP Protobuf plus gRPC/HTTP content, compression, retry and partial-
  success semantics.

Verification:

- auth bypass, cross-tenant, replay, duplicate, downgrade, slow-client tests;
- protocol conformance, malformed frame, batch limit, disconnect recovery;
- partial-success rejected-count handling without invalid retry and proof that
  custom durability acknowledgements are not added to OTLP itself;
- interoperability with representative senders.

Exit criteria: endpoint input cannot bypass source, tenant, limit, or lineage
controls. `v0.30.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.30.1 — OCSF Compatibility Endpoint

Status: planned

Goal: expose OCSF as a pinned schema over a Vakaheim transport without treating
OCSF as a transport protocol.

Deliverables:

- authenticated JSON, JSONL and bounded batch profiles using `v0.18.0` mappings;
- source registration, schema/mapping selection, limits and mapping outcomes;
- version negotiation, idempotency and Vakaheim acknowledgement semantics.

Verification:

- mapping conformance, malformed/lossy records, unsupported schema and batches;
- auth, tenant, replay, duplicate, downgrade, slow-client and disconnect cases;
- interoperability with representative OCSF producers.

Exit criteria: OCSF schema compatibility cannot bypass Vakaheim transport,
lineage or loss reporting. `v0.30.1 implementation stop reached. Run pentest
for this exact commit.`

### v0.31.0 — Native Durable Ingestion Protocol

Status: planned

Goal: carry Vakaheim durability acknowledgements without altering external
protocol semantics.

Deliverables:

- versioned native framing, capabilities, source/session/sequence and batch IDs;
- authenticated acknowledgement levels, idempotency, resume and explicit
  terminal rejection/quarantine outcomes;
- bounded compression negotiation, cancellation, deadlines and unknown fields.

Verification:

- reconnect at every frame and acknowledgement boundary, duplicate/reorder and
  downgrade tests;
- acknowledgement-to-stable-state recovery proof and hostile peer budgets;
- old/new interoperability and exact on-wire fixture corpus.

Exit criteria: Vakaheim durability claims exist only on its native negotiated
protocol. `v0.31.0 implementation stop reached. Run pentest for this exact
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

### v0.39.0 — Historical Import And Quarantine Reprocessing

Status: planned

Goal: import or reinterpret old evidence without confusing historical time,
arrival time, or current parser meaning.

Deliverables:

- bounded backfill jobs with original/source, ingest and backfill times;
- quarantine reprocessing under explicit old/new parser, mapping, schema and
  policy digests while preserving prior outcomes;
- resumable checkpoints, deduplication scope, rate/resource isolation and
  cancellation/audit contracts.

Verification:

- duplicate overlap, out-of-order windows, parser regression, mapping loss,
  cancellation/restart and storage pressure;
- unauthorized scope, cross-tenant, retention/hold and historical-rule effects;
- conservation and deterministic old/new comparison reports.

Exit criteria: backfill and reprocessing never rewrite original evidence or
masquerade as live collection. `v0.39.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.40.0 — Ingestion Security Milestone

Status: planned

Goal: harden the complete ingestion path before storage format commitment.

Deliverables:

- load, malformed-input, packet-loss, replay and long-duration campaigns;
- parser, endpoint, spool, enrollment, transport and relay review;
- remediations, operational limits, runbooks and failure evidence.
- executable conservation, acknowledgement, continuity, overload and reserved
  impairment-lane invariants across source, relay, native protocol and storage.

Verification:

- cross-component fuzzing and attack-scenario replay;
- resource-exhaustion, fault injection, upgrade and rollback tests;
- independent ingestion pentest.

Exit criteria: all ingestion findings are remediated and silent-loss claims are
evidence-backed. `v0.40.0 implementation stop reached. Run pentest for this
exact commit.`

## Phase D — Security-Native Storage

### v0.41.0 — Storage Capacity And Stable-Media Contract

Status: planned

Goal: define the database workload and durability model before fixing its
on-disk format.

Deliverables:

- reference event-size/rate, daily volume, replication and compaction-space
  capacity model, including the 500,000-event/second acceptance target;
- acknowledgement-to-process/page-cache/device-stable-media mapping and exact
  fsync/barrier assumptions per supported host;
- shard ownership, disk-space reservation, foreground/background budgets,
  failure model and quantitative early scale gates.

Verification:

- capacity arithmetic for ordinary, burst, repair, reindex and disk-loss cases;
- stable-media crash experiments on representative filesystems/devices;
- reject configurations lacking checkpoint/impairment reserve or safe headroom.

Exit criteria: storage format work begins with measurable capacity and
durability contracts. `v0.41.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.42.0 — Security Segment Format

Status: planned

Goal: specify immutable durable security-fact segments.

Deliverables:

- header, tenant/partition/time bounds, dictionaries, page directories;
- raw-capsule references, index directory, integrity/encryption metadata;
- atomic commit footer, version negotiation, scanner and repair boundaries.
- immutable generation manifest for snapshot-consistent segment/index sets and
  partition keys covering tenant, region, time, retention, hold and key domain.

Verification:

- canonical vectors, truncation at every byte, corrupt offsets/counts/lengths;
- parser fuzzing, cross-endian targets, unknown-version behavior;
- format design and forensic recoverability review.

Exit criteria: the format is bounded and parseable without trusting offsets.
`v0.42.0 implementation stop reached. Run pentest for this exact commit.`

### v0.43.0 — Hot Staging And Segment Lifecycle

Status: planned

Goal: bound ingestion memory and convert shard-owned hot state into immutable
segments predictably.

Deliverables:

- per-shard staging/memtable ownership, allocator and source/tenant quotas;
- target segment/page sizes, seal thresholds, maximum age, open-file bounds,
  preallocation and admission policy;
- crash interaction with WAL, manifest publication and abandoned-stage cleanup.

Verification:

- allocator/disk exhaustion, hot-shard/noisy-tenant, seal race and crash tests;
- conservation from admitted batch through WAL, stage, segment and manifest;
- latency/memory/open-file baselines under sustained and burst ingest.

Exit criteria: hot ingestion cannot grow without bound or publish a partial
generation. `v0.43.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.44.0 — Write-Ahead Log And Recovery

Status: planned

Goal: make writes crash-safe and replay deterministic.

Deliverables:

- WAL records, transaction/commit markers, sequence and checksum rules;
- per-shard ownership, group commit, reserved space and explicit fsync/stable-
  media state tied to every acknowledgement level;
- replay, torn-write detection, idempotent recovery, truncation/repair policy;
- fsync/durability adapter contract for supported hosted systems.

Verification:

- power loss at every write and sync point, disk-full and partial-sector tests;
- duplicate/reordered/corrupt/stale WAL and replay determinism;
- recovery model/property tests and real-filesystem smoke.

Exit criteria: committed and uncommitted states are unambiguous after crash.
`v0.44.0 implementation stop reached. Run pentest for this exact commit.`

### v0.45.0 — Storage Workload Scheduler

Status: planned

Goal: isolate foreground durability from background database work.

Deliverables:

- separate bounded pools/queues for ingest, WAL sync, seal, index, compaction,
  replication, repair, backup, scrub and query IO/CPU;
- priority, admission, cancellation, I/O token buckets and foreground latency
  protection;
- maintenance/emergency modes and durable impairment when work is deferred.

Verification:

- compaction/repair/backup/query storms cannot block WAL/fsync control threads;
- starvation, priority inversion, cancellation, queue overflow and disk-full;
- workload-isolation and p99 foreground latency evidence.

Exit criteria: background work cannot silently destabilize durable ingestion.
`v0.45.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.47.0 — Generation Snapshots And Cache Ownership

Status: planned

Goal: give readers consistent generations without unbounded obsolete-data pins
or cross-tenant caches.

Deliverables:

- atomic generation snapshots, reader pin lease/count/age limits and cleanup;
- tenant-owned quotas for metadata, pages, decompressed blocks, postings,
  entity adjacency and compiled plans;
- encrypted/residency-aware cache entries, invalidation and observability.

Verification:

- compaction concurrent with long queries, expired/crashed pins and rollback;
- noisy-neighbor/cache probing, cross-tenant leakage and eviction fairness;
- deterministic fallback after missing/stale/corrupt cache entries.

Exit criteria: snapshots are consistent and no reader can retain obsolete
generations indefinitely. `v0.47.0 implementation stop reached. Run pentest
for this exact commit.`

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

### v0.52.0 — Rollups And Bounded Graph Views

Status: planned

Goal: accelerate common time-series and relationship work without promising
unbounded instant graph queries.

Deliverables:

- rebuildable policy/version-bound time-series rollups and graph adjacency
  materializations;
- freshness, completeness, source-generation and invalidation metadata;
- SLO classes by working set, selectivity, hop count, fan-out and completeness.

Verification:

- source-scan equivalence, stale/partial/rebuild and policy-change cases;
- high-fanout/deep graph and rollup amplification/resource limits;
- published latency evidence per SLO class, never an unqualified “instant.”

Exit criteria: materializations improve bounded workloads without changing
truth or hiding staleness. `v0.52.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.53.0 — Storage Integrity And Authenticity

Status: planned

Goal: detect corruption, substitution and rollback independently of encryption.

Deliverables:

- per-block checksum/digest, segment Merkle root/linkage and writer identity;
- manifest/WAL/index/raw-reference integrity and rollback generations;
- offline verifier, corruption localization and explicit integrity findings.

Verification:

- corruption at every structure, swap, replay, truncation and rollback;
- wrong writer/generation/reference and partial verification scenarios;
- known-answer/provider conformance and independent verifier comparison.

Exit criteria: modified, substituted or rolled-back storage fails closed and
produces attributable integrity evidence. `v0.53.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.54.0 — Content-Addressed Raw Evidence Store

Status: planned

Goal: durably own large raw capsules and quarantine artifacts separately from
columnar facts.

Deliverables:

- tenant-scoped content-addressed objects, chunking and explicit deduplication
  leakage/policy decisions;
- atomic fact/reference/object publication, quarantine promotion, retention,
  encryption hooks and access audit;
- orphan/dangling-reference scan, repair, reprocess and secure expiry.

Verification:

- crash at every object/fact commit point, duplicate/collision, partial object,
  missing chunk and disk-full;
- cross-tenant dedup/reference probes, unauthorized read, hold and expiry races;
- orphan repair and source-capsule reconstruction at scale.

Exit criteria: every retained raw reference resolves atomically or carries a
durable explicit unavailability state. `v0.54.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.55.0 — Storage Encryption And Key Hierarchy

Status: planned

Goal: protect tenant evidence at rest using the approved cryptographic provider.

Deliverables:

- authenticated encryption binding data, metadata, tenant, generation and
  integrity identity;
- tenant/segment/raw-object key hierarchy, wrapping and least-privilege key
  access boundary;
- encrypted WAL, spill, cache, backup and cold-data policy.

Verification:

- ciphertext/header swap/replay, wrong-key/domain and metadata-auth tests;
- known-answer/provider conformance and unavailable-provider behavior;
- cryptographic design review and storage pentest.

Exit criteria: modified, substituted or unauthenticated data fails closed.
`v0.55.0 implementation stop reached. Run pentest for this exact commit.`

### v0.56.0 — Key Rotation, Hardware Keys And Crypto-Shred

Status: planned

Goal: operate the storage key lifecycle without conflating revocation, loss,
rotation and intentional destruction.

Deliverables:

- staged rotation/rewrap, generation activation, rollback limits and progress;
- OS/hardware-key adapter hooks, availability/fallback policy and operator
  separation;
- crypto-shred authorization/proof, lost-key state and backup/restore handling.

Verification:

- interruption at every rotation phase, stale/revoked key, hardware outage,
  split generation and restore;
- unauthorized shred, partial deletion, key reuse and rollback attacks;
- no-third-party provider feasibility and hardware-adapter pentest.

Exit criteria: every key transition is resumable and auditable, while destroyed
or lost authority can never silently resurrect data. `v0.56.0 implementation
stop reached. Run pentest for this exact commit.`

### v0.57.0 — Storage Compatibility, Scrub And Disaster Reindex

Status: planned

Goal: operate mixed versions and recover large datasets without unsafe format
assumptions.

Deliverables:

- online format migration, mixed-version reader matrix and downgrade boundary;
- scheduled scrub, integrity escalation, lost-key/crypto-shred distinction and
  explicit unrecoverable-data policy;
- resumable disaster-scale repair/reindex with generation and capacity control.

Verification:

- every supported upgrade/downgrade pair, interrupted migration and rollback;
- corrupt segment/index, missing/revoked/lost key and partial reindex scenarios;
- old readers fail closed on unsafe new semantics.

Exit criteria: format evolution and lost authority cannot silently corrupt or
resurrect evidence. `v0.57.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.58.0 — Early Storage Scale And Fault Campaign

Status: planned

Goal: test the largest technical risk before query and detection layers depend
on it.

Deliverables:

- multi-terabyte/day reference workload derived from the capacity contract;
- sustained/burst ingest with sealing, indexing, compaction, scrub, backup,
  local repair, retention and storage-level scans/access patterns;
- hardware, OS, filesystem, media, schemas, event sizes, settings and commit.

Verification:

- long-duration process/device/filesystem faults, optional implemented local-
  mirror/multi-disk faults and reindex;
- bounded write amplification, stable acknowledgement, no resurrection and no
  silent loss;
- independent reproduction and storage-focused pentest.

Exit criteria: quantitative evidence supports continuing to VQL; unmet targets
force redesign before `v0.65.0`; no cluster replication, node-quorum or disk-
evacuation claim is permitted here. `v0.58.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.60.0 — Retention, Compaction And Cold Data

Status: planned

Goal: enforce lifecycle policy without erasing auditability.

Deliverables:

- tenant/source/field/classification/incident/geography/purpose retention;
- legal hold, auditable deletion, compaction and expired-data proofs;
- tiered/leveled policy, bounded write amplification, I/O budgets, foreground
  protection, emergency disk-full behavior and no failed-compaction resurrection;
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
- independent byte, token, nesting, AST-node, diagnostic and recovery-attempt
  budgets;
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

### v0.72.0 — Plan Capability And Security Barriers

Status: planned

Goal: bind query authority before statistics access or physical planning.

Deliverables:

- authenticated `PlanCapability` binding tenant, identity, purpose, policy
  epoch, fields, time, regions, operators, output limit and expiry;
- authorization/residency rewrites before statistics access plus storage recheck;
- non-reorderable tenant/redaction security-barrier operators.

Verification:

- forged/stale/replayed capability, rewrite bypass and policy-epoch change;
- optimizer cannot cross a security barrier or expose forbidden statistics;
- aggregation/cardinality/error/timing leakage tests.

Exit criteria: planning and execution possess only explicitly granted query
authority. `v0.72.0 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.76.0 — Worst-Case Cost And Admission Control

Status: planned

Goal: reject queries whose upper resource bound is unsafe or unknowable.

Deliverables:

- upper-bound plus uncertainty estimates for pages/bytes, instructions, wall
  time, allocations, result/network bytes, partitions and graph expansion;
- tenant queues, weighted fairness, concurrency limits and administrator kill;
- admission/replan/abort behavior when actual cardinality exceeds its bound.

Verification:

- plan explosion, hostile statistics, underestimated cardinality and queue
  starvation;
- every resource cap and cancellation path at operator/page boundaries;
- no admitted query can execute on WAL/fsync or storage-control threads.

Exit criteria: expected cost alone can never authorize execution.
`v0.76.0 implementation stop reached. Run pentest for this exact commit.`

### v0.77.0 — Physical Planner

Status: planned

Goal: choose executable operators deterministically without hiding policy or
worst-case work.

Deliverables:

- index/scan, join algorithm/build side, aggregate, sort/top-k and spill choices;
- partition, snapshot, rollup, graph-view, operator-fusion and vector-batch
  selection;
- deterministic conservative fallback for missing/stale/untrusted statistics
  and traceable physical-plan identity.

Verification:

- physical/reference equivalence across every choice and fallback;
- stale/poisoned statistics, skew, memory pressure, missing index/rollup and
  replan races;
- security barriers and capability bounds survive every physical rewrite.

Exit criteria: every executable operator and fallback has explicit ownership,
authority and worst-case bounds. `v0.77.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.78.0 — Query Workload Isolation And Encrypted Spill

Status: planned

Goal: isolate query CPU/IO and safely bound temporary state.

Deliverables:

- separate query CPU, decompression and IO pools with bounded queues;
- tenant-scoped encrypted, quota-limited, residency-bound spill files;
- crash cleanup, key lifecycle, cancellation and disk-reserve integration.

Verification:

- spill exhaustion, crash/restart, wrong tenant/key/region and stale cleanup;
- decompression/parser/graph storms cannot block storage durability/control;
- noisy-neighbor fairness and temporary-data disclosure tests.

Exit criteria: query pressure and temporary state cannot cross tenant or
durability boundaries. `v0.78.0 implementation stop reached. Run pentest for
this exact commit.`

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

### v0.82.0 — Bounded Join Engine

Status: planned

Goal: execute joins only under provable time, key, state and output bounds.

Deliverables:

- required bounded event time range unless privileged offline mode is explicit;
- equality/partition key or an explicit nested-loop work budget;
- build-side row/byte, output-cardinality, spill and replan/abort limits.

Verification:

- Cartesian, skew, duplicate, cardinality surprise and spill attacks;
- authorization is reapplied to both inputs and outputs;
- reference equivalence and deterministic abort/replan evidence.

Exit criteria: joins fail closed before exceeding admitted work or authority.
`v0.82.0 implementation stop reached. Run pentest for this exact commit.`

### v0.83.0 — Ordering, Pagination And Set Operations

Status: planned

Goal: make ordering-dependent results stable, bounded and snapshot-safe.

Deliverables:

- sort/top-k with total tie-breaking order and bounded memory/spill;
- opaque snapshot-bound pagination/resume tokens and duplicate/omission rules;
- union/intersection/difference semantics with policy and completeness
  propagation.

Verification:

- equal keys, page boundaries, concurrent generation change, token tamper,
  expiry and replay;
- external sort failure/cancellation and adversarial set cardinality;
- reference equivalence and authorization on every set input/output.

Exit criteria: repeated pagination over one snapshot is stable and set
operations cannot hide partial or policy-limited inputs. `v0.83.0 implementation
stop reached. Run pentest for this exact commit.`

### v0.84.0 — Statistical And Text Operators

Status: planned

Goal: define common security analytics and text matching without unbounded or
cross-plane-inconsistent semantics.

Deliverables:

- distinct, rates, ratios, percentiles and cardinality with exact/approximate
  identity, error bounds and empty/missing behavior;
- bounded glob and regex profile, or an explicit release-blocking decision that
  regex remains unsupported;
- case-folding, collation, tokenization and text-index equivalence tied to the
  pinned `v0.4.2` profile.

Verification:

- hand-calculated aggregate vectors, overflow, approximation and merge order;
- catastrophic-pattern/work-limit, Unicode confusable/case/collation and index-
  scan equivalence tests;
- tenant/policy leakage through counts, errors, timing and approximations.

Exit criteria: analytical and text operators are bounded, versioned and return
the same semantics through scans and indexes. `v0.84.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.85.0 — Temporal Operations

Status: planned

Goal: reason honestly over event time, late data and uncertainty.

Deliverables:

- event-time windows, watermarks, late-arrival policy and retractions;
- ordered/partially ordered sequences, negative conditions and timeouts;
- bitemporal `as_of` perspective and clock uncertainty propagation.
- negative conditions finalize only after watermark and required-telemetry
  completeness gates pass.

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
- path-count/edge-type caps and authorization recheck on every node and edge;
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
- subscription leases, lag limits and explicit-gap slow-subscriber eviction;
- logical/physical/cost/policy/completeness explain output;
- indexes/segments/regions/redactions/gaps/approximations in results.

Verification:

- resume/reconnect/replay, configuration epoch and late-data tests;
- explanation/result consistency and information-leak review;
- redact unauthorized topology, counts and policy detail from errors and
  explanations, including timing/cardinality side channels;
- live overload, cancellation and subscriber fairness.

Exit criteria: users can see why a result exists and why it may be incomplete.
`v0.95.0 implementation stop reached. Run pentest for this exact commit.`

### v0.96.0 — Query Scheduler And Explain Side-Channel Gate

Status: planned

Goal: prove end-to-end fairness, cancellation and authorization-safe
observability before the query security freeze.

Deliverables:

- per-tenant admission/scheduling metrics without cross-tenant metadata;
- complete operator cancellation/lease/kill matrix and support controls;
- safe logical/physical/cost/policy/completeness explanation profiles.

Verification:

- noisy-neighbor, slow subscriber, kill race and abandoned spill/pin cases;
- counts, plans, errors, latency and cache-state side-channel campaign;
- workload scheduler cannot starve durability, repair or impairment reporting.

Exit criteria: query supportability reveals no unauthorized system or tenant
state. `v0.96.0 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.115.0 — Deterministic Detection Execution Contract

Status: planned

Goal: make the complete execution identity explicit before adding more rule
semantics.

Deliverables:

- canonical identity over rule, schema, mapping, policy, content, engine and
  configuration digests;
- checked fixed-point arithmetic, explicit rounding, ordering, clock and locale
  rules;
- prohibition of ambient network, filesystem, randomness and unrecorded state.

Verification:

- cross-target golden executions and canonical identity vectors;
- clock, locale, architecture, overflow and input-substitution attacks;
- replay rejects every missing or mismatched execution input.

Exit criteria: equal execution identities produce equal results and every
difference is attributable. `v0.115.0 implementation stop reached. Run pentest
for this exact commit.`

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

### v0.145.0 — Detection State Admission And Impairment

Status: planned

Goal: prevent state growth or placement pressure from silently reducing
detection coverage.

Deliverables:

- compile-time and admission-time cardinality, memory and expiry bounds;
- deterministic eviction hierarchy with per-rule, entity and tenant reserves;
- signed impairment findings for eviction, lag, saturation and unavailable
  partitions.

Verification:

- adversarial cardinality, hot-key, timeout and rebalance campaigns;
- conservation checks between admitted state, expiry, eviction and recovery;
- impairment-lane exhaustion and recovery tests.

Exit criteria: the engine rejects unbounded state and reports every coverage
reduction. `v0.145.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.150.0 — Findings And Evidence Bundles

Status: planned

Goal: emit immutable, explainable, replayable detection conclusions.

Deliverables:

- rule digest/version/parameters, facts, capsule refs and state transitions;
- aggregates, entity paths, gaps, uncertainty, confidence and severity reasons;
- worker identity, execution time, canonical digest and replay contract;
- separate integrity, authenticity, availability, reconstructability and
  source-truth claims, without allowing one property to imply another.

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

### v0.165.0 — Detection Placement Equivalence

Status: planned

Goal: prove that valid worker placement, restart and rebalance choices do not
change detection meaning.

Deliverables:

- explicit placement keys, ownership epochs and hand-off boundaries;
- duplicate-safe transition and finding identity across movement;
- reference single-worker semantics for distributed comparison.

Verification:

- randomized placement/rebalance/restart schedules against the reference;
- partition, delayed hand-off, duplicate delivery and stale-owner attacks;
- finding and impairment equivalence across supported topologies.

Exit criteria: placement affects latency and availability only through recorded
impairments, never rule meaning. `v0.165.0 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.175.0 — Decomposable Risk Projection

Status: planned

Goal: project findings into reviewable risk without creating opaque evidence.

Deliverables:

- deterministic formula over severity, confidence, asset criticality, exposure,
  control health and temporal decay;
- per-input contribution, missing-input and uncertainty explanation;
- tenant policy bounds that cannot rewrite the underlying finding.

Verification:

- hand-calculated vectors, monotonicity/property tests and replay stability;
- missing, stale and manipulated asset, vulnerability and control inputs;
- overflow, weight abuse and cross-tenant isolation tests.

Exit criteria: every score decomposes into recorded inputs and remains a
projection rather than evidence. `v0.175.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.178.0 — Threat Intelligence Lifecycle And ATT&CK Coverage

Status: planned

Goal: govern intelligence and detection coverage as versioned, observable
security inputs.

Deliverables:

- source trust, confidence, validity, expiry, revocation, conflict and
  declassification lifecycle;
- retro-hunt scheduling and poisoning quarantine with bounded propagation;
- ATT&CK technique plus data-component/telemetry coverage and gap reporting.

Verification:

- stale, revoked, conflicting, oversized and poisoned feed scenarios;
- retro-hunt reproducibility and coverage calculation fixtures;
- provenance loss, source compromise and rollback rehearsals.

Exit criteria: intelligence cannot silently remain authoritative after expiry
or revocation. `v0.178.0 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.205.0 — Common Agent And Privileged IPC Boundary

Status: planned

Goal: establish one portable continuity model and a minimal privileged boundary
before platform collection expands.

Deliverables:

- common source sequence, cursor, spool, health and impairment protocol;
- authenticated, versioned, replay-resistant IPC with least-privilege helpers;
- install, update, rollback, key rotation and crash-recovery contracts.

Verification:

- malicious peer, stale message, downgrade, privilege and spool corruption;
- restart/upgrade continuity and terminal-outcome conservation;
- Linux, Windows, macOS and BSD adapter conformance harness.

Exit criteria: each platform inherits the same continuity guarantees and
privileged code remains narrowly bounded. `v0.205.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.210.0 — Linux Base Agent

Status: planned

Goal: collect core Linux security evidence with least privilege.

Deliverables:

- journald/syslog, audit, process, authentication, service, package, file and
  network/container context;
- unprivileged agent, small privileged helper boundary, spool and health;
- installation, permissions, upgrade, rollback and non-eBPF operation;
- audit backlog/lost counters and journald cursor/boot/rotation continuity.

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
- explicit capability detection and non-eBPF fallback;
- per-CPU ring-loss accounting, map-pressure health and generation identity.

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
- provider/session loss, permission and security-control impairment evidence;
- channel/bookmark/rendering semantics with log-clear, wrap and subscription
  error continuity.

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
- response adapter contracts without generic command execution;
- ETW provider/session identity, lost-event/buffer counters and restart epochs.

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
- fallback and unsupported-event reporting;
- Endpoint Security mute/drop/sequence health and Unified Logging cursor epochs.

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

### v0.260.0 — BSD Sensors

Status: planned

Goal: add BSD host evidence without pretending all BSD kernels expose the same
telemetry.

Deliverables:

- FreeBSD/OpenBSD syslog, audit/OpenBSM, kqueue, process accounting and pf;
- common fact/spool/transport semantics and capability-health reporting.

Verification:

- supported BSD matrices and representative attacks;
- audit loss, rotation, overload, permission and upgrade cases;
- cross-platform fact and continuity conformance.

Exit criteria: platform differences are explicit without format fragmentation.
`v0.260.0 implementation stop reached. Run pentest for this exact commit.`

### v0.265.0 — Kubernetes Sensor

Status: planned

Goal: collect Kubernetes control-plane and workload evidence with explicit
cluster, tenant and identity boundaries.

Deliverables:

- audit, workload identity, admission, RBAC, exec, image and network facts;
- API watch resource-version continuity, relist epochs and audit loss evidence;
- bounded metadata enrichment and namespace/tenant isolation.

Verification:

- workload churn, identity reuse, watch expiry, audit loss and overload;
- compromised service account, namespace escape and enrichment poisoning;
- supported Kubernetes matrix and representative attack scenarios.

Exit criteria: relists, watch gaps and workload identity reuse are visible in
the evidence chain. `v0.265.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.267.0 — Aesynx Portability Contract

Status: planned

Goal: prove platform assumptions do not lock out a future Aesynx adapter without
claiming current support.

Deliverables:

- documented kernel, clock, entropy, storage, IPC and networking capabilities;
- adapter traits with unsupported-capability and impairment semantics;
- compile-only mock platform and portability decision record.

Verification:

- build with every optional host capability removed independently;
- architecture-width, endianness, clock and stable-storage boundary tests;
- review against the then-current Aesynx capability surface.

Exit criteria: no required platform assumption lacks an adapter boundary or an
explicit Aesynx limitation. `v0.267.0 implementation stop reached. Run pentest
for this exact commit.`

## Phase H — SDK, Connectors And Source Assurance

### v0.270.0 — Private Rust SDK Preview

Status: planned

Goal: stabilize an in-workspace SDK without publishing it.

Deliverables:

- `no_std` types/events and `alloc` query/rule/playbook surfaces;
- stable internal traits, errors, IDs and conversion/validation contracts;
- compile-time capability/version markers without a network client.

Verification:

- API/feature/semver compile tests and internal compatibility matrix;
- unknown field/enum and invalid-state conversion tests;
- package-content check proving `publish = false`.

Exit criteria: the SDK is usable internally but remains unpublishable.
`v0.270.0 implementation stop reached. Run pentest for this exact commit.`

### v0.272.0 — API Wire Contract

Status: planned

Goal: freeze a bounded product API contract before implementing its service or
client.

Deliverables:

- version/capability negotiation, stable errors and authentication context;
- snapshot pagination tokens, streaming/resume/cancellation, rate limits,
  idempotency and audit metadata;
- query, finding, case, rule, evidence and action endpoint schemas plus
  compatibility/deprecation rules.

Verification:

- old/new compatibility, unknown fields/enums, downgrade and token tamper;
- authorization context confusion, oversized messages, retry and cancellation;
- deterministic wire fixtures and API threat-model review.

Exit criteria: service and client implementations consume one reviewed contract
rather than defining each other implicitly. `v0.272.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.274.0 — Authenticated API Service

Status: planned

Goal: implement the server side of the private API over approved authority and
transport substrates.

Deliverables:

- bounded routing/streaming over `v0.29.1` with `v0.19.0` authorization;
- endpoint quotas, deadlines, cancellation, idempotency and audit emission;
- snapshot/policy epoch binding and graceful drain/upgrade behavior.

Verification:

- auth bypass, cross-tenant, request smuggling/profile confusion, slow client,
  cancellation race and overload;
- policy/snapshot change, idempotency replay and partial-stream recovery;
- service interoperability and independent API pentest.

Exit criteria: all API endpoints enforce policy and resource limits server-side.
`v0.274.0 implementation stop reached. Run pentest for this exact commit.`

### v0.276.0 — Private Rust Network Client

Status: planned

Goal: add `std` client behavior only after the wire contract and service exist.

Deliverables:

- blocking and poll-based clients with negotiation, pagination and streaming;
- resume, cancellation, deadline, rate-limit and idempotent retry behavior;
- authenticated session/provider integration and audit/correlation metadata.

Verification:

- mock/live service conformance, timeout, reconnect, partial stream and retry;
- malicious server, downgrade, token confusion and cancellation races;
- package-content check proving `publish = false`.

Exit criteria: the private client is interoperable and remains unpublishable.
`v0.276.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.282.0 — Isolated Connector Host

Status: planned

Goal: execute connectors outside trusted services with concrete process and
authority containment.

Deliverables:

- sandboxed worker process, authenticated IPC and capability broker;
- secret/egress/DNS/HTTP brokers, CPU/memory/IO/concurrency quotas and lifecycle;
- crash containment, checkpoint handoff, signed upgrade, quarantine and
  revocation.

Verification:

- escape, confused deputy, secret exfiltration, DNS/redirect/proxy bypass;
- crash loop, exhaustion, stale worker, upgrade/rollback and revoked connector;
- host unavailable behavior and independent connector-host pentest.

Exit criteria: connector code has no ambient process, filesystem, secret or
network authority. `v0.282.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.290.0 — Shared Cloud Connector Substrate

Status: planned

Goal: establish shared cloud collection mechanics without hiding provider
semantics in a generic milestone.

Deliverables:

- account/project/subscription discovery, credential scopes and regional jobs;
- pagination, checkpoint, eventual-consistency, rate and permission-health
  contracts;
- source-native preservation and common entity-mapping interfaces.

Verification:

- simulated duplicate/late/missing page, throttle and credential tests;
- cross-account/tenant/region and partial-permission completeness;
- shared conformance suite and connector-host pentest.

Exit criteria: cloud collection states exactly which accounts/regions/actions
are visible. `v0.290.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.292.0 — AWS Source Profile

Status: planned

Goal: validate AWS audit and inventory semantics independently of other clouds.

Deliverables:

CloudTrail, Organizations, IAM, Config and selected security-source
profiles with account, region, digest, pagination and permission coverage.

Verification:

pinned/live fixtures, organization changes, late delivery,
digest failure, throttling and partial-permission campaigns.

Exit criteria: every configured account/region has explicit collection and
permission evidence. `v0.292.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.294.0 — Azure Source Profile

Status: planned

Goal: validate Azure control-plane, directory and resource evidence semantics.

Deliverables:

Activity Log, Entra and resource inventory profiles with tenant,
subscription, region, cursor, latency and permission coverage.

Verification:

pinned/live fixtures, tenant/subscription movement, paging,
throttling, delayed availability and partial-permission campaigns.

Exit criteria: every tenant/subscription scope has explicit visibility evidence.
`v0.294.0 implementation stop reached. Run pentest for this exact commit.`

### v0.296.0 — GCP Source Profile

Status: planned

Goal: validate GCP audit, organization and resource evidence semantics.

Deliverables:

Cloud Audit Logs, organization/folder/project and asset inventory
profiles with log exclusions, sinks, cursors and permission coverage.

Verification:

pinned/live fixtures, hierarchy movement, sink/exclusion changes,
paging, throttling and partial-permission campaigns.

Exit criteria: hierarchy and exclusion gaps cannot appear as complete coverage.
`v0.296.0 implementation stop reached. Run pentest for this exact commit.`

### v0.298.0 — Asset, CMDB And Vulnerability Connectors

Status: planned

Goal: supply governed asset lifecycle, criticality, exposure and vulnerability
context without turning enrichment into source truth.

Deliverables:

- lifecycle states from discovered through retired with stable identity rules;
- CMDB, scanner and exposure mappings with conflicts, freshness and provenance;
- deterministic merge policy and history-preserving reassignment.

Verification:

- identity collision/reuse, stale inventory, conflicting owner and retirement;
- poisoned criticality/vulnerability inputs and permission-limited sources;
- replayable merge decisions and cross-tenant isolation.

Exit criteria: enrichment remains attributable and asset retirement never erases
historical identity. `v0.298.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.300.0 — Shared Identity And SaaS Connector Substrate

Status: planned

Goal: establish shared identity/SaaS mechanics before provider profiles.

Deliverables:

- bounded API polling/webhook and shared lifecycle contracts;
- user/session/application/token/entity mapping interfaces and source capsules;
- checkpoint, webhook verification, permissions and rate health.

Verification:

- webhook spoof/replay, deleted account, renamed identity, paging and throttle;
- least-privilege scopes, secret rotation and tenant separation;
- shared conformance suite and connector-host pentest.

Exit criteria: identity ambiguity and permission-limited visibility are
reported. `v0.300.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.302.0 — Identity, IAM And Directory Profiles

Status: planned

Goal: make identity-provider and directory semantics explicit.

Deliverables:

session, token, application, group, role, lifecycle and directory
profiles with immutable source identifiers, aliases and deletion markers.

Verification:

rename/reuse, disabled/deleted accounts, group churn, webhook
replay, paging and least-privilege coverage tests.

Exit criteria: identity reuse and ambiguity are represented, never guessed away.
`v0.302.0 implementation stop reached. Run pentest for this exact commit.`

### v0.304.0 — SaaS, Source-Control And Ticketing Profiles

Status: planned

Goal: ingest collaboration evidence while preserving provider boundaries.

Deliverables:

source-control, productivity and ticketing profiles with webhook
verification, audit cursor, user mapping and permission health.

Verification:

spoof/replay, deleted resources, renamed users, paging, throttle,
secret rotation and provider-specific retention tests.

Exit criteria: provider limitations and missing audit scopes remain visible.
`v0.304.0 implementation stop reached. Run pentest for this exact commit.`

### v0.306.0 — TAXII Threat-Intelligence Connector

Status: planned

Goal: transport STIX intelligence through TAXII without confusing content,
transport or trust semantics.

Deliverables:

pinned TAXII profiles, collection cursors, STIX object preservation,
source trust, expiry/revocation and quarantine integration.

Verification:

hostile servers, pagination loops, duplicates, revoked content,
version skew, oversized bundles and poisoning scenarios.

Exit criteria: transport success never implies intelligence trust or validity.
`v0.306.0 implementation stop reached. Run pentest for this exact commit.`

### v0.315.0 — Network-Security Ingestion

Status: planned

Goal: ingest common network and security-device telemetry.

Deliverables:

- flow, DNS, DHCP, VPN, firewall, proxy, email-security, IDS, CEF and LEEF
  profiles;
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

### v0.335.0 — Integrity And Source-Assurance Detection Content

Status: planned

Goal: detect attacks against Vakaheim's own evidence and security-control
continuity after sensor and connector signals exist.

Deliverables:

- signed rules for collector/provider impairment, resets/gaps, clock anomalies,
  rule/configuration tamper and audit-stream discontinuity;
- storage integrity/key failures, security-control disablement and correlated
  source/completeness degradation;
- ATT&CK/data-component mapping, severity/confidence and operational runbooks.

Verification:

- disable/tamper/gap/rollback/clock/storage/audit attack fixtures end to end;
- false-positive cases for legitimate restart, rotation, migration and outage;
- staged attack exercises from source through finding, routing and explanation.

Exit criteria: every required integrity-detection class has tested signed
content and visible coverage limits. `v0.335.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.342.0 — Notification Connectors And Durable Outbox

Status: planned

Goal: deliver outbound notifications without losing, duplicating or granting
ambient authority to alert routing.

Deliverables:

- typed notification envelope, transactional outbox, delivery attempts and
  terminal outcome ledger;
- sandboxed email/webhook/messaging adapters with secret/egress capabilities;
- idempotency, rate/fairness, retry/dead-letter, redaction and audit policy.

Verification:

- crash between enqueue/send/ack, duplicate, reorder, provider timeout and
  unknown outcome;
- webhook redirect/rebinding, secret leakage, cross-tenant and flood attacks;
- conservation and user-visible delivery-status tests.

Exit criteria: alert state and notification delivery are decoupled but every
delivery outcome remains durable and auditable. `v0.342.0 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.382.0 — Automated Forensic Acquisition And Evidence Vault

Status: planned

Goal: acquire volatile and durable forensic material before response changes the
target, while maintaining custody and bounded authority.

Deliverables:

- approved acquisition profiles for memory, process, file and platform evidence;
- dedicated acquisition capability, explicit approval, target/precondition
  fencing and separately authenticated privileged-agent protocol;
- pre-response capture dependency, source metadata and custody receipts;
- encrypted evidence vault, integrity verification, retention and legal hold.

Verification:

- partial capture, target race, oversized evidence, interruption and retry;
- unauthorized acquisition/export, key loss, hold conflict and tamper cases;
- prove ordinary collection-helper authority cannot invoke acquisition;
- independent offline custody verification.

Exit criteria: acquisition scope, failure and every custody transition are
verifiable. `v0.382.0 implementation stop reached. Run pentest for this exact
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

### v0.393.0 — API Authentication And Session Security

Status: planned

Goal: establish phishing-resistant local human sessions before the UI.

Deliverables:

- WebAuthn registration/authentication and recovery policy;
- bounded sessions, reauthentication, token audience and device/session audit.

Verification:

- origin/RP/user-presence confusion, replay, fixation, downgrade and recovery
  abuse;
- authenticator/session rotation, revocation and clock-skew cases;
- protocol conformance and independent authentication pentest.

Exit criteria: no UI or API path relies on password-only or bearer identity
without the documented profile. `v0.393.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.394.0 — OIDC And SAML Federation

Status: planned

Goal: federate human identity without confusing issuers, tenants, audiences or
session assurance.

Deliverables:

- pinned OIDC authorization-code/PKCE and SAML service-provider profiles;
- issuer/metadata/key lifecycle, claim mapping, assurance and logout/session
  binding;
- tenant-specific federation configuration and fail-closed discovery.

Verification:

- issuer/audience/redirect/relay-state confusion, signature wrapping, mix-up,
  replay, downgrade, stale metadata and key rollover;
- cross-tenant claim mapping and session-assurance changes;
- provider interoperability and federation pentest.

Exit criteria: federated identity is issuer-, tenant-, audience- and assurance-
bound. `v0.394.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.395.0 — Identity Provisioning And Workload mTLS

Status: planned

Goal: separate account lifecycle and workload identity from interactive login.

Deliverables:

- bounded SCIM provisioning/deprovisioning and group/role mapping;
- workload mTLS identities, audience/purpose, rotation and revocation;
- stale-membership/session invalidation and lifecycle audit linkage.

Verification:

- stale/reordered SCIM updates, rename/reuse, deletion, group explosion and
  tenant confusion;
- certificate substitution, rotation interruption, revocation and purpose
  confusion;
- provisioning/workload interoperability and pentest.

Exit criteria: deprovisioning and workload revocation propagate within explicit
bounds. `v0.395.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.397.0 — Authorization, Elevation And Break Glass

Status: planned

Goal: combine reviewable roles and attributes with time-bounded exceptional
access.

Deliverables:

deny-first RBAC plus ABAC, resource/field/action policies,
just-in-time elevation, two-person break glass and automatic expiry.

Verification:

policy conflicts, stale attributes, confused deputy, cache
invalidation, elevation races, collusion and expiry failures.

Exit criteria: every exceptional grant is scoped, approved, expiring and
independently auditable. `v0.397.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.399.0 — Independent Security Audit Stream

Status: planned

Goal: keep security-relevant audit evidence outside the authority and failure
domain of the operation it records.

Deliverables:

append-only signed audit events, independent writer/reader roles,
remote replication, sequence/gap health and protected retention.

Verification:

actor/admin compromise, omission, reorder, replay, destination
outage, clock change and storage exhaustion.

Exit criteria: an administrator cannot alter an action and its audit record
through the same authority. `v0.399.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.401.0 — Confidential Cases And Evidence Access Lifecycle

Status: planned

Goal: support need-to-know investigations without weakening immutable evidence
or legal obligations.

Deliverables:

case compartments, membership epochs, field/evidence redaction,
revocation propagation, export controls, retention and legal-hold precedence.

Verification:

membership removal, cached views, shared entities, derived data,
hold conflicts, delegated export and cross-compartment inference.

Exit criteria: revocation reaches every derived access path while holds remain
enforceable. `v0.401.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.403.0 — Analyst Authorization And Coverage Gate

Status: planned

Goal: verify analyst workflows against authorization, audit and telemetry
coverage before the complete interface ships.

Deliverables:

end-to-end policy matrix, coverage/data-component views,
impairment-safe dashboards and inaccessible-data placeholders without leakage.

Verification:

role/attribute/compartment changes across search, graph, case,
report, rules and administration; side-channel and stale-cache attacks.

Exit criteria: every analyst surface has server-side policy, audit and coverage
evidence. `v0.403.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.404.0 — Analyst UI

Status: planned

Goal: expose investigation workflows through a policy-safe analyst interface.

Deliverables:

- search/query/live/event/raw/entity/timeline/graph/incident/case/report views;
- rule studio, simulation, rollout, source assurance and coverage views;
- accessible workflows, safe rendering and server-issued action forms.

Verification:

- browser security, session, CSRF, XSS, injection, clickjacking and CSP tests;
- authorization/redaction and stale membership across every analyst view;
- end-to-end investigation and analyst-UI pentest.

Exit criteria: analyst rendering cannot replace server enforcement or leak
inaccessible evidence through derived views. `v0.404.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.405.0 — Administration UI

Status: planned

Goal: expose privileged administration only after analyst workflows and
authorization gates are proven.

Deliverables:

- tenant, identity, role, policy, trust-root, key and schema administration;
- fleet, storage, backup, upgrade, registry and audit administration;
- step-up/two-person forms, preview/diff, staged rollout and rollback controls.

Verification:

- browser security, session, CSRF, XSS, injection, clickjacking and CSP tests;
- authorization/redaction at every view/action and accessible workflows;
- end-to-end privileged administration and admin-UI pentest.

Exit criteria: the UI never replaces server-side enforcement or generated
evidence explanations. `v0.405.0 implementation stop reached. Run pentest for
this exact commit.`

## Phase J — Wasm And SOAR

### v0.407.0 — First-Party Wasm Execution Core

Status: planned

Goal: implement and bound core WebAssembly instruction execution before
Component Model or host capabilities depend on it.

Deliverables:

- pinned core Wasm profile, validated decoder, typed instruction IR and
  deterministic interpreter;
- fuel, stack, memory/table, call-depth, module-size and output limits;
- trap/cancellation semantics, no JIT/native code, and zero-third-party
  feasibility decision.

Verification:

- official specification tests, malformed/invalid modules and interpreter
  differential fixtures;
- fuel, memory, recursion, numeric edge, NaN and cancellation attacks;
- cross-target deterministic behavior and sustained fuzzing.

Exit criteria: no component reaches a host without a bounded validated execution
core. `v0.407.0 implementation stop reached. Run pentest for this exact commit.`

### v0.408.0 — Component Model Canonical ABI

Status: planned

Goal: implement canonical lifting/lowering and resource ownership separately
from core execution and host policy.

Deliverables:

- pinned Canonical ABI types, memory/string/list lifting/lowering and resources;
- allocation, aliasing, ownership, cleanup, recursion and size limits;
- WIT-to-runtime identity and no-third-party feasibility record.

Verification:

- official component fixtures, invalid discriminants/handles, aliasing, partial
  allocation and cleanup failure;
- hostile nested values, encoding/size overflow and resource leaks;
- differential Canonical ABI and cross-target equivalence.

Exit criteria: component values cannot confuse ownership, exceed bounds or
bypass core validation. `v0.408.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.410.0 — Component Format And WIT Validator

Status: planned

Goal: validate the pinned WebAssembly Component Model and WIT contract before
any component can reach a host.

Deliverables:

pinned normative profile, bounded binary/WIT decoders, canonical
component identity, import/export/type validation and compatibility fixtures.

Verification:

official fixtures, malformed sections/types, recursion, oversized
names/graphs, version skew and differential parser fuzzing.

Exit criteria: unsupported or ambiguous component semantics fail closed before
instantiation. `v0.410.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.415.0 — Component Registry, Provenance And Revocation

Status: planned

Goal: make component admission, distribution and withdrawal independently
verifiable.

Deliverables:

immutable digest-addressed registry, builder/reviewer signatures,
transparency log, capability manifest, lifecycle and emergency revocation.

Verification:

substitution, equivocation, rollback, stale cache, compromised
signer, revoked component and unavailable registry cases.

Exit criteria: every executable component has a logged provenance chain and
revocation reaches all placements. `v0.415.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.420.0 — Read-Only Wasm Host And OS Sandbox

Status: planned

Goal: run optional read-only extensions without ambient authority.

Deliverables:

- WIT capability worlds and signed manifests admitted through `v0.410.0` and
  `v0.415.0`;
- fuel, wall time, memory, output, host-call and concurrency limits;
- isolated worker process/OS sandbox and evidence-only handles.

Verification:

- malformed module/component, capability forgery, escape and confused deputy;
- fuel/memory/output/host-call exhaustion, cancellation and worker crash;
- differential sandbox review and independent Wasm-host pentest.

Exit criteria: the Wasm runtime is defense-in-depth, bounded and read-only.
`v0.420.0 implementation stop reached. Run pentest for this exact commit.`

### v0.425.0 — Cryptographically Bound Action Envelope

Status: planned

Goal: bind every proposed side effect to exact reviewed inputs before workflow
execution exists.

Deliverables:

signed envelope over tenant, actor, incident, target, action,
parameters, component/policy/evidence/effect-plan/dry-run digests, target
preconditions, idempotency key, verification procedure, compensation version,
maximum blast radius, nonce, expiry and approval class.

Verification:

field substitution, replay, retargeting, stale evidence/policy,
cross-tenant, expiry and signature-confusion tests.

Exit criteria: changing any security-relevant action input invalidates the
envelope and its approvals. `v0.425.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.430.0 — Playbook Engine

Status: planned

Goal: model response workflows as typed auditable state machines.

Deliverables:

- proposed/policy/approval/scheduled/prepared/dispatching/dispatched/
  unknown-outcome/reconciled/verifying/completed/failure and compensation/cancel
  states;
- typed steps, branching, waits, retries, deadlines, idempotency and recovery;
- immutable execution audit and deterministic dry-run plan.

Verification:

- exhaustive small-workflow transitions and crash/retry/cancel at every state;
- duplicate delivery, stale approval, timeout and compensation failures;
- workflow fuzz/model checking and replay.

Exit criteria: no workflow step executes from an invalid or unaudited state.
`v0.430.0 implementation stop reached. Run pentest for this exact commit.`

### v0.435.0 — Dry Run, Simulation And Canary Planning

Status: planned

Goal: produce reviewable bounded effect plans before granting mutation
authority.

Deliverables:

deterministic dry-run output, target expansion, dependency and
blast-radius estimates, fixture simulator and canary/abort plan.

Verification:

target drift, partial inventories, simulator divergence, canary
failure, stale plan and resource-exhaustion scenarios.

Exit criteria: mutable execution cannot begin without a current bounded plan or
an explicitly audited emergency exception. `v0.435.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.440.0 — Capabilities And Secret Handles

Status: planned

Goal: grant extensions only narrow unforgeable operation authority.

Deliverables:

- tenant/incident/action-scoped handles, expiry and revocation;
- sign/fetch-short-token/authenticated-call secret operations;
- per-component DNS/IP/protocol/destination allowlists, identity, quotas and
  full audit;
- redirect, proxy, name-resolution and response-size policy enforced by the host.

Verification:

- handle forgery/reuse/leak/cross-tenant, stale/revoked and scope confusion;
- DNS/rebinding/redirect/egress bypass and secret-exfiltration tests;
- formal authorization properties and pentest.

Exit criteria: long-lived secrets and ambient connectors are not exposed.
`v0.440.0 implementation stop reached. Run pentest for this exact commit.`

### v0.445.0 — Exact-Digest Approval And Separation Of Duties

Status: planned

Goal: make approval authorize one immutable effect plan under independent
authority.

Deliverables:

approval signatures over action-envelope and plan digests, role
separation, quorum policy, expiry, revocation and reapproval triggers.

Verification:

self-approval, collusion, digest substitution, reordered approval,
policy/target drift, expiry and signer revocation.

Exit criteria: approvals cannot be reused for a changed plan, target, policy or
component. `v0.445.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.447.0 — Durable Action Dispatch And Unknown Outcomes

Status: planned

Goal: reconcile external side effects when a provider applies an action but
Vakaheim loses the response.

Deliverables:

- transactional outbox/inbox and fenced action-worker leases;
- provider/tenant/action idempotency ledger, target/precondition snapshot and
  dispatch receipt state;
- verification-before-retry rules and explicit manual reconciliation for
  providers without reliable idempotency keys.

Verification:

- crash or partition before/after every send, provider apply and response write;
- stale worker, duplicate dispatch, idempotency collision/expiry, unverifiable
  target and provider lying/timeout;
- state-machine model proving no unknown outcome is reported as failure or safe
  retry without reconciliation.

Exit criteria: an uncertain external effect remains `UnknownOutcome` until
verified or explicitly reconciled. `v0.447.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.450.0 — Response Action Framework

Status: planned

Goal: implement the common bounded action lifecycle before provider families.

Deliverables:

- typed provider-neutral target/action/precondition/verification contracts;
- automatic/human/two-person/prohibited approval policy;
- idempotency, verification, retry, compensation, dry run and canary;
- effect classification as reversible, compensatable or irreversible, with
  pre-response forensic capture and recovery requirements.

Verification:

- unauthorized/destructive/wrong-target, duplicate, race and stale context;
- approval bypass/collusion, failed verification and compensation scenarios;
- red-team response worker/connectors and independent pentest.

Exit criteria: arbitrary command execution remains prohibited and every side
effect is scoped and verified. `v0.450.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.451.0 — Endpoint And Identity Actions

Status: planned

Goal: implement narrow endpoint and identity response profiles.

Deliverables:

- isolate/release endpoint and bounded process/file acquisition or containment;
- disable/re-enable account, revoke session/token and force credential reset;
- action-specific preconditions, verification, compensation and effect classes.

Verification:

- wrong/reused target identity, stale inventory, partial endpoint/IdP outcome;
- duplicate/unknown outcome, lockout, compensation and privilege attacks;
- representative platform/provider interoperability and pentest.

Exit criteria: endpoint and identity actions expose no generic command or
unscoped administration surface. `v0.451.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.452.0 — Network And Cloud Actions

Status: planned

Goal: implement narrow network and cloud containment profiles.

Deliverables:

- block/unblock indicators or flows through bounded device APIs;
- cloud quarantine/tag/policy actions with account/region/resource fencing;
- propagation-aware verification, compensation and blast-radius estimates.

Verification:

- NAT/address/resource reuse, rule shadowing, region/account confusion and
  eventual consistency;
- duplicate/unknown outcome, excessive target expansion and rollback failure;
- representative network/cloud interoperability and pentest.

Exit criteria: network/cloud actions remain target-, region- and policy-bound.
`v0.452.0 implementation stop reached. Run pentest for this exact commit.`

### v0.453.0 — Credential, Evidence And Ticket Actions

Status: planned

Goal: implement remaining governed response and workflow side effects.

Deliverables:

- rotate/revoke bounded credential handles without exposing secret material;
- acquire/seal/export specifically approved evidence packages;
- create/update ticketing records and notifications with redaction policy.

Verification:

- secret exfiltration, wrong credential/evidence/case, unauthorized export and
  ticket data leakage;
- duplicate/unknown outcome, provider timeout and compensation limitations;
- custody, privacy and connector-host pentest.

Exit criteria: secret, evidence and ticket actions preserve authority, custody
and disclosure boundaries. `v0.453.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.455.0 — Verification, Compensation And Irreversible Recovery

Status: planned

Goal: close the response lifecycle with evidence of actual effect and bounded
failure handling.

Deliverables:

action-specific verification, compensation eligibility and
deadlines, irreversible recovery procedures, residual-risk findings and custody
links.

Verification:

false success, partial effect, unreachable target, compensation
failure, repeated retry and irreversible-action tabletop exercises.

Exit criteria: no action is reported complete without effect evidence, and
unrecoverable outcomes produce explicit incidents. `v0.455.0 implementation stop
reached. Run pentest for this exact commit.`

## Phase K — Control Plane, Cluster And Federation

### v0.459.0 — Operational-State Durability Matrix

Status: planned

Goal: assign consistency and recovery ownership before clustering mutable state.

Deliverables:

- matrix for detection state, connector checkpoints, alerts/incidents/cases,
  playbooks/actions/approvals, live-query leases, saved queries and audit cursors;
- authority, partition key, consistency, fencing, replication, RPO, RTO,
  backup/restore, migration and loss/impairment semantics per class;
- explicit routing decision separating control metadata, immutable evidence and
  high-volume mutable operational state.

Verification:

- architecture/tabletop review for crash, partition, stale owner, corruption,
  failover, region loss and restore per state class;
- reject undefined RPO/RTO or accidental metadata-log placement;
- cross-state transaction and irreversible-loss analysis.

Exit criteria: no mutable state class enters cluster implementation without a
named durability and failover contract. `v0.459.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.460.0 — Distributed Control Plane

Status: planned

Goal: distribute the proven `v0.17.0` local authority model as immutable signed
configuration epochs.

Deliverables:

- node/fleet identity, trust roots, config, schema, parser, rule and component
  registries, policy, tenant, storage and upgrade metadata;
- current/previous epoch, validation, activation, rollback, drift and audit;
- bootstrap, break-glass and least-privilege administration.
- compatibility and semantic-equivalence proof with local authorization,
  registry, trust-root and audit contracts.

Verification:

- unauthorized/stale/tampered/partial epoch and split configuration;
- rollover, rollback, drift, break-glass and compromised admin scenarios;
- control-plane API/UI pentest.

Exit criteria: nodes cannot activate unauthenticated or invalid configuration.
`v0.460.0 implementation stop reached. Run pentest for this exact commit.`

### v0.462.0 — Consensus Adversary And Fault Model

Status: planned

Goal: state metadata-consensus guarantees and non-guarantees before choosing or
implementing an algorithm.

Deliverables:

- authenticated crash-fault-tolerant model, quorum and network assumptions;
- explicit statement that a compromised voting quorum is outside safety claims;
- containment, key rotation, membership recovery and operator trust boundaries.

Verification:

- architecture review against partitions, crash, disk, clock and key compromise;
- CFT/BFT claim audit and misuse/operational tabletop;
- decision record approved before implementation.

Exit criteria: no documentation or API implies Byzantine safety from an
authenticated CFT design. `v0.462.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.463.0 — Formal Metadata Consensus Model

Status: planned

Goal: model safety, liveness and reconfiguration before production code.

Deliverables:

executable formal model for election, log agreement, commit,
membership change, snapshots and recovery under the `v0.462.0` assumptions.

Verification:

exhaustive bounded exploration, injected partitions/crashes,
joint-membership and stale-node counterexamples, plus reviewable invariants.

Exit criteria: all stated invariants hold in the bounded model and discovered
counterexamples are resolved. `v0.463.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.465.0 — Metadata Consensus

Status: planned

Goal: replicate small control metadata under a documented crash-fault model.

Deliverables:

- leader election, log, commit, snapshot, membership change and stale-leader
  protection;
- formal executable model aligned with implementation and traceable to
  `v0.462.0` assumptions and `v0.463.0` invariants;
- bounded messages/storage, authentication and operational recovery.

Verification:

- model checking, deterministic network schedules and fault injection;
- partition, reorder, duplicate, crash/restart, snapshot and membership races;
- implementation/model trace comparison and consensus pentest.

Exit criteria: safety properties hold for the documented fault assumptions.
`v0.465.0 implementation stop reached. Run pentest for this exact commit.`

### v0.466.0 — Detection-State Placement And Failover

Status: planned

Goal: make detection checkpoints/state highly available without changing rule
semantics.

Deliverables:

- partition placement, ownership epochs, fencing, replicated checkpoints and
  deterministic handoff;
- RPO/RTO, impairment findings and replay from immutable evidence;
- migration and compatibility with placement-equivalence guarantees.

Verification:

- owner crash, partition, duplicate/stale owner, corrupt checkpoint and rebalance;
- reference replay/finding equivalence and bounded state recovery;
- hot-key/noisy-tenant and failover latency campaign.

Exit criteria: detection failover cannot double fire, lose state silently or
change rule meaning. `v0.466.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.467.0 — Connector And Subscription Lease HA

Status: planned

Goal: fence mutable source cursors and live-query ownership across failover.

Deliverables:

- connector/checkpoint and live/saved-query lease placement with ownership
  epochs;
- connector, subscription and audit-stream cursor replication, resume, handoff
  and duplicate/gap evidence;
- provider-rate and tenant-fairness behavior during recovery.

Verification:

- dual owner, stale lease, crash between fetch/checkpoint, provider replay,
  subscriber reconnect and partition;
- exact cursor conservation and query resume semantics;
- failover storms and lease-store exhaustion.

Exit criteria: failover creates neither an unreported collection gap nor an
unfenced duplicate owner. `v0.467.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.468.0 — Alert, Incident And Case State HA

Status: planned

Goal: preserve mutable analyst workflow under node failure and concurrency.

Deliverables:

- partitioned replicated operational journal, optimistic versions and fencing;
- alert/incident/case/SLA/approval consistency and conflict-resolution rules;
- backup/restore, RPO/RTO and immutable evidence/audit references.

Verification:

- concurrent edit, failover, stale owner/client, partial replication, restore
  and cross-state transition;
- case compartment/hold/authorization changes during failover;
- no loss or mutation of linked immutable evidence.

Exit criteria: analyst state meets its declared RPO/RTO and every conflict is
visible and auditable. `v0.468.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.469.0 — Playbook And Action State HA

Status: planned

Goal: fail over approvals, playbooks and external-effect ledgers without
duplicating or forgetting side effects.

Deliverables:

- replicated playbook state, approvals, outbox/inbox and idempotency ledger;
- fenced worker recovery and `UnknownOutcome` reconciliation after owner loss;
- RPO/RTO and durable linkage to action envelopes, verification and audit.

Verification:

- failover before/after dispatch/provider apply/receipt/verification;
- stale worker, duplicate send, approval race, compensation and region partition;
- state-machine/model comparison under replicated-log faults.

Exit criteria: failover cannot authorize a new effect or turn uncertainty into a
safe retry. `v0.469.0 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.472.0 — Placement, Repair, Rebalancing And Disk Evacuation

Status: planned

Goal: separate data movement policy from replication correctness and bound its
operational blast radius.

Deliverables:

placement generations, throttled repair/rebalance, disk evacuation,
priority classes, cancellation/restart and progress/impairment evidence.

Verification:

hot partitions, simultaneous failures, full disks, stale plans,
operator cancellation, bandwidth starvation and mixed-version movement.

Exit criteria: movement cannot violate quorum durability or starve ingest and
recovery reserves. `v0.472.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.474.0 — Multi-Tenant Workload And Key Isolation

Status: planned

Goal: enforce tenant boundaries across compute, memory, storage, encryption and
operations before federation.

Deliverables:

per-tenant quotas/reserves, scheduler fairness, cache/index/spill
ownership, key hierarchy, backup/export isolation and noisy-neighbor evidence.

Verification:

identifier confusion, quota bypass, cache/spill reuse, key mix-up,
backup restore, workload starvation and side-channel campaigns.

Exit criteria: no tenant can consume or observe another tenant's data, keys or
reserved capacity. `v0.474.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.475.0 — Federated Query

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

### v0.478.0 — SRE Operations And Supportability

Status: planned

Goal: expose the operational evidence required to run Vakaheim safely at scale.

Deliverables:

service objectives, health/dependency graph, saturation and error
budgets, safe diagnostics, support bundles, capacity forecasts and runbooks.

Verification:

partial outage, false-green health, telemetry loss, diagnostic
redaction, overload, upgrade and on-call game-day scenarios.

Exit criteria: operators can distinguish healthy, degraded and unverifiable
states without privileged data leakage. `v0.478.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.480.0 — Multi-Region Replication And Failover

Status: planned

Goal: survive regional failure under explicit consistency, sovereignty and data-
loss contracts.

Deliverables:

- region-aware placement, asynchronous replication, failover and sovereignty;
- per-state-class regional RPO/RTO, authority and completeness evidence;
- failover/failback fencing, lag, conflict and unavailable-region behavior.

Verification:

- region loss, total partition, stale owner, lag, conflict and key/trust outage;
- failover/failback of evidence and every mutable state class;
- sovereignty, split-region and multi-region pentest.

Exit criteria: recovery objectives, data loss and unavailable evidence are
measured honestly. `v0.480.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.481.0 — Backup, Restore And Disaster Rebuild

Status: planned

Goal: rebuild a complete deployment from protected backups and immutable source
material.

Deliverables:

- backup/restore for control, evidence, keys, operational state and audit;
- repair/reindex/migration ordering, consistency points and dependency manifest;
- full disaster runbooks, clean-room bootstrap and recovery verification.

Verification:

- stale/partial/corrupt backup, missing key, incompatible version and interrupted
  restore;
- point-in-time/state-class RPO checks and post-restore authorization/audit;
- independent clean-environment disaster exercise.

Exit criteria: restored state is complete to declared recovery points, and every
unavailable class is explicit. `v0.481.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.482.0 — Air-Gapped And Sovereign Operations

Status: planned

Goal: operate, update and exchange approved evidence without online trust or
control dependencies.

Deliverables:

- signed offline update, trust, configuration, rule and component bundles;
- policy-aware evidence/import export, transfer custody and replay protection;
- offline freshness/revocation limitations and deterministic re-entry workflow.

Verification:

- tampered/stale/replayed bundle, revoked signer, clock uncertainty and partial
  transfer;
- cross-domain policy/redaction/custody and removable-media attacks;
- prolonged disconnected operation and reconnection rehearsal.

Exit criteria: air-gapped operation neither bypasses trust/policy nor claims
fresh online revocation knowledge. `v0.482.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.483.0 — Rolling Upgrade And Deterministic Rollback

Status: planned

Goal: upgrade every distributed plane while mixed versions remain safe and
rollback limits are explicit.

Deliverables:

- compatibility matrix, staged/canary order, drain/handoff and feature gates;
- schema/format/protocol/state migration and downgrade boundaries;
- automatic abort, deterministic rollback and irreversible-step approval.

Verification:

- every supported mixed-version pair, crash/partition during each step and
  rollback after partial migration;
- stale binary/config, incompatible state and failed drain/handoff;
- full single-node/cluster/multi-region upgrade rehearsal.

Exit criteria: unsupported downgrade fails before mutation, and supported
rollback restores a defined prior state. `v0.483.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.484.0 — Distributed Scale And Failover Campaign

Status: planned

Goal: test distributed capabilities only after replication, evacuation,
operational-state HA, federation, SRE and recovery exist.

Deliverables:

- multi-terabyte/day cluster workload with ingest, query, detection, connectors,
  analyst state, actions, repair, evacuation and multi-region replication;
- exact topology/hardware/configuration/data/rules/failure schedule and commits;
- measured RPO/RTO, acknowledgement, completeness and impairment evidence.

Verification:

- node/rack/region loss, quorum partition, disk evacuation, stale owner, failover,
  rebalance, noisy tenant and rolling upgrade;
- conservation and semantic equivalence across every state class;
- independent reproduction and distributed-system pentest.

Exit criteria: distributed durability, availability and recovery claims have
fault-injected quantitative evidence. `v0.484.0 implementation stop reached.
Run pentest for this exact commit.`

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
- multi-terabyte cluster scale, failover, spool, evidence verification and
  recovery results;
- hardware, OS, flags, data, schemas, rules, indexes, replication and commits.

Verification:

- repeated cold/warm/steady/burst/failure runs and statistical reporting;
- sustained ingest/query/retention at multi-terabyte scale, resource exhaustion,
  noisy neighbor and regression thresholds;
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
