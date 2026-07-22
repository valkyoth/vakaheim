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
- execute capability-limited, approved response actions whose effects are
  classified as reversible, compensatable, or irreversible;
- operate as a single node, cluster, sovereign federation, air-gapped system,
  endpoint collector, or embedded portable core;
- expose a deliberately scoped SDK before production 1.0.

Version 1.0.0 is the first serious production release. It may not defer a
major product plane.

## 2. Audit Integration Decisions

The July 2026 completeness audits are incorporated as strengthening passes, not
as roadmap replacements. Version numbers are an unbounded sequence of security
review stops, not a countdown or a ceiling: the plan may continue through
`v0.1000.0` and beyond before 1.0 if safe decomposition requires it. New minor,
patch, and intermediate milestones close specific gaps before dependent product
layers may proceed.

### Evidence semantics

Evidence integrity, authenticity, availability, reconstruction capability, and
evidentiary truth are separate claims. A digest can prove that supplied bytes
match a prior digest; it cannot prove that bytes still exist, that a source was
truthful, or that an interpretation was complete. `v0.6.1` owns a canonical
mapping-outcome and reconstruction-availability contract. `v0.11.0` owns fact
conflict and extension semantics.

### Dependency constraint

The audit recommended relaxing the zero-third-party rule at host boundaries.
That recommendation conflicts with Vakaheim's owner constraint and is not
adopted. Product, build, and development manifests remain workspace-only.
Security-critical functionality must use a reviewed first-party implementation,
a narrow operating-system service/ABI boundary, or remain unavailable and fail
closed. `v0.10.1` must demonstrate the `core`/`alloc`/`std`, dependency
direction, host adapter, allocator-failure, and future unsafe allowlist model
before host crates appear. Later protocol, cryptography, Unicode, compression,
Wasm, and OS milestones each include an explicit no-third-party feasibility
gate; inability to meet it splits or blocks the milestone rather than silently
admitting a crate.

### Release assessment authenticity

Plain text is insufficient evidence of tester identity. `v0.1.0` now requires
the exact-commit assessment to carry a verifiable trusted-tester signature or
attestation in addition to commit ancestry and report fields. Trust-root,
revocation, offline verification, and key-rotation procedures are part of that
gate.

### Consensus claim

Vakaheim will not imply Byzantine tolerance while implementing a crash-fault
tolerant protocol. `v0.462.0` fixes the adversary and fault model before
`v0.463.0` models the protocol and `v0.465.0` implements it. The baseline is
authenticated CFT: a quorum of compromised voting members is outside the
safety model. Compromise detection, key revocation, member quarantine, audit,
restore, and reconfiguration are containment controls, not BFT claims.

### Storage risk and early scale evidence

The embedded database is the largest technical risk. `v0.41.0` defines its
capacity and stable-media contract before format implementation. Intermediate
milestones add hot staging, shard ownership, generation snapshots, workload
isolation, cache quotas, rollups, migration, scrubbing, and disaster reindexing.
`v0.58.0` is an early multi-terabyte/day scale and long-duration fault gate;
late `v0.540.0` through `v0.570.0` performance stops provide separate endpoint,
ingest/storage, query/detection/analyst, and cluster/recovery confirmation.

### Capability honesty

Cross-compilation proves portability, not operational platform support. Every
sensor, connector, protocol, storage, query, detection, UI, and response claim
requires real or representative interoperability, impairment, upgrade,
rollback, resource, and security evidence at its named milestone.

### Providers must precede consumers

No milestone may depend on an unnamed substrate hidden inside its feature
scope. Cryptographic contracts and trust primitives now precede digests and
signatures. Hosted runtime, text/Unicode/IDNA, TLS/certificate, raw-capsule,
self-observability, Protobuf/compression, HTTP/2/gRPC, API, connector-host, Wasm
interpreter, and Canonical ABI work each have explicit implementation stops.
Every stop includes a zero-third-party feasibility decision; failure blocks its
consumers instead of moving the work invisibly into them.

### Local authority before distribution

