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
- ship signed first-party detections, hunts, dashboards, runbooks and safe
  playbooks, and continuously measure whether they work;
- manage immutable findings, structured alert triage, formal incidents, cases,
  independent obligations, regulatory reports, and chain of custody;
- support formal evidence-bound threat hunts and governed promotion into durable
  detection and incident content;
- run a framework-neutral incident process with signed bounded optional
  ENISA/NIST/NIS2/DORA/GDPR packs and no automatic legal-compliance claim;
- synchronize explicitly governed incident fields with ServiceNow without making
  external availability or state authoritative by default;
- execute capability-limited, approved response actions whose effects are
  classified as reversible, compensatable, or irreversible;
- remain fully useful without external egress while permitting disabled-by-
  default, policy-governed security-data export and standards interoperability;
- monitor AI workloads as security subjects while keeping optional AI assistance
  proposal-only and outside authoritative incident/response decisions;
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
cases, framework activations/assessments/obligations, reports/submissions,
external synchronization, approvals, playbooks, action idempotency, and audit
cursors are production state with different consistency and recovery needs.
`v0.459.0` owns their durability matrix. Separate Stage K milestones implement
fencing, placement, replication, failover, RPO, and RTO without forcing
high-volume operational
state through the metadata-consensus log.

### Formal incident authority and framework packages

An incident graph is an explainable correlation model, not a formal incident
record. `v0.344.1` fixes evidence/finding/alert/incident/case/graph boundaries;
`v0.345.1`–`v0.346.3` implement structured triage, atomic idempotent promotion,
formal incident phases and history-preserving control operations. One incident
has one primary case by default. Merge, split and reopen cannot advance earliest
awareness or an existing obligation deadline.

The base incident process is mandatory and remains usable without legal packs or
external ITSM. `v0.344.2`–`v0.344.6` implement immutable signed manifests, a
bounded deterministic declarative IR, tenant-scoped registry, independent
composition and explicit shadow migration. Packs have no native/I/O/network/
ambient-time authority and preserve `Unknown` outcomes. Default, ENISA, NIS2,
DORA, GDPR and NIST SP 800-61r3 packs are separately versioned at
`v0.360.4`–`v0.360.13`; optional
activation never means their admitted implementation gates may be skipped. The
private authoring tool at `v0.360.11` grants no activation or crates.io authority.
`v0.344.7`, `v0.360.14`–`v0.360.15`, `v0.420.0` and `v0.730.0` close named-
pack, national-profile, authoritative-Wasm and support/compliance claims before
1.0.

### Current standards are versioned product contracts

OCSF, OpenTelemetry semantic conventions, ATT&CK, Sigma, CACAO and OpenC2 are
not timeless labels. Their exact admitted versions, profiles, fixtures, mapping
loss, upgrade windows and deprecation behavior are frozen at their owning
milestones and checked again at candidate qualification. Logs, traces, metrics,
events/profiles and AI workload telemetry remain distinct signals with explicit
correlation evidence; a shared attribute is not proof of common causality.

### The engine and first-party security content are separate products

A correct rule engine with no usable content is not a complete SIEM. The
`v0.336.0`–`v0.336.13` series owns signed offline-capable detections, hunts,
dashboards, investigation runbooks and safe playbooks for every admitted
platform and named source. The `v0.337.0`–`v0.337.6` series separately owns
disposition feedback, controlled miss/precision/recall evidence, adversary
emulation, purple-team validation, tuning debt and recurring effectiveness
checks. Coverage tags never substitute for required telemetry or test evidence.

### Internal completeness and optional portability coexist

Air-gapped and egress-denied deployments retain complete ingest, detection,
hunting, incident and response operation. The `v0.343.0`–`v0.343.6` export
series is disabled by default and requires tenant authority, policy filtering,
explicit destinations, durable cursors, outcome reconciliation and audit. It
provides data ownership and migration paths without making an external service,
data lake or second SIEM part of Vakaheim's correctness boundary.

### AI monitoring is not AI authority

