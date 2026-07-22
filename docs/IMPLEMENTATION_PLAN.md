# Vakaheim Implementation Plan

Status: planning document

This plan turns the initial product idea into build order and engineering
constraints. The version-by-version handoff is in
[RELEASE_PLAN.md](RELEASE_PLAN.md). Every capability named here remains
unimplemented until its release exit criteria pass.

## 1. Objective

Build Vakaheim into a self-contained security evidence platform that can:

- collect cross-platform and external telemetry;
- retain exact or policy-permitted source evidence and full lineage;
- compile observations into typed immutable facts;
- store and query facts without a mandatory external database;
- run explainable deterministic and behavioral detection;
- manage findings, incidents, cases, reports, and chain of custody;
- execute capability-limited, approved, reversible response actions;
- operate as a single node, cluster, sovereign federation, air-gapped system,
  endpoint collector, or embedded portable core;
- expose a deliberately scoped SDK before production 1.0.

Version 1.0.0 is the first serious production release. It may not defer a
major product plane.

## 2. Engineering Sequence

### Stage A: constitution and portable foundations

Freeze the environmental, dependency, unsafe, publishing, modularity,
evidence, resource-bound, and release laws before product implementation.
Then build checked byte access, identity, time, parser, event, provenance,
codec, policy, and bounded-memory primitives. These crates remain dependency
free and `no_std`, with `alloc` admitted only where a milestone requires it.

### Stage B: facts and interoperability

Build the entity, relationship, uncertainty, schema, source-capsule, and
compatibility-mapping model. OCSF and OpenTelemetry are boundaries, not the
internal source of truth. Every lossy mapping reports its loss.

### Stage C: ingestion and transport

Add bounded local ingestion, file tailing, syslog, JSON, authenticated OTLP and
OCSF endpoints, encrypted spooling, batch acknowledgement, enrollment, secure
transport, and relays. Overload produces explicit telemetry-gap evidence.

### Stage D: storage

Implement an immutable security segment format, crash-safe WAL, deterministic
column pages, security indexes, encryption/integrity, retention, compaction,
repair, backup, and cold export. No external storage service is required.

### Stage E: VQL query and reasoning

The working query-language name is VQL (Vakaheim Query Language). Build a
bounded lexer/parser, typed AST, normalized IR, authorization/residency
rewrites, logical and physical planning, cost controls, single-node execution,
temporal and graph operations, live subscriptions, historical perspective,
and completeness explanations.

### Stage F: detection

Build signed rule packages, bounded deterministic IR, stateless predicates,
temporal automata, durable state, immutable findings, graph and behavioral
detection, content import, simulation, shadow deployment, canary rollout, and
automatic fail-closed rollback thresholds.

### Stage G: native sensors

Introduce Linux, Windows, macOS, BSD, Kubernetes, Android, and iOS collection
only after the common fact/spool/transport contracts stabilize. Privileged
helpers are small and separate. Every sensor reports missing privileges,
detachments, sequence gaps, clock problems, backpressure, and health loss.

### Stage H: SDK and connectors

Build a private in-workspace SDK first, then connector contracts, cloud,
identity, SaaS, flow, DNS, DHCP, VPN, firewall, proxy, email, and IDS inputs.
Adaptive collection remains bounded, signed, visible, and self-reverting.

The SDK stays unpublished until a dedicated admission milestone. If publication
is later approved, only the SDK uses `MIT OR Apache-2.0`.

### Stage I: analyst product

Build routing, incident graphs, case management, evidence views, reports,
source assurance, rule studio, analyst UI, and administration UI. Mutable case
state never rewrites immutable evidence.

### Stage J: extension and response

Build WIT capability worlds, validation, signatures, an OS-isolated Wasm host,
typed playbook state, secret handles, network allowlists, approvals,
verification, compensation, dry-run, and canary response.

### Stage K: cluster and federation

Build immutable signed configuration epochs, fleet management, a formally
modeled metadata consensus path, data replication, quorum acknowledgement,
repair, rebalancing, tenant isolation, federated query, sovereignty, backup,
restore, air-gap bundles, rolling upgrades, and disaster recovery.

### Stage L: product completion

Add optional audited AI assistance, privacy and compliance enforcement,
published reference performance evidence, full verification and chaos
campaigns, independent assessment and remediation, production-like beta, API
and format freezes, an exact release candidate, and unchanged 1.0 promotion.

## 3. Planned Workspace Families

Crates are created just in time. The names below are architectural ownership,
not permission to create empty crates prematurely.