The early local control plane owns service/tenant/source identity, trust roots,
configuration epochs, registries, local authorization, capability issuance,
and the audit-event contract before ingestion and query consume them. Stage I
adds human federation, administration, elevation, and break glass. Stage K
replicates the proven local model; it does not invent authority semantics late.

### Mutable state is not metadata

Detection checkpoints, connector cursors, live-query leases, alerts, incidents,
cases, approvals, playbooks, action idempotency, and audit cursors are production
state with different consistency and recovery needs. `v0.459.0` owns their
durability matrix. Separate Stage K milestones implement fencing, placement,
replication, failover, RPO, and RTO without forcing high-volume operational
state through the metadata-consensus log.

### Scale claims follow implemented capability

`v0.58.0` is a single-node or explicitly implemented local-mirror storage
campaign. It cannot claim cluster replication, node quorum, or disk evacuation.
Those capabilities receive their distributed fault and scale campaign only
after Stage K implements them. The same sequencing law applies to SDK clients,
forensic acquisition, UI, authentication, Wasm, SOAR, and disaster recovery.

### Contracts are not usable providers

An interface milestone cannot satisfy a consumer dependency by itself.
`v0.4.3` implements the mandatory baseline cryptographic provider before source
digests or signatures. `v0.4.4` defines portable time-trust semantics;
`v0.10.2` measures hosted clocks and `v0.30.2` adds network refinement.
Device keystore/spool keys and local PKI precede enrollment and agent spooling;
the connector credential vault precedes the connector host. A provider that
cannot meet the zero-third-party security gate blocks its consumers.

### Activation follows authority and durability

Static control schemas and signed dissemination may precede consensus, but
distributed activation may not. `v0.465.1` activates the distributed control
plane only after the formal model and consensus implementation pass. Likewise,
`DurableQuorum` remains an unadvertised capability until active WAL/hot-batch
replication at `v0.471.0` proves quorum acknowledgement recovery.

Live forensic acquisition begins only after human authentication,
authorization/elevation, and independent audit exist. Earlier forensic work is
limited to protocol, simulator and passive evidence-vault behavior.

### Shared machinery before state-specific HA

The state durability matrix is followed by one replicated operational-state
substrate for conditional writes, journals, fencing, leases, snapshots,
compaction, watches and idempotency. Detection, connector/query, analyst and
action-state HA consume that substrate rather than inventing replication four
times. The matrix includes identity/session, notification, acquisition,
backfill, API-idempotency and audit state as well as the original classes.

The shared substrate is not an unnamed second consensus system. It reuses the
authenticated CFT algorithm in independent sharded groups with separate data,
storage and scheduling. An operational-state fault model and formal refinement
prove conditional-write linearizability, journal ordering, lease/fencing safety,
snapshot installation and watch continuity before the engine is implemented.

### Identity protocols require codecs

TLS and human identity milestones may not hide parser or canonicalization work.
Portable DER/PEM/X.509 precedes TLS. Bounded CBOR/COSE, JOSE/JWK/JWT/OAuth,
XML/namespaces/canonicalization/signature restrictions, and SCIM schema/filter/
pagination stops precede WebAuthn, OIDC, SAML and provisioning respectively.
All are governed by pinned normative fixtures and zero-third-party feasibility.

### Time has no circular trust bootstrap

Portable `TimeTrust`, uncertainty/epoch semantics and signed-time-token
verification follow the crypto provider without requiring a host. Hosted clock
acquisition follows the host-boundary proof. Authenticated network refinement
follows TLS/networking and cannot bootstrap certificate validity from time
learned solely through the same unvalidated connection.

### Administrative authority starts offline

Before federated human login exists, hardware/offline operator signing
identities, quorum/separation policy, recovery/revocation, ceremony transcripts
and audit binding authorize PKI, vault, provisioning and local activation. The
later WebAuthn/OIDC system has a witnessed transition from these principals.

### Durability is a vector

Acknowledgement evidence distinguishes fact, raw-capsule, mapping/provenance,
index and detection progress. `DurableQuorum` never implies raw reconstruction
unless referenced chunks and manifests meet the same quorum failure claim.
Cluster publication preserves the local atomic fact/reference/object invariant.