AI workloads are monitored like other high-risk identities and execution
surfaces through cross-signal telemetry and first-party detections. Optional AI
assistance has separate registry, provenance, data-policy, prompt-injection,
grounding, TEVV, drift, local-runtime and external-gateway stops at
`v0.485.0`–`v0.485.14`. It may draft queries, rules, tests, hunts and response
suggestions, but cannot close alerts, declare incidents, determine legal duties
or dispatch effects. Autonomous decision or response authority is a tested 1.0
non-goal.

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
`DurableQuorum` remains an unadvertised capability until the cluster extension
of the canonical acknowledgement envelope passes at `v0.470.1` and active
WAL/hot-batch replication at `v0.471.0` proves quorum acknowledgement recovery.

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
`v0.31.1` defines the portable canonical envelope before `v0.34.0` implements
local durability variants. Each ingestion acknowledgement has a canonical
request/payload digest, source/session/sequence and receipt identity, durability
vector/class, commit position and signer/key epoch. `v0.470.1` adds placement/
quorum epoch, commit index and node-assurance evidence before `v0.471.0` may
advertise `DurableQuorum`; authentication binds the claim but does not make a
compromised backend truthful.

Schema support is not claim activation, and roadmap versions are planning/test
ownership only—not runtime trust inputs. `v0.31.3` owns the fail-closed verifier
registry contract; `v0.31.4` makes every active component require an opaque
`ClaimPermit<Component>` scoped to tenant/source, semantic epochs, covered input,
verifier identity and activation generation. `v0.44.0`, `v0.54.0`,
`v0.48.1`/`v0.50.0`, `v0.140.2` and `v0.471.0` own actual state proof and permit
issuance. The encoder cannot consult milestone labels, accept caller assertions
or let one claim/component imply another.

Asynchronous progress is coverage-bound. `v0.48.1` binds index progress to the
exact fact generation/range, index definition/version/generation and terminal
coverage state. `v0.140.1` commits the authoritative active rule set, policy
epoch and rollout cohort for an input range; `v0.140.2` reconciles one terminal
outcome per required rule. Workers cannot choose a smaller set, and missing,
disabled, shadow/canary or mid-range-changed work stays explicitly non-complete.

Transport replay acceptance and evidentiary validity are separate lifecycles.
`v0.31.2` binds the replay deadline, manifest retention, signed time and
`TimeTrust` uncertainty, signer/key epoch, historical certificate/trust evidence
and revocation-at-signing status. Network expiry does not erase a retained
manifest's historical verifiability; later compromise is represented explicitly
rather than silently rewriting the claim.

### Coverage claims follow a canonical model

`v0.79.1` defines local query result and coverage states before the first
executor, joins, set operators and cold tiers consume them. `v0.79.2` defines
versioned expected-set commitments with canonical ordering, duplicate rejection,
element count, catalog generation/root, snapshot, retention and cold-catalog
watermarks, plus membership/opening verification or a narrowly named trusted
expander. Catalog movement during execution cannot silently change the committed
expected set.
`v0.475.1` extends that proven model to distributed fragments before `v0.476.0`
executes them; `v0.476.1` alone may derive `Complete` after reconciliation.

### Durable work has one scheduler contract

Connector polls, renewal, retention, scrub, compaction, backup, reindex,
retro-hunt, risk recomputation, SLA escalation, scheduled query/report,
playbook wait/compensation and cold rehydration consume one durable local job
and timer contract after WAL exists. The implementation is layered:
`scheduler-core` is a portable effect-free state machine; `scheduler-store`
persists transitions over a narrow journal/WAL interface; `scheduler-worker`
owns hosted claims and dispatch; the storage workload scheduler owns only CPU/IO
priority. WAL sync, storage recovery and emergency compaction never depend on
scheduler-store/workers and ordinary jobs never run on durability threads. The
scheduler journal has separate namespaces, files, queues, reserved space and a
corruption domain from the primary fact WAL even when both reuse WAL primitives.

Every consumer declares job identity, checkpoint, cancellation, misfire,
idempotency, recovery and uncertain-time behavior. Effectful work leaves the
generic scheduler through a durable outbox/UnknownOutcome protocol; blind retry
of external effects is forbidden. Handoff is logically atomic: the job cannot be
`HandedOff` before a durable receipt validates its unique outbox/effect record.
The mechanism is a durable `HandoffIntent` with a canonical `HandoffKey`
containing a non-null authority domain (`Tenant(TenantId)` or
`System(SystemDomainId)`), consumer namespace, job ID, effect ordinal and stable
logical destination-ledger ID, plus canonical request digest and schema version.
There is no ambient/global authority domain: tenant IDs come from internal tenant
authority, while system IDs are registry-issued, purpose-scoped and non-reusable.
The complete key is issued by the admitted scheduler/consumer contract rather
than accepted as an unscoped caller-selected ID. Linearizable outbox
`put_if_absent` and the record/digest/commit-epoch receipt bind that key. A
matching key with a conflicting digest is an integrity incident.

