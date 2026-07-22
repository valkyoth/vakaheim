# Vakaheim Release Plan To 1.0

Status: planning document

This is the canonical version plan. Vakaheim is security-sensitive evidence
infrastructure, so every milestone is intentionally small enough to review,
test, pentest, and stop cleanly. Split a milestone or add a patch release when
its scope no longer fits one safe implementation pass.

Tags use:

```text
v0.N.0      milestone release; N has no upper bound
v0.N.P      tightly scoped correction or hardening release
v1.0.0-rc.N exact production candidate
v1.0.0      unchanged promotion of the approved candidate
```

Pre-1.0 numbering has no ceiling. `v0.500.0`, `v0.1000.0`, and higher minor
numbers are ordinary review stops; only completed production evidence permits
the move to `v1.0.0-rc.N`.

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
| Normative fixture governance precedes every parser/crypto/text consumer | `v0.1.1`, expanded at `v0.20.1` and each protocol milestone |
| Crypto provider, split time, certificate codecs, host/OS adapters/TLS, device keys, PKI and operator authority | `v0.4.1`–`v0.4.5`, `v0.10.1`–`v0.10.4`, `v0.20.2`–`v0.20.9`, `v0.30.2` |
| Fact conflicts, schema ownership, extension governance, and mapping loss | `v0.11.0`, `v0.15.0`, `v0.16.0`, `v0.20.1` |
| Deterministic identity resolution, asset inventory, ownership, exposure, and retirement | `v0.13.0`, `v0.298.0` |
| Local identities/control/authorization plus complete tenant lifecycle before consumers | `v0.17.0`, `v0.17.1`, `v0.19.0`; audit/remnant policy at `v0.457.1`; all-plane single-node gate at `v0.458.0`; independent audit at `v0.467.3`; distributed closure at `v0.474.1` |
| Conservation, acknowledgement truth, raw quarantine, continuity, overload, backfill/reprocessing, and impairment lane | `v0.20.4`, `v0.22.0`, `v0.31.0`, `v0.39.0`, `v0.40.0` |
| Exact external protocol and identity-codec profiles | `v0.20.1`, `v0.26.0`–`v0.30.2`, `v0.306.0`, `v0.392.0`–`v0.395.0`, `v0.407.0`–`v0.410.0` |
| Database capacity, raw evidence, integrity/encryption/keys, local backup/restore, migration, and scoped early scale | `v0.41.0` through `v0.60.0`, especially `v0.53.0`–`v0.58.0` |
| Layered durable local and HA jobs/timers with atomic effect handoff, upgrade compatibility, consumer admission, declared time, retry, fencing and idempotency | `v0.44.1`–`v0.44.7`, consumer matrix, `v0.459.0`, `v0.467.4` |
| Query authority/planning/operators, cold rehydration, side channels, federation and distributed execution | `v0.72.0`–`v0.100.0`, `v0.475.0`, `v0.476.0` |
| Detection identity/state/placement, split behavior families, entity risk, intelligence lifecycle/matching, ATT&CK | `v0.115.0`–`v0.200.0`, especially `v0.170.0`–`v0.179.0` |
| Common agent/helper boundary, signed software integrity/self-protection and platform continuity | `v0.205.0` through `v0.267.5`, especially `v0.206.0` |
| Base API before client, later case/response extensions, credential vault, connector isolation and split provider profiles | `v0.270.0`–`v0.342.0`, `v0.376.0`, `v0.450.1` |
| Simulated/live forensics, confidential cases, auth/audit, dashboards/scheduled reports and split UIs | `v0.382.0`–`v0.405.0`, especially `v0.400.0`, `v0.402.0` |
| Wasm, bound actions, storm/kill controls, unknown outcomes, split providers, and recovery | `v0.407.0` through `v0.455.0`, especially `v0.446.0`–`v0.453.2` |
| Honest node measurement assurance, optional attestation closure, signed builds, admission, anti-rollback and runtime quarantine | `v0.456.0`–`v0.457.0`, `v0.460.0`, `v0.465.1`, `v0.483.0`, `v0.483.1` |
| State CFT/HA, raw quorum, tenant propagation, distributed query, discovery/routing/proxy trust, SRE/DR/scale/admin | `v0.459.0` through `v0.484.1`, especially `v0.465.1`–`v0.479.1` |
| Regulated cryptographic-mode claims require an applicable validated boundary or explicit rejection | `v0.530.0` |
| Every optional 1.0 capability has a binding decision and implementation-or-non-goal closure | `v0.100.1`, reserved closures, audited at `v0.730.0` |

## Provider Claim Admission

A family milestone defines shared schema, cursor, permission, rate, outage and
conformance contracts; it does not create a vendor support claim. Every named
product/provider requires its own later patch or intermediate release before the
next phase gate, with:

- exact product/service/API versions and enabled source/action surfaces;
- independent schema-drift, cursor/checkpoint, permission, rate-limit, outage,
  retention and completeness evidence;
- `v0.44.5` polling/token-renewal profile when the provider performs scheduled
  work; webhooks alone do not create an implicit polling loop;
- pinned/live interoperability, upgrade/rollback, secrets/egress and pentest
  evidence on the exact release commit.

The first such releases use the next available patch numbers under the owning
family (`v0.304.P` for productivity, `v0.305.P` for source control, and
`v0.310.P` through `v0.315.P` for network/security families). A separate
ticketing provider series is assigned when the first named provider is selected.
Unallocated patch numbers are reservations, not planned support or publication
authority.

## Scheduler Consumer Admission Matrix

`v0.44.5` requires every persistent timer/job consumer to declare job identity,
checkpoint, cancellation, misfire/catch-up/skip, idempotency, recovery and
uncertain-time behavior. Externally visible effects additionally use `v0.44.4`
and its `v0.44.7` compatibility gate; the generic scheduler never owns blind
effect retries.

| Consumer | Integration owner |
| --- | --- |
| Key, certificate, revocation and trust renewal | `v0.44.6` |
| Storage CPU/IO priority; recovery and emergency work | `v0.45.0` remains independent of scheduler availability |
| Scrub, repair/reindex, backup, retention and compaction | `v0.57.0`, `v0.57.1`, `v0.60.0` |
| Cold catalog retrieval and rehydration | `v0.86.0` |
| Rule rollout, entity-risk recompute and intelligence retro-hunt | `v0.190.0`, `v0.176.0`, `v0.179.0` |
| Connector polling and credential/token renewal | `v0.290.0` plus every named provider admission |
| Alert escalation and SLA timers | `v0.345.0` |
| Scheduled queries, reports and governed delivery | `v0.402.0` |
| Playbook waits and delayed compensation | `v0.430.0`; effects continue through later action ledgers |

The owning milestone fails if it creates a private persistent scheduler or omits
its conformance profile.

## Pre-1.0 Option Decision Register

Every option closes before the release-candidate freeze. “Support” requires its
implementation, tests, documentation and pentest before `v0.730.0`; “non-goal”
requires an explicit boundary, rejection behavior and documentation. No decision
may be deferred to 1.0.

| Option | Binding decision/closure |
| --- | --- |
| PCAP acquisition and packet evidence | Decide at `v0.100.1`; if admitted implement `v0.315.1`–`v0.315.5`; close at `v0.316.0` |
| YARA-compatible or other artifact-content matching | Decide at `v0.100.1`; if admitted implement `v0.180.1`–`v0.180.3`; close at `v0.181.0` |
| PE/ELF/Mach-O metadata and signature extraction | Decide at `v0.100.1`; if admitted implement `v0.267.1`–`v0.267.5`; close at `v0.268.0` |
| Remote Windows Event Forwarding | Decide at `v0.100.1`; if admitted implement `v0.231.0`–`v0.234.0`; close at `v0.235.0` |
| Cloud object/archive and message-stream ingestion | Decide at `v0.100.1`; if admitted implement `v0.307.0`–`v0.307.3`; close at `v0.308.0` |
| Named connector/action providers | One provider-admission release per claim before its phase security gate |
| eBPF and any Windows driver | `v0.220.0`/`v0.240.0` decide admitted surface and preserve tested no-driver fallbacks |
| Aesynx 1.0 support | `v0.267.0` closes as future portability only unless a later explicit implementation stop is inserted |
| Optional Wasm extensions and proposal-only AI | `v0.420.0` and `v0.485.0` prove complete disable paths |
| Privileged/OS-backed runtime measurement | Decide at `v0.456.0`; if admitted implement `v0.456.2`; close at `v0.456.5` |
| Hardware measured boot and remote attestation | Decide at `v0.456.0`; if admitted implement `v0.456.3`–`v0.456.4`; close at `v0.456.5` |
| Regulated cryptographic operating mode | Admit or reject at `v0.530.0` |
| Public SDK publication | Admit or reject at `v0.660.0`; all other crates remain private |

`v0.730.0` audits this register and fails if any row remains conditional, lacks
its closure evidence, or silently changes the 1.0 product claim.

Conditional implementation-series milestones execute only when their owning
decision (`v0.100.1` or `v0.456.0`) admits that capability. Rejection skips their
implementation work but never the reserved final closure, which must enforce and
test the non-goal. If an admitted series still exceeds one safe pass, add more
intermediate versions; the listed closure remains an integration/security gate,
never a container for hidden work.

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

### v0.1.1 — Normative Fixture Governance Constitution

Status: planned

Goal: govern external standards and generated fixtures before the first parser,
crypto or text milestone consumes them.

Deliverables:

- normative source/revision/retrieval/license/digest/provenance manifest schema;
- positive interoperability, negative conformance, malformed, downgrade and
  old/new-version fixture classes;
- offline deterministic use, network freshness separation, update/review and
  generated-data reproducibility rules.

Verification:

- reject unpinned “latest,” missing license/source/digest and silent fixture
  replacement;
- source/fixture/generated-data drift and offline-suite reproducibility;
- bootstrap fixture sets for checked bytes, crypto, time, Unicode and X.509.

Exit criteria: every later external standard or generated table extends one
reviewed fixture-governance contract. `v0.1.1 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.4.3 — Mandatory Baseline Cryptographic Provider

Status: planned

Goal: deliver a usable mandatory provider before any digest, signature or
authenticated configuration consumer.

Deliverables:

- pinned baseline hash, MAC, signature, AEAD, KDF and CSPRNG implementations;
- opaque key objects, import/generation/use/destruction policy, domain separation,
  constant-time handling and documented zeroization limits;
- portable first-party implementation only; OS-backed adapters are prohibited
  until the host-boundary proof and `v0.10.4`;
- blocking zero-third-party feasibility decision.

Verification:

- official known-answer/Monte Carlo where applicable, negative and misuse tests;
- cross-provider/cross-platform equivalence, invalid keys/nonces, entropy failure,
  downgrade and algorithm-confusion attacks;
- timing-oriented review, secret debug/clone/serialization rejection and forced
  provider-unavailable behavior.

Exit criteria: every early cryptographic consumer can use one tested mandatory
profile, or the roadmap stops before that consumer. `v0.4.3 implementation stop
reached. Run pentest for this exact commit.`

### v0.4.4 — Portable TimeTrust And Signed Time Tokens

Status: planned

Goal: define portable time trust without requiring host clocks or networking.

Deliverables:

- `TimeTrust` states, uncertainty bounds, source identity and mapping epochs;
- signed-time-token format/verifier using the mandatory crypto provider;
- certificate/token/lease/retention behavior for trusted, bounded-uncertain,
  rollback-suspected and unavailable time.

Verification:

- canonical token, signature, replay, rollback, expiry and source-conflict tests;
- uncertainty-bound arithmetic and deterministic state transitions;
- certificate, capability, retention and ordering consumers fail safely at each
  trust state.

Exit criteria: no security decision treats an unmeasured wall clock as trusted.
`v0.4.4 implementation stop reached. Run pentest for this exact commit.`

### v0.4.5 — ASN.1, DER, PEM And X.509 Substrate

Status: planned

Goal: validate certificate material before TLS or PKI depends on hidden codecs.

Deliverables:

- bounded ASN.1 DER decoder/encoder, PEM armor and exact-consumption rules;
- X.509 certificate, extension, name, constraint, key and status-object model;
- canonical signature-input extraction, unknown-critical-extension behavior and
  no-third-party feasibility record.

Verification:

- pinned DER/X.509/PEM conformance, malformed length/tag/nesting/string/time and
  duplicate/unknown extension corpus;
- certificate/path/name/constraint/status differential fixtures;
- fuzzing, allocation/depth/work caps and signature-wrapping/ambiguity attacks.

Exit criteria: TLS and PKI consume one bounded certificate codec and reject
ambiguous or unsupported critical semantics. `v0.4.5 implementation stop
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

### v0.10.2 — Hosted Clock Acquisition

Status: planned

Goal: acquire host time and uncertainty only after the host-boundary proof.

Deliverables:

- narrow OS monotonic/wall-clock providers for supported host families;
- boot/suspend/resume/rollback/leap/drift detection and monotonic-wall mapping;
- conversion into portable `TimeTrust` evidence without claiming network
  authentication.

Verification:

- wall jump/rollback, leap, suspend/resume, monotonic discontinuity, provider
  failure and prolonged offline operation;
- Linux, Windows, macOS and BSD conformance;
- host errors or uncertainty cannot become trusted time silently.

Exit criteria: hosted consumers receive measured local time trust through the
approved boundary. `v0.10.2 implementation stop reached. Run pentest for this
exact commit.`

### v0.10.3 — Offline And Local Operator Authority

Status: planned

Goal: authenticate security ceremonies before WebAuthn or federated human
identity is available.

Deliverables:

- hardware/offline operator signing identities and local bootstrap principals;
- operation-specific quorum/separation-of-duty, recovery and revocation policy;
- signed ceremony transcripts, audit binding and witnessed transition contract
  into later WebAuthn/OIDC identities.

Verification:

- lost/compromised/revoked signer, quorum substitution, self-approval, replay,
  transcript omission and recovery ceremony;
- PKI, credential-vault, connector-provisioning and configuration-activation
  authorization fixtures;
- later identity transition cannot silently expand bootstrap authority.

Exit criteria: every early privileged ceremony has concrete authenticated
principals, quorum and recovery evidence. `v0.10.3 implementation stop reached.
Run pentest for this exact commit.`

### v0.10.4 — OS Cryptographic Provider Adapters

Status: planned

Goal: admit hosted cryptographic adapters only after the host boundary is proven.

Deliverables:

- narrow Linux, Windows, macOS and BSD provider adapters where approved services
  expose the `v0.4.1` contract;
- key-object/algorithm/error/entropy semantics equivalent to `v0.4.3`;
- capability discovery, provider identity and fail-closed portable fallback or
  explicit unavailability.

Verification:

- cross-provider known-answer and misuse equivalence;
- unavailable/disabled/partially compliant OS service, downgrade, key-handle and
  error-mapping attacks;
- no host adapter leaks into portable dependency graphs.

Exit criteria: hosted providers preserve mandatory semantics and cannot silently
substitute weaker behavior. `v0.10.4 implementation stop reached. Run pentest for
this exact commit.`

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

### v0.17.1 — Local Tenant Lifecycle And Provisioning

Status: planned

Goal: own tenant creation through irreversible destruction before ingestion or
authorization assumes an active tenant.

Deliverables:

- proposed/provisioning/active/suspended/read-only/quarantined/offboarding/held/
  destroyed state machine;
- namespace, key domain, quota, residency, retention, operator and initial policy
  provisioning with non-reusable tenant identity;
- suspension propagation contract for sessions, agents, connectors, queries,
  jobs, actions, caches and API tokens;
- hold/export/offboarding precedence, crypto-shred/deletion proof and recovery
  rules that cannot revive suspended or destroyed authority;
- destruction distinguishes tenant authority/data from independently retained
  security-audit evidence; exact residue policy is integrated at `v0.457.1`.

Verification:

- exhaustive state transitions, concurrent suspend/hold/offboard/destroy,
  provisioning rollback and partial failure;
- tenant/key-domain reuse, stale token/agent/job/cache and restore/resurrection;
- deletion-proof coverage across local evidence, raw data, cold data, backups,
  spill and operational state interfaces.

Exit criteria: no tenant resource or authority exists outside an explicit
lifecycle state, and destroyed identity/key domains are never reused. `v0.17.1
implementation stop reached. Run pentest for this exact commit.`

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

### v0.20.1 — Protocol And Identity Fixture Expansion

Status: planned

Goal: extend `v0.1.1` with the protocols and identity standards selected before
network ingestion.

Deliverables:

- checked-in fixture manifest with normative source, version/revision, digest,
  retrieval date, license and local provenance under `v0.1.1`;
- positive interoperability, negative conformance, downgrade, malformed and
  old/new-version fixture classes;
- pinned profiles for syslog RFCs, RFC 8259 JSON, OTLP, OCSF schema snapshots,
  STIX/TAXII, ASN.1/DER/PEM/X.509, CBOR/COSE, JOSE/OAuth/OIDC, XML/SAML,
  SCIM and later Component Model/WIT inputs.

Verification:

- fixture digest/license/source drift and unsupported-version checks;
- offline deterministic suite plus explicitly separate network freshness check;
- no behavior bound to an unpinned “latest” standard or schema.

Exit criteria: selected protocol/identity fixture sets extend the early contract
and every consumer uses pinned normative evidence. `v0.20.1 implementation stop
reached. Run pentest for this exact commit.`

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
- `v0.4.5` X.509 name/path/purpose/time validation, trust stores, revocation hooks,
  session resumption and key-update policy;
