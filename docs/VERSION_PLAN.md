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
roadmap or weakening an earlier gate. Neither `v0.500.0` nor any other pre-1.0
version is a numeric ceiling: minor numbers may pass `v0.1000.0`, and 1.0 waits
until the work and evidence are complete.

The sequence remains:

| Range | Context |
| --- | --- |
| `v0.1.0`–`v0.20.9` | early fixture governance, portable/host crypto, split time, text/certificate codecs, operator authority, local tenant lifecycle/control, runtime/TLS, device keys/PKI, encrypted raw persistence, and objectives |
| `v0.22.0`–`v0.40.0` | ingestion conservation, Protobuf/compression, HTTP/gRPC, OTLP/OCSF, authenticated time refinement, secure transport, canonical acknowledgement, historical evidence, claim registry and runtime permit authority, backfill/reprocessing, and hardening |
| `v0.41.0`–`v0.60.0` | storage, isolated scheduler core/store/worker, authority-scoped atomic effect handoff, ledger migration, spent-key replay protection and rollback-anchor assurance, exact index-coverage claims, mixed-version integration, raw evidence, integrity/keys, backup/restore, migration/reindex, and local multi-terabyte proof |
| `v0.65.0`–`v0.100.1` | VQL authority/planning, pre-execution canonical local coverage and authoritative expected-set commitments, operators/cold queries, hardening, and binding admission decisions for optional 1.0 evidence/ingestion capabilities |
| `v0.110.0`–`v0.200.0` | deterministic detection/state, authoritative active-rule-set/cohort commitments and progress acknowledgement, behavior/risk/intelligence, conditional artifact-matching implementation/integration, ATT&CK, interoperability, and rollout |
| `v0.205.0`–`v0.268.0` | agent integrity, native platforms, conditional WEF and per-format executable implementation/integration, Kubernetes, and future Aesynx portability |
| `v0.270.0`–`v0.342.0` | API, compartmented platform vault, isolated connector host, provider contracts, conditional cloud archive/stream and PCAP implementation series, integrity content, and notification substrate |
| `v0.345.0`–`v0.405.0` | transactional alert notifications, analyst workflow, identity/auth, live forensics, dashboards/scheduled reports, authorization/audit, and local UIs |
| `v0.407.0`–`v0.458.0` | Wasm/response, action recovery, node measurement/attestation and optional hardware-monotonic-anchor decisions, server integrity, tenant audit/identifier/pseudonym policy, and all-plane single-node tenant lifecycle conformance |
| `v0.459.0`–`v0.484.1` | expanded state matrix, operational CFT/engine, five-domain-independent and freshness-bounded scheduler witnessing/state HA, cluster acknowledgement extension before quorum activation, tenant/audit propagation, distributed coverage extension/reconciliation, routing/proxy trust, node quarantine, SRE/DR/scale, and cluster administration |
| `v0.485.0`–`v0.520.0` | optional proposal-only AI plus separate privacy-policy, field/purpose, residency, retention/deletion, and compliance-workflow stops |
| `v0.530.0` | approved-cryptographic-mode admission or explicit rejection |
| `v0.540.0`–`v0.570.0` | separate endpoint, ingest/storage, query/detection/analyst, and cluster/recovery performance campaigns |
| `v0.580.0`–`v0.610.0` | separate fuzz/conformance, formal/concurrency/memory, chaos/recovery, and compatibility/reproducibility campaigns |
| `v0.620.0`–`v0.650.0` | independent assessment preparation, execution, remediation, and independent retest |
| `v0.660.0`–`v0.720.0` | SDK decision, topology-specific betas, upgrade beta, operational readiness, and beta remediation |
| `v0.730.0`–`v0.770.0` | option-closure audit, compatibility freeze, artifact freeze, candidate qualification, and feature-complete candidate evidence |
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
- generic fixture provenance/governance exists before the first consumer, with
  later milestones adding protocol-specific sets;
- DER/X.509, CBOR/COSE, JOSE/OAuth, restricted XML/SAML and SCIM have bounded
  codecs before TLS or human identity consumes them;