Ledger generation is deliberately outside the uniqueness key. `v0.44.8` owns a
fenced routing epoch that authorizes exactly one generation to accept new keys,
fences old writes before cutover, preserves or authoritatively consults the
deduplication index, and validates receipts against the committed routing epoch.
Intent creation, migration and insertion races recover without letting old and
new generations both accept the same logical handoff key.
Ordinary record retention cannot reset uniqueness. `v0.44.9` replaces deleted
payload/outbox state with a non-identifying spent-key/request commitment for the
maximum journal/backup/restore/delayed-delivery horizon, coordinates GC across
all copies, and maintains a minimum accepted anti-replay epoch after tombstone
expiry. `v0.44.10` labels its rollback assurance as `HardwareMonotonic`,
`ExternalWitnessed` or `Unverifiable`; ordinary files/keystores cannot claim
hardware resistance. `ExternalWitnessed` requires a current authority outside
the workload's snapshot/restore, storage-failure, administrative, signing-key and
consensus/recovery domains; cluster-local consensus alone is only a replicated
anchor. Dispatch binds the exact witness record/epoch/identity/authority class
and signed `TimeTrust` lease, bounded again by each `v0.44.5` effect class's
declared maximum stale/offline interval. The full conservative `v0.4.4` time-
uncertainty interval must fit the signed lease; local time may shorten but never
extend it. `v0.10.3`-authorized signer-successor records bind old/new witness
identities and the current minimum epoch without letting rotation, revocation or
compromise fork/lower the chain. Missing/conflicting/rolled-back/expired evidence,
time discontinuity/uncertainty, a revoked/compromised permit signer or signer
conflict cause historical data to mount read-only and disable every effect until
authorized reconciliation. The epoch
advances only after every registered pending, unknown, compensation,
reconciliation and delayed state below it is terminal/spent; otherwise
tombstones remain. Tenant crypto-shred removes
identifying/payload keys without erasing the minimal replay fence.
Cancellation wins before intent, becomes a request after intent, and cannot erase
uncertainty after outbox commit. Local and HA paths use intent/receipt recovery
across separate stores, not an assumed shared transaction. Mixed-version
journal/outbox compatibility is a separate gate.

### Optional scope closes before implementation freeze

`v0.100.1` makes binding support/non-goal decisions for PCAP, artifact-content
matching, PE/ELF/Mach-O metadata, Windows Event Forwarding, and cloud archive/
message-stream ingestion. An admitted choice uses its planned intermediate
implementation series before the reserved scope-closure gate; a rejected choice
skips implementation but still passes the closure gate's tested non-goal path.
More intermediate versions are added whenever needed—the closure gate may not
hide a large implementation. AI, regulated cryptographic mode, SDK publication,
named providers, optional drivers and future Aesynx support retain their own
decision gates. Privileged OS runtime measurement, hardware remote attestation
and platform `HardwareMonotonic` fence anchoring are decided at `v0.456.0`,
conditionally implemented through `v0.456.4`, and closed at `v0.456.5`.
Rejection preserves mandatory external witnessing; attestation cannot be
replaced by a healthy self-report. Post-destruction audit re-identification is
permitted or forbidden at `v0.457.2` and closed at `v0.457.5`. `v0.462.0` closes
Byzantine/compromised-backend truth guarantees as a 1.0 non-goal. No conditional
or “TBD” capability
may survive `v0.730.0`.

`v0.100.2` makes a second binding decision set for external data-lake query-in-
place, DSPM/EASM, passive OT/ICS monitoring, MSSP hierarchical tenancy and named
national NIS2 profiles. Admitted scope uses the small series ending at
`v0.101.3`, `v0.298.6`, `v0.318.6`, `v0.474.6` or `v0.360.15`; rejected scope
must still pass tested absence, rejection and documentation gates. OT/ICS is
passive by default, and automatic OT response remains outside the 1.0 claim.