- bootstrap-time policy using bounded local/offline trust; certificate validity
  cannot rely solely on time learned through that unvalidated TLS connection;
- first-party or narrow OS-provider feasibility decision and fail-closed
  capability behavior under the no-third-party rule.

Verification:

- protocol/certificate conformance, downgrade, truncation, replay, renegotiation,
  name/path/constraint and cross-tenant trust attacks;
- provider equivalence, unavailable/revoked trust source and clock-skew cases;
- circular network-time bootstrap attempts fail closed or enter an explicitly
  constrained operator-approved recovery mode;
- interoperability with supported platform clients and servers.

Exit criteria: no network consumer claims confidentiality or peer identity
without this validated profile. `v0.20.3 implementation stop reached. Run
pentest for this exact commit.`

### v0.20.4 — Raw Capsule And Quarantine Spool

Status: planned

Goal: retain bounded raw evidence and rejected input before operational
ingestion begins, while persistent storage remains disabled until key ownership
exists.

Deliverables:

- append-only raw/quarantine records with source metadata, digest, reason,
  parser/mapping/policy identities and original/ingest times;
- quotas, retention, encryption-provider hooks, inspection authorization and
  terminal expiry/reprocess outcomes;
- crash-safe reference issuance and dangling-reference detection interface for
  the later raw-evidence store.
- bounded in-memory/test implementation only; persistent plaintext fallback is
  prohibited and durable activation belongs to `v0.20.9`.

Verification:

- malformed/oversized input, crash, disk-full, corruption, expiry and quota;
- unauthorized inspection, cross-tenant reference and parser-loop attacks;
- conservation between accepted raw bytes and durable/quarantine/loss outcomes.

Exit criteria: ingestion cannot emit a raw reference to nowhere or hide a
quarantined record's lifecycle, and cannot persist it before approved encryption
and key ownership. `v0.20.4 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.20.6 — Device And Service Keystore And Spool Keying

Status: planned

Goal: protect device/service identity and local spool keys before agents or
servers persist or authenticate telemetry.

Deliverables:

- platform keystore adapter plus encrypted-file fallback with explicit assurance;
- separate device and server/service identity domains with distinct raw-spool
  master/data key derivation, rotation, recovery and destruction lifecycles;
- tenant/source/purpose domain separation so agent, relay and server spool keys
  are neither interchangeable nor derivable across roles;
- anti-rollback binding, least-privilege access and unattended-boot policy;
- rotation is manually/event driven here; persistent timing is prohibited until
  shared-scheduler integration at `v0.44.6`.

Verification:

- key theft/substitution/rollback, permission loss, corrupt keystore, rotation
  interruption, reinstall/clone and hardware-provider outage;
- platform matrix and no-third-party feasibility review;
- spool data cannot be decrypted or silently reinitialized under the wrong
  device/service identity, role or key domain.

Exit criteria: agent and server/service spooling have concrete separate bounded
key owners.
`v0.20.6 implementation stop reached. Run pentest for this exact commit.`

### v0.20.7 — Local PKI And Certificate Lifecycle

Status: planned

Goal: issue and recover Vakaheim service/device trust without depending on an
undefined external CA.

Deliverables:

- offline root, bounded issuing hierarchy and service/device certificate
  profiles;
- authenticated issuance, renewal, revocation distribution, rollover and
  compromise-recovery ceremonies;
- protected key custody, serial/identity binding, audit and air-gap procedures;
- `v0.10.3` operator quorum authorizes root/issuer ceremonies and recovery;
- renewal is manually/event driven here; persistent timing is prohibited until
  shared-scheduler integration at `v0.44.6`.

Verification:

- unauthorized issuance, duplicate identity/serial, stale revocation, root/
  issuer compromise, rollover interruption and uncertain-time behavior;
- TLS/enrollment interoperability and offline-root recovery rehearsal;
- independent PKI design and implementation pentest.

Exit criteria: every Vakaheim certificate has an owned issuance, renewal,
revocation and compromise-recovery path. `v0.20.7 implementation stop reached.
Run pentest for this exact commit.`

### v0.20.8 — System-Wide Non-Functional Contract

Status: planned

Goal: constrain every product plane with shared scale and service objectives
before operational implementation expands.

Deliverables:

- supported single-node, relay, sensor and initial cluster deployment profiles;
- event-size/burst/source/tenant/entity/rule/retention/graph-shape envelopes;
- ingest/query/detection/control latency, resource, availability and initial
  per-state-class RPO/RTO targets.

Verification:

- arithmetic consistency with storage capacity and bounded-memory contracts;
- worst-case profile combinations, overload priorities and unsupported-profile
  rejection;
- each later milestone names the profile and objectives it verifies or revises.

Exit criteria: no subsystem optimizes against an unstated workload or service
objective. `v0.20.8 implementation stop reached. Run pentest for this exact
commit.`

### v0.20.9 — Encrypted Raw And Quarantine Persistence Activation

Status: planned

Goal: enable durable raw/quarantine spooling only after device/service key
ownership and approved crypto providers exist.

Deliverables:

- encrypted append-only raw/quarantine records using `v0.20.6` key domains;
- key rotation, crash recovery, quotas, retention and durable reference issuance;
- explicit no-key/provider behavior that rejects or retains only bounded memory,
  never plaintext persistence.

Verification:

- power loss, corruption, disk-full, key/provider loss, rotation interruption,
  rollback and wrong device/service key;
- prove filesystem/media never contains plaintext source or quarantine payloads;
- conservation and dangling-reference recovery under restart.

Exit criteria: operational ingestion may persist raw/quarantine data only through
the approved encrypted key-owned path. `v0.20.9 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.30.2 — Authenticated Network-Time Refinement

Status: planned

Goal: refine local time uncertainty only after independently bootstrapped
authenticated transport exists.

Deliverables:

- pinned authenticated server-time exchange returning signed time tokens;
- multi-source offset/delay bounds, disagreement/quarantine and refresh/expiry;
- explicit rule that connection certificate validation uses prior local/offline
  trust, never time learned solely inside that connection.

Verification:

- spoof, replay, delay/asymmetry, malicious/disagreeing source, stale token,
  partition and local rollback;
- bootstrap with uncertain/expired certificate time and operator recovery;
- network refinement can narrow or degrade `TimeTrust` but cannot erase evidence.

Exit criteria: network time strengthens independently established trust without
creating a certificate-validation cycle. `v0.30.2 implementation stop reached.
Run pentest for this exact commit.`

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
- acknowledgement carries a durability vector for fact, raw-capsule or
  intentional raw unavailability, mapping/provenance, index and detection state;
- capability negotiation keeps `DurableQuorum` unavailable until `v0.471.0`;
  unsupported levels are rejected rather than approximated by local durability.

Verification:

- reconnect at every acknowledgement, duplicate storms, reordered batches;
- checkpoint corruption, window expiry, retry exhaustion and partial writes;
- end-to-end invariant that acknowledged levels match durable state.

Exit criteria: no exactly-once fiction; retries are safe and progress is
honest, and quorum durability cannot be advertised before active-write
replication exists. `v0.34.0 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.44.1 — Portable Job And Timer State Machine

Status: planned

Goal: define scheduler semantics without storage, threads, clocks or external IO.

Deliverables:

- `no_std` job/trigger state machine with identity, type/version, tenant,
  dependencies, checkpoints, cancellation, retries and terminal outcomes;
- monotonic deadlines versus trusted wall schedules, with misfire/catch-up/skip/
  duplicate-run policy and explicit uncertain-time inputs;
- deterministic transition commands/events, idempotency keys, quotas and audit
  facts with no filesystem, WAL, worker or effect authority.

Verification:

- wall rollback/forward jump, uncertainty, suspend/resume, misfire storms,
  dependency cycle and duplicate transition properties;
- exhaustive small-machine/model tests, `no_std` builds and bounded-memory tests;
- prove state-machine output cannot perform or blindly retry external effects.

Exit criteria: scheduling policy is portable, deterministic and effect-free.
`v0.44.1 implementation stop reached. Run pentest for this exact commit.`

### v0.44.2 — Scheduler Journal Persistence

Status: planned

Goal: persist `v0.44.1` through a narrow journal interface without owning storage.

Deliverables:

- scheduler-store append/read/snapshot contract over `v0.44.0` WAL primitives;
- separate scheduler journal namespace, files, queues, reserved space and
  corruption/failure domain from the primary fact WAL;
- durable create/claim/checkpoint/complete/cancel/retry transitions and recovery;
- schema/version, compaction, corruption, quota and explicit unavailable state.

Verification:

- crash at every append/sync/snapshot/restore boundary;
- torn/reordered/duplicate/corrupt transitions and deterministic replay;
- scheduler-store full/corrupt/unavailable cannot consume primary-WAL reserves,
  queues or recovery authority or block primary storage recovery.

Exit criteria: job state is durable without coupling scheduler recovery to
storage durability control flow. `v0.44.2 implementation stop reached. Run
pentest for this exact commit.`

### v0.44.3 — Hosted Scheduler Worker And Isolation

Status: planned

Goal: claim and dispatch ordinary jobs without sharing durability threads.

Deliverables:

- scheduler-worker claims, leases, checkpoints, cancellation and bounded dispatch;
- dedicated pools/queues, tenant fairness, quotas, storm prevention and audit;
- explicit failure isolation from WAL sync, storage recovery and emergency
  compaction, all of which operate when scheduler state is unavailable/corrupt.

Verification:

- worker/scheduler crash, stale claim, duplicate dispatch and cancellation race;
- scheduler corruption/exhaustion while WAL recovery and emergency compaction run;
- prove ordinary workers never execute on storage durability threads.

Exit criteria: hosted scheduling cannot deadlock or starve durable storage.
`v0.44.3 implementation stop reached. Run pentest for this exact commit.`

### v0.44.4 — Effectful Job Handoff And Unknown Outcomes

Status: planned

Goal: prevent generic retries from duplicating externally visible effects.

Deliverables:

- stable `(job identity, effect identity)` and an atomic logical handoff protocol
  to a durable outbox/action ledger;
- job remains `HandoffPending` until the uniquely keyed outbox/action record is
  durable; only then may it become `HandedOff`;
- prepared/dispatched/unknown-outcome/reconciled/terminal protocol compatible
  with later SOAR effect semantics;
- recovery idempotently completes one handoff and cannot create two outbox
  records for one effect identity;
- cancellation after handoff cannot delete, reinterpret or hide an uncertain
  effect; retry ownership, reconciliation and impairment remain explicit;
- no production effect adapter activates until its owning durable outbox/action
  ledger milestone passes.

Verification:

- crash before/after handoff/send/ack, timeout, duplicate and ambiguous response;
- crash at every scheduler-intent/outbox-durable/HandedOff boundary and concurrent
  cancellation/recovery;
- non-idempotent destination and unavailable reconciler scenarios;
- uniqueness/property proof for one durable outbox record per effect identity;
- prove generic scheduler retry cannot directly repeat an external side effect.

Exit criteria: effectful work leaves the scheduler through a durable protocol
with explicit unknown outcomes. `v0.44.4 implementation stop reached. Run
pentest for this exact commit.`

### v0.44.5 — Scheduler Consumer Admission Contract

Status: planned

Goal: prevent later subsystems from inventing private schedulers.

Deliverables:

- mandatory consumer profile: job identity/version, checkpoint, cancellation,
  misfire/catch-up/skip, idempotency, recovery and uncertain-time behavior;
- classification of internal/idempotent versus externally effectful work;
- conformance harness and registry for every admitted job type.

Verification:

- reject incomplete profiles, ambient wall-clock use and unbounded retry;
- duplicate/misfire/cancel/restart/uncertain-time tests generated from profiles;
- architecture scan for private persistent timer/job loops.

Exit criteria: no persistent scheduled consumer activates without a complete
profile and shared-scheduler conformance. `v0.44.5 implementation stop reached.
Run pentest for this exact commit.`

### v0.44.6 — Key PKI And Trust Renewal Scheduling Integration

Status: planned

Goal: integrate existing key/certificate lifecycles with the shared scheduler.

Deliverables:

- `v0.44.5` profiles for spool/service keys, certificates, revocation material
  and trust/issuer renewal;
- checkpointed ceremony preparation with authorization kept outside workers;
- uncertain-time, missed-renewal, catch-up, emergency and air-gap behavior.

Verification:

- forward/backward/uncertain time, outage, missed window and duplicate dispatch;
- cancellation during rotation/renewal and recovery from every checkpoint;
- scheduler compromise cannot authorize key, certificate or trust changes.

Exit criteria: renewal timing is shared and durable while cryptographic authority
remains independently authorized. `v0.44.6 implementation stop reached. Run
pentest for this exact commit.`

### v0.44.7 — Scheduler-Outbox Upgrade Compatibility Gate

Status: planned

Goal: preserve atomic handoff while scheduler and outbox schemas are mixed-version.

Deliverables:

- current/previous scheduler-journal, handoff-intent and outbox record matrix;
- upgrade/migration order, dual-read/write limits and irreversible boundaries;
- old/new worker fencing and stable job/effect identity across schema changes.

Verification:

- every supported mixed-version pair and crash at each handoff transition;
- partial migration, rollback, stale worker, duplicate recovery and cancellation;
- prove one durable outbox record and an honest job state after every trace.

Exit criteria: mixed versions cannot lose, duplicate or reinterpret an effect
handoff. `v0.44.7 implementation stop reached. Run pentest for this exact
commit.`

### v0.45.0 — Storage Workload Scheduler

Status: planned

Goal: isolate foreground durability from background database work.

Deliverables:

- separate bounded pools/queues for ingest, WAL sync, seal, index, compaction,
  replication, repair, backup, scrub and query IO/CPU;
- priority, admission, cancellation, I/O token buckets and foreground latency
  protection;
- maintenance/emergency modes and durable impairment when work is deferred;
- CPU/IO admission only: this component is not a persistent job/timer scheduler;
  storage recovery, WAL sync and emergency compaction bypass `v0.44.2`/`v0.44.3`.

Verification:

- compaction/repair/backup/query storms cannot block WAL/fsync control threads;
- starvation, priority inversion, cancellation, queue overflow and disk-full;
- workload-isolation and p99 foreground latency evidence;
- shared-scheduler outage/corruption while durability and emergency work proceed.

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
- `v0.44.5` scrub/repair/reindex profiles with checkpoint, cancellation, misfire,
  idempotency, recovery and uncertain-time declarations.

Verification:

- every supported upgrade/downgrade pair, interrupted migration and rollback;
- corrupt segment/index, missing/revoked/lost key and partial reindex scenarios;
- old readers fail closed on unsafe new semantics.

Exit criteria: format evolution and lost authority cannot silently corrupt or
resurrect evidence. `v0.57.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.57.1 — Single-Node Backup And Restore

Status: planned

Goal: implement locally consistent recovery before backup appears in the early
storage campaign.

Deliverables:

- consistency-point manifest over segments, raw objects, WAL boundary, local
  control/audit state and key references;
- incremental/full backup, retention, verification and encrypted destination
  adapter;
- clean-directory restore, dependency ordering, reindex and post-restore proof.
- `v0.44.5` backup profile; restore/recovery remains explicit operator work and
  never depends on scheduler availability.

Verification:

- backup concurrent with ingest/compaction, crash, missing/corrupt object,
  stale manifest, wrong/lost key and disk-full;
- restore to empty host, point-in-time boundary and authorization/audit checks;
- independent reconstruction and source/reference integrity comparison.

Exit criteria: `v0.58.0` can test an implemented backup/restore path with a
verified local consistency point. `v0.57.1 implementation stop reached. Run
pentest for this exact commit.`

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
- `v0.44.5` retention/compaction profiles; emergency disk-full compaction remains
  on the independent `v0.45.0` durability path.

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

### v0.86.0 — Cold-Tier Catalog And Rehydration

Status: planned

Goal: query exported cold evidence without hiding retrieval cost, policy or
availability.

Deliverables:

- authorized cold-object catalog with tenant, snapshot/generation, time,
  retention/hold, key and integrity identity;
- physical-plan retrieval/rehydration, cache lifetime, cost/admission,
  cancellation and cleanup;
- missing/revoked key, unavailable object, partial snapshot and completeness
  semantics.
- `v0.44.5` rehydration profile with stable request identity, checkpoint,
  cancellation, duplicate-fetch idempotency, misfire and uncertain-time behavior.

Verification:

- stale/tampered catalog, missing object/key, hold/retention conflict, retrieval
  timeout, cancellation, duplicate fetch and cache leakage;
- hot/cold result and snapshot equivalence where complete;
- large retrieval cost, tenant fairness and partial-result explanations.

Exit criteria: historical queries catalog and authorize cold evidence explicitly
and never present unavailable cold ranges as complete. `v0.86.0 implementation
stop reached. Run pentest for this exact commit.`

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

### v0.100.1 — V1 Optional Capability Admission Decisions

Status: planned

Goal: bind support or documented non-goal decisions early enough to complete all
admitted work before the release freeze.

Deliverables:

- signed decision records for PCAP, artifact-content matching, PE/ELF/Mach-O
  extraction, Windows Event Forwarding and cloud archive/message streams;
- per-option security value, threat model, zero-third-party feasibility, privacy/
  licensing, resource/format/API and platform-operability analysis;
- binding admitted implementation/final-gate routes: `v0.180.1`–`v0.181.0`,
  `v0.231.0`–`v0.235.0`, `v0.267.1`–`v0.268.0`, `v0.307.0`–`v0.308.0` and
  `v0.315.1`–`v0.316.0` respectively;