| Family | Representative crates | Environment |
| --- | --- | --- |
| Facade | `vakaheim` | `no_std` by default |
| Foundation | `vakaheim-core`, `-bytes`, `-id`, `-time`, `-value`, `-policy` | `no_std`; optional `alloc` |
| Facts | `-event`, `-entity`, `-provenance`, `-integrity`, `-source-capsule` | `no_std`; optional `alloc` |
| Ingestion | `-ingest-core`, `-parser-sdk`, `-syslog`, `-json`, `-otlp`, `-ocsf` | core portable; runtimes `std` |
| Platform | `-linux`, `-windows`, `-macos`, `-bsd`, `-android`, `-ios`, `-kubernetes` | isolated `std`/FFI |
| Runtime | `-runtime-core`, OS reactors, channels, protocol, transports, enrollment | mixed explicit boundary |
| Storage | `-storage-format`, `-wal`, `-segment`, `-index`, `-retention`, `-backup` | format `no_std`; engine `std` |
| Query | `-query-syntax`, `-ast`, `-ir`, `-typecheck`, `-plan`, `-exec`, `-graph` | front-end `no_std + alloc`; exec `std` |
| Detection | `-rule-model`, `-rule-compiler`, `-detect-core`, `-detect-state`, `-behavior` | core `no_std + alloc`; workers `std` |
| Response | `-wasm-abi`, `-wasm-validate`, `-wasm-host`, `-soar-core`, `-approval` | ABI/core portable; host isolated `std` |
| Control | `-control`, `-auth`, `-authorization`, `-audit`, `-cluster`, `-federation` | explicit `std` services |
| Analyst | `-finding`, `-incident`, `-case`, `-report`, `-api`, `-sdk`, `-ui-model` | mixed |
| Verification | `-testkit`, fixtures, attack scenarios, fuzz, Kani, Loom, conformance, bench | never product dependencies |

## 4. Product Roles

A deployment may combine or separate these roles:

- sensor: native collection and safe edge processing;
- relay: buffer, validate, prioritize, and forward;
- ingest node: authenticate, decode, partition, and durably acknowledge;
- fact compiler: preserve source and produce typed facts;
- detection worker: evaluate live bounded detection state;
- storage node: write, index, compact, encrypt, replicate, and verify;
- query worker: historical, temporal, graph, live, and federated execution;
- incident node: finding correlation and incident state;
- action worker: isolated enrichment and response components;
- control node: trust, configuration, policy, schemas, rules, fleet, cluster;
- API/UI node: authorized analyst, administration, and SDK boundaries.

## 5. Test Strategy

Testing is designed with each API, not added after it:

- unit tests for success, boundary, invalid, and state-transition behavior;
- compile checks for `no_std` and supported target families;
- table, property, round-trip, metamorphic, and differential tests;
- negative and adversarial corpora for every untrusted parser;
- fuzzing for codecs, planners, protocols, formats, and recovery paths;
- Miri for low-level invariants and any admitted unsafe boundary;
- Kani for bounded parsers, state machines, authorization, and arithmetic;
- Loom or first-party deterministic schedulers for concurrency contracts;
- fault injection, corruption, partial-write, disk-full, clock, and network
  partitions;
- attack-scenario replay and deterministic finding replay;
- upgrade, rollback, backup, restore, repair, and migration tests;
- performance regression with hardware, dataset, configuration, and commit;
- independent pentest for every exact release implementation.

Tests must avoid production dependencies. Test-only utilities are internal
workspace crates or repository scripts.

## 6. Security Workstream

Every implementation milestone updates:

- threat-model delta and data-flow delta;
- parser/resource/authorization boundaries;
- unsafe inventory (expected empty until an approved boundary);
- dependency inventory (expected workspace-only);
- attack scenarios and abuse cases;
- fuzz/formal/concurrency targets affected;
- storage, protocol, schema, and API compatibility claims;
- operator documentation and known limitations;
- release notes and pentest scope.

Security fixes may interrupt the roadmap. A broad milestone is split before it
is allowed to weaken review quality.

## 7. Platform Strategy

Representative core compile targets are checked early. Native collectors are
then admitted separately:

- Linux: journald, audit, process/auth/service/file/network/container health,
  with optional small eBPF helper and non-eBPF fallback;
- Windows: Event Log, ETW, process/auth/service/registry/network health;
- macOS: Endpoint Security, Unified Logging, FSEvents, permissions health;
- FreeBSD/OpenBSD: syslog, audit/OpenBSM, kqueue, process accounting, pf;
- Android/iOS: application/device-safe adapters within platform sandbox rules;
- Kubernetes: audit, workload identity, admission, RBAC, exec, image, network;
- Aesynx: future adapter over portable contracts when that OS is ready.

Support claims require tested functionality on real or representative systems;
cross-compilation alone is only a portability check.

## 8. Operational Acceptance

The 1.0 acceptance contract includes zero silent loss, bounded overload,
published reference throughput/latency/agent overhead, committed-record
durability under the stated model, rolling upgrades, deterministic rollback,
multi-day endpoint spool, evidence verification, complete recovery tooling,
and honest partial-result/completeness reporting.

Targets are gates supported by reproducible evidence, never marketing claims.

## 9. Definition Of Production 1.0

Version 1.0.0 requires all product planes, all supported platform collectors,
storage/query/detection/case/response/cluster/SDK/UI operation, format and API
stability, production documentation, signed reproducible artifacts, independent
assessment, no unresolved critical or high findings, and unchanged promotion
of an approved release candidate.