Runtime claim permits, exact asynchronous and pre-execution coverage/expected-
set contracts, ledger-migration uniqueness, post-retention handoff replay
fencing, external witnessing and unverifiable fail-closed dispatch are mandatory
correctness work, not optional scope. Only `HardwareMonotonic` support is
conditional; the five-domain-independent witness and freshness baseline cannot
be rejected, disabled or deferred, including conservative lease evaluation and
quorum-authorized signer rotation/compromise handling.

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
Exact current OCSF classes/profiles and OpenTelemetry logs, traces, metrics,
events/profiles and AI workload semantic conventions receive separate model,
endpoint, cross-signal and upgrade stops before support is claimed.

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
Portable scheduler semantics, narrow journal persistence, isolated hosted
workers, effect handoff and consumer admission land after WAL and before
background storage work. Storage durability/recovery remains independently
operable and every later scheduled subsystem consumes the shared contract.

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
An external data-lake query-in-place path exists only if admitted at `v0.100.2`;
it uses explicit foreign-authority, pushdown, cost, coverage and partial-result
contracts and can never make local/internal querying depend on external access.

### Stage F: detection

Build signed rule packages, a canonical execution identity, deterministic
fixed-point semantics, bounded IR, stateless and aggregate predicates,
temporal automata, durable quota-controlled state, detection-impairment facts,
immutable findings, placement equivalence, graph and behavioral detection,
threat-intelligence lifecycle, ATT&CK coverage graph, decomposable risk
projection, content import, simulation, shadow deployment, canary rollout, and
automatic quarantine/rollback thresholds.

ATT&CK Detection Strategies/Analytics and Sigma 2.1 rules, correlations and
filters use pinned versioned models. First-party content then lands in small
platform/source families, followed by a separate continuous-effectiveness
series; neither imported rule compatibility nor a technique mapping proves
detection efficacy.

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
The committed 1.0 set has independent stops for AWS, Azure/Entra, GCP, Okta,
Google Workspace, Microsoft 365, Slack, GitHub, GitLab, PAN-OS, FortiGate,
Zscaler, Defender for Office 365, Proofpoint, Defender for Endpoint and
CrowdStrike, in addition to ServiceNow. A governed onboarding lifecycle covers
safe sampling, parser/mapping lineage, schema drift, shadow replay, volume/
cardinality/cost, permission completeness, canary activation and rollback.
DSPM/EASM and passive OT/ICS source families exist only if admitted by their
pre-1.0 decisions and must pass their own protocol/safety boundaries.
ServiceNow is the first named ticketing provider: `v0.305.2` owns its transport,
authentication/schema/capability profile; `v0.453.3` activates approved typed
writes; `v0.453.4` owns bidirectional polling/webhook reconciliation, loop
prevention, explicit field authority and unknown outcomes. Internal incident
handling remains available and authoritative by default through every external
outage or synchronization conflict.
The platform credential vault is shared but independently compartmented for
collection, response, PKI and notifications; authority never flows between
compartments implicitly.

The SDK stays unpublished until a dedicated admission milestone. If publication
is later approved, only the SDK uses `MIT OR Apache-2.0`.

### Stage I: analyst product

Build framework-neutral alert routing and triage, atomic promotion, a formal
incident lifecycle, separately bound incident graphs, a primary case workspace,
confidential compartments, evidence-access revocation, legal/discovery/export
holds, framework assessments/obligations, report/submission receipts, automated
volatile-data acquisition, evidence-vault sealing, authentication/session
federation, RBAC+ABAC, an independently keyed audit stream, source assurance,
rule studio, analyst UI, and administration UI. Mutable workflow state never
rewrites immutable evidence or source timestamps.

Every terminal alert has a structured disposition or stable incident reference.
The default pack supplies native states, severity, assignment, escalation,
closure and post-analysis without claiming compliance. Other packs create
independent assessments and deadlines; they cannot collapse obligations, weaken
core invariants, access unauthorized evidence or block base handling. Regulatory
reports bind exact package/input/payload digests and a receipt or explicit
unknown outcome. Closure validates structured impact/root-cause/recovery/
lessons/corrective-action/obligation fields or records an authorized exception.