- accepted options receive bounded scope and implementation requirements;
  rejected options receive enforced unsupported behavior and 1.0 non-goal text.

Verification:

- every option has one unambiguous signed decision and owner;
- accepted scope has small intermediate stops and may add more without weakening
  the reserved final integration gate;
- rejected scope has API/config/parser rejection tests and no support claim.

Exit criteria: all five options are decided; none remains “possible,” implied or
deferred to 1.0. `v0.100.1 implementation stop reached. Run pentest for this
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

### v0.170.0 — Behavioral Model Framework

Status: planned

Goal: establish transparent replayable model state before adding behavioral
families.

Deliverables:

- tenant-local versioned model inputs, state, checkpoint and execution identity;
- bounded feature/window/sketch interfaces, drift/health and explanation schema;
- poisoning quarantine, rollout/rollback and resource admission.

Verification:

- model-state replay/checkpoint/upgrade and cross-target stability;
- poisoning, sparse/cold-start, drift, clock and overflow framework tests;
- false-positive/negative evaluation and resource-budget harness.

Exit criteria: no opaque model output is treated as authoritative evidence.
`v0.170.0 implementation stop reached. Run pentest for this exact commit.`

### v0.171.0 — Rarity And Bounded Sketches

Status: planned

Goal: detect rare values and cardinality changes with explicit approximation.

Deliverables:

exact bounded counts plus pinned sketches, merge/decay semantics,
error bounds, explanations and source-completeness requirements.

Verification:

hand-calculated datasets, merge order, overflow, adversarial hash/
cardinality, poisoning and approximation-bound tests.

Exit criteria: rarity states its population, window, completeness and exact or
bounded approximate error. `v0.171.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.172.0 — Baselines, Seasonality And Peer Groups

Status: planned

Goal: implement robust temporal and peer comparison separately from rarity.

Deliverables:

robust baseline/seasonal profiles, explicit peer membership,
cold-start/minimum-data rules, drift and decomposable deviation evidence.

Verification:

fixed seasonal/peer datasets, sparse data, clock uncertainty,
peer churn/manipulation, poisoned baseline and replay stability.

Exit criteria: every deviation names its baseline/peer version and cannot hide
cold-start or incomplete telemetry. `v0.172.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.173.0 — Change Points And Identity Geography

Status: planned

Goal: detect bounded behavioral shifts and geographic identity anomalies.

Deliverables:

versioned change-point profile, location/source confidence,
travel/velocity uncertainty, network-proxy/VPN context and explanations.

Verification:

hand-calculated shifts, location conflict, VPN/proxy, clock skew,
impossible-travel boundaries, poisoning and resource caps.

Exit criteria: geography and change findings remain uncertainty-aware evidence-
backed projections. `v0.173.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.174.0 — Transition And Graph Novelty

Status: planned

Goal: identify unusual bounded sequences and relationship changes.

Deliverables:

versioned transition/edge/path novelty state, entity-resolution
binding, bounded graph/window state and supporting path evidence.

Verification:

known transition/graph fixtures, identity merge/split, high
fan-out, cyclic paths, poisoning, eviction and deterministic replay.

Exit criteria: novelty findings include the exact prior state and source-backed
relationship evidence. `v0.174.0 implementation stop reached. Run pentest for
this exact commit.`

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

### v0.176.0 — Stateful Entity Risk Ledger

Status: planned

Goal: accumulate risk events by entity without converting a finding score into
an opaque alert.

Deliverables:

- user/device/workload risk events, deduplication, decay, thresholds,
  suppression and immutable threshold finding/event emission;
- deterministic recomputation for late identity, asset, vulnerability and
  exposure changes;
- `v0.44.5` risk-recompute profile with checkpoint, cancellation, coalescing,
  idempotency and deterministic restart inputs;
- bounded hot-entity state, poisoning controls and complete contribution ledger.

Verification:

- duplicate/late/retracted findings, merge/split identity, threshold boundaries,
  decay/recompute and hot-entity overload;
- risk inflation, poisoned enrichment, suppression bypass and tenant isolation;
- hand-calculated ledger and replay equivalence.

Exit criteria: every entity-risk threshold finding decomposes into immutable
risk events and versioned enrichment; this milestone creates no mutable alert.
`v0.176.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.179.0 — Threat-Intelligence Matching Engine

Status: planned

Goal: match governed intelligence against live and historical evidence with
exact provenance.

Deliverables:

- canonical IP/CIDR, domain, URL, hash, certificate, email and file observables;
- bounded STIX-pattern subset with validity, revocation, markings, confidence,
  allowlists and exceptions;
- streaming match and retro-hunt paths whose evidence binds intelligence object/
  version, matched source field, normalization and time.
- `v0.44.5` retro-hunt profile with snapshot identity, checkpoint, cancellation,
  duplicate suppression, misfire and replay behavior.

Verification:

- canonicalization/IDNA/IP/URL edge cases, expired/revoked/conflicting objects,
  allowlist precedence and poisoned feeds;
- streaming/retro-hunt equivalence, late intelligence and high-cardinality load;
- unsupported STIX patterns fail explicitly and matching remains tenant-safe.

Exit criteria: every match proves the exact intelligence and source values used.
`v0.179.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.180.1 — Artifact Matching Rule Profile

Status: conditional on admission at `v0.100.1`

Goal: define a bounded artifact-content rule language before matching bytes.

Deliverables:

- admitted YARA-compatible subset or native equivalent with exact exclusions;
- parser/typecheck/compiler IR, rule identity/version and resource declarations;
- pinned fixtures, licensing record and unsupported-feature diagnostics.

Verification:

- malformed/ambiguous rules, exponential constructs and compatibility corpus;
- deterministic compilation, downgrade and unsupported-feature rejection;
- zero-third-party feasibility and rule-language pentest.

Exit criteria: admitted rules compile deterministically into bounded reviewed IR.
`v0.180.1 implementation stop reached. Run pentest for this exact commit.`

### v0.180.2 — Bounded Streaming Artifact Matcher

Status: conditional on admission at `v0.100.1`

Goal: match artifact bytes without unbounded buffering or work.

Deliverables:

- streaming matcher over `v0.180.1` IR with fuel/memory/output limits;
- offset/range identity, chunk-boundary semantics and cancellation;
- decompression/archive boundary kept outside unless separately admitted.

Verification:

- adversarial patterns/bytes, boundary-spanning matches and match storms;
- size/fuel/memory exhaustion, cancellation and deterministic replay;
- matcher fuzzing, differential fixtures and performance/pentest evidence.

Exit criteria: matching is bounded and cannot turn hostile content/rules into
resource denial. `v0.180.2 implementation stop reached. Run pentest for this
exact commit.`

### v0.180.3 — Artifact Match Evidence Integration

Status: conditional on admission at `v0.100.1`

Goal: integrate matches with evidence, detection and policy semantics.

Deliverables:

- artifact/rule/version/offset/source-capsule evidence and lineage;
- simulation, live/retro paths, policy/redaction and tenant isolation;
- SDK/API/coverage/health surfaces and unsupported-content evidence.

Verification:

- live/retro/simulation equivalence, late rule/content and replay;
- cross-tenant, redaction, provenance substitution and poisoned-rule attacks;
- end-to-end artifact matching pentest.

Exit criteria: every match proves exact rule and source bytes under current
policy. `v0.180.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.181.0 — Artifact-Content Matching Scope Closure

Status: conditional on `v0.100.1`

Goal: close the 1.0 artifact-content/YARA-compatible matching decision.

Deliverables:

- if admitted: integrate and independently audit `v0.180.1`–`v0.180.3` with no
  functionality hidden in this final gate;
- if rejected: explicit 1.0 non-goal, unsupported rule/API/config behavior and no
  YARA or artifact-content support claim;
- either path updates threat model, SDK/API, detection coverage and release notes.

Verification:

- admitted path: pinned compatibility fixtures, malicious rules/artifacts,
  decompression/size/work attacks, deterministic replay and pentest;
- rejected path: parser/config/API rejection and documentation/claim audit;
- licensing and zero-third-party feasibility evidence matches the decision.

Exit criteria: artifact-content matching is implemented within admitted bounds
or conclusively excluded from 1.0. `v0.181.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.190.0 — Rule Simulation And Rollout

Status: planned

Goal: change detection safely with historical and staged evidence.

Deliverables:

- unit/adversarial tests, historical simulation and comparison reports;
- draft/validated/tested/shadow/canary/active/quarantined lifecycle;
- tenant/region/group/source/percentage/time rollout and rollback thresholds.
- `v0.44.5` timed rollout profile with policy/rule identity, cancellation,
  misfire/catch-up/skip and rollback checkpoint behavior.

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

### v0.206.0 — Agent Software Integrity And Self-Protection

Status: planned

Goal: protect agent and helper identity across install, update, runtime and
controlled removal before platform sensors ship.

Deliverables:

- signed binary/package/update manifest verification and provenance binding;
- anti-rollback version/epoch, measured runtime component inventory and helper/
  IPC replacement protection;
- authorized uninstall/recovery, tamper response and explicit self-protection/
  measurement impairment evidence.

Verification:

- unsigned/substituted/downgraded/partially installed update, stale signer,
  rollback and interrupted update/recovery;
- helper/binary/path/config replacement, debugger/injection where detectable,
  permission loss and unauthorized uninstall;
- supported platform install/update/rollback/remove matrices and independent
  agent-integrity pentest.

Exit criteria: unsupported or impaired self-protection is visible, and no agent
or helper update activates without verified identity and anti-rollback policy.
`v0.206.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.231.0 — WEF Transport And Source Authentication

Status: conditional on admission at `v0.100.1`

Goal: define authenticated remote Windows event transport before subscriptions.

Deliverables:

- pinned WinRM/WS-Management profile and bounded message handling;
- collector/source computer identity, certificate/Kerberos policy where admitted;
- channel/source binding, replay protection and native-agent distinction.

Verification:

- spoofed source/collector, downgrade, redirect, replay and oversized messages;
- certificate/trust/permission failures and supported Windows matrix;
- zero-third-party feasibility and transport pentest.

Exit criteria: remote source and collector identity are authenticated explicitly.
`v0.231.0 implementation stop reached. Run pentest for this exact commit.`

### v0.232.0 — WEF Subscription Provisioning

Status: conditional on admission at `v0.100.1`

Goal: provision and own bounded push/pull subscription lifecycle.

Deliverables:

- collector- and source-initiated subscription profiles where admitted;
- channel/filter/config identity, authorization, rollout and rollback;
- provisioning health, drift, conflict and explicit unsupported combinations.

Verification:

- unauthorized/stale/partial provisioning and conflicting subscriptions;
- source join/leave, permission change, rollback and configuration drift;
- real-system provisioning matrix and pentest.

Exit criteria: every remote subscription is authorized, versioned and observable.
`v0.232.0 implementation stop reached. Run pentest for this exact commit.`

### v0.233.0 — WEF Bookmark And Continuity Semantics

Status: conditional on admission at `v0.100.1`

Goal: preserve honest remote delivery, bookmark and gap evidence.

Deliverables:

- source/channel/subscription bookmark identity and restart epochs;
- duplicate, reorder, reset, log-clear/wrap, backlog and gap semantics;
- collector outage/recovery, checkpoint and bounded backfill behavior.

Verification:

- crash around receive/checkpoint, bookmark reset/reuse and duplicate replay;
- source/collector outage, backlog exhaustion and channel recreation;
- conservation and native-versus-WEF continuity comparison.

Exit criteria: WEF cannot present an unknown or reset continuity state as complete.
`v0.233.0 implementation stop reached. Run pentest for this exact commit.`

### v0.234.0 — WEF Operational Integration And Hardening

Status: conditional on admission at `v0.100.1`

Goal: integrate WEF with tenancy, routing, health and resource controls.

Deliverables:

- tenant/source mapping, quotas, backpressure and collector health;
- enrollment/API/configuration, diagnostics and upgrade/rollback behavior;
- source-native capsule and common fact mapping with loss evidence.

Verification:

- noisy source/tenant, collector overload, mapping conflict and routing failure;
- upgrade/rollback, permission loss, stale config and support diagnostics;
- end-to-end Windows interoperability and hardening pentest.

Exit criteria: admitted WEF is operable without weakening native endpoint
collection. `v0.234.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.235.0 — Windows Event Forwarding Scope Closure

Status: conditional on `v0.100.1`

Goal: close the 1.0 remote Windows Event Forwarding decision.

Deliverables:

- if admitted: integrate and independently audit `v0.231.0`–`v0.234.0` with no
  functionality hidden in this final gate;
- if rejected: explicit 1.0 non-goal and disabled WEF enrollment/config/API paths;
- either path distinguishes native endpoint collection from remote forwarding.

Verification:

- admitted path: push/pull subscription, reconnect, bookmark reset, duplicate/
  gap, collector outage, spoofed source, certificate/permission and Windows matrix;
- rejected path: configuration/API rejection and support-claim audit;
- independent Windows transport and source-authentication pentest.

Exit criteria: WEF is implemented with honest continuity or conclusively excluded
from 1.0. `v0.235.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.240.0 — Windows Advanced Telemetry

Status: planned

Goal: add network, scripting, WMI and security-control visibility safely.

Deliverables:

- network metadata, PowerShell/scripting, WMI and security-product health;
- optional driver boundary only for evidence unavailable through safe APIs;
- signed support decision that either admits the exact driver evidence surface
  or declares the driver a 1.0 non-goal with every no-driver path preserved;
- response adapter contracts without generic command execution;
- ETW provider/session identity, lost-event/buffer counters and restart epochs.

Verification:

- evasion, provider disable, high-volume script/network and WMI scenarios;
- optional-driver install/remove/failure and no-driver fallback;
- dedicated privileged-boundary review and pentest.

Exit criteria: advanced collection cannot weaken the base agent security model,
and the driver option is conclusively implemented or excluded from 1.0.
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
- compile-only mock platform and portability decision record;
- explicit 1.0 non-goal for operational Aesynx support unless an intervening
  implementation milestone supplies real-system evidence and support ownership.

Verification:

- build with every optional host capability removed independently;
- architecture-width, endianness, clock and stable-storage boundary tests;
- review against the then-current Aesynx capability surface.

Exit criteria: no required platform assumption lacks an adapter boundary, and
Aesynx is conclusively documented as future portability rather than 1.0 support
unless the roadmap has added and passed an implementation stop. `v0.267.0
implementation stop reached. Run pentest for this exact commit.`

### v0.267.1 — Portable Executable-Container Reader Foundation

Status: conditional on admission at `v0.100.1`

Goal: define shared bounded byte/range/string primitives for executable formats.

Deliverables:

- `no_std` reader with checked offsets/counts/alignment and work budgets;
- format dispatch, truncation/loss, overlap and unsupported-feature semantics;
- source-byte range provenance for every extracted value.

Verification:

- integer/offset/count overflow, overlap, truncation and hostile nesting;
- fuzz/property/differential reader tests across architecture widths;
- prove no executable loading, relocation or code execution authority.

Exit criteria: format parsers share one bounded provenance-preserving foundation.
`v0.267.1 implementation stop reached. Run pentest for this exact commit.`

### v0.267.2 — PE Metadata Parser

Status: conditional on admission at `v0.100.1`

Goal: parse admitted PE metadata without implementing a loader.

Deliverables:

- DOS/COFF/optional headers, sections, data directories and build identity;
- bounded imports/exports/resources/debug metadata selected at `v0.100.1`;
- Authenticode location metadata without yet claiming signature validity.

Verification:

- malformed RVA/file-offset mappings, overlaps, cycles and count bombs;
- pinned PE fixtures, parser differential/fuzz and Windows compatibility;
- explicit unsupported architecture/directory behavior.

Exit criteria: PE metadata is bounded, source-ranged and never executes content.
`v0.267.2 implementation stop reached. Run pentest for this exact commit.`

### v0.267.3 — ELF Metadata Parser

Status: conditional on admission at `v0.100.1`

Goal: parse admitted ELF metadata without implementing a loader.

Deliverables:

- ELF headers, program/section tables, notes and build identity;
- bounded dynamic symbols/imports/exports selected at `v0.100.1`;
- architecture, byte-order and ABI metadata with explicit unsupported cases.

Verification:

- malformed offsets/sizes/links, extended counts, overlap and cycles;
- pinned ELF fixtures, parser differential/fuzz and Linux/BSD compatibility;
- endian/word-width and stripped/minimal binary cases.

Exit criteria: ELF metadata is bounded and portable across admitted variants.
`v0.267.3 implementation stop reached. Run pentest for this exact commit.`

### v0.267.4 — Mach-O Metadata Parser

Status: conditional on admission at `v0.100.1`

Goal: parse admitted Mach-O metadata without implementing a loader.

Deliverables:

- thin/fat headers, load commands, segments/sections and build identity;
- bounded dylib/symbol/export metadata selected at `v0.100.1`;
- code-signature location metadata without yet claiming validity.

Verification:

- hostile fat slices, command sizes/counts, overlaps and architecture confusion;
- pinned Mach-O fixtures, parser differential/fuzz and macOS compatibility;
- explicit unsupported command/architecture behavior.

Exit criteria: Mach-O metadata is bounded and slice identity cannot be confused.
`v0.267.4 implementation stop reached. Run pentest for this exact commit.`

### v0.267.5 — Executable Signature Metadata And Evidence

Status: conditional on admission at `v0.100.1`

Goal: bind executable metadata and admitted platform signature checks to evidence.

Deliverables:

- platform signature structure/profile parsing over prior crypto/X.509 contracts;
- validity/trust/time/revocation/unsupported distinctions without broad trust claims;
- raw-byte provenance, metadata facts, SDK/API fields and policy/redaction.

Verification:

- signature wrapping/confusion, wrong range, stale trust/time and revocation gaps;
- signed/unsigned/tampered fixtures per format and cross-format confusion;
- end-to-end executable evidence and signature pentest.

Exit criteria: metadata and any signature result state exact bytes, policy, trust
and limitations. `v0.267.5 implementation stop reached. Run pentest for this
exact commit.`

### v0.268.0 — Executable Metadata Extraction Scope Closure

Status: conditional on `v0.100.1`

Goal: close the 1.0 PE/ELF/Mach-O metadata and signature-extraction decision.

Deliverables:

- if admitted: integrate and independently audit `v0.267.1`–`v0.267.5` with no
  functionality hidden in this final gate;
- if rejected: explicit 1.0 non-goal and disabled artifact-parser/API fields;
- either path defines raw-byte provenance, truncation/loss and unsupported-format
  behavior.

Verification:

- admitted path: pinned format/signature fixtures, malformed offsets/counts,
  overlap, truncation, parser differentials, fuzzing and signature confusion;
- rejected path: parser/API rejection and support-claim audit;
- resource bounds and zero-third-party feasibility match `v0.100.1`.

Exit criteria: executable metadata/signature extraction is implemented within
admitted bounds or conclusively excluded from 1.0. `v0.268.0 implementation stop
reached. Run pentest for this exact commit.`

## Phase H — SDK, Connectors And Source Assurance

### v0.270.0 — Private Rust SDK Preview

Status: planned

Goal: stabilize an in-workspace SDK without publishing it.

Deliverables:

- `no_std` types/events and `alloc` query/rule/evidence/finding surfaces;
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
- base envelope, query, finding, rule and evidence endpoint schemas plus
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

### v0.281.0 — Platform Credential Vault And Broker

Status: planned

Goal: own platform credentials before connector or response workers request
attenuated operations.

Deliverables:

- independently keyed connector, response, PKI and notification compartments
  with tenant/provider/purpose-scoped credential objects;
- create/import/rotate/revoke/expire/recover lifecycle with dual-control policy;
- `v0.10.3` operator principals authorize dual-control operations until witnessed
  transition to later human identities;
- broker operations for request signing, short-token minting and authenticated
  calls without exposing long-lived secret bytes.
- explicit non-inheritance: collection authority never grants response authority
  and cross-compartment operations require separate capabilities.

Verification:

- cross-tenant/provider/purpose confusion, stale/revoked credential, rotation
  race, backup/restore and vault outage;
- worker/broker confused-deputy, response leakage and audit omission attacks;
- platform key-provider integration and independent vault pentest.

Exit criteria: workers receive only attenuated compartment operations, never
ambient or unnecessary long-lived credential material. `v0.281.0 implementation
stop reached. Run pentest for this exact commit.`

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
- `v0.44.5` polling/token-renewal profiles with cancellation, misfire,
  idempotency, recovery and uncertain-time behavior;
- externally effectful credential/token renewal uses `v0.44.4` unknown-outcome
  handoff rather than generic retry;
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

### v0.304.0 — Productivity SaaS Provider Contract

Status: planned

Goal: define productivity/collaboration connector semantics without claiming a
named provider.

Deliverables:

mail, file-sharing, collaboration and administration profiles with webhook
verification, audit cursor, schema version, user mapping and permission health.

Verification:

independent provider fixtures for cursor/paging, permission change, schema drift,
rate limit, outage, webhook spoof/replay and live interoperability.

Exit criteria: the conformance contract is testable; no named productivity
provider is supported by this milestone alone.
`v0.304.0 implementation stop reached. Run pentest for this exact commit.`

### v0.305.0 — Source-Control Provider Contract

Status: planned

Goal: define repository, identity, workflow and administration connector
semantics without claiming a named provider.

Deliverables:

independent provider profiles with cursor/webhook, repository/org,
actor/token, workflow and permission semantics plus source-native capsules.

Verification:

per-provider cursor, permission, schema-drift, rate-limit, outage,
rename/delete, webhook spoof/replay and live interoperability acceptance.

Exit criteria: the conformance contract is testable; each named source-control
provider requires its own admitted release. `v0.305.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.305.1 — Ticketing Provider Contract