- cryptography, text, runtime, TLS, raw evidence, transport, API and Wasm
  substrates precede their consumers and each can block the roadmap on an
  unacceptable zero-third-party feasibility result;
- provider contracts never substitute for a usable provider: trusted time,
  baseline crypto, device/spool keys, PKI and connector credentials each have
  concrete lifecycle and failure milestones;
- portable, hosted and authenticated-network time are separate trust stages;
  certificate validation cannot bootstrap from the same unvalidated channel;
- portable scheduler state, journal persistence, hosted dispatch, effect handoff,
  consumer admission and storage CPU/IO scheduling are separate layers; storage
  durability never depends on ordinary scheduler availability, and atomic
  scheduler/outbox handoff uses durable intent, a non-null tenant-or-system
  authority domain, consumer/job/ordinal/stable-logical-ledger key, canonical
  digest, linearizable put-if-absent and validated receipt across recovery and
  mixed versions; a separately fenced routing epoch preserves uniqueness across
  ledger migration, while spent-key commitments plus a hardware/external/
  unverifiable anchor state preserve it after ordinary record retention and old-
  snapshot restore; an external witness shares none of the workload's snapshot/
  restore, storage-failure, administrative, signing-key or consensus/recovery
  domains, and cluster-local consensus never qualifies alone; dispatch binds the
  exact witness digest/epoch/authority and freshness lease within an effect-class
  stale limit; the complete conservative `TimeTrust` interval must fit the lease,
  while quorum-authorized successor records preserve the minimum epoch across
  signer rotation/revocation/compromise; time discontinuity, a revoked/
  compromised permit signer, signer conflict or other unverifiable state disables
  effects, and the epoch cannot advance past any older live effect state;
- storage and query admission are designed for worst-case work and multi-tenant
  isolation before large-scale deployment;
- early storage scale claims are local; cluster node, quorum, evacuation and
  multi-region claims begin only after their Stage K implementations;
- detection execution identity contains every semantic input and never depends
  on ambient state;
- behavior, entity-risk accumulation and threat-intelligence matching have
  separate deterministic state and evidence contracts;
- entity-risk thresholds remain immutable findings until alert routing promotes
  them, and generic notification becomes transactional with alerts only later;
- response approval binds the exact effect plan, with reversible,
  compensatable, and irreversible recovery classes;
- uncertain external effects use durable dispatch and reconciliation rather
  than assuming a timeout means failure or safe retry;
- automation triggers are admitted through cooldown/concurrency/recursion and
  per-target controls with scoped kill switches;
- each mutable operational-state class has its own consistency, fencing,
  replication, RPO and RTO contract instead of being forced through metadata
  consensus;
- operational state formally reuses authenticated CFT in separate sharded groups
  before its engine and state-specific HA are implemented;
- static control dissemination precedes consensus, while the canonical local
  acknowledgement envelope and evidence lifecycle precede batching; distributed
  activation and `DurableQuorum` claims wait for consensus, the cluster envelope
  extension and active-write replication;
- acknowledgement evidence carries separate fact, raw, provenance, index and
  detection progress claims plus request digest; its cluster extension binds
  placement/quorum epoch, and transport replay expiry remains distinct from
  historical signature/trust verification; parseable claim tags remain disabled
  until the fail-closed registry and owning state verifier issue a scoped runtime
  permit; roadmap versions never participate in runtime authorization;
- index progress binds exact fact ranges and index definitions/generations;
  detection progress binds an authoritative active-rule-set commitment, rollout
  cohort and policy epoch, with incomplete/mid-change states kept explicit;
- family connector milestones do not claim vendors; each named provider needs
  its own patch/intermediate interoperability release;
- tenant lifecycle and suspension/destruction propagate across every local and
  distributed authority/data/job/cache/key domain without identifier reuse;
- retained/pseudonymized independent audit evidence, vault remnants,
  notifications and action receipts have separate keys/retention and cannot
  reactivate destroyed tenant authority;