### Durable work has one scheduler contract

Connector polls, renewal, retention, scrub, compaction, backup, reindex,
retro-hunt, risk recomputation, SLA escalation, scheduled query/report,
playbook wait/compensation and cold rehydration consume one durable local job
and timer scheduler after WAL exists. It distinguishes monotonic deadlines from
trusted wall schedules and defines misfire, catch-up, skip, duplicate,
checkpoint, cancellation, retry, quota, fairness and uncertain-clock behavior.
Stage K adds a fenced HA adapter over the operational-state engine.

### Optional scope closes before implementation freeze

`v0.100.1` makes binding support/non-goal decisions for PCAP, artifact-content
matching, PE/ELF/Mach-O metadata, Windows Event Forwarding, and cloud archive/
message-stream ingestion. Each has a reserved later scope-closure version that
either implements admitted support with full evidence or enforces and documents
the non-goal. AI, regulated cryptographic mode, SDK publication, named providers,
optional drivers, and future Aesynx support retain their own decision gates. No
conditional or “TBD” capability may survive the `v0.730.0` closure audit.

## 3. Engineering Sequence

### Stage A: constitution and portable foundations

Freeze the environmental, dependency, unsafe, publishing, modularity,
evidence, resource-bound, and release laws before product implementation.
Then build checked byte access, identity, time, parser, event, provenance,
cryptographic provider/trust contracts, text/Unicode/IDNA profiles, codec,
policy, and bounded-memory primitives. These crates remain dependency free and
`no_std`, with `alloc` admitted only where a milestone requires it.

The mandatory crypto implementation and trusted-time provider must pass before
any digest, signature, certificate or authenticated capability consumer.
Portable time semantics precede hosted clock acquisition; network refinement is
deferred until authenticated transport exists.

### Stage B: facts and interoperability

Build the canonical fact, entity, relationship, identity-resolution, asset,
exposure, uncertainty, schema, source-capsule, and compatibility-mapping model.
OCSF and OpenTelemetry are boundaries, not the internal source of truth. Every
transformation emits a bounded canonical mapping outcome with exact loss,
policy redaction, reconstruction availability, parser/mapping identity, source
ranges, parent/output digests, and replay requirements.

Before ingestion, establish a local control and authority plane for identities,
trust roots, immutable configuration epochs, registries, authorization
decisions, capability issuance, and security audit events.
An offline/local operator authority contract authenticates early ceremonies and
later transitions into federated human identities.

### Stage C: ingestion and transport

Add bounded local ingestion, file tailing, explicitly profiled syslog, RFC 8259
JSON, authenticated OTLP and OCSF endpoints, a native durable transport,
encrypted spooling, batch acknowledgement, enrollment, secure transport, and
relays. Conservation, acknowledgement truth, source continuity, bounded
overload, and a reserved durable telemetry-gap lane are executable invariants.
UDP and sequence-free sources make explicitly limited continuity claims.

Hosted runtime, TLS/certificate, Protobuf/compression, HTTP/2/gRPC, bounded raw
quarantine, and self-observability substrates land as separate prerequisites.
Device keystore/spool-keying, local PKI and a system-wide deployment/resource/
latency/RPO/RTO contract also land before operational ingestion.
Portable DER/PEM/X.509 precedes TLS. Authenticated network-time refinement
occurs only after transport validates from independent bootstrap trust and
bounded local time.
Historical backfill and quarantine reprocessing preserve original, ingest, and
backfill/reprocess time plus parser/mapping identity.

### Stage D: storage

Implement a capacity model; per-shard hot staging and WAL; exact group-commit
and fsync semantics; immutable generation manifests and snapshot pins;
deterministic pages; primary, security, text, IP and graph indexes; tenant-owned
caches and materialized views; workload scheduling; encryption/integrity;
retention-aware partitioning and compaction; online migration, scrubbing,
repair, disaster reindex, backup, and cold export. No external storage service
is required. Scale gates begin in the storage phase, not only near 1.0.