Status: planned

Goal: define ticket/case workflow connector semantics without claiming a named
provider or conflating it with other SaaS families.

Deliverables:

independent provider profiles with cursor/webhook, project/issue,
actor/status/comment/attachment and permission/retention semantics.

Verification:

per-provider cursor, permission, schema-drift, rate-limit, outage,
rename/delete, webhook spoof/replay and live interoperability acceptance.

Exit criteria: the conformance contract is testable; each named ticketing
provider requires its own admitted release. `v0.305.1 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.307.0 — Cloud Object And Archive Ingestion

Status: conditional on admission at `v0.100.1`

Goal: ingest admitted cloud objects/archives with bounded enumeration and expansion.

Deliverables:

- object listing/read/version/checkpoint contracts and mutation identity;
- bounded admitted archive formats, expansion/depth/entry limits and quarantine;
- source capsule, tenant/account/region and object-version provenance.

Verification:

- replace/delete/version races, pagination loops and eventually consistent lists;
- archive bombs, path confusion, truncation, corruption and nested limits;
- provider-neutral object/archive fuzz and pentest.

Exit criteria: each ingested byte binds an exact object version and bounded
archive path. `v0.307.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.307.1 — Cloud Message-Stream Ingestion

Status: conditional on admission at `v0.100.1`

Goal: ingest admitted partitioned message streams with honest delivery semantics.

Deliverables:

- stream/topic/partition/message identity and offset/checkpoint contracts;
- consumer-group assignment/rebalance, duplicate/gap and replay behavior;
- bounded batching, backpressure, ordering and dead-letter/quarantine semantics.

Verification:

- partition move/rebalance, offset reset/truncation and concurrent consumers;
- duplicate/reorder/gap, poison message, overload and checkpoint crash;
- conservation/model and message-stream protocol pentest.

Exit criteria: offsets and acknowledgements never imply stronger delivery than
the provider proves. `v0.307.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.307.2 — Cloud Ingestion Checkpoint And Recovery Integration

Status: conditional on admission at `v0.100.1`

Goal: unify object/stream recovery, scheduling and source completeness.

Deliverables:

- `v0.44.5` polling profiles, durable checkpoints and cancellation;
- backfill/replay, outage, throttle, credential/token renewal and uncertain-time
  behavior through shared connector substrate;
- permission, inventory, cost/quota and completeness health.

Verification:

- crash at fetch/persist/checkpoint, prolonged outage and token expiry;
- stale scheduler job, duplicate poll, throttle storm and partial permissions;
- object/stream recovery and source-conservation comparison.

Exit criteria: recovery is resumable, bounded and never hides missing scope.
`v0.307.2 implementation stop reached. Run pentest for this exact commit.`

### v0.307.3 — Cloud Archive And Stream Provider Hardening

Status: conditional on admission at `v0.100.1`

Goal: validate every named admitted provider independently before final closure.

Deliverables:

- provider/API/version profiles with exact object/archive/stream surfaces;
- credential/egress, region/tenant, rate/cost and schema-drift controls;
- upgrade/rollback, diagnostics and unsupported-capability evidence.

Verification:

- live/pinned provider interoperability, outage, permission and rate campaigns;
- confused deputy, cross-account/region, redirect/egress and secret leakage;
- independent cloud connector pentest per support claim.

Exit criteria: only provider surfaces with independent admission evidence are
claimed. `v0.307.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.308.0 — Cloud Archive And Message-Stream Scope Closure

Status: conditional on `v0.100.1`

Goal: close the 1.0 cloud object/archive and message-stream ingestion decision.

Deliverables:

- if admitted: integrate and independently audit `v0.307.0`–`v0.307.3` with no
  functionality hidden in this final gate;
- if rejected: explicit 1.0 non-goal and disabled archive/stream connector
  capabilities;
- either path defines object mutation/version, archive expansion, offset/ack,
  replay, permission and completeness semantics.

Verification:

- admitted path: object replace/delete/version, archive bomb, pagination,
  partition rebalance, offset reset, duplicate/gap, throttle/outage and live
  provider interoperability;
- rejected path: connector/config/API rejection and claim audit;
- credential/egress, tenant and cost/resource limits match the decision.

Exit criteria: cloud archive/stream ingestion is implemented within admitted
providers/bounds or conclusively excluded from 1.0. `v0.308.0 implementation
stop reached. Run pentest for this exact commit.`

### v0.310.0 — Network Flow Provider Contract

Status: planned

Goal: ingest flow/IPFIX-style telemetry with explicit exporter and sampling
semantics.

Deliverables:

pinned flow templates/records, exporter identity, template cache,
sampling, counters, time and loss/completeness evidence.

Verification:

template churn/reuse, sequence gap, sampling, counter wrap,
fragmentation, clock, rate/overload and independent exporter interoperability.

Exit criteria: sampled or template-incomplete flow data cannot appear complete;
named exporters require separate admitted releases.
`v0.310.0 implementation stop reached. Run pentest for this exact commit.`

### v0.311.0 — DNS And DHCP Profiles

Status: planned

Goal: ingest name-resolution and address-assignment evidence with lifecycle
identity.

Deliverables:

pinned DNS/DHCP record profiles, lease/query/response identity,
resolver/server/source health, truncation and privacy policy.

Verification:

compression/fragmentation, malformed names, lease/address reuse,
cache/negative answers, loss/rate/outage and independent interoperability.

Exit criteria: DNS and DHCP identity/time ambiguity remains explicit.
`v0.311.0 implementation stop reached. Run pentest for this exact commit.`

### v0.312.0 — VPN, Firewall And Proxy Provider Contract

Status: planned

Goal: define access/network-control connector semantics without claiming a named
provider.

Deliverables:

session, rule/action, NAT, URL/request and policy-version profiles
with cursor, permission, sampling/truncation and source health.

Verification:

per-provider schema drift, cursor, permission, rate, outage, NAT/
address reuse, spoof/truncation and live interoperability acceptance.

Exit criteria: the conformance contract is testable; each named VPN, firewall or
proxy provider requires its own admitted release. `v0.312.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.313.0 — Email-Security Provider Contract

Status: planned

Goal: ingest message, authentication, delivery and security-control evidence.

Deliverables:

message/recipient/attachment/link, SPF/DKIM/DMARC and verdict/
quarantine profiles with privacy, cursor and permission health.

Verification:

per-provider schema drift, cursor, permission, rate, outage,
malformed identity, redaction and live interoperability acceptance.

Exit criteria: the conformance contract is testable; each named email-security
provider requires its own admitted release. `v0.313.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.314.0 — IDS And Detection-Appliance Provider Contract

Status: planned

Goal: ingest external detections without treating their verdicts as Vakaheim
truth.

Deliverables:

alert/signature/rule, flow/context, severity/confidence and sensor-
health profiles with source-native preservation.

Verification:

per-provider schema drift, cursor, permission, rate, outage,
duplicate/retracted alerts and live interoperability acceptance.

Exit criteria: the conformance contract preserves appliance/rule provenance;
each named provider requires its own admitted release. `v0.314.0 implementation
stop reached. Run pentest for this exact commit.`

### v0.315.0 — CEF And LEEF Device Compatibility Contract

Status: planned

Goal: support bounded enterprise device compatibility formats.

Deliverables:

- pinned CEF and LEEF framing/escaping/extension profiles;
- bounded vendor/product-specific mapping registry and source-native capsules;
- timestamps, truncation, mapping loss and device/source health.

Verification:

- format corpus/fuzzing, spoofed/truncated/fragmented and volume attacks;
- vendor schema drift, mapping conflict, clock/order and completeness;
- independent device/provider fixtures, throughput and parser pentest.

Exit criteria: incomplete, truncated or lossy device evidence is never presented
as complete; each named device mapping requires its own admitted release.
`v0.315.0 implementation stop reached. Run pentest for this exact commit.`

### v0.315.1 — Packet Capture Authority And Acquisition

Status: conditional on admission at `v0.100.1`

Goal: bound capture privilege and source identity before parsing packets.

Deliverables:

- approved live/file capture sources, interface identity and privilege boundary;
- capture filter/configuration epochs, sampling/truncation and loss counters;
- start/stop/rotation, clock, health and source-capsule custody.

Verification:

- unauthorized interface/filter, privilege loss, interface reuse and clock shift;
- buffer overflow, dropped packets, rotation crash and capture-source spoofing;
- platform acquisition boundary pentest.

Exit criteria: packet acquisition authority and loss are explicit and auditable.
`v0.315.1 implementation stop reached. Run pentest for this exact commit.`

### v0.315.2 — Bounded PCAP And PCAPNG Parsing

Status: conditional on admission at `v0.100.1`

Goal: parse admitted capture containers without trusting their lengths or options.

Deliverables:

- bounded PCAP/PCAPNG headers, blocks, interfaces, timestamps and packet records;
- checked lengths/alignment/options, truncation and unsupported-link semantics;
- exact byte-range provenance and streaming input.

Verification:

- malformed block/packet lengths, endian/time-resolution and option confusion;
- truncated/concatenated/multi-interface captures and high record counts;
- normative fixtures, fuzzing, differential parsing and pentest.

Exit criteria: hostile capture containers cannot escape budgets or lose provenance.
`v0.315.2 implementation stop reached. Run pentest for this exact commit.`

### v0.315.3 — Packet Flow And Reassembly Semantics

Status: conditional on admission at `v0.100.1`

Goal: derive only bounded packet/flow context selected by the admission decision.

Deliverables:

- admitted link/network/transport header profiles and flow identity;
- bounded fragmentation/stream reassembly if admitted, with overlap/gap policy;
- sampling, truncation, encapsulation and incomplete-flow evidence.

Verification:

- fragment/segment overlap, evasion, tunnel depth and flow-table exhaustion;
- reorder, missing packets, address/port reuse and timeout uncertainty;
- reference-stack differential and network-evasion pentest.

Exit criteria: derived flow/packet context never implies absent bytes were seen.
`v0.315.3 implementation stop reached. Run pentest for this exact commit.`

### v0.315.4 — Packet Evidence Storage And Privacy

Status: conditional on admission at `v0.100.1`

Goal: retain packet evidence only within approved custody and privacy bounds.

Deliverables:

- encrypted raw packet/capture chunks, manifests, references and integrity;
- field/payload minimization, redaction, retention, hold and residency policy;
- tenant/source/interface identity, access audit and export custody.

Verification:

- cross-tenant reference, key loss/rotation, partial chunks and restore;
- retention/hold conflict, unauthorized payload query/export and inference;
- privacy/legal/capacity review and packet-evidence pentest.

Exit criteria: packet evidence is reconstructable only when policy and durable
raw availability allow it. `v0.315.4 implementation stop reached. Run pentest
for this exact commit.`

### v0.315.5 — Packet Pipeline Capacity And Impairment

Status: conditional on admission at `v0.100.1`

Goal: prove admitted packet processing remains bounded and honest under load.

Deliverables:

- capture/parser/flow/storage quotas, backpressure and priority policy;
- loss/drop/truncation/sampling/resource impairment evidence;
- published platform/link-rate capacity and unsupported-scale boundaries.

Verification:

- sustained/burst high rate, tiny-packet storm, many flows and slow storage;
- impairment-lane exhaustion, recovery, cancellation and noisy tenant;
- independent performance reproduction and overload pentest.

Exit criteria: packet overload degrades visibly within declared capacity rather
than causing silent loss. `v0.315.5 implementation stop reached. Run pentest
for this exact commit.`

### v0.316.0 — PCAP And Packet-Evidence Scope Closure

Status: conditional on `v0.100.1`

Goal: close the 1.0 PCAP acquisition and bounded packet-evidence decision.

Deliverables:

- if admitted: integrate and independently audit `v0.315.1`–`v0.315.5` with no
  functionality hidden in this final gate;
- if rejected: explicit 1.0 non-goal and disabled capture/parser/API paths;
- either path defines privilege, retention, redaction, encryption, scale and
  completeness limits.

Verification:

- admitted path: malformed captures/blocks/lengths, high rate, packet loss,
  truncation, clock, interface changes, privacy policy and acquisition pentest;
- rejected path: configuration/API/parser rejection and support-claim audit;
- storage/capacity and legal/privacy evidence matches the decision.