Forensic acquisition has its own narrow capability, approval, target fencing,
and privileged-agent protocol; it never inherits ordinary collector authority.
The early milestone validates those contracts without live privileged effects;
live activation follows authentication, elevation and independent audit.
Case APIs remain workload/internal until human-session activation. The early
administration UI exposes implemented local features only; cluster and upgrade
surfaces arrive after Stage K.
Saved searches, dashboards and scheduled analytics reports bind snapshot/query/
policy epochs, completeness and recipient authorization before the analyst UI.
Formal hunts bind hypothesis, scope, snapshot, queries, expected coverage and
evidence; support collaboration and recurrence; and promote idempotently into
rules, findings, incidents and signed content. SOC metrics define timestamp,
population, censoring and incomplete-data semantics before measuring alert
quality/workload, incident response or corrective-action outcomes. Optional
security-data export has dedicated governance and UI and remains disabled by
default.

### Stage J: extension and response

Build WIT capability worlds, complete component validation, signed transparent
component registry and revocation, an OS-isolated Wasm host, cryptographically
bound action envelopes, typed playbook state, dry-run/simulation, secret and
egress brokers, exact-digest step-up/two-person approvals, forensic pre-capture,
verification, reversible/compensatable/irreversible classification,
compensation, recovery, kill switches, and bounded canary response.

Core Wasm execution and the Component Model Canonical ABI precede the host.
Read-only Wasm may suggest or format, but only the bounded declarative framework
IR may make authoritative applicability, classification, obligation, deadline or
reporting decisions for 1.0.
CACAO 2.0 import/export and OpenC2 2.0 translation are interoperability layers
over this native authority model. Semantic loss, approval, exact effect identity,
idempotency and unknown outcomes remain explicit; an imported playbook or
command cannot bypass Vakaheim policy.
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
Framework activation/binding, assessment, obligation/deadline, report/submission
and external synchronization journals receive separate `v0.468.1`–`v0.468.2`
HA contracts. Export receives `v0.468.3`; hunt, content, effectiveness and SOC-
metric state receive `v0.468.4`; admitted MSSP tenancy closes at `v0.474.6`.
Failover cannot change a deterministic assessment, move a deadline
forward, duplicate a submission/ServiceNow action, erase a conflict or convert
an unknown external outcome into success.
The replicated scheduler fence lives outside workload snapshots and is witnessed
by an audit/operator authority outside the workload's snapshot/restore, storage,
administration, signing-key and consensus/recovery domains. The operational
anchor group never qualifies as external merely because it uses consensus.
Exact-record witness permits carry signed `TimeTrust` leases and effect-class
offline/stale limits declared at `v0.44.5`; the complete `v0.4.4` uncertainty
interval must prove validity. Quorum-authorized successor records preserve the
minimum epoch across signer rotation/revocation/compromise, and unresolved old/
new signer conflict fails closed. Backup, whole-cluster restore and air-gap
bundles can never lower the fence; expired/stale/missing/conflicting evidence
yields read-only `Unverifiable` recovery until an authorized reconciliation
ceremony.
The canonical local acknowledgement envelope and historical verification
lifecycle precede batching; its cluster extension precedes active-write
replication and owns practical quorum acknowledgements. The local query coverage
model and authoritative expected-set commitment precede joins, set operations
and cold queries. Distributed coverage extends that model before distributed
physical query execution owns authenticated fragments, exchanges, shuffle,
partial aggregation, distributed joins/graphs, snapshot coordination,
backpressure, retry, stragglers, worker loss and coordinator/tenant bounds.
Canonical result/coverage manifests bind query/plan, tenant/auth/policy/snapshot,
expected shard/partition/segment commitments, every fragment terminal status,
result/aggregate/checkpoint digests, signer/key and node-assurance evidence.
`Complete` requires post-execution reconciliation of every expected element;
physical execution emits only pending or explicit non-complete states until that
gate passes. Other outcomes are explicitly `Partial`, `Unavailable`, `Truncated`
or `PolicyLimited`.
Raw chunks/manifests participate in quorum durability and atomic publication.
Independent audit HA uses a separately deployed administrative/storage/scheduler
failure domain, not only different keys in the operational cluster.
Before clustering, node assurance distinguishes signed-build verification,
startup measurement, privileged OS evidence, hardware remote attestation and
`Unverifiable`; software self-report never implies the stronger levels. Optional
levels receive binding support/non-goal closure. Signed server builds,
anti-rollback and an all-plane single-node tenant lifecycle gate must pass.
Fence-anchor assurance is a separate dimension: only admitted counter evidence
or an independent witness can authorize effect dispatch; node health, measured
boot and ordinary keystore state cannot silently upgrade it.
Control epochs admit exact build identities and required assurance; unknown,
revoked or under-assured nodes are rejected, and later drift/unverifiable state
causes policy-driven authenticated drain or quarantine.
Cluster-native service discovery and authenticated routing precede distributed
scale tests and preserve sequence/acknowledgement truth across rerouting. The
first routing stop is in-region and reports regional endpoint exhaustion as
unavailable; only the following multi-region milestone may authorize and fence
cross-region routing/failover.
Native routing binds backend durability acknowledgements, source/session/
sequence identity, query snapshot/policy epochs, response completeness and
backend service/build identity end to end. When OTLP/browser trust terminates at
a proxy, that proxy is an explicit narrowly identified member of the protocol's
trusted computing base and cannot widen capability or launder backend failure.
Tenant lifecycle has local and distributed state machines from proposal through
hold/offboarding/destruction, including suspension propagation and no identifier
or key-domain reuse. Independently retained audit evidence and external receipts
use separate keys, minimized/pseudonymized identity and statutory/hold policy;
they can never reactivate tenant authority. Opaque internal IDs remain permanent
non-reusable tombstones without identifying fields. Human/external identifiers
may be reassigned only by explicit policy to a new internal/key domain, while
pseudonym stability, linkage-key expiry and any re-identification authority are
closed before all-plane lifecycle testing.