Raw evidence uses a content-addressed store with atomic fact/reference publish,
explicit deduplication, quarantine lifecycle, retention, and orphan repair.
Single-node backup/restore is implemented before the early storage campaign.
Cold export has catalog, authorization, planning, rehydration, cancellation,
snapshot and partial-availability semantics before VQL claims historical reach.
A shared durable job/timer scheduler lands after WAL and before background
storage work; every later scheduled subsystem consumes it.

### Stage E: VQL query and reasoning

The working query-language name is VQL (Vakaheim Query Language). Build a
bounded lexer/parser, typed AST, normalized IR, authenticated plan capability,
authorization/residency rewrites, non-reorderable security barriers, logical
and physical planning, worst-case admission controls, isolated CPU/I/O pools,
encrypted tenant-scoped spill, single-node execution, bounded joins, temporal
and graph operations, leased live subscriptions, historical perspective, and
authorization-safe completeness explanations.

Physical planning explicitly owns scan/index, join, aggregate, sort/top-k,
spill, partition/rollup, fusion, batch sizing, and stale-statistics fallback.
Stable pagination, set operations, rates/ratios/percentiles/cardinality, and
bounded text/glob/regex/collation equivalence have named operator milestones.

### Stage F: detection

Build signed rule packages, a canonical execution identity, deterministic
fixed-point semantics, bounded IR, stateless and aggregate predicates,
temporal automata, durable quota-controlled state, detection-impairment facts,
immutable findings, placement equivalence, graph and behavioral detection,
threat-intelligence lifecycle, ATT&CK coverage graph, decomposable risk
projection, content import, simulation, shadow deployment, canary rollout, and
automatic quarantine/rollback thresholds.

Behavioral families are separate releases. Entity-risk accumulation and actual
threat-intelligence streaming/retro-hunt matching are explicit stateful engines,
not implied by scoring or intelligence lifecycle governance.
Entity risk emits immutable threshold events/findings; alert routing alone owns
promotion into mutable alerts.

### Stage G: native sensors

Introduce a common unprivileged agent and authenticated bounded IPC before
Linux, Windows, macOS, BSD, Kubernetes, Android, and iOS collection. Collection
and response helpers are small, separate, and never expose a generic command
surface. Parsing, mapping, policy, spool, and networking remain unprivileged.
Every sensor reports bookmarks/cursors, boot/session identity, missing
privileges, provider changes, detachments, kernel/API drop counters, sequence
gaps, clock problems, backpressure, unsupported telemetry, and health loss.

### Stage H: SDK and connectors

Build a private in-workspace SDK first, then an isolated connector host and
contracts for cloud, identity, SaaS, asset/CMDB/vulnerability, TAXII threat
intelligence, flow, DNS, DHCP, VPN, firewall, proxy, email, and IDS inputs.
Connectors retain feed freshness, markings, expiry/revocation, confidence,
source trust, checkpoints, and partial-permission completeness. Adaptive
collection remains bounded, signed, visible, and self-reverting.

The API wire contract and service precede the private network client. Connectors
run in a separately sandboxed host with capability, secret, egress, quota,
lifecycle, upgrade, crash-containment, and revocation ownership. A durable
notification outbox and integrity/source-assurance detection content are
delivered before analyst workflow depends on them.

The initial API covers only already-designed base, query, evidence, finding and
rule surfaces. Case and response extensions ship beside their state machines.
Connector credentials come from a dedicated vault/broker. Productivity,
source-control, ticketing, flow, DNS/DHCP, network-control, email, IDS and
CEF/LEEF providers each receive independent acceptance milestones.
Family milestones are contracts, not vendor support claims. Every named vendor
requires its own patch/intermediate release with schema, cursor, permission,
rate-limit, outage and live interoperability evidence.
The platform credential vault is shared but independently compartmented for
collection, response, PKI and notifications; authority never flows between
compartments implicitly.

The SDK stays unpublished until a dedicated admission milestone. If publication
is later approved, only the SDK uses `MIT OR Apache-2.0`.

### Stage I: analyst product