Exit criteria: PCAP/packet evidence is implemented within admitted bounds or
conclusively excluded from 1.0. `v0.316.0 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.342.0 — Generic Notification Substrate And Durable Outbox

Status: planned

Goal: provide generic outbound delivery without depending on mutable alert
state.

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

Exit criteria: generic notification requests and outcomes are durable and
auditable, with no alert-transaction claim. `v0.342.0 implementation stop
reached. Run pentest for this exact commit.`

## Phase I — Analyst Product

### v0.345.0 — Alert Routing

Status: planned

Goal: route immutable findings into controlled analyst workflows.

Deliverables:

- finding deduplication/grouping, alert identity/state and ownership;
- entity-risk threshold findings are promoted through the same routing policy;
- tenant/team routing, priority, notification, escalation and SLA policy;
- `v0.44.5` escalation/SLA profiles with incident/alert identity, cancellation,
  misfire, idempotency and uncertain-time behavior;
- governed suppression with reason, approval, expiry and full audit.

Verification:

- duplicate storms, route loops, stale ownership, SLA and notification faults;
- suppression bypass/expiry and cross-tenant access tests;
- load/fairness and audit-completeness scenarios.

Exit criteria: mutable alerts never alter their immutable source findings.
`v0.345.0 implementation stop reached. Run pentest for this exact commit.`

### v0.346.0 — Transactional Alert Notification Integration

Status: planned

Goal: connect implemented alert transitions to the generic notification outbox
without losing either state.

Deliverables:

- transactional alert-state/outbox intent with stable alert/notification IDs;
- route/escalation/SLA templates, redaction and recipient policy;
- delivery outcome linkage without allowing provider state to rewrite alerts.

Verification:

- crash before/after alert commit/outbox publish/send/receipt;
- route change, suppression/closure race, duplicate escalation, provider outage
  and cross-tenant recipient attacks;
- conservation from committed alert notification intent to terminal delivery
  outcome.

Exit criteria: every committed alert notification intent has one durable,
auditable delivery lifecycle. `v0.346.0 implementation stop reached. Run pentest
for this exact commit.`

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

### v0.376.0 — Case API Extension

Status: planned

Goal: add workload/internal case wire semantics after the state machine, without
claiming human-facing activation before session authentication.

Deliverables:

- versioned case/task/comment/evidence/hold/approval schemas and transitions;
- optimistic version, compartment, pagination, idempotency and audit binding;
- compatibility/deprecation rules independent of base API evolution.
- service-identity-only capability profile; human sessions are rejected until
  `v0.396.0`.

Verification:

- invalid/stale/concurrent transition, compartment/hold change, duplicate retry,
  pagination snapshot and old/new client cases;
- server-side authorization and immutable-evidence reference checks;
- client/service/state-machine conformance and API pentest.

Exit criteria: the case API reflects the implemented state machine rather than
freezing it early, and remains unavailable to human principals. `v0.376.0
implementation stop reached. Run pentest for this exact commit.`

### v0.382.0 — Automated Forensic Acquisition And Evidence Vault

Status: planned

Goal: validate forensic acquisition protocol, capability and vault behavior
without enabling live privileged acquisition before human authority exists.

Deliverables:

- proposed acquisition profiles for memory, process, file and platform evidence;
- dedicated acquisition capability, explicit approval, target/precondition
  fencing and separately authenticated privileged-agent protocol;
- deterministic simulator, pre-response dependency, source metadata and custody
  receipts;
- encrypted evidence vault, integrity verification, retention and legal hold.

Verification:

- partial capture, target race, oversized evidence, interruption and retry;
- unauthorized acquisition/export, key loss, hold conflict and tamper cases;
- prove ordinary collection-helper authority cannot invoke acquisition;
- prove no live privileged acquisition path is enabled;
- independent offline custody verification.

Exit criteria: acquisition scope, failure and every custody transition are
verifiable in simulation and the live capability remains disabled. `v0.382.0
implementation stop reached. Run pentest for this exact commit.`

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

### v0.392.0 — CBOR And COSE Identity Substrate

Status: planned

Goal: validate WebAuthn binary and signed objects before authentication consumes
them.

Deliverables:

- bounded pinned CBOR profile with deterministic encoding and duplicate/map-key
  policy;
- COSE key/algorithm/signature structures and crypto-provider bindings;
- generated/constants provenance, unsupported semantics and zero-third-party
  feasibility record.

Verification:

- official CBOR/COSE fixtures, non-canonical/indefinite/deep/wide/duplicate maps,
  malformed keys and algorithm confusion;
- cross-implementation vectors, fuzzing and allocation/work limits;
- exact signature-input and unknown-field behavior.

Exit criteria: WebAuthn cannot introduce an implicit CBOR/COSE implementation.
`v0.392.0 implementation stop reached. Run pentest for this exact commit.`

### v0.392.1 — JOSE, JWK, JWT And OAuth Message Substrate

Status: planned

Goal: validate OIDC tokens and OAuth messages independently of federation
workflow.

Deliverables:

- bounded JWK/JWS/JWT profiles, base64url and exact signature-input semantics;
- OAuth authorization/token/error message, PKCE, state/nonce and issuer/audience
  validation primitives;
- key-set cache/rotation, algorithm allowlist and zero-third-party feasibility.

Verification:

- pinned JOSE/OAuth vectors, algorithm/key/type confusion, duplicate JSON,
  critical headers, issuer/audience/nonce/state mix-up and key rotation;
- malformed/oversized tokens and cache outage/staleness;
- differential validation and fuzz campaigns.

Exit criteria: OIDC consumes one bounded JOSE/OAuth validator with no permissive
algorithm fallback. `v0.392.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.392.2 — XML And SAML Signature Substrate

Status: planned

Goal: bound XML and signature semantics before SAML federation uses them.

Deliverables:

- restricted XML parser with namespaces, ID typing and entity/DTD prohibition;
- pinned canonicalization and XML-signature validation profile;
- explicit encryption/transform/reference restrictions, certificate binding and
  zero-third-party feasibility decision.

Verification:

- official XML/SAML signature fixtures, wrapping, duplicate ID, namespace,
  canonicalization, external entity, transform and algorithm-confusion attacks;
- deep/wide/large input work limits and fuzzing;
- signed-element selection is identical to consumed SAML semantics.

Exit criteria: SAML cannot consume unsigned/wrongly signed elements or an
unbounded XML feature. `v0.392.2 implementation stop reached. Run pentest for
this exact commit.`

### v0.392.3 — SCIM Schema, Filter And Pagination Substrate

Status: planned

Goal: implement bounded provisioning data semantics before SCIM lifecycle
activation.

Deliverables:

- pinned core user/group/resource schemas, extensions and patch/bulk limits;
- bounded filter parser/evaluator, sorting and cursor/pagination semantics;
- ETag/version, error, unknown-extension and zero-third-party feasibility rules.

Verification:

- official SCIM fixtures, hostile filters, extension collision, patch conflict,
  pagination duplicate/omission, stale ETag and bulk exhaustion;
- schema/filter fuzzing and old/new compatibility;
- tenant/authorization enforcement for every filter/result field.

Exit criteria: provisioning cannot hide a general parser or unbounded filter
engine. `v0.392.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.393.0 — API Authentication And Session Security

Status: planned

Goal: establish phishing-resistant local human sessions before the UI.

Deliverables:

- WebAuthn registration/authentication and recovery policy;
- authenticator-data/attestation/client-data validation through `v0.392.0`;
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
- OIDC validation through `v0.392.1` and SAML XML/signatures through `v0.392.2`;
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
- schema/filter/pagination semantics through `v0.392.3`;
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

### v0.396.0 — Human API Session Activation

Status: planned

Goal: activate human-facing API surfaces only after WebAuthn/federation sessions
and identity lifecycle exist.

Deliverables:

- human session-to-capability exchange with assurance, tenant, purpose and
  reauthentication binding;
- activation of base/query/evidence/finding/rule and case API profiles;
- witnessed transition/attenuation of `v0.10.3` bootstrap operator authority into
  named WebAuthn/federated identities;
- session/federation/provisioning revocation propagation, audit and graceful
  denial for unsupported response/cluster surfaces.

Verification:

- stale/revoked session, assurance downgrade, tenant/purpose confusion,
  deprovisioning race and API token replay;
- human/workload capability separation and case compartment changes;
- end-to-end WebAuthn/OIDC/SAML-to-API pentest.

Exit criteria: every human API request derives from a current authenticated
session and only already-implemented surfaces activate. `v0.396.0 implementation
stop reached. Run pentest for this exact commit.`

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

### v0.400.0 — Live Forensic Acquisition Activation

Status: planned

Goal: enable tightly scoped live acquisition only after authentication,
authorization/elevation and independent audit are operational.

Deliverables:

- authenticated human approval bound to target, acquisition profile,
  preconditions, blast radius, expiry and evidence destination;
- separately authenticated/fenced privileged-agent acquisition worker;
- live progress, cancellation, custody transitions, failure/unknown-outcome and
  automatic capability revocation.

Verification:

- auth/session/elevation expiry, approval substitution, wrong/reused target,
  worker replay, partial acquisition, disconnect and cancellation;
- ordinary collector cannot invoke acquisition and audit destination failure
  blocks or safely records activation;
- representative platform acquisition and independent privileged-path pentest.

Exit criteria: every live acquisition is authenticated, approved, fenced,
audited and custody-bound. `v0.400.0 implementation stop reached. Run pentest for
this exact commit.`

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

### v0.402.0 — Dashboards And Scheduled Analytics Reports

Status: planned

Goal: provide governed repeatable analytics before the analyst UI renders them.

Deliverables:

- saved searches and versioned dashboard definitions with time-series, table,
  graph and coverage/completeness panels;
- snapshot, query-plan, schema/mapping and policy epoch binding plus cold-data,
  redaction, approximation and partial-result explanations;
- `v0.44.5` scheduled query/report profiles plus governed export, cancellation,
  retention, signatures and audit; delivery uses `v0.44.4` unknown outcomes;
- recipient authorization at both generation and delivery time, with redaction/
  suppression or failed delivery when authority changes.

Verification:

- definition/query/policy drift, stale snapshot, unavailable cold data,
  approximation, cancellation/retry and schedule misfire;
- recipient removal, compartment/tenant/purpose change, export leakage and
  notification unknown outcome;
- deterministic dashboard/report regeneration and signed-package verification.

Exit criteria: dashboards and reports disclose their exact data/policy context,
and scheduled delivery never relies on stale recipient authority. `v0.402.0
implementation stop reached. Run pentest for this exact commit.`

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
- `v0.402.0` saved-search/dashboard/scheduled-report views and controls;
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
authorization gates are proven, limited to already implemented local features.

Deliverables:

- tenant, identity, role, policy, trust-root, key and schema administration;
- local storage, backup, registry and audit administration;
- step-up/two-person forms, preview/diff, staged rollout and rollback controls.
- explicit unavailable placeholders for cluster, fleet, region and rolling-
  upgrade surfaces until `v0.484.1`.

Verification:

- browser security, session, CSRF, XSS, injection, clickjacking and CSP tests;
- authorization/redaction at every view/action and accessible workflows;
- end-to-end privileged administration and admin-UI pentest.

Exit criteria: the UI never replaces server-side enforcement or generated
evidence explanations and claims no later Stage K operation. `v0.405.0
implementation stop reached. Run pentest for this exact commit.`

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
- `v0.44.5` wait/delayed-compensation profiles; external effects use `v0.44.4`
  handoff and the later action ledger rather than scheduler retries;
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
- attenuated `v0.281.0` response-compartment operations for signing, short-token
  minting and authenticated calls;
- no connector/collection credential authority inheritance;
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

### v0.446.0 — Trigger Admission, Storm Controls And Kill Switches

Status: planned

Goal: prevent findings, incidents or recursive automation from creating an
unbounded response storm.

Deliverables:

- signed finding/incident-to-playbook trigger binding and admission identity;
- deduplication, cooldown, maximum concurrent runs, recursion/depth prevention
  and per-target serialization;
- global, tenant, provider, playbook and action-class kill switches with defined
  in-flight and `UnknownOutcome` behavior.

Verification:

- duplicate/cyclic findings, incident regrouping, trigger replay, hot target,
  tenant/provider floods and admission races;
- kill activation before/during dispatch, stale worker, partial propagation and
  recovery/re-enable;
- prove unknown external effects remain reconciled while new dispatch stops.

Exit criteria: automation load is bounded and every kill-switch scope has
tested fail-safe in-flight semantics. `v0.446.0 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.450.1 — Response API Extension

Status: planned

Goal: add action/playbook wire semantics only after their state machines,
envelopes and dispatch controls exist.

Deliverables:

- versioned proposal/plan/approval/run/action/outcome/reconciliation schemas;
- exact digest, idempotency, kill-switch, pagination/watch and audit binding;
- compatibility/deprecation rules independent of the base API.

Verification:

- stale plan/approval, digest substitution, duplicate request, unknown outcome,
  kill activation and old/new client cases;
- server-side authorization and no arbitrary-action construction;
- client/service/playbook/action-framework conformance and API pentest.

Exit criteria: the response API exposes only already-implemented safe state
transitions. `v0.450.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.451.0 — Endpoint Actions

Status: planned

Goal: implement narrow endpoint response profiles.

Deliverables:

- isolate/release endpoint and bounded process/file containment; any acquisition
  invokes the existing `v0.400.0` forensic capability;
- action-specific preconditions, verification, compensation and effect classes.

Verification:

- wrong/reused target identity, stale inventory and partial endpoint outcome;
- duplicate/unknown outcome, lockout, compensation and privilege attacks;
- representative platform/provider interoperability and pentest.

Exit criteria: endpoint actions expose no generic command surface, and each
claimed platform has independent target, outage and interoperability evidence.
`v0.451.0 implementation stop reached. Run pentest for this exact commit.`

### v0.451.1 — Identity Actions

Status: planned

Goal: implement narrow identity-provider response profiles.

Deliverables:

disable/re-enable account, revoke session/token and force bounded
credential reset with provider-specific preconditions and verification.

Verification:

per-provider target reuse, permission drift, rate limit, outage,
eventual consistency, duplicate/unknown outcome and live interoperability.

Exit criteria: each claimed identity provider has independent authority,
failure and interoperability evidence. `v0.451.1 implementation stop reached.
Run pentest for this exact commit.`

### v0.452.0 — Network Actions

Status: planned

Goal: implement narrow network containment profiles.

Deliverables:

- block/unblock indicators or flows through bounded device APIs;
- propagation-aware verification, compensation and blast-radius estimates.

Verification:

- NAT/address reuse, rule shadowing and eventual consistency;
- duplicate/unknown outcome, excessive target expansion and rollback failure;
- representative network/cloud interoperability and pentest.

Exit criteria: each claimed network provider has independent target, permission,
outage and interoperability evidence.
`v0.452.0 implementation stop reached. Run pentest for this exact commit.`

### v0.452.1 — Cloud Actions

Status: planned

Goal: implement narrow cloud containment profiles.

Deliverables:

cloud quarantine/tag/policy actions with account, region, resource,
policy-version, propagation and compensation semantics.

Verification:

per-provider account/region/resource confusion, permission drift,
rate limit, outage, eventual consistency, unknown outcome and interoperability.

Exit criteria: each claimed cloud provider has independent authority, blast-
radius, failure and interoperability evidence. `v0.452.1 implementation stop
reached. Run pentest for this exact commit.`

### v0.453.0 — Credential Actions

Status: planned

Goal: rotate or revoke credentials without exposing secret material.

Deliverables:

- rotate/revoke bounded credential handles without exposing secret material;
- provider-specific preconditions, verification, compensation and effect class.

Verification:

- secret exfiltration, wrong/reused credential and permission drift;
- duplicate/unknown outcome, provider timeout and compensation limitations;
- custody, privacy and connector-host pentest.

Exit criteria: each claimed credential provider has independent secret, failure
and interoperability evidence. `v0.453.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.453.1 — Evidence Actions

Status: planned

Goal: invoke, seal or export only specifically approved evidence packages
through the existing forensic capability.

Deliverables:

custody-bound `v0.400.0` acquisition invocation plus seal/export profiles with
case, target,
scope, redaction, hold, destination and verification semantics.

Verification:

wrong evidence/case/target, unauthorized export, custody break,
partial/unknown outcome, destination outage and platform interoperability.

Exit criteria: each evidence action preserves authority, custody and disclosure
boundaries. `v0.453.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.453.2 — Ticket And Notification Actions

Status: planned

Goal: update external workflow systems without leaking or duplicating incident
data.

Deliverables:

create/update/comment/notify profiles with redaction, idempotency,
external identity, link-back and delivery verification.

Verification:

per-provider permission/schema drift, rate/outage, data leakage,
duplicate/unknown outcome and live interoperability acceptance.

Exit criteria: each claimed workflow provider has independent disclosure,
failure and interoperability evidence. `v0.453.2 implementation stop reached.
Run pentest for this exact commit.`

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

## Pre-Cluster Integration Gates

### v0.456.0 — Node Measurement And Attestation Admission Decision

Status: planned

Goal: bind honest 1.0 support/non-goal decisions before node-integrity claims.

Deliverables:

- separate decisions for privileged/OS-backed runtime measurement and hardware
  measured boot/remote attestation;
- platform availability, trust anchor, freshness, privacy, recovery, operations,
  zero-third-party feasibility and support-cost analysis;
- admitted routes through `v0.456.2`–`v0.456.4`; rejected routes require tested
  non-goals at `v0.456.5` and remain `Unverifiable` where appropriate.

Verification:

- signed decision/owner for each option and exact admitted platforms/assurance;
- challenge self-measurement, compromised-process, replay and downgrade claims;
- reject any plan that converts an unavailable/untrusted report into healthy.

Exit criteria: both optional assurance levels are admitted with bounded scope or
explicitly rejected for 1.0. `v0.456.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.456.1 — Node Measurement Assurance Model

Status: planned

Goal: distinguish software-integrity evidence without implying remote attestation.

Deliverables:

- assurance states for signed-build verification, startup file/config measurement,
  privileged/OS-backed runtime measurement, hardware measured boot/remote
  attestation and `Unverifiable`;
- evidence issuer, target build/config, freshness, nonce, trust, policy and
  limitation fields with monotonic non-upgrade rules;
- explicit rule that self-report alone cannot prove a fully compromised process
  healthy or impersonate a stronger assurance level.

Verification:

- forged/replayed/stale/missing evidence, level confusion and downgrade;
- compromised self-reporter and unavailable verifier result in `Unverifiable`;
- formal/state-machine and documentation claim audit.