### Stage L: product completion

Add AI workload detection and optional audited proposal-only assistance; then
implement privacy policy, field/purpose,
residency, retention/deletion and compliance workflow passes separately. Split
performance by endpoint, ingest/storage, query/detection/analyst and cluster;
split verification by fuzz/conformance, formal/concurrency/memory, chaos and
compatibility/reproducibility. Independent assessment preparation, execution,
remediation and retest remain separate stops, as do each beta topology,
operational readiness, option closure, compatibility freeze, artifact freeze,
candidate qualification, the exact release candidate, and unchanged 1.0
promotion. The currently named final stop is not a ceiling; new `v0.N.P` or
`v0.N.0` stops are inserted whenever one pass becomes too broad.
Framework legal/guidance sources, named-provider matrices, pack decisions and
non-compliance limitations are re-audited at option closure and candidate
qualification; mutable law/provider behavior cannot be assumed current merely
because an old package remains cryptographically valid.

## 4. Planned Workspace Families

Crates are created just in time. The names below are architectural ownership,
not permission to create empty crates prematurely.

| Family | Representative crates | Environment |
| --- | --- | --- |
| Facade | `vakaheim` | `no_std` by default |
| Foundation | `vakaheim-core`, `-bytes`, `-id`, `-time`, `-time-trust`, `-value`, `-policy`, `-crypto-api`, `-crypto-provider`, `-text`, `-asn1` | `no_std`; optional `alloc` |
| Facts | `-event`, `-entity`, `-provenance`, `-integrity`, `-source-capsule` | `no_std`; optional `alloc` |
| Ingestion | `-ingest-core`, `-ack-manifest`, `-parser-sdk`, `-syslog`, `-json`, `-protobuf`, `-otlp`, `-ocsf` | core/manifest/claim registry and permits portable; runtimes `std` |
| Platform | `-linux`, `-windows`, `-macos`, `-bsd`, `-android`, `-ios`, `-kubernetes` | isolated `std`/FFI |
| Runtime | `-runtime-core`, `-time-host`, `-scheduler-core`, `-scheduler-store`, `-scheduler-worker`, `-handoff-core`, OS reactors, channels, HTTP/TLS/PKI/protocol transports, enrollment | core/handoff identity `no_std`; hosted stores/workers explicit `std` |
| Storage | `-storage-format`, `-wal`, `-segment`, `-raw-store`, `-index`, `-retention`, `-backup`, `-work-scheduler` | format `no_std`; engine `std` |
| Query | `-query-syntax`, `-ast`, `-ir`, `-typecheck`, `-plan`, `-exec`, `-query-coverage`, `-query-distributed`, `-graph` | front-end/manifests `no_std + alloc`; exec `std` |
| Detection | `-rule-model`, `-rule-compiler`, `-detect-core`, `-detect-state`, `-behavior`, `-risk-ledger`, `-intel-match` | core `no_std + alloc`; workers `std` |
| Content and hunting | `-content-core`, `-content-package`, `-content-registry`, `-effectiveness`, `-hunt` | models/packages `no_std + alloc`; validation and execution hosted `std` |
| Standards interop | `-attack`, `-sigma`, `-cacao`, `-openc2`, plus ingestion `-ocsf` and `-otlp` | models/codecs portable; hosted adapters explicit `std` |
| Export | `-export-core`, `-export-policy`, `-export-host` | policy/envelopes portable; destinations and scheduling hosted `std` |
| Response | `-wasm-core`, `-wasm-abi`, `-wasm-validate`, `-wasm-host`, `-soar-core`, `-action-ledger`, `-approval` | ABI/core portable; host isolated `std` |
| Identity | `-cbor`, `-cose`, `-jose`, `-oauth`, `-xml`, `-scim`, `-webauthn`, `-identity-federation` | codecs portable; services `std` |
| Control | `-control`, `-auth`, `-authorization`, `-audit`, `-tenant-id`, `-audit-pseudonym`, `-pki`, `-credential-vault`, `-node-integrity`, `-attestation`, `-opstate`, `-cluster`, `-federation` | portable identity/policy; explicit `std` services |
| Framework | `-framework-core`, `-framework-package`, `-framework-registry`, `-obligation`, `-regulatory-report`, `-framework-sdk` | core/package/evaluator `no_std + alloc`; registry/tools hosted `std`; private only |
| Analyst | `-finding`, `-alert`, `-incident`, `-case`, `-external-link`, `-dashboard`, `-report`, `-scheduled-report`, `-api-model`, `-api-host`, `-sdk`, `-ui-model` | mixed |
| AI security | `-ai-telemetry`, `-ai-policy`, `-ai-provenance`, optional `-ai-host`, `-ai-gateway` | telemetry/policy models portable; runtimes isolated hosted `std` |
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
- incident node: alert triage, formal incident/case/graph state, framework
  assessments, obligations, reports and external links;
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
- first-party content provenance/revocation/rollback, controlled miss/precision/
  recall corpora, adversary emulation and recurring detection validation;