Build routing, decomposable risk, incident graphs, confidential case
compartments, evidence-access revocation, legal/discovery/export holds,
automated volatile-data acquisition, evidence-vault sealing, reports,
authentication and session federation, RBAC+ABAC, an independently keyed and
replicated audit stream, source assurance, rule studio, analyst UI, and
administration UI. Mutable case state never rewrites immutable evidence.

Forensic acquisition has its own narrow capability, approval, target fencing,
and privileged-agent protocol; it never inherits ordinary collector authority.
The early milestone validates those contracts without live privileged effects;
live activation follows authentication, elevation and independent audit.
Case APIs remain workload/internal until human-session activation. The early
administration UI exposes implemented local features only; cluster and upgrade
surfaces arrive after Stage K.
Saved searches, dashboards and scheduled analytics reports bind snapshot/query/
policy epochs, completeness and recipient authorization before the analyst UI.

### Stage J: extension and response

Build WIT capability worlds, complete component validation, signed transparent
component registry and revocation, an OS-isolated Wasm host, cryptographically
bound action envelopes, typed playbook state, dry-run/simulation, secret and
egress brokers, exact-digest step-up/two-person approvals, forensic pre-capture,
verification, reversible/compensatable/irreversible classification,
compensation, recovery, kill switches, and bounded canary response.

Core Wasm execution and the Component Model Canonical ABI precede the host.
External actions use a transactional outbox/inbox, fenced workers, provider
idempotency ledgers, verification-before-retry, and an explicit unknown-outcome
reconciliation state.

Trigger admission, recursion/cooldown/concurrency controls, per-target
serialization, and global/tenant/provider/playbook/action-class kill switches
precede dispatch. Response providers are split by endpoint, identity, network,
cloud, credential, evidence and ticket/notification family.

### Stage K: cluster and federation

Build immutable signed configuration epochs, fleet management, an explicit CFT
adversary model, formally modeled metadata consensus, data replication, quorum
acknowledgement, repair, rebalancing, disk evacuation, tenant workload/key/
cache/index isolation, federated query, sovereignty, capacity forecasting,
admission and maintenance modes, certificate/key-loss drills, diagnostic
bundles, backup, restore, air-gap bundles, rolling upgrades, and disaster
recovery.

Operational-state HA is implemented by state class, and the distributed
scale/failover campaign occurs only after replication, evacuation, tenancy,
federation, SRE, and disaster mechanisms exist.
Active-write replication owns practical quorum acknowledgements. Distributed
physical query execution owns authenticated fragments, exchanges, shuffle,
partial aggregation, distributed joins/graphs, snapshot coordination,
backpressure, retry, stragglers, worker loss and coordinator/tenant bounds.
Raw chunks/manifests participate in quorum durability and atomic publication.
Independent audit HA uses a separately deployed administrative/storage/scheduler
failure domain, not only different keys in the operational cluster.
Cluster-native service discovery and authenticated routing precede distributed
scale tests and preserves sequence/acknowledgement truth across rerouting.
Tenant lifecycle has local and distributed state machines from proposal through
hold/offboarding/destruction, including suspension propagation and no identifier
or key-domain reuse.

### Stage L: product completion

Add optional audited AI assistance; then implement privacy policy, field/purpose,
residency, retention/deletion and compliance workflow passes separately. Split
performance by endpoint, ingest/storage, query/detection/analyst and cluster;
split verification by fuzz/conformance, formal/concurrency/memory, chaos and
compatibility/reproducibility. Independent assessment preparation, execution,
remediation and retest remain separate stops, as do each beta topology,
operational readiness, option closure, compatibility freeze, artifact freeze,
candidate qualification, the exact release candidate, and unchanged 1.0
promotion. The currently named final stop is not a ceiling; new `v0.N.P` or
`v0.N.0` stops are inserted whenever one pass becomes too broad.

## 4. Planned Workspace Families

Crates are created just in time. The names below are architectural ownership,
not permission to create empty crates prematurely.