Exit criteria: every node-integrity result states exactly what measured it and
what remains unverifiable. `v0.456.1 implementation stop reached. Run pentest
for this exact commit.`

### v0.456.2 — Privileged OS Runtime Measurement Adapters

Status: conditional on admission at `v0.456.0`

Goal: obtain admitted runtime measurements outside the ordinary server process.

Deliverables:

- narrowly scoped OS/privileged adapters for admitted platforms and artifacts;
- authenticated evidence bound to process/image/config/build identity and epoch;
- capability discovery, freshness, failure and unsupported-platform semantics.

Verification:

- compromised/unavailable helper, process replacement, stale PID/image and TOCTOU;
- forged/replayed evidence, permission loss and platform update matrix;
- no-third-party feasibility and privileged-boundary pentest.

Exit criteria: admitted OS-backed evidence cannot be replaced by process self-
report. `v0.456.2 implementation stop reached. Run pentest for this exact commit.`

### v0.456.3 — Hardware Measured-Boot Evidence Acquisition

Status: conditional on admission at `v0.456.0`

Goal: acquire admitted hardware/firmware-backed boot measurements and identity.

Deliverables:

- supported root-of-trust, boot/event-log and device identity profiles;
- nonce-bound evidence acquisition with firmware/boot-chain/config provenance;
- enrollment, key rotation/revocation, privacy and unavailable-state behavior.

Verification:

- replay, cloned identity, stale boot log, reset/reprovision and trust-root change;
- malformed event log, unsupported firmware and hardware-provider outage;
- real-device interoperability and hardware-boundary pentest.

Exit criteria: hardware evidence is attributable, fresh and limited to its exact
measured boundary. `v0.456.3 implementation stop reached. Run pentest for this
exact commit.`

### v0.456.4 — Remote Attestation Verification And Policy

Status: conditional on admission at `v0.456.0`

Goal: verify hardware-backed evidence without allowing replay or policy confusion.

Deliverables:

- challenge/nonce, verifier identity, reference values, freshness and verdicts;
- build/config/boot policy binding, revocation, cache limits and audit evidence;
- `Trusted`/`Rejected`/`Unverifiable` results without binary false-green fallback.

Verification:

- nonce replay, verifier compromise/outage, stale reference value and mixed policy;
- valid hardware with unapproved build, approved build with incomplete evidence;
- independent protocol/cryptographic/attestation pentest.

Exit criteria: only fresh evidence under the exact admitted trust policy produces
an attested result. `v0.456.4 implementation stop reached. Run pentest for this
exact commit.`

### v0.456.5 — Node Attestation Scope Closure

Status: planned

Goal: close both optional node-assurance decisions before server integrity ships.

Deliverables:

- if admitted: integrate and independently audit the applicable `v0.456.2`–
  `v0.456.4` paths with platform/support boundaries;
- if rejected: explicit 1.0 non-goal, disabled configuration/API/claim paths and
  mandatory `Unverifiable` handling;
- either path updates cluster admission, operations, SDK/API and documentation.

Verification:

- admitted path: end-to-end evidence, downgrade, outage and real-platform matrix;
- rejected path: configuration/API rejection and support-claim audit;
- self-report can never be promoted to OS-backed or hardware-attested health.

Exit criteria: privileged runtime measurement and hardware remote attestation are
each implemented within admitted bounds or conclusively excluded from 1.0.
`v0.456.5 implementation stop reached. Run pentest for this exact commit.`

### v0.457.0 — Server And Node Software Integrity Baseline

Status: planned

Goal: give server/node runtimes mandatory signed/startup identity protections
without overstating the optional assurance closed at `v0.456.5`.

Deliverables:

- signed server binary/component/update manifests with build/toolchain identity;
- startup binary/build/configuration digest measurement labeled under `v0.456.1`;
- anti-rollback, incompatible-feature rejection and revoked-build policy;
- explicit impaired/unmeasurable state rather than false healthy integrity;
- optional OS/hardware evidence only through admitted `v0.456.5` paths; ordinary
  process self-measurement never claims remote attestation.

Verification:

- binary/helper/config/manifest substitution, signature confusion and rollback;
- measured-after-start mutation where detectable, missing measurement and stale
  revocation/configuration;
- compromised self-report remains `Unverifiable` and triggers configured policy;
- supported server OS/package/update matrix and independent node-integrity pentest.

Exit criteria: no server build activates with trusted build identity without
signature verification, anti-rollback and an honest `v0.456.1` measurement state.
`v0.457.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.457.1 — Tenant Destruction Audit And External-Receipt Policy

Status: planned

Goal: define what security evidence may survive tenant destruction without
preserving tenant authority.

Deliverables:

- policy for retained, minimized or pseudonymized audit tenant identity and
  statutory/compliance retention;
- separate audit key domains, crypto-shred/rotation behavior and legal-hold/
  statutory-retention precedence;
- credential-vault remnant, notification-delivery record and external-action
  receipt disposition with purpose/access/expiry limits;
- independent audit-replica deletion/retention proof and permanent non-authority
  tombstone preventing credential/session/tenant reactivation.

Verification:

- destroy under legal hold/statutory retention, audit-key loss/rotation and expiry;
- restore retained audit/remnants without tenant keys, sessions or capabilities;
- vault handle/notification/action receipt cannot reactivate or address tenant;
- independent privacy, compliance, audit-separation and resurrection pentest.

Exit criteria: every permitted post-destruction residue is minimal, separately
keyed, purpose-bound and cryptographically incapable of restoring authority.
`v0.457.1 implementation stop reached. Run pentest for this exact commit.`

### v0.458.0 — Single-Node Tenant Lifecycle Integration Gate

Status: planned

Goal: prove `v0.17.1` across every completed local product plane before clustering.

Deliverables:

- suspend/read-only/quarantine/hold/offboard/destroy propagation through sessions,
  agents, connectors, ingest, storage, queries, detection, cases, reports, jobs,
  actions, caches, exports, keys and backups;
- all-plane lifecycle conformance harness and transition/denial evidence;
- restore/resurrection, tenant-ID/key-domain tombstone and deletion-proof audit;
- `v0.457.1` disposition across local audit, vault remnants, notification
  delivery and action receipts with retained evidence unable to restore authority.

Verification:

- transition at every queued/running/checkpointed/cached/exported state;
- stale tokens/agents/jobs/actions/caches, concurrent hold/offboard/destroy and
  restore from every local backup/cold/spill class;
- retained/pseudonymized audit access, expiry and non-reactivation tests;
- cross-plane single-node pentest and independent deletion-proof review.

Exit criteria: no completed local plane can outlive or bypass the tenant lifecycle;
distributed work may now preserve this conformance rather than invent it.
`v0.458.0 implementation stop reached. Run pentest for this exact commit.`

## Phase K — Control Plane, Cluster And Federation

### v0.459.0 — Operational-State Durability Matrix

Status: planned

Goal: assign consistency and recovery ownership before clustering mutable state.

Deliverables:

- matrix for detection state, connector checkpoints, alerts/incidents/cases,
  playbooks/actions/approvals, live-query leases and saved queries;
- human sessions/WebAuthn credentials/revocations/elevation, notification
  outbox/delivery, acquisition/custody, backfill/reprocessing, API idempotency,
  audit records and audit cursors;
- allowed/revoked build identity, `v0.456.1` assurance level, node measurement,
  admission, drain and quarantine state from `v0.457.0`;
- durable scheduler jobs for cold rehydration, backup/restore, repair/reindex,
  rule rollout, retro-hunt/risk recompute, report/export, certificate/key renewal,
  tenant offboarding and playbook wait/compensation, including classes whose RPO
  is rebuild from immutable evidence;
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

### v0.460.0 — Static Control Schema And Dissemination

Status: planned

Goal: define and disseminate signed candidate configuration without claiming
consensus-backed distributed activation.

Deliverables:

- node/fleet identity, trust roots, config, schema, parser, rule and component
  registries, policy, tenant, storage and upgrade metadata;
- allowed/revoked `v0.457.0` server build identities and exact `v0.456.1`
  assurance requirements bound to each candidate configuration epoch;
- current/previous candidate epoch, validation, staging, rollback, drift and
  audit; local nodes retain `v0.17.0` activation authority;
- bootstrap, break-glass and least-privilege administration;
- compatibility and semantic-equivalence proof with local authorization,
  registry, trust-root and audit contracts.

Verification:

- unauthorized/stale/tampered/partial candidate epoch and split dissemination;
- unknown/revoked build, evidence below required assurance, `Unverifiable` policy
  and build/config digest mismatch;
- rollover, rollback, drift, break-glass and compromised admin scenarios;
- control-plane API/UI pentest.

Exit criteria: nodes cannot stage unauthenticated or invalid configuration, and
no distributed activation or consistency claim is made. `v0.460.0 implementation
stop reached. Run pentest for this exact commit.`

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

### v0.465.1 — Consensus-Backed Control Activation

Status: planned

Goal: activate distributed control epochs only through the implemented metadata
consensus path.

Deliverables:

- committed candidate-to-active transition, quorum proof and activation epoch;
- node compatibility/readiness, staged rollout, fencing, rollback and drift;
- cluster admission rejects unknown/revoked builds or evidence below the epoch's
  required `v0.456.1` assurance and binds the admitted result to activation;
- semantic equivalence with local control, authorization, registry, trust-root
  and audit behavior.

Verification:

- partition/leader change/crash before and after commit/activation;
- stale/incompatible node, partial rollout, rollback, trust change and audit
  destination failure;
- revoked build, assurance downgrade and measurement change before/during activation;
- no node activates an uncommitted or invalid epoch.

Exit criteria: distributed configuration becomes authoritative only after a
valid consensus commit and local validation. `v0.465.1 implementation stop
reached. Run pentest for this exact commit.`

### v0.465.2 — Operational-State CFT Model

Status: planned

Goal: prove shared mutable-state semantics before implementing a second class of
replicated system.

Deliverables:

- reuse `v0.462.0` authenticated-CFT assumptions and the `v0.465.0` algorithm in
  independent sharded groups with separate storage/scheduling;
- formal refinements for linearizable conditional writes, total per-shard journal
  order, fencing epochs, lease safety, snapshots/compaction and watch continuity;
- explicit cross-shard non-atomicity, idempotency, recovery and liveness limits.

Verification:

- bounded formal exploration of concurrent/stale writes, leader loss, partition,
  snapshot installation/compaction, lease expiry and membership changes;
- counterexample review for clock uncertainty, stale fencing and watch gaps;
- CFT/BFT claim audit and traceable safety invariants.

Exit criteria: conditional-write, journal, lease, fencing, snapshot and watch
safety hold under the documented CFT assumptions. `v0.465.2 implementation stop
reached. Run pentest for this exact commit.`

### v0.465.3 — Replicated Operational-State Engine

Status: planned

Goal: implement the modeled shared substrate before state-specific HA layers.

Deliverables:

- sharded consensus groups with partitioned conditional writes, replicated
  journals and fencing epochs;
- leases, snapshots, compaction, watch streams and idempotency records;
- separate storage/scheduling, tenant quotas, encryption, backup/restore,
  migration, RPO/RTO and impairment interfaces.

Verification:

- implementation/model trace comparison under deterministic network schedules;
- concurrent/stale writes, leader/owner loss, partition, duplicate/reorder,
  snapshot/compaction race, watch gap, restore and tenant isolation;
- sustained fault/load campaign and operational-state pentest.

Exit criteria: the engine conforms to `v0.465.2`; later HA milestones add only
state-class semantics. `v0.465.3 implementation stop reached. Run pentest for
this exact commit.`

### v0.466.0 — Detection-State Placement And Failover

Status: planned

Goal: make detection checkpoints/state highly available without changing rule
semantics.

Deliverables:

- detection-state schema and placement adapter over `v0.465.3`;
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

- connector/subscription adapters over `v0.465.3`;
- connector/checkpoint and live/saved-query lease placement with ownership
  epochs;
- connector and subscription cursor replication, resume, handoff and duplicate/
  gap evidence;
- provider-rate and tenant-fairness behavior during recovery.

Verification:

- dual owner, stale lease, crash between fetch/checkpoint, provider replay,
  subscriber reconnect and partition;
- exact cursor conservation and query resume semantics;
- failover storms and lease-store exhaustion.

Exit criteria: failover creates neither an unreported collection gap nor an
unfenced duplicate owner. `v0.467.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.467.1 — Identity Session And Revocation HA

Status: planned

Goal: preserve authentication and elevation safety across failure and failover.

Deliverables:

- WebAuthn credential metadata, human/workload sessions, revocations and
  elevation-grant adapters over `v0.465.3`;
- fencing, expiry, reauthentication and revocation propagation RPO/RTO;
- recovery that cannot resurrect expired or revoked authority.

Verification:

- failover concurrent with login, logout, rotation, revoke and elevation expiry;
- stale replica/session, partition, clock uncertainty and restore;
- no duplicate credential or revived grant across ownership change.

Exit criteria: identity failover is availability-preserving but never authority-
expanding. `v0.467.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.467.2 — Job, Notification And API Ledger HA

Status: planned

Goal: fail over bounded background jobs and outward delivery/idempotency state.

Deliverables:

- backfill/reprocessing and forensic-acquisition job adapters over `v0.465.3`;
- notification outbox/delivery and API idempotency ledgers;
- `v0.457.1` tenant-destruction disposition for delivery records and external
  action receipts, retaining no routable tenant authority;
- fenced ownership, progress/custody checkpoints, retry/unknown-outcome and
  per-class RPO/RTO.

Verification:

- failover at every job checkpoint, acquisition custody step, notification send
  and API side effect;
- stale worker, duplicate retry, unknown outcome, cancellation and restore;
- conservation and no authority/custody expansion after failover.

Exit criteria: failover neither duplicates outward effects nor loses job,
delivery or custody state silently. `v0.467.2 implementation stop reached. Run
pentest for this exact commit.`

### v0.467.3 — Independent Audit Record HA

Status: planned

Goal: replicate audit records and cursors without joining the authority domain
of the operations they record.

Deliverables:

- independently keyed audit-record/cursor adapters over `v0.465.3`;
- independently deployed audit consensus groups with separate administrative,
  scheduler, storage and failure domains from operational state;
- append sequencing, remote placement, acknowledgement, gap and retention RPO/
  RTO while preserving independent writer/reader roles;
- `v0.457.1` retained/pseudonymized tenant identity, separate audit key domains,
  legal/statutory hold precedence and post-destruction access/expiry policy;
- independent audit replicas participate explicitly in retention, crypto-shred
  and deletion proofs without joining tenant authority;
- failover/restore verification and explicit unavailable-audit behavior.

Verification:

- writer/admin/replica failure, partition, omission, reorder, duplicate, stale
  cursor, full destination and restore;
- compromised operational authority cannot alter replicated audit history;
- loss/compromise of the operational-state cluster does not remove the audit
  replica set or its recovery authority;
- tenant destruction cannot erase required retained audit, reactivate authority
  through it or leave an undeclared independently replicated copy;
- offline sequence/signature comparison after failover.

Exit criteria: audit HA increases availability without merging audit and
operational authority or failure domains. `v0.467.3 implementation stop reached.
Run pentest for this exact commit.`

### v0.467.4 — Durable Scheduler HA Adapter

Status: planned

Goal: fail over `v0.44.1`–`v0.44.7` scheduler state/dispatch semantics through
the replicated operational-state engine without duplicate authority.

Deliverables:

- `v0.44.2` job/trigger/checkpoint store adapter over `v0.465.3` with fencing
  epochs and leases;
- partition/tenant placement, failover, snapshot/restore and watch-driven worker
  dispatch;
- preservation of monotonic-versus-wall schedule, misfire/catch-up/skip,
  cancellation, dependency and idempotency semantics;
- HA `HandoffPending`/outbox durability protocol with stable effect identity and
  one `v0.467.2` outbox record across owner/leader failover;
- per-job-class RPO/RTO and rebuild-from-immutable-evidence option where declared.

Verification:

- owner loss/partition/clock change at every claim/checkpoint/complete boundary;
- failover at each scheduler-intent/outbox-durable/HandedOff boundary and
  cancellation after handoff;
- stale worker, duplicate dispatch, lease expiry, dependency storm, restore and
  tenant/noisy-neighbor failures;
- local/HA scheduler state-machine equivalence and canonical idempotent outcomes.

Exit criteria: scheduled work survives failover within declared RPO/RTO without
exactly-once claims or concurrent unfenced owners. `v0.467.4 implementation stop
reached. Run pentest for this exact commit.`

### v0.468.0 — Alert, Incident And Case State HA

Status: planned

Goal: preserve mutable analyst workflow under node failure and concurrency.

Deliverables:

- analyst operational-state schema and journal adapter over `v0.465.3`;
- partitioned replicated operational journal, optimistic versions and fencing;
- alert/incident/case/SLA consistency and conflict-resolution rules;
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

- playbook/action/approval/outbox adapters over `v0.465.3`;
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

- partition placement, sealed-segment replica acknowledgement, rack awareness
  and bandwidth priorities; this does not enable `DurableQuorum` for hot writes;
- authenticated segment transfer, integrity comparison, repair and rebalance;
- authenticated raw-object chunk/manifest transfer and atomic segment/raw-
  reference publication for sealed generations;
- lag, under-replication, corruption and unavailable-partition evidence.

Verification:

- node/rack loss, partition, stale/corrupt replica, rebuild and rebalance;
- missing/corrupt raw chunk/manifest, dangling reference and atomic publication;
- quorum/RPO invariants, acknowledgement truth and split-brain scenarios;
- load/chaos campaign and storage-cluster pentest.

Exit criteria: committed durability claims match the exact failure model.
`v0.470.0 implementation stop reached. Run pentest for this exact commit.`

### v0.471.0 — Active-Write Replication And Quorum Acknowledgement

Status: planned

Goal: make low-latency `DurableQuorum` truthful for unsealed WAL and hot batches.

Deliverables:

- write-shard leader/ownership epoch, fenced writers and replicated WAL/hot-
  batch records;
- raw-object chunks/manifests and mapping/provenance records required by each hot
  batch, preserving atomic fact/reference/object publication;
- source/session/sequence deduplication, quorum commit index and stable-media
  acknowledgement mapping;
- crash/re-election recovery, divergent-tail truncation and handoff to immutable
  segment replication.

Verification:

- leader crash/partition before and after local/remote write/fsync/ack;
- stale writer, duplicate source sequence, divergent log, quorum loss, full disk
  and seal race;
- model/property proof that every `DurableQuorum` acknowledgement survives the
  documented quorum failure and produces one canonical idempotent storage
  outcome;
- traceability to `v0.462.0` CFT assumptions and `v0.463.0`/`v0.465.0`
  consensus safety, including raw-object quorum state.

Exit criteria: `DurableQuorum` is advertised only when active-write replication
and recovery prove every promised durability-vector component; raw
reconstructability is never implied without quorum-durable chunks/manifests.
`v0.471.0 implementation stop reached. Run pentest for this exact commit.`

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

### v0.474.1 — Distributed Tenant Lifecycle Propagation

Status: planned

Goal: extend `v0.17.1` tenant authority and destruction semantics across every
cluster and region while preserving `v0.458.0` single-node conformance.

Deliverables:

- consensus-committed lifecycle epoch and fenced propagation to sessions,
  agents, connectors, queries, scheduler jobs, actions, caches and API tokens;
- provisioning/deprovisioning of placement, replicas, cold data, backups,
  operational state and per-tenant key domains;
- hold/export precedence, distributed crypto-shred/deletion proof and permanent
  tenant-ID/key-domain tombstone;
- recovery/failover rules that cannot revive suspended/offboarding/destroyed
  authority from stale replicas or backups;
- `v0.457.1` disposition for credential-vault remnants, notification records,
  external action receipts and separately keyed independent audit replicas;
- legal-hold/statutory-retention precedence and pseudonymized permanent
  non-authority tombstones across regions;
- shared conformance suite proving local and distributed lifecycle outcomes do
  not diverge.

Verification:

- partition/region outage during activate/suspend/hold/offboard/destroy;
- stale session/agent/job/cache/action, failover, restore and rolling upgrade;
- deletion/shred proof across replicas, cold tiers, backup, spill and operational
  state plus independent audit replicas and tenant-ID/key reuse attacks;
- retained audit/remnant access cannot mint credentials, address notifications,
  invoke actions or restore tenant/session identity;
- single-node/distributed trace equivalence for every lifecycle transition.

Exit criteria: tenant lifecycle state and denial propagate within declared bounds,
and destroyed authority/data cannot resurrect. `v0.474.1 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.476.0 — Distributed Physical Query Execution