- formal hunt snapshot/coverage/replay/promotion tests and SOC-metric population,
  timestamp, censoring and incomplete-data tests;
- named-provider source-onboarding drift, permission, cost, outage, cursor,
  canary/rollback and live-interoperability suites;
- export policy, cursor, duplicate, interruption, reconciliation, HA and re-import
  tests, including complete operation with every egress path disabled;
- AI workload attack scenarios plus assistance prompt-injection, exfiltration,
  provenance, grounding, TEVV, drift and no-authority tests;
- framework package canonical/conformance/negative corpora, legal-source review,
  historical shadow replay and obligation/deadline time-uncertainty models;
- alert/incident/case/report/external-sync state machines and unknown-outcome
  conservation across crash, retry, failover and provider outage;
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
It requires current pinned OCSF/OpenTelemetry/ATT&CK/Sigma support, cross-signal
telemetry, the committed named-provider set, governed source onboarding, signed
first-party content, formal hunts, continuous detection-effectiveness evidence,
SOC metrics and disabled-by-default security-data export with air-gap-safe
internal operation. CACAO/OpenC2 interoperability cannot weaken native authority.
AI workloads are monitored; optional assistance remains proposal-only,
provenance-bound and incapable of authoritative workflow or response effects.
It requires the framework-neutral default workflow, admitted signed pack set,
structured alert/incident/closure semantics, exact obligation clocks, report
payload/receipt evidence, ServiceNow conflict-safe synchronization and their HA
state. Optional pack activation, external outage or package failure cannot stop
internal triage/containment/evidence; no package or generated report is itself a
legal-compliance claim.
Every server/node build is signed, measured, anti-rollback protected and bound to
an admitted control epoch; evidence states its exact assurance level, unavailable
or untrusted measurement is `Unverifiable`, and optional attestation is either
implemented within admitted bounds or an explicit tested non-goal. Tenant
destruction leaves only policy-permitted independently keyed audit/remnant
evidence with no authority; internal/external/pseudonym linkage semantics are
closed; canonical acknowledgement/query coverage manifests exist; and proxy/
backend trust termini are protocol-explicit without a Byzantine-truth claim.