- opaque internal tenant IDs are permanently non-reusable without retaining
  external names; external identifiers, pseudonym rotation/linkage and any
  re-identification authority follow explicit closed policy;
- signed-build, startup, privileged OS and hardware-attested node evidence are
  distinct assurance levels; optional levels close before 1.0 and self-report
  cannot become remote attestation; node/keystore evidence separately states
  whether rollback is prevented, merely detected or unverifiable, and cannot
  promote an ordinary local value to `HardwareMonotonic`;
- epoch-bound cluster admission, anti-rollback and runtime drain/quarantine
  extend software integrity beyond endpoint agents;
- canonical local query coverage precedes the first executor, joins, sets and
  cold tiers; versioned committed sets bind ordering/count, catalog generation/
  root, snapshot, retention/cold watermarks and verifiable membership or a named
  trusted expander; the distributed extension precedes fragment execution and
  reconciliation before `Complete` is emitted;
- native routing binds acknowledgement/coverage manifests end to end, while
  terminating standard-protocol proxies are explicit narrowly scoped TCB;
- cluster safety is authenticated crash-fault tolerance. A compromised voting
  quorum is outside the safety claim and is handled through explicit containment
  and recovery controls, not mislabeled Byzantine tolerance; signatures and
  manifests authenticate a backend claim but do not prove a compromised backend
  truthful.

## Pre-1.0 Decision Closure

`v0.100.1` decides PCAP, artifact-content matching, executable metadata, WEF and
cloud archive/message-stream scope. If admitted, their small implementation
series are `v0.315.1`–`v0.315.5`, `v0.180.1`–`v0.180.3`, `v0.267.1`–`v0.267.5`,
`v0.231.0`–`v0.234.0` and `v0.307.0`–`v0.307.3`; reserved final integration gates
remain `v0.316.0`, `v0.181.0`, `v0.268.0`, `v0.235.0` and `v0.308.0`. Rejected
options skip implementation but still pass the tested non-goal integration gate.
Admitted work may add more intermediate versions rather than enlarge that gate.

Named providers, eBPF/driver surfaces, Aesynx support, Wasm/AI enablement,
privileged OS runtime measurement, hardware remote attestation, hardware/OS
monotonic fence anchoring, regulated cryptographic mode and SDK publication close
through their owning milestones in
[RELEASE_PLAN.md](RELEASE_PLAN.md). Node assurance is decided at `v0.456.0`,
conditionally implemented through `v0.456.4`, and closed at `v0.456.5`.
Post-destruction pseudonym re-identification is permitted or forbidden at
`v0.457.2` and closed at `v0.457.5`; `v0.462.0` closes
Byzantine/compromised-backend truth guarantees as a 1.0 non-goal. `v0.730.0`
rejects every remaining conditional/TBD decision or missing closure.

The `v0.31.3`–`v0.31.4` claim registry/runtime permits, `v0.48.1` and
`v0.140.1`–`v0.140.2` asynchronous coverage contracts, `v0.79.1`–`v0.79.2`
pre-execution coverage, and `v0.44.8`–`v0.44.10` migration/post-retention/
external-witnessed uniqueness are mandatory correctness prerequisites. They are
not option rows and cannot become tested non-goals before 1.0. Five-domain witness
independence, exact-record authorization and freshness/effect-class stale limits
are part of that mandatory baseline, as are conservative `v0.4.4` lease
evaluation and `v0.10.3`-authorized witness-signer succession/compromise rules.
Only per-platform `HardwareMonotonic` support is optional; `v0.456.0` decides it
and `v0.456.5` closes it without weakening `ExternalWitnessed`/`Unverifiable`
behavior.

## Non-Negotiable Boundaries

Every detailed milestone inherits the repository constitution: latest approved
stable Rust (currently pinned to 1.97.1 until a tested update), `no_std`-first
core crates, no source file above 500 lines, no unsafe code by default, no
third-party crates, no crates.io publication, and exact-commit security testing.
The review suggestion to relax the third-party rule was deliberately not
adopted. `v0.10.1` instead requires proof that host and environment boundaries
remain honest and fail closed under that constraint.