Status: planned

Goal: execute federated plans across workers with bounded exchange, coordination
and failure semantics.

Deliverables:

- authenticated fragment distribution and tenant/snapshot/policy-bound exchange;
- repartition/shuffle, partial aggregation, distributed joins and bounded graph
  traversal;
- coordinator/worker memory limits, backpressure, cancellation, retry,
  duplicate-fragment identity, straggler and worker-loss handling.

Verification:

- fragment substitution/replay, stale policy/snapshot, skewed shuffle, coordinator
  exhaustion, worker loss, partition, retry duplicate and straggler;
- distributed/local result and completeness equivalence;
- noisy-tenant fairness, cancellation propagation and cross-worker leakage.

Exit criteria: distributed execution cannot exceed coordinator/tenant authority
or present partial worker results as complete. `v0.476.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.478.0 — SRE Operations And Supportability

Status: planned

Goal: expose the operational evidence required to run Vakaheim safely at scale.

Deliverables:

- service objectives, health/dependency graph, saturation and error budgets,
  safe diagnostics, support bundles, capacity forecasts and runbooks;
- extension contract for later discovery/routing endpoint, route, leader,
  backpressure, drain and regional-availability health.

Verification:

partial outage, false-green health, telemetry loss, diagnostic
redaction, overload, upgrade and on-call game-day scenarios.

Exit criteria: operators can distinguish healthy, degraded and unverifiable
states without privileged data leakage. `v0.478.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.479.0 — Cluster Service Discovery And Data-Plane Routing

Status: planned

Goal: route clients to healthy authoritative services without requiring an
external load balancer for correctness.

Deliverables:

- authenticated node/endpoint discovery for native ingest, OTLP, API, query and
  relay services;
- write-shard leader/ownership discovery, stale-route fencing and bounded
  redirect versus authenticated-proxy policy;
- certificate/SNI/tenant binding, affinity, retry budgets, backpressure, loop
  prevention and connection drain during upgrade/evacuation;
- source sequence/session and acknowledgement-state preservation across reroute;
- discovery/routing health integrated into the `v0.478.0` dependency model;
- explicit unavailable outcome when no healthy endpoint exists in the current
  region; this milestone grants no cross-region reroute/failover authority.

Verification:

- stale/poisoned discovery, leader move, redirect/proxy loop, certificate/SNI/
  tenant confusion and compromised endpoint;
- node/region/control-plane outage, drain, retry storm, slow proxy and partition;
- total regional endpoint loss reports unavailability without attempting another
  region before `v0.480.0` policy/authority exists;
- end-to-end duplicate/gap/acknowledgement truth under rerouting for every
  admitted protocol.

Exit criteria: in-region rerouting preserves authority, sequence and durability
semantics, regional exhaustion is explicit, and no external balancer is part of
the correctness model. `v0.479.0
implementation stop reached. Run pentest for this exact commit.`

### v0.479.1 — End-To-End Backend Binding And Proxy Trust

Status: planned

Goal: define exactly what routing proxies can attest, terminate and forward.

Deliverables:

- per-protocol trust profile for native ingest, OTLP, API/query, browser and relay;
- native end-to-end backend binding for durability acknowledgements, source/
  session/sequence identity, query snapshot/policy epochs, response completeness
  and backend service/build identity plus its `v0.456.1` assurance state;
- proxy capabilities that cannot forge `DurableQuorum`, widen authority,
  substitute tenant/source, or convert backend failure/partial results to success;
- where OTLP/browser standards terminate at the proxy, explicit proxy membership
  in that protocol's TCB, narrow service identity, authenticated backend hop,
  audit and disclosed claim limits.

Verification:

- compromised proxy forges ack/completeness/backend identity or swaps tenant;
- replay/substitution across backend, route, session, snapshot and policy epochs;
- terminating-proxy confused-deputy, capability widening and failure laundering;
- end-to-end cryptographic/protocol binding and routing-proxy pentest.

Exit criteria: every routed response states its trust terminus; a proxy cannot
claim backend facts it cannot cryptographically or protocol-bind. `v0.479.1
implementation stop reached. Run pentest for this exact commit.`

### v0.480.0 — Multi-Region Replication And Failover

Status: planned

Goal: survive regional failure under explicit consistency, sovereignty and data-
loss contracts.

Deliverables:

- region-aware placement, asynchronous replication, failover and sovereignty;
- policy-authorized cross-region discovery/routing activation with regional
  fencing, endpoint identity, tenant/residency and failback authority;
- `v0.479.1` end-to-end/TCB bindings preserved across regional proxy/backend hops;
- per-state-class regional RPO/RTO, authority and completeness evidence;
- failover/failback fencing, lag, conflict and unavailable-region behavior.

Verification:

- region loss, total partition, stale owner, lag, conflict and key/trust outage;
- prove cross-region routing is impossible before committed failover authority
  and preserves acknowledgement/session truth after activation;
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
- signed server update manifests, allowed-build epoch transitions and anti-rollback;
- `v0.44.7` scheduler-journal/outbox handoff compatibility and migration order;
- schema/format/protocol/state migration and downgrade boundaries;
- automatic abort, deterministic rollback and irreversible-step approval.

Verification:

- every supported mixed-version pair, crash/partition during each step and
  rollback after partial migration;
- stale binary/config, incompatible state and failed drain/handoff;
- unknown/revoked build, manifest rollback and binary/config measurement mismatch;
- old/new scheduler/outbox crash during atomic effect handoff and cancellation;
- full single-node/cluster/multi-region upgrade rehearsal.

Exit criteria: unsupported downgrade fails before mutation, and supported
rollback restores a defined prior state. `v0.483.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.483.1 — Runtime Measurement Drift And Node Quarantine

Status: planned

Goal: contain an admitted node whose measured state changes or becomes unverifiable.

Deliverables:

- periodic/on-demand evidence labeled as startup, OS-backed or hardware-attested
  strictly according to `v0.456.1` and `v0.456.5` admission;
- ordinary self-measurement never upgrades assurance; an untrusted/unavailable
  report becomes `Unverifiable`, not healthy;
- authenticated drain, admission revoke, quarantine and recovery/reimage workflow;
- workload/leadership handoff, impairment evidence and operator escalation.

Verification:

- runtime/config mutation, measurement unavailable, compromised self-report,
  assurance downgrade, stale result and false report;
- change during ingest/query/job/action/leadership and concurrent node failures;
- drain timeout, quarantine bypass, rollback/rejoin and node-integrity pentest.

Exit criteria: measurement drift cannot remain silently authoritative; the node
drains or is fenced/quarantined with explicit availability impact. `v0.483.1
implementation stop reached. Run pentest for this exact commit.`

### v0.484.0 — Distributed Scale And Failover Campaign

Status: planned

Goal: test distributed capabilities only after replication, evacuation,
operational-state HA, federation, SRE and recovery exist.

Deliverables:

- multi-terabyte/day cluster workload with ingest, query, detection, connectors,
  analyst state, actions, durable scheduled jobs, repair, evacuation and
  multi-region replication;
- discovery/routing, leader movement, drain and backpressure workloads across
  native ingestion, OTLP, API/query and relay planes;
- distributed tenant activation, suspension, hold, offboarding and destruction
  transitions while work is queued, running, retrying and rerouted;
- exact topology/hardware/configuration/data/rules/failure schedule and commits;
- measured RPO/RTO, acknowledgement, completeness and impairment evidence.

Verification:

- node/rack/region loss, quorum partition, disk evacuation, stale owner, failover,
  rebalance, noisy tenant and rolling upgrade;
- scheduler fencing/misfire recovery, routing-loop prevention, stale discovery,
  tenant-state propagation delay and credential/key revocation during failover;
- conservation and semantic equivalence across every state class;
- independent reproduction and distributed-system pentest.

Exit criteria: distributed durability, availability and recovery claims have
fault-injected quantitative evidence. `v0.484.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.484.1 — Cluster Administration API And UI Extension

Status: planned

Goal: expose cluster, fleet, region and upgrade administration only after those
services and their failure campaigns exist.

Deliverables:

- versioned cluster/fleet/placement/replication/repair/evacuation API surfaces;
- region/failover/backup/air-gap/upgrade/rollback controls and status views;
- plan/diff/impact preview, step-up/two-person approval, staged execution,
  cancellation limits and complete audit linkage.

Verification:

- stale topology/plan, wrong node/region/disk, partial outage, concurrent admin,
  approval/session expiry and rollback boundary;
- browser/API authorization, CSRF/XSS/injection and cross-tenant/region policy;
- end-to-end operator game days and cluster-admin pentest.

Exit criteria: administrative surfaces expose only implemented Stage K
capabilities and cannot bypass their safety workflows. `v0.484.1 implementation
stop reached. Run pentest for this exact commit.`

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

### v0.490.0 — Privacy Policy Model

Status: planned

Goal: define one privacy-policy model before product planes enforce it.

Deliverables:

- data classes, purposes, subjects, jurisdictions, obligations and policy epochs;
- precedence/conflict rules across tenant, case, legal hold and operator policy;
- decision/explanation interface with deny/unknown/fail-closed semantics.

Verification:

- exhaustive policy precedence and conflict tables;
- stale/missing epoch, unknown jurisdiction, malformed policy and downgrade;
- independent privacy model and authorization-boundary review.

Exit criteria: every privacy decision has one versioned input, result and
explanation contract before enforcement is distributed.
`v0.490.0 implementation stop reached. Run pentest for this exact commit.`

### v0.495.0 — Field Protection And Purpose Enforcement

Status: planned

Goal: enforce field visibility and purpose limitation across every use path.

Deliverables:

- field redaction, tokenization, minimization and purpose-bound access;
- enforcement at ingest, storage, index, query, detection, case, export, AI and
  response boundaries;
- cache, derived-value, aggregate and explanation labeling.

Verification:

- cross-plane policy matrix and stale-policy races;
- inference, aggregation, cache/index/spill/export and derived-field leakage;
- tenant, role, purpose and emergency-access adversarial combinations.

Exit criteria: no direct or derived field bypasses the same purpose-bound policy.
`v0.495.0 implementation stop reached. Run pentest for this exact commit.`

### v0.500.0 — Residency Placement Enforcement

Status: planned

Goal: enforce jurisdiction and residency constraints in placement and movement.

Deliverables:

- residency labels for evidence, indexes, operational state, backups and exports;
- placement, replication, repair, failover and rehydration policy enforcement;
- denied/unavailable/exception evidence and migration planning.

Verification:

- node/region loss, evacuation, restore, cold rehydrate and federation;
- mislabeled destination, stale topology, mixed jurisdiction and failover pressure;
- prove no prohibited copy through cache, spill, diagnostic or support paths.

Exit criteria: availability pressure cannot silently override residency policy.
`v0.500.0 implementation stop reached. Run pentest for this exact commit.`

### v0.510.0 — Retention And Deletion Proof

Status: planned

Goal: prove retention, hold and deletion outcomes across all storage classes.

Deliverables:

- retention evaluation for facts, raw data, indexes, cold tiers, caches and state;
- legal-hold precedence, crypto-shred, physical cleanup and tombstone evidence;
- replica, backup, spill and restore-aware deletion proofs.

Verification:

- concurrent hold/expiry/delete/export, outage and partial cleanup;
- restore from stale backup, key-domain reuse and deleted-data reappearance;
- proof completeness and honest residual-media limitation review.

Exit criteria: each retained, held or deleted object has a truthful auditable
outcome across every declared copy class. `v0.510.0 implementation stop reached.
Run pentest for this exact commit.`

### v0.520.0 — Compliance Workflows And Access Reporting

Status: planned

Goal: expose governed privacy workflows without creating a policy bypass.

Deliverables:

- subject/access/export/correction/deletion request workflow where applicable;
- purpose/residency/retention access reports and signed decision evidence;
- approvals, deadlines, exceptions, redaction and operator documentation.

Verification:

- identity fraud, scope expansion, deadline race and conflicting legal hold;
- report incompleteness, unauthorized recipient and export exfiltration;
- independent workflow, audit and compliance-evidence assessment.

Exit criteria: workflows expose and execute only policy-authorized outcomes with
complete audit linkage. `v0.520.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.530.0 — Approved Cryptographic Mode Admission

Status: planned

Goal: decide whether any regulated cryptographic operating mode can be claimed
without confusing algorithm tests with module validation.

Deliverables:

- exact approved algorithms/providers/modules, certificate/validation status,
  platform/build/configuration boundary and operational mode indicator;
- self-test, entropy, key lifecycle, error-state, audit and configuration-lock
  requirements for the admitted mode;
- explicit rejection path: without an applicable validated module and complete
  boundary evidence, no FIPS 140-3 or equivalent claim is made for 1.0.

Verification:

- validated-boundary provenance/status, power-up/conditional self-tests, forced
  failure/error state and non-approved algorithm rejection;
- platform/build/config drift, mixed-mode, downgrade and operator-misreporting;
- independent cryptographic compliance and security assessment.

Exit criteria: regulated-mode documentation names the exact validated boundary,
or states unambiguously that Vakaheim 1.0 has no such claim. `v0.530.0
implementation stop reached. Run pentest for this exact commit.`

### v0.540.0 — Endpoint Resource Performance

Status: planned

Goal: prove sensor and relay resource targets on published reference systems.

Deliverables:

- CPU, memory, disk, network, battery and spool evidence per supported platform;
- steady, burst, offline, catch-up, degraded-permission and update workloads;
- exact hardware/OS/build/configuration/data and measurement methodology.

Verification:

- repeated idle/steady/burst/failure runs and regression thresholds;
- overload, disk pressure, thermal/battery constraints and visibility impairment;
- independent endpoint result reproduction.

Exit criteria: endpoint overhead claims are reproducible per supported platform
and never hide evidence loss. `v0.540.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.550.0 — Ingest And Storage Performance

Status: planned

Goal: prove conservation and durability under sustained ingest and storage load.

Deliverables:

- source/relay/ingest throughput, latency, burst reserve and backpressure results;
- WAL/segment/index/raw/cold/retention/compaction/scrub/backup capacity results;
- exact reference systems, data distributions, schemas, encryption and commits.

Verification:

- cold/warm/steady/burst, disk-full, corruption, reindex and retention overlap;
- multi-terabyte/day duration, noisy tenant and resource-exhaustion thresholds;
- conservation, acknowledgement and impairment evidence plus reproduction.