| Family | Representative crates | Environment |
| --- | --- | --- |
| Facade | `vakaheim` | `no_std` by default |
| Foundation | `vakaheim-core`, `-bytes`, `-id`, `-time`, `-time-trust`, `-value`, `-policy`, `-crypto-api`, `-crypto-provider`, `-text`, `-asn1` | `no_std`; optional `alloc` |
| Facts | `-event`, `-entity`, `-provenance`, `-integrity`, `-source-capsule` | `no_std`; optional `alloc` |
| Ingestion | `-ingest-core`, `-parser-sdk`, `-syslog`, `-json`, `-protobuf`, `-otlp`, `-ocsf` | core portable; runtimes `std` |
| Platform | `-linux`, `-windows`, `-macos`, `-bsd`, `-android`, `-ios`, `-kubernetes` | isolated `std`/FFI |
| Runtime | `-runtime-core`, `-time-host`, `-scheduler`, OS reactors, channels, HTTP/TLS/PKI/protocol transports, enrollment | mixed explicit boundary |
| Storage | `-storage-format`, `-wal`, `-segment`, `-raw-store`, `-index`, `-retention`, `-backup` | format `no_std`; engine `std` |
| Query | `-query-syntax`, `-ast`, `-ir`, `-typecheck`, `-plan`, `-exec`, `-query-distributed`, `-graph` | front-end `no_std + alloc`; exec `std` |
| Detection | `-rule-model`, `-rule-compiler`, `-detect-core`, `-detect-state`, `-behavior`, `-risk-ledger`, `-intel-match` | core `no_std + alloc`; workers `std` |
| Response | `-wasm-core`, `-wasm-abi`, `-wasm-validate`, `-wasm-host`, `-soar-core`, `-action-ledger`, `-approval` | ABI/core portable; host isolated `std` |
| Identity | `-cbor`, `-cose`, `-jose`, `-oauth`, `-xml`, `-scim`, `-webauthn`, `-identity-federation` | codecs portable; services `std` |
| Control | `-control`, `-auth`, `-authorization`, `-audit`, `-pki`, `-credential-vault`, `-opstate`, `-cluster`, `-federation` | explicit `std` services |
| Analyst | `-finding`, `-incident`, `-case`, `-dashboard`, `-report`, `-scheduled-report`, `-api-model`, `-api-host`, `-sdk`, `-ui-model` | mixed |
| Verification | `-testkit`, fixtures, attack scenarios, fuzz, Kani, Loom, conformance, bench | never product dependencies |

## 5. Product Roles

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

## 6. Test Strategy

Testing is designed with each API, not added after it:

- unit tests for success, boundary, invalid, and state-transition behavior;
- compile checks for `no_std` and supported target families;
- table, property, round-trip, metamorphic, and differential tests;
- negative and adversarial corpora for every untrusted parser;
- checked-in normative protocol fixtures with source version, digest, license,
  positive interoperability, negative conformance, downgrade, malformed, and
  old/new-version cases;
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
- trusted-tester cryptographic attestation and offline verification for every
  permanent passing assessment.

Tests must avoid production dependencies. Test-only utilities are internal
workspace crates or repository scripts.

## 7. Security Workstream

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

## 8. Platform Strategy

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

## 9. Operational Acceptance

The 1.0 acceptance contract includes zero silent loss, bounded overload,
published reference throughput/latency/agent overhead, committed-record
durability under the stated model, rolling upgrades, deterministic rollback,
multi-day endpoint spool, evidence verification, complete recovery tooling,
and honest partial-result/completeness reporting.

Targets are gates supported by reproducible evidence, never marketing claims.

For sources that cannot prove continuity, “zero silent loss” means every loss
observable to Vakaheim becomes durable impairment evidence; it is not a false
claim that UDP, a sequence-free source, or a compromised source cannot lose or
misstate events.

## 10. Definition Of Production 1.0

Version 1.0.0 requires all product planes, all supported platform collectors,
storage/query/detection/case/response/cluster/SDK/UI operation, format and API
stability, production documentation, signed reproducible artifacts, independent
assessment, no unresolved critical or high findings, and unchanged promotion
of an approved release candidate. It also requires local and HA scheduler
evidence, complete tenant lifecycle enforcement, discovery/routing continuity,
scheduled report and dashboard operation, and a closed option-decision register:
no conditional, undecided, or `TBD` 1.0 capability may cross the release freeze.