Exit criteria: ingest/storage performance claims preserve declared durability and
loss truth. `v0.550.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.560.0 — Query Detection And Analyst Performance

Status: planned

Goal: prove interactive and continuous workloads within bounded admission rules.

Deliverables:

- query, dashboard, report, graph, live and cold-rehydration latency evidence;
- detection throughput/state, retro-hunt, risk and intelligence-match evidence;
- analyst/API concurrency, cancellation, fairness and worst-case cost results.

Verification:

- skew, high cardinality, adversarial query/rule and cold/partial data;
- concurrent ingest/detection/query/report/analyst load and noisy tenants;
- result equivalence, completeness and independent reproduction.

Exit criteria: latency and capacity claims retain correct results, policy and
honest partial behavior. `v0.560.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.570.0 — Cluster Failover And Recovery Performance

Status: planned

Goal: quantify distributed scale, failure and recovery separately from local load.

Deliverables:

- node/rack/region scale, replication, routing, rebalance and evacuation results;
- scheduler/state/query failover and backup/restore/repair/reindex RPO/RTO;
- topology, hardware, placement, tenant, workload and fault schedule evidence.

Verification:

- quorum loss/return, rolling upgrade, leader movement and regional failover;
- simultaneous workload/failure, degraded links, noisy tenant and recovery storm;
- independent quantitative reproduction and claim-boundary review.

Exit criteria: cluster and recovery claims have reproducible fault-injected
evidence without broadening the failure model. `v0.570.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.580.0 — Fuzz Conformance And Parser Verification

Status: planned

Goal: run release-duration fuzzing and conformance against every untrusted format.

Deliverables:

- sustained codec/parser/protocol/format/planner fuzz campaigns;
- normative positive/negative conformance and differential/metamorphic corpora;
- coverage, sanitizer-equivalent instrumentation and residual gap inventory.

Verification:

- crash/timeout/resource thresholds and corpus minimization/replay;
- mutation testing or equivalent test-effectiveness sampling per family;
- independent review of unreachable states and unfuzzed boundaries.

Exit criteria: every untrusted grammar has release-duration adversarial evidence
and explicit remaining limits. `v0.580.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.590.0 — Formal Concurrency And Memory Verification

Status: planned

Goal: consolidate proof, concurrency and memory-safety evidence at release scope.

Deliverables:

- Kani/model checks for bounded critical invariants and protocol refinements;
- Loom/first-party deterministic schedules for admitted concurrency contracts;
- Miri, unsafe inventory, allocator-failure and architecture-width evidence.

Verification:

- release-duration state exploration and implementation/model trace comparison;
- cancellation, ownership, fencing, snapshot, queue and shutdown race suites;
- independent proof-assumption and residual unsafe-boundary review.

Exit criteria: critical state/concurrency/memory invariants have reproducible
evidence and named limits. `v0.590.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.600.0 — Chaos Corruption And Power-Loss Verification

Status: planned

Goal: exercise destructive failure behavior across every supported topology.

Deliverables:

- crash, power-loss, corruption, disk-full, network and clock fault campaigns;
- single-node, cluster, multi-region, air-gap and endpoint recovery scenarios;
- conservation, durability-vector, impairment and recovery evidence bundles.

Verification:

- faults at each durable transition and simultaneous dependent failures;
- stale/partial restore, corrupt backup, uncertain clock and operator error;
- independent chaos schedule reproduction and invariant review.

Exit criteria: every promised recovery path survives its declared fault model or
fails visibly within a documented boundary. `v0.600.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.610.0 — Compatibility Upgrade And Reproducibility Verification

Status: planned

Goal: prove compatibility and reproducibility independently from chaos testing.

Deliverables:

- wire/storage/API/CLI/rule/schema/SDK compatibility matrices;
- install, migration, rolling upgrade, rollback and downgrade-boundary evidence;
- reproducible builds, archives, packages, SBOM, provenance and signatures.

Verification:

- every supported version pair and mixed-version topology;
- interrupted migration/upgrade, stale artifact and unsupported downgrade;
- clean-room artifact reproduction and byte/checksum comparison.

Exit criteria: supported compatibility paths and release artifacts reproduce
without hidden mutable inputs. `v0.610.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.620.0 — Independent Assessment Preparation

Status: planned

Goal: freeze a complete reviewable assessment scope before external execution.

Deliverables:

- architecture/source inventories and threat/data/authority flow packages;
- crypto, storage, cluster, agent, UI/API, Wasm/SOAR, supply-chain and operations
  test scopes with exact commits and environments;
- assessor independence, disclosure, evidence custody and retest agreements.

Verification:

- scope-to-acceptance checklist trace and omitted-boundary challenge;
- environment/artifact reproducibility and assessor access rehearsal;
- independent readiness review before assessment begins.

Exit criteria: the assessor can reproduce the product and test every security
boundary without scope ambiguity. `v0.620.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.630.0 — Independent Security Assessment Execution

Status: planned

Goal: obtain the full external assessment against the frozen scope and commit.

Deliverables:

- executed architecture, source, crypto, storage, cluster, agent, UI/API,
  Wasm/SOAR, supply-chain and operational assessment;
- severity, exploitability, affected boundary and evidence for every finding;
- public-safe summary and access-controlled complete finding archive.

Verification:

- assessor evidence signatures/custody and exact-commit traceability;
- internal reproduction of every accepted finding;
- dispute handling cannot suppress unresolved risk from the release record.

Exit criteria: the complete independent assessment is delivered, attributable
and reproducible; findings are not yet considered remediated. `v0.630.0
implementation stop reached. Run pentest for this exact commit.`

### v0.640.0 — Security Assessment Remediation

Status: planned

Goal: remediate assessment findings without combining fixes and independent retest.

Deliverables:

- fixes, regression tests and threat/control/documentation updates per finding;
- explicit treatment for accepted lower-severity residual risk;
- rerun performance, verification, compatibility and release gates as affected.

Verification:

- internal exploit reproduction fails for the intended reason;
- adjacent bypass, variant, rollback and regression campaigns;
- clean exact remediation commits and finding-to-change traceability.

Exit criteria: no critical/high finding remains internally reproducible and every
fix awaits independent retest. `v0.640.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.650.0 — Independent Security Retest

Status: planned

Goal: obtain independent closure of every release-blocking assessment finding.

Deliverables:

- assessor retest results for original exploits and material variants;
- closure/reopen decision, residual-risk record and exact remediation commits;
- updated public-safe assessment summary.

Verification:

- trusted assessor signatures and offline-verifiable evidence;
- no code change between retested commit and closure report parent relation;
- full gate rerun after any reopened finding is repaired and retested.

Exit criteria: every critical/high finding is independently closed and remaining
risk is explicit. `v0.650.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.660.0 — SDK Publication Admission

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
decision and all evidence exist. `v0.660.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.670.0 — Single-Node Public Beta

Status: planned

Goal: operate the complete product in production-like single-node deployments.

Deliverables:

- supported single-node install/upgrade/backup/restore beta deployments;
- realistic ingest, storage, query, detection, analyst and response operation;
- issue telemetry, support bundles, triage and safe feedback procedures.

Verification:

- long-duration operation and real operator/analyst exercises;
- crash, disk pressure, recovery, upgrade and workload-growth rehearsals;
- beta finding capture and exact-commit pentest.

Exit criteria: single-node beta operation exposes no untracked release blocker.
`v0.670.0 implementation stop reached. Run pentest for this exact commit.`

### v0.680.0 — Cluster Public Beta

Status: planned

Goal: operate production-like clustered deployments independently of other betas.

Deliverables:

- supported cluster bootstrap, expansion, repair, evacuation and administration;
- realistic multi-tenant ingest/query/detection/response and scheduled workloads;
- failover, observability, support and issue-evidence procedures.

Verification:

- long duration, rolling failure/upgrade, rebalance and noisy-tenant exercises;
- operator error, stale topology, quorum impairment and recovery game days;
- real operator/analyst exercises and cluster beta pentest.

Exit criteria: cluster beta operation exposes no untracked release blocker.
`v0.680.0 implementation stop reached. Run pentest for this exact commit.`

### v0.690.0 — Multi-Region And Air-Gap Public Beta

Status: planned

Goal: beta sovereign multi-region and disconnected operation as distinct modes.

Deliverables:

- multi-region placement/failover/residency beta deployments;
- air-gap install, trust, update, content, backup and transfer workflows;
- mode-specific support, evidence exchange and limitation documentation.

Verification:

- region loss/return, sovereignty denial, partition and stale control state;
- disconnected expiry/revocation, bundle replay/tamper and offline recovery;
- independent multi-region and air-gap operator exercises/pentest.

Exit criteria: both modes work within explicit availability, freshness and trust
limits. `v0.690.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.700.0 — Upgrade Migration And Rollback Beta

Status: planned

Goal: beta lifecycle transitions separately from steady-state deployment modes.

Deliverables:

- clean install, import, migration, rolling upgrade and supported rollback paths;
- mixed-version feature gates, drain/handoff and irreversible-step approvals;
- compatibility issue triage and release-blocking boundary ownership.

Verification:

- every supported source version/topology and staged interruption point;
- partial migration, stale artifact, failed drain and rollback limit;
- operator game days and upgrade/migration pentest.

Exit criteria: supported lifecycle transitions are reproducible and fail before
unsafe mutation. `v0.700.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.710.0 — Documentation Support And Operational Readiness

Status: planned

Goal: finish production documentation and support operations before scope freeze.

Deliverables:

- operator, security, developer, SDK, detector and incident-response manuals;
- installation, capacity, backup/recovery, upgrade/rollback and failure runbooks;
- security response, support escalation, maintenance and compatibility policies.

Verification:

- clean-room documentation exercises by each intended role;
- broken-link/example/command/version drift and accessibility review;
- on-call, incident, disclosure and recovery tabletop exercises.

Exit criteria: intended users can operate and recover supported deployments from
versioned documentation alone. `v0.710.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.720.0 — Beta Finding Remediation And Regression

Status: planned

Goal: resolve beta findings before any compatibility or artifact freeze.

Deliverables:

- triaged fixes and regression tests across every beta topology;
- performance, security, usability, documentation and support finding closure;
- updated risk register and release-blocker evidence.

Verification:

- reproduce then close each blocker on exact commits;
- cross-topology variants and complete affected campaign reruns;
- no critical/high security finding or unresolved release blocker.

Exit criteria: all beta blockers are closed with regression evidence; material
fixes receive their own stop when this pass grows too broad. `v0.720.0
implementation stop reached. Run pentest for this exact commit.`

### v0.730.0 — Pre-1.0 Option Closure Audit

Status: planned

Goal: prove every optional 1.0 capability is implemented or an explicit non-goal.

Deliverables:

- signed audit of every Pre-1.0 Option Decision Register row and closure commit;
- support-claim inventory across code, configuration, APIs and documentation;
- rejection/disable evidence for every non-goal and implementation evidence for
  every admitted option;
- conditional-series ledger proving every admitted intermediate passed and every
  skipped intermediate belongs only to an explicitly rejected capability.

Verification:

- reject any conditional/TBD option, missing closure, unimplemented support
  decision or undocumented non-goal;
- reject an admitted option with a skipped required series stop or a rejected
  option whose implementation surface remains reachable;
- scan APIs/configuration/UI/docs for implied or orphaned support claims;
- independent scope-closure and product-claim pentest.

Exit criteria: every option is closed before compatibility freeze begins.
`v0.730.0 implementation stop reached. Run pentest for this exact commit.`

### v0.740.0 — Public API Wire And Format Freeze

Status: planned

Goal: freeze externally observable compatibility surfaces after scope is closed.

Deliverables:

- public API, CLI, wire, storage, rule, schema and admitted SDK baselines;
- compatibility manifests, migration guarantees and explicit unstable exclusions;
- change-control rule allowing only security/correctness/release-blocking fixes.

Verification:

- previous-version clients/data/rules/configurations and mixed-version operation;
- undocumented surface, accidental export and incompatible-change scans;
- independent compatibility and downgrade-boundary pentest.

Exit criteria: every supported external surface has an approved frozen baseline;
material change creates a new pre-1.0 stop. `v0.740.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.750.0 — Packaging And Artifact Freeze

Status: planned

Goal: freeze build inputs and distributable artifacts separately from APIs.

Deliverables:

- final toolchain/dependency/unsafe/action inventory and locked build inputs;
- packages, archives, SBOM, provenance, checksums and signing procedures;
- installation metadata and publication prohibition for every internal crate.

Verification:

- clean-room byte/checksum reproduction on supported builders;
- archive/package secret, internal-file, license and provenance audit;
- install/uninstall/upgrade packaging matrix and supply-chain pentest.

Exit criteria: candidate artifacts are reproducible and contain only approved
contents; material input change creates a new stop. `v0.750.0 implementation
stop reached. Run pentest for this exact commit.`

### v0.760.0 — Full Candidate Qualification

Status: planned

Goal: run every 1.0 gate against one feature- and artifact-frozen commit.

Deliverables:

- complete acceptance-checklist evidence and release notes;
- consolidated performance, verification, assessment, beta and operations proof;
- exact candidate topology, artifacts and residual-risk record.

Verification:

- complete clean rebuild and all repository/release campaigns;
- install, upgrade, rollback, recovery, disaster and support exercises;
- final independent full-product pentest with no critical/high finding.

Exit criteria: every 1.0 gate passes on one exact commit; any change requires a
new qualification stop. `v0.760.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.770.0 — Feature-Complete Stable Candidate Evidence

Status: planned

Goal: approve the qualified commit for exact release-candidate versioning.

Deliverables:

- maintainer approval of the complete product and all acceptance evidence;
- signed reproducible artifacts, SBOM/provenance and final audit index;
- final confirmation that no foundational capability is deferred to 1.x.

Verification:

- qualification commit/artifact/evidence cryptographic identity;
- independent audit of gate completeness and assessment ancestry;
- no code, manifest, lockfile or generated-evidence change since qualification.

Exit criteria: the exact approved commit may become `v1.0.0-rc.1`; otherwise add
another `v0.N.0` or `v0.N.P` stop, including beyond `v0.1000.0` when useful.
`v0.770.0 implementation stop reached. Run pentest for this exact commit.`

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
- Agent binaries/helpers/updates are signed, anti-rollback protected, measured,
  controllably removable and emit self-protection impairment evidence.
- Server/node binaries, components and updates are signed, measured,
  anti-rollback protected and epoch-admitted; every assurance level is honest,
  self-report cannot imply attestation, and drift/unverifiable state follows
  configured drain or quarantine policy.
- Cloud, identity, network, syslog, OTLP, OCSF, JSON and file ingestion work.
- Source lineage, immutable facts, telemetry gaps and completeness are queryable.
- Trusted-time bootstrap/refinement and PKI issuance, renewal, revocation and
  compromise recovery pass their cross-platform and ceremony exercises.
- Durable local and HA jobs/timers prove declared time bases, misfire policy,
  fencing, idempotency, cancellation, dependency and checkpoint semantics;
  storage durability/recovery remains available without scheduler workers/state,
  and mixed-version effect handoff creates one canonical durable outbox record
  per effect identity.
- Storage survives crash, corruption, node/rack/region loss and rolling upgrade.
- Historical hot/cold, live, temporal, graph, federated and distributed-physical
  VQL queries work safely with honest partial/cost/cancellation behavior.
- `DurableQuorum` evidence proves fact, raw-capsule and mapping/provenance
  durability independently; raw reconstruction is never implied without it.
- Predicate, temporal, stateful, graph, behavioral and integrity detection work.
- Threat-intelligence live/retro matching and entity-risk threshold findings
  are deterministic, evidence-backed and poisoning-resistant.
- Simulation, shadow, canary, rollback and deterministic finding replay work.
- Alerts, incidents, cases, evidence, legal hold and signed reports work.
- Wasm is capability-limited and OS-isolated; response requires correct approval,
  idempotency, verification and compensation.
- Live forensic acquisition is authenticated, elevated, independently audited
  and custody-bound; ordinary collection authority cannot invoke it.
- SOAR cooldown/concurrency/recursion/target serialization and every scoped kill
  switch behave correctly for queued, in-flight and unknown-outcome actions.
- Multi-tenancy, field policy, residency and purpose enforcement pass independent
  assessment.
- Tenant provisioning, suspension, read-only/quarantine, hold, export,
  offboarding and cryptographic destruction propagate across every product plane;
  tenant identifiers and key domains cannot be reused or resurrected, while any
  lawfully retained independent audit/remnant evidence conveys no authority.
- Single-node, cluster, sovereign multi-region and air-gap operation are tested.
- Cluster discovery and authenticated data-plane routing preserve loop,
  backpressure, sequence, retry and acknowledgement truth through drain,
  leader movement, partition and stale-route failure; cross-region routing occurs
  only after committed failover authority, and proxy trust termini/backend
  bindings are explicit per protocol.
- Backup, restore, repair, reindex, migration, upgrade and rollback are complete.
- The SDK publication decision is explicit; internal crates remain unpublished.
- Dashboards, scheduled analytics reports, analyst and administration interfaces,
  and complete operator/developer/security documentation exist.
- Every optional capability in the pre-1.0 decision register is implemented and
  evidenced or is an explicit tested non-goal; none remains conditional or `TBD`.
- No critical or high assessment finding remains.
- Wire, storage, rule-package, schema, SDK and public API formats are stable.
- Builds and release artifacts are reproducible, signed and provenance-bound.
- Any regulated cryptographic-mode claim names an applicable validated boundary;
  otherwise documentation explicitly states that no such claim exists.
