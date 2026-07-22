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
| Current OCSF class/profile/version support, OpenTelemetry cross-signal correlation and AI workload telemetry | `v0.18.1`–`v0.18.3`, `v0.20.10`–`v0.20.14`, `v0.30.3`–`v0.30.6` |
| Deterministic identity resolution, asset inventory, ownership, exposure, and retirement | `v0.13.0`, `v0.298.0` |
| Local identities/control/authorization plus complete tenant lifecycle before consumers | `v0.17.0`, `v0.17.1`, `v0.19.0`; audit/remnant/identifier policy at `v0.457.1`–`v0.457.5`; all-plane single-node gate at `v0.458.0`; independent audit at `v0.467.3`; distributed closure at `v0.474.1` |
| Conservation, acknowledgement truth/manifests/runtime permits, exact asynchronous coverage, raw quarantine, continuity, overload, backfill/reprocessing, and impairment lane | `v0.20.4`, `v0.22.0`, `v0.31.0`–`v0.31.4`, `v0.39.0`, `v0.40.0`, `v0.44.0`, `v0.48.1`, `v0.50.0`, `v0.54.0`, `v0.140.1`–`v0.140.2`, `v0.470.1`, `v0.471.0` |
| Exact external protocol and identity-codec profiles | `v0.20.1`, `v0.26.0`–`v0.30.2`, `v0.306.0`, `v0.392.0`–`v0.395.0`, `v0.407.0`–`v0.410.0` |
| Database capacity, raw evidence, integrity/encryption/keys, local backup/restore, migration, and scoped early scale | `v0.41.0` through `v0.60.0`, especially `v0.53.0`–`v0.58.0` |
| Layered durable local and HA jobs/timers with atomic effect handoff, ledger migration, post-retention replay fencing/anchor assurance, upgrade compatibility, consumer admission, declared time, retry, fencing and idempotency | `v0.44.1`–`v0.44.10`, consumer matrix, `v0.459.0`, `v0.467.4` |
| Query authority/planning/operators, local coverage/committed sets, cold rehydration, side channels, conditional external data-lake query, federation, distributed execution and coverage reconciliation | `v0.72.0`–`v0.101.3`, especially `v0.79.1`–`v0.79.2`; distributed extension at `v0.475.1`–`v0.476.1` |
| Detection identity/state/placement, split behavior families, entity risk, intelligence lifecycle/matching, current ATT&CK strategies/analytics and Sigma 2.1 | `v0.115.0`–`v0.200.0`, especially `v0.170.0`–`v0.180.6` |
| Common agent/helper boundary, signed software integrity/self-protection and platform continuity | `v0.205.0` through `v0.267.5`, especially `v0.206.0` |
| Named cloud/identity/productivity/source-control/network/email/EDR providers, DSPM/EASM decisions and governed source onboarding | `v0.292.1`–`v0.329.6` |
| First-party signed detection/hunt/dashboard/runbook/playbook content and continuous effectiveness evidence | `v0.336.0`–`v0.337.6` |
| Optional disabled-by-default normalized security-data export and portability | `v0.343.0`–`v0.343.6`, HA at `v0.468.3` |
| Framework-neutral alert/formal-incident/case lifecycle, signed bounded pack engine, independent obligations, default/ENISA/NIST/NIS2/DORA/GDPR packs and regulatory reports | `v0.344.1`–`v0.390.2`, especially `v0.344.7`, `v0.360.2`–`v0.360.15`, `v0.375.1`–`v0.376.2` |
| Formal threat-hunt workflow, simulated/live forensics, confidential cases, auth/audit, dashboards/scheduled reports and specialized analyst UIs | `v0.377.0`–`v0.406.3`, especially `v0.404.1`–`v0.404.8` |
| Wasm, CACAO/OpenC2 interoperability, bound actions, storm/kill controls, unknown outcomes, named ServiceNow actions/sync and recovery | `v0.407.0` through `v0.455.0`, especially `v0.430.1`–`v0.430.3`, `v0.450.2`–`v0.450.4` |
| Honest node/keystore/rollback assurance, optional attestation and hardware-monotonic closure, signed builds, admission, anti-rollback and runtime quarantine | `v0.20.6`, `v0.44.10`, `v0.456.0`–`v0.457.0`, `v0.460.0`, `v0.465.1`, `v0.483.0`, `v0.483.1` |
| State CFT/HA including framework/report/export/hunt/content/metric journals, independently witnessed scheduler fence, raw quorum, tenant/MSSP propagation, distributed query, discovery/routing/proxy trust, SRE/DR/scale/admin | `v0.459.0` through `v0.484.1`, especially `v0.465.1`–`v0.482.0` |
| AI workload monitoring/detection and optional proposal-only governed assistance | `v0.20.14`, `v0.30.5`, `v0.485.0`–`v0.485.14` |
| Regulated cryptographic-mode claims require an applicable validated boundary or explicit rejection | `v0.530.0` |
| Every optional 1.0 capability has a binding decision and implementation-or-non-goal closure | `v0.100.1`–`v0.100.2`, reserved closures, audited at `v0.730.0` |

## Modern SIEM 1.0 Closure Matrix

This matrix makes the reviewed modern-SIEM scope auditable as product work. A
schema, interface or generic framework alone does not close a row: the listed
implementation, adversarial verification, operational evidence and pentest
stops must all pass before 1.0.

| Product outcome | Small implementation series and closure |
| --- | --- |
| Current open security schemas and cross-signal observability | Exact OCSF support at `v0.18.1`–`v0.18.3`; OpenTelemetry logs/traces/metrics/events/profiles and AI workload telemetry at `v0.20.10`–`v0.20.14`; hosted endpoints and correlation at `v0.30.3`–`v0.30.6` |
| Current detection standards and explainable coverage | ATT&CK strategies/analytics and upgrade evidence at `v0.178.1`–`v0.178.3`; Sigma 2.1 rules/correlations/filters at `v0.180.4`–`v0.180.6` |
| Usable first-party SOC content rather than an empty engine | Content constitution, signed distribution, platform/cloud/identity/network detections, hunts, dashboards, runbooks, playbooks and minimum coverage at `v0.336.0`–`v0.336.13` |
| Measured detection quality and continuous control validation | Disposition feedback, controlled precision/recall/miss evidence, adversary emulation, tuning debt and scheduled validation at `v0.337.0`–`v0.337.6` |
| Governed source onboarding and named integrations | Named provider stops at `v0.292.1`–`v0.314.2`; lifecycle, safe sampling, mapping, drift, cost, permissions and canary onboarding at `v0.329.0`–`v0.329.6` |
| Formal threat hunting and promotion into detections/incidents | Hunt identity, evidence, collaboration, promotion, recurrence and API at `v0.377.0`–`v0.377.5`; dedicated UI at `v0.404.5` |
| Internal-first alert/incident response with standards interoperability | Native workflow at `v0.344.1`–`v0.390.2`; CACAO 2.0 at `v0.430.1`–`v0.430.3`; OpenC2 2.0 at `v0.450.2`–`v0.450.4`; external services remain non-authoritative |
| Air-gap-safe data ownership and optional portability | Disabled-by-default normalized export, subscriptions, OCSF/OTLP/syslog/archive/stream profiles, re-import and HA at `v0.343.0`–`v0.343.6` and `v0.468.3`; internal-only operation remains complete |
| SOC operational measurement | Alert quality/workload and incident/corrective-action metrics with governed dashboards/exports at `v0.406.0`–`v0.406.3` |
| AI-era monitoring and safely bounded assistance | AI workload telemetry/detection plus proposal-only assistance, provenance, prompt-injection isolation, grounding, TEVV, drift and local/external execution boundaries at `v0.20.14`, `v0.30.5` and `v0.485.0`–`v0.485.14`; autonomous authority is excluded |
| Conditional advanced scope cannot disappear | External query-in-place closes at `v0.101.3`, DSPM/EASM at `v0.298.6`, passive OT/ICS at `v0.318.6`, MSSP tenancy at `v0.474.6`, and named national NIS2 profiles at `v0.360.15`; each is implemented or a tested explicit 1.0 non-goal |
| Production assurance across every admitted plane | State-specific HA at `v0.459.0`–`v0.474.6`; performance/fuzz/formal/chaos/compatibility at `v0.540.0`–`v0.610.0`; independent assessment, betas and exact-candidate qualification at `v0.620.0`–`v1.0.0-rc.N` |

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

Named 1.0 admissions are explicit: AWS, Azure/Entra, GCP, Okta, Google Workspace,
Microsoft 365, Slack, GitHub, GitLab, ServiceNow, PAN-OS, FortiGate, Zscaler,
Defender for Office 365, Proofpoint, Defender for Endpoint and CrowdStrike each
own a separate milestone. ServiceNow transport is `v0.305.2`, with action/sync
activation at `v0.453.3`–`v0.453.4`. Names not listed still require their own
release; a generic family or protocol creates no support claim.

## Incident And Framework Coverage Matrix

Framework packages extend a mandatory native workflow; they never replace it.
Optional means tenant activation is optional, not that the admitted 1.0
implementation/testing stop may be skipped. A package or connector name creates
no compliance/provider claim outside its listed owner.

| Required capability | Owning versions |
| --- | --- |
| Entity boundaries, primary case and graph separation | `v0.344.1`, `v0.360.1` |
| Signed package model, bounded policy, registry, composition and immutable upgrades | `v0.344.2`–`v0.344.6` |
| Named-pack/opaque-Wasm/national-profile decisions | `v0.344.7`, closed by `v0.360.14`–`v0.360.15` and `v0.420.0` |
| Alert triage, structured closure and tuning feedback | `v0.345.1`–`v0.345.2` |
| Atomic promotion, formal incident lifecycle and merge/split/reopen controls | `v0.346.1`–`v0.346.3` |
| Applicability assessments and independent conservative obligations | `v0.360.2`–`v0.360.3` |
| Default, ENISA, NIS2 EU/national-overlay contract, DORA, GDPR and NIST SP 800-61r3 packs | `v0.360.4`–`v0.360.13` |
| Private authoring/conformance tools and integrated pack claim closure | `v0.360.11`–`v0.360.15` |
| Closure/post-analysis/corrective-action evidence | `v0.375.1`–`v0.375.2` |
| Analyst/framework/report and external-sync APIs | `v0.376.1`–`v0.376.2` |
| Formal threat hunt lifecycle, evidence, promotion, recurrence and API | `v0.377.0`–`v0.377.5` |
| Regulatory report versions, approvals, submissions, receipts and corrections | `v0.390.1`–`v0.390.2` |
| Triage, incident, obligation/report, external-sync, hunt, onboarding, export and effectiveness UIs | `v0.404.1`–`v0.404.8` |
| ServiceNow named transport, actions and bidirectional reconciliation | `v0.305.2`, `v0.453.3`–`v0.453.4` |
| Framework/obligation/report/submission/external-sync/export/hunt/content/metric HA | `v0.468.1`–`v0.468.4` |

## Scheduler Consumer Admission Matrix

`v0.44.5` requires every persistent timer/job consumer to declare job identity,
checkpoint, cancellation, misfire/catch-up/skip, idempotency, recovery and
uncertain-time behavior. Externally visible effects additionally use `v0.44.4`
and its `v0.44.7` compatibility gate; every ledger passes `v0.44.9`–`v0.44.10`,
and any migrating ledger also passes `v0.44.8`. The generic scheduler never owns
blind effect retries.

| Consumer | Integration owner |
| --- | --- |
| Key, certificate, revocation and trust renewal | `v0.44.6` |
| Storage CPU/IO priority; recovery and emergency work | `v0.45.0` remains independent of scheduler availability |
| Scrub, repair/reindex, backup, retention and compaction | `v0.57.0`, `v0.57.1`, `v0.60.0` |
| Cold catalog retrieval and rehydration | `v0.86.0` |
| Rule rollout, entity-risk recompute and intelligence retro-hunt | `v0.190.0`, `v0.176.0`, `v0.179.0` |
| Content validation and recurring threat hunts | `v0.337.5`, `v0.377.4` |
| Connector polling and credential/token renewal | `v0.290.0` plus every named provider admission; ServiceNow at `v0.305.2`/`v0.453.4` |
| Alert escalation/SLA, framework shadow replay/migration and obligation/deadline clocks | `v0.345.0`, `v0.344.6`, `v0.360.3`, `v0.468.1` |
| Corrective-action reminders and effectiveness windows | `v0.375.2` |
| Scheduled queries, reports and governed delivery | `v0.402.0` |
| Export subscriptions and reconciliation | `v0.343.1`, `v0.468.3` |
| Playbook waits and delayed compensation | `v0.430.0`; effects continue through later action ledgers |

The owning milestone fails if it creates a private persistent scheduler or omits
its conformance profile.

## Acknowledgement Claim Activation Matrix

`v0.31.1` makes every claim tag parseable; it does not authorize every tag to be
emitted. Version numbers in this table assign planning, implementation and test
ownership only: they are never serialized as runtime authority, compared by an
encoder or accepted as security evidence. `v0.31.3` defines the fail-closed
registry contract, and `v0.31.4` makes the encoder require an opaque scoped
`ClaimPermit<Component>` from the owning durable-state verifier. A claim remains
disabled when its permit, prerequisite, requested component, coverage or mixed-
version capability is absent.

| Claim | Earliest activation owner and required state |
| --- | --- |
| `Received` | `v0.31.4` intake-verifier permit scoped to authenticated tenant/source, bounded covered bytes and their `v0.22.0` conservation entry; it implies no validation or durability |
| `Validated` | `v0.31.4` parser/policy-verifier permit for the exact protocol/schema/mapping/policy epochs and covered input; one format cannot activate another |
| `DurableLocal.fact` | `v0.44.0` WAL verifier permit for the exact fact input/generation and documented stable-media state |
| `DurableLocal.mapping_provenance` | `v0.44.0` WAL verifier permit for the exact mapping/provenance records; a fact permit cannot activate it |
| `DurableLocal.raw` | `v0.20.9` encrypted raw persistence plus a `v0.54.0` raw-store verifier permit for exact atomic fact/reference/object publication |
| `Indexed.primary` | `v0.48.0` primary index plus `v0.48.1` coverage-verifier permit for the exact fact generation/range, index definition/version and terminal index generation |
| `Indexed.security` | `v0.50.0` security index using the `v0.48.1` coverage-verifier permit; neither index class nor one index definition implies another |
| `DetectionProcessed` | `v0.140.2` progress-verifier permit over the authoritative `v0.140.1` active-rule-set/cohort commitment, exact input range and complete `v0.115.0` execution identity |
| `DurableQuorum` | `v0.470.1` cluster envelope plus a `v0.471.0` quorum-verifier permit for every exact claimed vector component and covered commit range |

Every runtime permit binds tenant/source scope, protocol/schema/mapping/policy
epochs, covered input or generation, verifier identity and activation
generation. Every owner inherits substitution, component-independence,
downgrade, unknown-tag and current/previous mixed-version tests. Negotiation
must reject a missing/invalid permit; it may never approximate it with a weaker
or different component.

## Pre-1.0 Option Decision Register

Every option closes before the release-candidate freeze. “Support” requires its
implementation, tests, documentation and pentest before `v0.730.0`; “non-goal”
requires an explicit boundary, rejection behavior and documentation. No decision
may be deferred to 1.0.

Runtime claim permits, exact asynchronous/pre-execution coverage contracts,
ledger-migration uniqueness, post-retention handoff replay fencing and the
`ExternalWitnessed`/`Unverifiable` fail-closed anchor model are mandatory
correctness prerequisites, not optional capabilities. Only platform-specific
`HardwareMonotonic` support is optional; the mandatory baseline cannot be
disabled or converted into a 1.0 non-goal through this register. A witness is
external only when at least one current authority is outside the protected
workload's snapshot/restore authority, storage failure domain, administrative
authority, signing-key domain and consensus/recovery domain; an operational
consensus group alone never qualifies.
Conservative `v0.4.4` lease evaluation and `v0.10.3`-authorized witness-signer
replacement are also mandatory parts of that baseline, not later options.
The framework-neutral incident workflow/package engine/default pack and admitted
named-pack implementations are required 1.0 work. ENISA/NIS2/DORA/GDPR pack
activation is tenant-optional; implementation cannot be silently skipped.

| Option | Binding decision/closure |
| --- | --- |
| PCAP acquisition and packet evidence | Decide at `v0.100.1`; if admitted implement `v0.315.1`–`v0.315.5`; close at `v0.316.0` |
| YARA-compatible or other artifact-content matching | Decide at `v0.100.1`; if admitted implement `v0.180.1`–`v0.180.3`; close at `v0.181.0` |
| PE/ELF/Mach-O metadata and signature extraction | Decide at `v0.100.1`; if admitted implement `v0.267.1`–`v0.267.5`; close at `v0.268.0` |
| Remote Windows Event Forwarding | Decide at `v0.100.1`; if admitted implement `v0.231.0`–`v0.234.0`; close at `v0.235.0` |
| Cloud object/archive and message-stream ingestion | Decide at `v0.100.1`; if admitted implement `v0.307.0`–`v0.307.3`; close at `v0.308.0` |
| Named connector/action providers | Named 1.0 source matrix is committed across `v0.292.1`–`v0.314.2`; one provider-admission release remains required per additional claim; ServiceNow action/sync closes at `v0.453.4` |
| eBPF and any Windows driver | `v0.220.0`/`v0.240.0` decide admitted surface and preserve tested no-driver fallbacks |
| Aesynx 1.0 support | `v0.267.0` closes as future portability only unless a later explicit implementation stop is inserted |
| Optional Wasm extensions and proposal-only AI | `v0.420.0` rejects authoritative framework determinations; `v0.485.0`–`v0.485.14` implement monitored/disabled/proposal-only AI and enforce autonomous authority as a 1.0 non-goal |
| Framework pack 1.0 set | Decide at `v0.344.7`; implement default/ENISA/NIS2/DORA/GDPR/NIST SP 800-61r3 and national-overlay contract at `v0.360.4`–`v0.360.13`; close at `v0.360.14` |
| Named national NIS2 profiles and other future named packs | Decide at `v0.100.2`; `v0.360.15` requires one separate implementation stop per admitted country or explicit rejection; SANS/VERIS remain non-goals unless separately implemented |
| External data-lake query-in-place | Decide at `v0.100.2`; if admitted implement `v0.101.0`–`v0.101.2`; close at `v0.101.3` |
| DSPM/data-security monitoring and external attack-surface management | Decide at `v0.100.2`; if admitted implement `v0.298.1`–`v0.298.5`; close at `v0.298.6` |
| OT/ICS monitoring | Decide at `v0.100.2`; if admitted implement passive-only `v0.318.0`–`v0.318.5`; close at `v0.318.6`; automatic OT response remains a 1.0 non-goal |
| MSSP hierarchical tenancy | Decide at `v0.100.2`; if admitted implement `v0.474.2`–`v0.474.5`; close at `v0.474.6` |
| Privileged/OS-backed runtime measurement | Decide at `v0.456.0`; if admitted implement `v0.456.2`; close at `v0.456.5` |
| Hardware measured boot and remote attestation | Decide at `v0.456.0`; if admitted implement `v0.456.3`–`v0.456.4`; close at `v0.456.5` |
| Hardware/OS monotonic anti-replay fence anchor | Decide per platform at `v0.456.0`; if admitted implement counter evidence/reset handling in `v0.456.2`–`v0.456.3`; close at `v0.456.5`; rejection retains mandatory `ExternalWitnessed`/`Unverifiable` behavior |
| Post-destruction audit-pseudonym re-identification | Permit or forbid at `v0.457.2`; implement the selected path at `v0.457.4`; close at `v0.457.5` |
| Byzantine/compromised-backend truth guarantees | `v0.462.0` closes as a 1.0 non-goal; manifests authenticate claims but do not prove backend honesty |
| Regulated cryptographic operating mode | Admit or reject at `v0.530.0` |
| Public SDK publication | Admit or reject at `v0.660.0`; all other crates remain private |

`v0.730.0` audits this register and fails if any row remains conditional, lacks
its closure evidence, or silently changes the 1.0 product claim.

Conditional implementation-series milestones execute only when their owning
decision (`v0.100.1`, `v0.100.2` or `v0.456.0`) admits that capability. Rejection skips their
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
  rollback-suspected and unavailable time;
- conservative security-lease rule: the complete current uncertainty interval
  must fit inside the signed validity interval; local time evidence may shorten
  validity but can never extend the signed lease;
- clock rollback, reboot without proven monotonic continuity, source loss or
  excessive uncertainty produces rollback-suspected/unavailable time and a
  fail-closed lease result.

Verification:

- canonical token, signature, replay, rollback, expiry and source-conflict tests;
- uncertainty-bound arithmetic and deterministic state transitions;
- exact lease boundaries under forward/backward jumps, reboot with/without
  monotonic continuity and unavailable time sources;
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
  security-audit evidence; exact residue/identifier policy closes at `v0.457.5`.

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

### v0.18.1 — OCSF Version And Class Support Contract

Status: planned

Goal: bind an exact, current OCSF baseline and class/profile support matrix before
compatibility code becomes a vague forever-claim.

Deliverables:

- implementation-time latest-stable selection, currently OCSF `1.8.0`, with
  source digest, license, retrieval date and freshness owner;
- class/profile/extension matrix marking import, export, lossless, lossy,
  unsupported and experimental semantics independently;
- explicit AI-operation, finding, identity, cloud, network, endpoint and data-
  security scope decisions plus extension-ownership rules;
- schema-change, deprecation and unsupported-future-version policy.

Verification:

- official metaschema and representative class/profile fixtures;
- omitted-class, extension collision, unknown enum and misleading lossless-claim
  tests;
- independent schema-scope and licensing review.

Exit criteria: every OCSF class/profile claim names an exact supported version
and mapping outcome. `v0.18.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.18.2 — OCSF Core And Security Profile Mapping Corpus

Status: planned

Goal: implement the admitted OCSF mappings as reviewable per-class artifacts.

Deliverables:

- canonical fixtures and field-level lineage for each admitted event class,
  object, observable, profile and platform extension;
- import/export mapping rules with required/recommended/optional handling,
  enum/unknown preservation and explicit loss records;
- separate mapping packages for core activity, findings, identity, cloud,
  network, endpoint, data-security and AI-operation families;
- bounded decoder/encoder and mapping resource budgets without third-party code.

Verification:

- per-class positive, negative, boundary, future-field and round-trip corpora;
- semantic-confusion, extension spoofing, type/enum drift and loss suppression;
- cross-platform deterministic mapping and sustained fuzzing.

Exit criteria: every admitted OCSF family has executable conformance evidence
and field-attributable loss reporting. `v0.18.2 implementation stop reached. Run
pentest for this exact commit.`

### v0.18.3 — OCSF Upgrade Migration And Compatibility Gate

Status: planned

Goal: upgrade OCSF support without rewriting historical normalized truth.

Deliverables:

- old/current schema coexistence, mapping-version pinning and explicit migration
  or query-time projection rules;
- historical shadow remap and field/class/profile difference reports;
- producer/consumer negotiation and downgrade behavior;
- recurring freshness review that inserts a new pre-1.0 stop for material newer
  stable releases rather than silently changing fixtures.

Verification:

- previous/current/future schema matrices, rollback and mixed-version exchange;
- historical replay, extension removal/rename, lossy migration and stale cache;
- independent compatibility, downgrade and claim-boundary pentest.

Exit criteria: OCSF evolution is attributable and reversible, and no schema
upgrade mutates historical facts silently. `v0.18.3 implementation stop reached.
Run pentest for this exact commit.`

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
- explicit `PreventRollback`, `DetectInconsistency` or `NoRollbackEvidence`
  capability per adapter: an ordinary keystore/encrypted-file value cannot imply
  a monotonic counter or `v0.44.10` `HardwareMonotonic` fence assurance;
- rotation is manually/event driven here; persistent timing is prohibited until
  shared-scheduler integration at `v0.44.6`.

Verification:

- key theft/substitution/rollback, permission loss, corrupt keystore, rotation
  interruption, reinstall/clone and hardware-provider outage;
- full disk-image rollback and hardware/OS counter reset/reprovision distinguish
  prevention from detection-only behavior;
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

### v0.20.10 — OpenTelemetry Signal And Correlation Contract

Status: planned

Goal: extend OTLP beyond logs without confusing observability measurements with
security evidence.

Deliverables:

- implementation-time latest-stable semantic-convention selection, currently
  `1.43.0`, with per-domain stability and version-selection records;
- typed log, event, span/trace, metric, profile, resource and scope identities;
- trace/span/session/resource/entity correlation with conflict, sampling,
  missing-context and untrusted-baggage semantics;
- signal-specific provenance, privacy, cardinality, retention and evidence-claim
  boundaries; no metric or sampled trace implies complete activity.

Verification:

- official data-model/semantic-convention fixtures and cross-signal joins;
- forged trace context, baggage injection, resource collision, sampling gaps and
  unstable-convention downgrade;
- bounded cardinality and deterministic correlation property tests.

Exit criteria: every admitted OpenTelemetry signal has distinct truth and
correlation semantics. `v0.20.10 implementation stop reached. Run pentest for
this exact commit.`

### v0.20.11 — OTLP Trace And Span Mapping

Status: planned

Goal: normalize distributed operation paths for application and service attack
investigation without trusting caller-propagated context blindly.

Deliverables:

- bounded trace/span/resource/scope/status/event/link mapping and canonical IDs;
- parent/link validation, partial-trace and sampling evidence, clock/ordering
  uncertainty and service/workload entity links;
- pinned HTTP, RPC, messaging, database, FaaS and cloud semantic-convention
  profiles with explicit unstable/unsupported fields;
- security-sensitive route, peer, identity and error extraction under field
  protection policy.

Verification:

- broken/cyclic parents, reused IDs, cross-tenant links, spoofed peer/resource,
  huge fan-out and partial sampling;
- semantic-convention version migration and ambiguous service identity;
- trace reconstruction, loss reporting, fuzz and privacy campaigns.

Exit criteria: traces provide bounded attributable context and never fabricate a
complete request path. `v0.20.11 implementation stop reached. Run pentest for
this exact commit.`

### v0.20.12 — OTLP Metric Security Context Mapping

Status: planned

Goal: admit metrics as contextual measurements with explicit aggregation and
cardinality limits.

Deliverables:

- gauge, sum, histogram and exponential-histogram mapping with temporality,
  reset, exemplar and aggregation identity;
- metric-to-resource/entity and exemplar-to-trace correlation;
- sampling/aggregation/error and source-health metadata preventing a metric from
  becoming immutable event evidence;
- per-instrument/attribute cardinality, series count, memory and output budgets.

Verification:

- counter reset/wrap, temporality switch, duplicate/out-of-order points, hostile
  buckets and cardinality explosion;
- exemplar substitution, tenant/resource collision and aggregation ambiguity;
- hand-calculated vectors, deterministic rollups and sustained load tests.

Exit criteria: metric context is useful and bounded while its weaker evidentiary
meaning stays explicit. `v0.20.12 implementation stop reached. Run pentest for
this exact commit.`

### v0.20.13 — OTLP Event And Profile Mapping

Status: planned

Goal: support named application events and profiles without hiding their
different maturity, privacy or sampling characteristics.

Deliverables:

- named-event mapping over log records with event-name/version and trace context;
- pinned profile signal/data-model subset with sample type, period, frame/module,
  symbolization provenance and explicit development-status warning;
- secret/PII/source-path redaction, bounded stacks/labels/samples and retention;
- implementation-time admission check that inserts another stop if the profile
  specification is materially unstable.

Verification:

- event/log confusion, profile symbol/path leakage, hostile stacks/labels,
  missing binaries and sample bias;
- unsupported profile/version rejection and future-field preservation;
- cross-platform event/profile fixtures, fuzzing and privacy pentest.

Exit criteria: events and profiles remain versioned bounded signal types with
honest maturity and sampling limits. `v0.20.13 implementation stop reached. Run
pentest for this exact commit.`

### v0.20.14 — AI Workload Telemetry Model

Status: planned

Goal: model AI-system operations as monitored workload evidence independently
from Vakaheim's later optional AI assistant.

Deliverables:

- OCSF AI-operation and current OpenTelemetry GenAI mapping profiles for model,
  provider, operation, agent/tool, token/use and response metadata;
- prompt/context/output/tool payload classification with default minimization,
  digest/reference options and explicit collection consent;
- model/version, system/developer prompt, retrieval source and tool-call lineage;
- prompt-injection, data-exfiltration, unsafe-tool and anomalous-usage facts with
  no inference that missing sensitive payload equals safe behavior.

Verification:

- secret/personal-data capture, malicious prompt/tool output, model-name spoof,
  cross-tenant context and unbounded token/cardinality attacks;
- OCSF/OpenTelemetry mapping drift and missing-redacted-payload explanations;
- privacy review and hostile AI-telemetry corpus.

Exit criteria: Vakaheim can monitor AI workloads without requiring or trusting an
AI assistant. `v0.20.14 implementation stop reached. Run pentest for this exact
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

### v0.30.3 — OTLP Trace Ingestion Endpoint

Status: planned

Goal: expose authenticated bounded trace ingestion over common OTLP transport.

Deliverables:

- OTLP trace Protobuf/gRPC/HTTP profile over `v0.20.11` mappings;
- source/tenant/resource registration, batch limits, partial success,
  idempotency and signal-specific acknowledgements;
- sampling/configuration metadata and trace completeness outcomes;
- separate trace quotas and overload impairment from log ingestion.

Verification:

- malformed spans, deep/fan-out traces, disconnect/retry and partial success;
- cross-tenant trace IDs, forged resource context and trace/log quota starvation;
- representative sender interoperability and endpoint pentest.

Exit criteria: trace ingestion is bounded and never claims complete or durable
logs by association. `v0.30.3 implementation stop reached. Run pentest for this
exact commit.`

### v0.30.4 — OTLP Metric Ingestion Endpoint

Status: planned

Goal: ingest admitted metrics with series/cardinality admission before storage
or detection sees them.

Deliverables:

- OTLP metric Protobuf/gRPC/HTTP profile over `v0.20.12`;
- per-source instrument/series/attribute budgets and temporality negotiation;
- partial-success accounting, reset/gap health and backpressure;
- metric-specific retention/tiering and evidence labels.

Verification:

- series explosion, hostile histograms, reset/reorder, disconnect and retry;
- tenant/resource confusion and metric load starving event durability;
- representative sender interoperability and sustained capacity pentest.

Exit criteria: admitted metric load remains bounded and its aggregation limits
remain queryable. `v0.30.4 implementation stop reached. Run pentest for this
exact commit.`

### v0.30.5 — OTLP Event Profile And AI Telemetry Endpoint

Status: planned

Goal: activate named-event, admitted-profile and AI-operation ingestion under
their stricter privacy and maturity policies.

Deliverables:

- signal negotiation over `v0.20.13`–`v0.20.14` with unsupported profiles
  rejected explicitly;
- payload minimization/redaction preview, consent/purpose and source registration;
- per-signal quotas, partial success, lineage and development-spec warnings;
- feature gates allowing AI/profile telemetry to be disabled independently.

Verification:

- sensitive prompt/profile leakage, hostile frames/attributes, version downgrade,
  unsupported-signal smuggling and disable bypass;
- cross-signal retry/acknowledgement confusion and quota isolation;
- sender interoperability, privacy assessment and endpoint pentest.

Exit criteria: experimental or sensitive signals are never silently admitted as
ordinary logs. `v0.30.5 implementation stop reached. Run pentest for this exact
commit.`

### v0.30.6 — OpenTelemetry Cross-Signal Integration Gate

Status: planned

Goal: prove all admitted signals correlate without collapsing their different
coverage and truth claims.

Deliverables:

- end-to-end correlation/query fixtures across logs, traces, metrics, events,
  profiles and AI telemetry;
- source-health/coverage views and downgrade/disable behavior per signal;
- semantic-convention freshness review and migration inventory;
- explicit unsupported behavior for every non-admitted domain/profile.

Verification:

- missing/partial signal combinations, ID spoofing, schema drift, overload and
  cross-signal policy differences;
- same-source and cross-source reconstruction with honest completeness;
- independent interoperability, privacy and correlation pentest.

Exit criteria: each signal adds context without allowing another to imply its
completeness or authority. `v0.30.6 implementation stop reached. Run pentest for
this exact commit.`

### v0.31.0 — Native Durable Ingestion Protocol

Status: planned

Goal: carry Vakaheim durability acknowledgements without altering external
protocol semantics.

Deliverables:

- versioned native framing, capabilities, source/session/sequence and batch IDs;
- authenticated acknowledgement negotiation, idempotency, resume and explicit
  terminal rejection/quarantine outcomes; authoritative durability responses
  remain disabled until the canonical envelope passes at `v0.31.1`;
- bounded compression negotiation, cancellation, deadlines and unknown fields.

Verification:

- reconnect at every frame and acknowledgement boundary, duplicate/reorder and
  downgrade tests;
- acknowledgement-to-stable-state recovery proof and hostile peer budgets;
- old/new interoperability and exact on-wire fixture corpus.

Exit criteria: Vakaheim durability claims exist only on its native negotiated
protocol, and no pre-envelope response can be mistaken for durable evidence.
`v0.31.0 implementation stop reached. Run pentest for this exact commit.`

### v0.31.1 — Canonical Local Ingestion Acknowledgement Envelope

Status: planned

Goal: bind every local acknowledgement to the exact accepted input and bounded
durability claim before batching or storage variants consume it.

Deliverables:

- dependency-free canonical schema and bounded signed encoding for protocol/
  envelope version, payload and request digests, source/session/sequence, batch
  and receipt IDs;
- durability class/vector for fact, raw-capsule or intentional raw
  unavailability, mapping/provenance, index and detection state;
- local storage generation/commit position, signer/key epoch, explicit
  unsupported-field handling and domain-separated signature context;
- capability negotiation that rejects unsupported classes and keeps
  `DurableQuorum` unavailable pending `v0.470.1` and `v0.471.0`; every claim tag
  is parseable here, while emission authority requires the `v0.31.3` registry
  and a matching `v0.31.4` runtime permit.

Verification:

- canonical round-trip/golden vectors, malformed/bounds/fuzz and mixed-version;
- payload/request/source/session/sequence/receipt substitution and digest conflict;
- abstract-verifier allow/deny around envelope emission, duplicate/replay and
  unsupported-class downgrade tests; real stable-state crash proof is deferred
  to each WAL/raw/index/detection/quorum activation owner;
- claim audit proving a signature authenticates the claimant but cannot prove a
  compromised storage backend truthful.

Exit criteria: every later-enabled local durability acknowledgement uses one
canonical, request-bound claim with no stronger implied durability. `v0.31.1
implementation stop reached. Run pentest for this exact commit.`

### v0.31.2 — Acknowledgement Evidence And Historical Verification

Status: planned

Goal: separate live transport replay controls from long-lived chain-of-custody
verification of acknowledgement evidence.

Deliverables:

- separate transport replay-acceptance deadline, manifest retention period and
  historical verification policy fields;
- signed event time with `TimeTrust` source/epoch/uncertainty, signer/key epoch
  and retained certificate/trust-path or equivalent historical trust evidence;
- explicit revocation-at-signing, later revocation and later-compromise states,
  including policy for indeterminate historical status;
- archival verification interface that does not authorize replay or new writes
  and preserves a retained expired manifest as evidence when policy requires it.

Verification:

- expired transport window with valid retained evidence and forbidden replay;
- signer rotation, certificate expiry, revocation before/after signing, later key
  compromise, uncertain time and unavailable revocation history;
- retention expiry, legal hold, trust-root rotation and offline verification;
- canonical fixtures prove archival interpretation cannot mutate the original
  signed acknowledgement.

Exit criteria: network expiry cannot silently destroy or overstate historical
evidentiary validity, and historical verification grants no live authority.
`v0.31.2 implementation stop reached. Run pentest for this exact commit.`

### v0.31.3 — Acknowledgement Claim Activation Registry

Status: planned

Goal: make acknowledgement schema support independent from authority to emit a
claim whose implementation and component prerequisites have actually passed,
without treating a roadmap version label as runtime authority.

Deliverables:

- dependency-free fail-closed registry contract implementing the repository
  Acknowledgement Claim Activation Matrix by claim, component and protocol/
  schema/mapping/policy epoch, with roadmap versions retained only in docs/tests;
- verifier-class and permit-requirement registry binding exact build/
  configuration epochs; unknown, absent, stale or partially upgraded entries
  remain disabled;
- initial `Received` and per-profile `Validated` verifier requirements; later
  owners register fact/raw/index/detection/quorum verifier adapters without
  changing the envelope;
- negotiation exposes parseable-but-disabled claims as unsupported and never
  aliases a requested claim or component to a weaker one.

Verification:

- table-driven proof for every matrix row before, during and after activation;
- `Received` cannot imply `Validated`; fact cannot imply mapping/provenance or
  raw; primary index cannot imply security index; local durability cannot imply
  quorum or detection;
- missing/stale/forged activation evidence, version downgrade, unknown tags and
  current/previous mixed-version peers;
- prove roadmap/milestone version strings are absent from runtime permits,
  encodings and authorization decisions;
- failover/restart/config rollback preserves disabled state unless the complete
  prerequisite evidence is still valid.

Exit criteria: registry/schema presence conveys no runtime authority, and every
component has one fail-closed verifier requirement for `v0.31.4` to enforce.
`v0.31.3 implementation stop reached. Run pentest for this exact commit.`

### v0.31.4 — Runtime Claim Permit And Encoder Authority

Status: planned

Goal: make an active acknowledgement component unencodable without an opaque
permit issued by the durable-state verifier that actually proved it.

Deliverables:

- dependency-free sealed `ClaimPermit<Component>` contract with private
  construction and authenticated cross-process representation where required;
- mandatory tenant/source scope, protocol/schema/mapping/policy epochs, covered
  input range or generation, verifier identity, activation generation, component
  identity and terminal coverage status;
- encoder API that requires a matching permit for every active component and
  rejects booleans, caller assertions, roadmap versions and unrelated permits;
- separate complete versus explicit non-complete progress permits; `Partial`,
  `Unavailable`, `Stale`, `Rebuilding` or policy-limited evidence cannot be
  encoded as the active/complete claim;
- narrow verifier-adapter interface used later by WAL, raw, index, detection and
  quorum owners without moving their durability logic into `ack-manifest`.

Verification:

- compile-fail/API tests prove callers cannot construct, widen, retarget or
  substitute permits;
- codec/golden/fuzz tests use abstract verifier fixtures and never claim real
  stable-media, index, detection or quorum proof at this milestone;
- cross-tenant/source/component/range/epoch/verifier substitution, replay,
  activation-generation rollback and mixed-version downgrade;
- prove the encoder cannot consult milestone labels and cannot emit an active
  component from schema/registry presence alone.

Exit criteria: every active claim component requires a matching scoped runtime
permit, while actual state proof remains solely with its later activation owner.
`v0.31.4 implementation stop reached. Run pentest for this exact commit.`

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
- idempotent writes, deduplication windows and acknowledgement levels carried
  only in the `v0.31.1` envelope under the `v0.31.2` evidence lifecycle and
  enabled by the `v0.31.3` registry plus a matching `v0.31.4` runtime permit;
- Received/Validated/DurableLocal/DurableQuorum/Indexed/DetectionProcessed tags
  remain parseable but impossible to emit until their matrix owner passes;
- acknowledgement carries a durability vector for fact, raw-capsule or
  intentional raw unavailability, mapping/provenance, index and detection state;
- capability negotiation keeps `DurableQuorum` unavailable until its `v0.470.1`
  cluster envelope extension and `v0.471.0` active replication pass; unsupported
  levels are rejected rather than approximated by local durability.

Verification:

- reconnect at every acknowledgement, duplicate storms, reordered batches;
- checkpoint corruption, window expiry, retry exhaustion and partial writes;
- end-to-end invariant that acknowledged levels match durable state;
- downgrade/mixed-version and component-independence matrix conformance.

Exit criteria: no exactly-once fiction; retries are safe and progress is
honest, and quorum durability cannot be advertised before active-write
replication exists; no other claim activates from enum/schema presence.
`v0.34.0 implementation stop reached. Run pentest for this exact commit.`

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
- fsync/durability adapter contract for supported hosted systems;
- WAL durable-state verifier issues separate scoped `v0.31.4` permits for
  `DurableLocal.fact` and `DurableLocal.mapping_provenance` only when each exact
  covered component reaches documented stable media; fact cannot imply mapping/
  provenance, and raw/index/detection entries remain disabled.

Verification:

- power loss at every write and sync point, disk-full and partial-sector tests;
- crash before/after stable-state verification and permit issuance; no permit may
  precede the covered component's stable-media transition;
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

Goal: implement an exact recoverable handoff across separate scheduler/outbox
transaction domains without duplicating externally visible effects.

Deliverables:

- canonical `HandoffKey` containing non-null `AuthorityDomainId` as
  `Tenant(TenantId)` or `System(SystemDomainId)`, consumer namespace, job ID,
  effect ordinal and stable logical destination-ledger ID; no ambient/global
  authority exists; tenant IDs use the internal tenant authority, system IDs are
  registry-issued/purpose-scoped/non-reusable, and the admitted scheduler/
  consumer contract rejects fake tenant or arbitrary unscoped caller IDs;
- durable `HandoffIntent` binding the complete handoff key, canonical request
  digest, schema version and scheduler/consumer anti-replay epoch in the
  scheduler journal; the epoch is fenced state, not part of uniqueness identity;
- outbox `put_if_absent(handoff_key, request_digest)` with linearizable uniqueness;
  the same complete key plus another digest emits an integrity incident and stops;
- durable outbox receipt binding the complete handoff key, record ID, request
  digest, destination-ledger routing/generation epoch and commit epoch; routing/
  generation never becomes part of the uniqueness key;
- job remains `HandoffPending` until that receipt is read back and validated;
  only then may it become `HandedOff`;
- prepared/dispatched/unknown-outcome/reconciled/terminal protocol compatible
  with later SOAR effect semantics;
- recovery idempotently completes one handoff and cannot create two outbox
  records for one canonical handoff key;
- cancellation wins only before `HandoffIntent` commitment; after intent it is a
  cancellation request, and after outbox commit it cannot delete, suppress,
  reinterpret or hide an uncertain effect;
- local handoff explicitly uses this intent/receipt recovery protocol across
  separate stores rather than claiming a shared transaction domain;
- no production effect adapter activates until its owning durable outbox/action
  ledger milestone plus `v0.44.8` migration and `v0.44.9` post-retention replay
  gates and `v0.44.10` current anchor assurance pass.

Verification:

- crash before/after handoff/send/ack, timeout, duplicate and ambiguous response;
- crash at every scheduler-intent/outbox-durable/HandedOff boundary and concurrent
  cancellation/recovery;
- same handoff key/different digest, forged/stale/mismatched receipt and commit
  epoch;
- cross-authority-domain collision, tenant/system-domain confusion, same apparent
  ID in notification/action ledgers, malicious caller-selected IDs and effect-
  ordinal reuse;
- unknown/retired/reused `SystemDomainId`, purpose confusion and attempted
  ambient/global infrastructure authority;
- tenant destruction/external-ID reassignment, permanent internal-ID tombstone,
  destination-ledger migration/split and old ledger-generation replay;
- non-idempotent destination and unavailable reconciler scenarios;
- uniqueness/property proof for one durable outbox record per complete handoff
  key without collisions across authority domain, consumer or logical ledger;
- prove generic scheduler retry cannot directly repeat an external side effect.

Exit criteria: effectful work leaves through a concrete intent/put-if-absent/
receipt protocol whose canonical identity is authority-domain-, consumer- and
logical-ledger-scoped, with no ambient global scope and explicit unknown
outcomes. `v0.44.4 implementation stop reached. Run pentest for this exact
commit.`

### v0.44.5 — Scheduler Consumer Admission Contract

Status: planned

Goal: prevent later subsystems from inventing private schedulers.

Deliverables:

- mandatory consumer profile: job identity/version, checkpoint, cancellation,
  misfire/catch-up/skip, idempotency, recovery and uncertain-time behavior;
- classification of internal/idempotent versus externally effectful work;
- every externally effectful class declares its maximum witness-offline/stale
  interval and deterministic `Unverifiable` behavior for later `v0.44.10`
  dispatch admission; no consumer may inherit an unbounded/global default;
- conformance harness and registry for every admitted job type.

Verification:

- reject incomplete profiles, ambient wall-clock use, unbounded retry and missing/
  unbounded effect-class witness-staleness policy;
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

- current/previous scheduler-journal, handoff-intent, outbox record and receipt
  schema matrix;
- upgrade/migration order, dual-read/write limits and irreversible boundaries;
- old/new worker fencing and stable canonical `HandoffKey` identity across schema
  changes, including authority-domain and routing-epoch fields required by
  `v0.44.8`, anti-replay epoch/tombstone fields required by `v0.44.9` and anchor-
  assurance/witness fields required by `v0.44.10`.

Verification:

- every supported mixed-version pair and crash at each handoff transition;
- partial migration, rollback, stale worker, duplicate recovery and cancellation;
- prove one durable outbox record and an honest job state after every trace.

Exit criteria: mixed versions cannot lose, duplicate or reinterpret an effect
handoff. `v0.44.7 implementation stop reached. Run pentest for this exact
commit.`

### v0.44.8 — Outbox Ledger Migration Authority And Deduplication

Status: planned

Goal: migrate, split or replace an outbox ledger generation without resetting
handoff uniqueness or allowing two writable authorities.

Deliverables:

- dependency-free `handoff-core` authority/routing/fencing state model with
  hosted ledger adapters kept outside the portable uniqueness contract;
- stable logical destination-ledger identity in `HandoffKey` and a separate
  fenced routing/generation epoch recorded by intent, outbox record and receipt;
- linearizable authority record permitting exactly one generation to accept new
  handoff keys, with old-generation write fencing confirmed before cutover;
- transferred deduplication/key index or an authoritative lookup spanning old
  and new generations through the `v0.44.9` replay horizon;
- recovery state machine for overlap among intent creation, authority cutover,
  dedup-index transfer/lookup and outbox insertion;
- split/merge rules that preserve the logical ledger identity for an existing
  semantic destination and cannot reinterpret an in-flight handoff;
- receipt validation against the committed routing epoch while keeping that
  epoch outside the uniqueness key.

Verification:

- model/property proof that old and new generations cannot both accept the same
  handoff key at any cutover boundary;
- crash/partition/rollback during fencing, index transfer, routing commit,
  insertion and receipt persistence;
- stale route, stale/malicious writer, lost/corrupt partial dedup index and
  authoritative-lookup outage;
- intent before/during/after migration, concurrent retry/cancellation and same
  key/different digest across generations;
- tenant destruction/external-ID reassignment and tenant/system authority-domain
  separation survive migration without fake tenant or global authority.

Exit criteria: ledger topology can change without making an existing effect key
new again or authorizing concurrent generations. `v0.44.8 implementation stop
reached. Run pentest for this exact commit.`

### v0.44.9 — Spent Handoff Tombstone And Replay-Horizon Fence

Status: planned

Goal: preserve handoff uniqueness after payload, outbox record and ordinary
deduplication retention expire, including restore of older state.

Deliverables:

- compact terminal `SpentHandoffKey` containing domain-separated keyed
  commitments to the complete logical `HandoffKey` and canonical request digest,
  terminal disposition and anti-replay epoch, but no payload or external identity;
- tombstone retention covering the maximum scheduler-journal, outbox-replica,
  delayed-delivery, backup, restore and disaster-recovery replay horizon;
- scheduler/consumer minimum-accepted anti-replay epoch fence for intents older
  than retained tombstones, persisted separately from workload snapshots and
  usable for dispatch only under the `v0.44.10` anchor-assurance contract;
- coordinated GC proof across scheduler journals, outbox generations/replicas,
  backup catalogs and disaster-recovery copies before payload/dedup/tombstone
  removal or replay-fence advancement;
- restore admission that can recover historical data while refusing activation
  of an intent below the committed minimum epoch;
- separate anti-replay commitment-key lifecycle: tenant crypto-shred removes
  identifying/payload keys while non-identifying replay commitments remain only
  as long as required, with rotation and destruction governed/audited.

Verification:

- restore from every snapshot boundary before/after outbox, dedup-index, payload
  and tombstone cleanup;
- delayed message or old scheduler journal returns after ordinary record expiry;
- same key/same digest remains spent and same key/different digest raises an
  integrity incident after the original payload is gone;
- GC omission/race across journal, replica, backup and DR copy, plus rollback of
  the minimum accepted epoch;
- tombstone correlation/dictionary/privacy attacks, tenant destruction,
  anti-replay key rotation/loss and crypto-shred conformance;
- model proof that either a live key record, spent tombstone or currently
  verifiable epoch anchor rejects every replayable historical intent.

Exit criteria: no retained or restorable historical artifact can make a spent
handoff key usable again, while replay protection retains no unnecessary tenant
identity or payload. `v0.44.9 implementation stop reached. Run pentest for this
exact commit.`

### v0.44.10 — Anti-Replay Fence Anchor Assurance

Status: planned

Goal: distinguish a logically monotonic fence from evidence that can resist or
detect full-host, disk-image and workload-state rollback.

Deliverables:

- dependency-free `FenceAnchorAssurance` state machine with exactly
  `HardwareMonotonic`, `ExternalWitnessed` and `Unverifiable` dispatch states;
- `HardwareMonotonic` only for an admitted hardware/OS counter profile that proves
  non-rollback semantics and reset/reprovision handling; ordinary files,
  encrypted-file fallbacks and generic keystores cannot claim it;
- mandatory `ExternalWitnessed` baseline requiring at least one current witness
  outside the protected workload's snapshot/restore authority, storage failure
  domain, administrative authority, signing-key domain and consensus/recovery
  domain; admitted profiles are an independent audit domain or an externally
  retained `v0.10.3` operator-quorum-signed chained record;
- an operational/cluster consensus group may replicate the logical anchor and
  expose checkpoints, but cannot alone yield `ExternalWitnessed`; it must be
  checked against the external record above, or dispatch must separately qualify
  through `HardwareMonotonic`;
- canonical signed `WitnessDispatchPermit` binding authority domain, logical
  ledger/consumer, exact witness-record digest and minimum epoch, prior record
  digest, witness identity and authority class, signed `TimeTrust` validity/
  lease interval, activation generation, effect-class maximum offline/stale
  interval and the policy digest that selected that interval;
- inherit `v0.4.4`: dispatch is valid only when the complete conservative current
  uncertainty interval proves the permit is inside its signed lease and the
  effect-class stale limit; local clocks can shorten validity but never extend it,
  while rollback, reboot without monotonic continuity, unavailable sources or
  excessive uncertainty become `Unverifiable`;
- chained `WitnessSignerSuccessor` record binding old/new signer identities,
  current minimum epoch, prior witness digest and activation generation, with
  replacement authorized by a `v0.10.3` operator quorum; rotation cannot fork
  the chain or lower the fence;
- signer-status history preserves verification of old records with explicit
  valid-at-signing/revoked/compromised state, while any permit from a signer now
  revoked/compromised cannot authorize new dispatch and that signer cannot issue
  a unilateral successor;
- deterministic comparison/merge/conflict rules for multiple witnesses and
  restore/import; a backup witness is evidence to compare, never authority to
  lower the active fence;
- `Unverifiable` on absent/corrupt/conflicting/reset evidence, witness disagreement,
  expired lease, time discontinuity/excess uncertainty, a permit whose signer is
  revoked/compromised, successor conflict or exceeded effect-class offline/
  stale interval: historical data may mount read-only, but scheduler/outbox/
  action/notification dispatch and compensation remain disabled; no automatic
  fresh-epoch initialization;
- epoch-advance barrier proving no older `HandoffPending`, `UnknownOutcome`,
  compensation, reconciliation, delayed-delivery or registered effect state can
  remain live in journals, replicas, backups or DR copies; unknown/unproven
  consumers block advancement and require retaining spent-key tombstones;
- explicit authorized reconciliation ceremony from read-only recovery to a
  current hardware or external witness, with immutable audit evidence.

Verification:

- full-host/disk-image rollback and clone of an old backup onto a replacement
  machine;
- simultaneous rollback of every operational consensus member and workload
  snapshot while the independent witness remains ahead; the restored deployment
  stays read-only;
- missing/corrupt/conflicting witnesses, witness rollback and attempted fresh
  initialization;
- witness-record digest/epoch/identity/authority-class substitution, signed-lease
  expiry, disagreement and per-effect-class offline/stale boundary cases;
- forward/backward clock jumps, reboot with/without monotonic continuity,
  unavailable sources and uncertainty intervals touching/crossing lease bounds;
- normal/emergency signer rotation, lost/revoked/compromised old/new signer,
  unauthorized replacement, lowered-epoch successor, chain fork and conflicting
  old/new permits;
- falsely shared snapshot, storage, administrator, signing-key or consensus/
  recovery authority cannot be classified as external;
- hardware counter reset/reprovision, clone, unsupported provider and downgrade
  to a local file/keystore;
- candidate epoch advance with every older pending/unknown/compensation/
  reconciliation/delayed state, incomplete consumer registry or unavailable copy;
- read-only recovery followed by authorized fence reconciliation, including
  wrong quorum, stale witness and audit omission;
- model proof that effect dispatch is possible only with a current verified
  anchor and cannot advance beyond the proven live-state barrier.

Exit criteria: fence assurance states exactly what prevents or detects rollback;
operational consensus alone never claims externality; any missing, expired or
disagreeing proof, uncertain lease time or signer-chain conflict yields
`Unverifiable` and fails closed for every external effect.
`v0.44.10 implementation stop reached. Run pentest for this exact commit.`

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
- safe fallback to segment scan on absence or invalidity;
- durable generation/commit state exposed to the `v0.48.1` coverage verifier;
  this implementation alone cannot emit `Indexed.primary`.

Verification:

- result equivalence with full scans and corrupted/missing/stale index tests;
- boundary/range/cardinality and adversarial selectivity cases;
- crash before/after index-generation construction and commit publication;
- build/query resource and performance budgets.

Exit criteria: index use never changes query truth or bypasses policy.
`v0.48.0 implementation stop reached. Run pentest for this exact commit.`

### v0.48.1 — Exact Index Coverage And Progress Claim

Status: planned

Goal: prove that an index generation covers the exact acknowledged facts and
definition rather than merely proving that some index generation committed.

Deliverables:

- canonical coverage identity binding tenant/source, fact generation or bounded
  input range, index class, definition/digest/version, index generation and
  source snapshot/catalog generation;
- terminal `Complete`, `Partial`, `Missing`, `Unavailable`, `Stale` and
  `Rebuilding` coverage states with deterministic precedence;
- index coverage verifier that reconciles every expected fact/page/partition and
  alone issues the matching `v0.31.4` `ClaimPermit<Indexed>`;
- range-splitting rule for definition/policy/snapshot changes during indexing;
  one permit cannot cross a changed epoch;
- primary-index activation adapter here and reusable security-index adapter for
  `v0.50.0`; one class/definition/range never implies another.

Verification:

- omitted/duplicate/extra fact, page or partition and wrong range/generation;
- index definition/version/class substitution, stale snapshot, mid-range change,
  rebuild and partial publication;
- crash before/after coverage reconciliation, index commit and permit issuance;
- missing/disabled index produces explicit non-complete progress and cannot issue
  a complete permit;
- abstract caller, another index or committed-but-uncovered generation cannot
  cause the encoder to emit `Indexed`.

Exit criteria: `Indexed` identifies the exact covered fact set and index
definition, and every incomplete condition remains explicit. `v0.48.1
implementation stop reached. Run pentest for this exact commit.`

### v0.50.0 — Security Indexes

Status: planned

Goal: index security-specific values and relationships safely.

Deliverables:

- exact/token/prefix/suffix text, IP prefix, port/protocol, hash/identifier;
- entity adjacency, relationship type and finding/incident references;
- sensitive-index policy, encryption/transform hooks and collision semantics;
- `v0.48.1` coverage adapter for each exact security-index definition/range;
  only its complete verifier permit activates `Indexed.security`, and a primary-
  index permit cannot satisfy this claim.

Verification:

- Unicode/token, IP family/prefix, hash collision, high-degree graph tests;
- scan equivalence, leakage analysis and authorization filtering;
- missing/disabled/partial security index, mid-range definition change and crash
  before/after coverage permit issuance;
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
- orphan/dangling-reference scan, repair, reprocess and secure expiry;
- raw-store verifier issues the scoped `v0.31.4` `DurableLocal.raw` permit only
  when `v0.20.9` encrypted persistence and this atomic publication both verify
  for every exact referenced raw component/input range.

Verification:

- crash at every object/fact commit point, duplicate/collision, partial object,
  missing chunk and disk-full, including before/after permit issuance;
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
- clean-directory restore, dependency ordering, reindex and post-restore proof;
- export the current signed `v0.44.10` fence witness/assurance record beside the
  backup, including its exact permit digest/epoch/authority class and validity
  interval, without treating that copy as authority to lower an active fence;
- restore validates the current signer-successor/status chain independently; a
  backup cannot resurrect a permit from a later revoked/compromised signer;
- `v0.44.5` backup profile; restore/recovery remains explicit operator work and
  never depends on scheduler availability.

Verification:

- backup concurrent with ingest/compaction, crash, missing/corrupt object,
  stale manifest, wrong/lost key and disk-full;
- restore to empty host, point-in-time boundary and authorization/audit checks;
- restore/clone behind the active external/hardware witness, missing/conflicting
  witness and full-host image rollback: mount read-only as `Unverifiable`, never
  initialize a fresh epoch or dispatch effects;
- a co-restored witness/permit sharing the backup's authority or failure domains
  cannot qualify as external, even if its digest matches the restored anchor;
- backup before signer rotation/compromise discovery cannot restore the old key's
  dispatch authority or fork/lower the successor witness chain;
- authorized witness reconciliation can re-enable effects only after the active
  fence and all older live-state barriers prove current;
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

### v0.79.1 — Canonical Local Query Result And Coverage Model

Status: planned

Goal: define the final portable result/coverage contract before the first local
executor can emit a result.

Deliverables:

- canonical query/plan, tenant, authorization, policy and snapshot identities;
- expected local partition/segment identities and one terminal observed status
  per expected element, with result/aggregate/checkpoint digests;
- explicit `Pending`, `Complete`, `Partial`, `Unavailable`, `Truncated` and
  `PolicyLimited` states with a deterministic precedence table;
- `Complete` derivation only after all expected local elements reconcile to one
  compatible terminal success; absence, denial, truncation and faults remain
  explicit non-complete outcomes;
- dependency-free bounded encoding shared by the first executor, later
  operators, cold tiers and the distributed extension.

Verification:

- missing, duplicate, replayed and conflicting element/status/digest cases;
- policy/snapshot/catalog change, cancellation, result truncation and disk fault;
- composition properties prove later joins, aggregates and sets cannot turn a
  non-complete input into `Complete`;
- canonical round-trip/golden, malformed/bounds/fuzz and mixed-version tests.

Exit criteria: the first local executor has one deterministic coverage contract,
and successful transport alone can never imply completeness. `v0.79.1
implementation stop reached. Run pentest for this exact commit.`

### v0.79.2 — Authoritative Expected-Set Commitments

Status: planned

Goal: make a compact expected-set commitment verifiably represent the exact
authoritative catalog set before execution rather than authenticate an opaque
value after results exist.

Deliverables:

- versioned commitment algorithm/domain and canonical element encoding/order,
  with duplicate rejection and committed element count;
- catalog generation/root, query snapshot, retention watermark and cold-catalog
  watermark bound into the commitment context;
- bounded membership/opening proofs, or a narrowly named trusted catalog
  expander whose authenticated input/output and audit contract are equivalent;
- catalog pinning rules: execution uses the committed generation, while later
  catalog movement yields retry/stale/unavailable rather than changing the set;
- explicit list/commitment equivalence and migration policy for algorithm or
  catalog-format version changes.

Verification:

- reordered, duplicated, omitted, inserted and count-substituted elements;
- wrong catalog root/generation, snapshot, retention or cold watermark;
- forged/missing opening, compromised/unavailable expander and size/work limits;
- catalog change during execution, retention race, cold-tier movement,
  algorithm-version downgrade and list/commitment equivalence properties.

Exit criteria: before execution, a verifier can establish what authoritative
expected set was committed and detect any context or membership substitution.
`v0.79.2 implementation stop reached. Run pentest for this exact commit.`

### v0.80.0 — Single-Node Execution

Status: planned

Goal: execute bounded queries over local immutable segments.

Deliverables:

- scans, filters, projections, aggregates and result streaming through the
  `v0.79.1` model and `v0.79.2` expected-set context; joins remain exclusively
  owned by `v0.82.0`;
- memory/work/time/output budgets, cancellation and backpressure;
- storage-level authorization recheck and canonical coverage results; the
  executor cannot emit a legacy/bare completeness boolean.

Verification:

- reference-result comparison, cancel at every operator, disk/index faults;
- memory, CPU, output and aggregate/cardinality exhaustion tests;
- prove every result state derives through `v0.79.1` and every `Complete` result
  verifies the pinned `v0.79.2` authoritative expected set;
- benchmark suite with plans, data, indexes and exact commit.

Exit criteria: the first executor cannot exceed policy/resource budgets or emit
a result outside the canonical coverage contract. `v0.80.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.82.0 — Bounded Join Engine

Status: planned

Goal: execute joins only under provable time, key, state and output bounds.

Deliverables:

- required bounded event time range unless privileged offline mode is explicit;
- equality/partition key or an explicit nested-loop work budget;
- build-side row/byte, output-cardinality, spill and replan/abort limits;
- `v0.79.1` coverage-state composition and `v0.79.2` expected-set context are
  preserved independently for both inputs and the output.

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
  propagation through the canonical `v0.79.1` model without promoting a
  non-complete input.

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
  pinned `v0.4.2` profile;
- aggregate/result digests and uncertainty preserve `v0.79.1` coverage-state
  precedence without promoting incomplete inputs.

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
  completeness gates pass through the `v0.79.1` coverage model.

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
  semantics through `v0.79.1`;
- catalog generations/roots, retention and cold watermarks participate in the
  authoritative `v0.79.2` expected-set commitment rather than an ambient lookup.
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

### v0.100.2 — Extended Modern-SIEM Scope Admission Decisions

Status: planned

Goal: bind advanced product-scope decisions early enough that none can remain an
implicit promise or late 1.0 surprise.

Deliverables:

- signed implement-or-non-goal decisions for external data-lake query-in-place,
  OT/ICS monitoring, DSPM/data-security monitoring, external attack-surface
  management and MSSP hierarchical tenancy;
- named national NIS2 profile decision with jurisdiction/legal-review ownership;
- per-option threat, privacy, safety, protocol/format, no-third-party feasibility,
  operations, performance and support analysis;
- exact admitted implementation/closure series and tested rejection surfaces.

Verification:

- every option has owner, bounded support claim, dependencies and closure route;
- rejected paths fail through API/config/UI and documentation claim tests;
- admitted paths have enough small stops before `v0.730.0`.

Exit criteria: all extended-scope choices are executable plans or explicit
tested 1.0 non-goals. `v0.100.2 implementation stop reached. Run pentest for this
exact commit.`

### v0.101.0 — External Data-Lake Catalog And Snapshot Contract

Status: conditional on admission at `v0.100.2`

Goal: query external retained security data without treating remote listings or
mutable objects as a complete Vakaheim snapshot.

Deliverables:

- provider-neutral catalog, object/version/partition identity and snapshot
  manifest contracts;
- admitted open columnar format decision, schema/statistics provenance and
  explicit unsupported encodings;
- credential/egress/residency/purpose capabilities and immutable query audit;
- missing, changed, deleted, permission-limited and unverifiable object states.

Verification:

- mutable listing, object replacement, stale catalog, partial permissions and
  partition omission;
- hostile metadata/statistics/schema and cross-tenant credentials;
- zero-third-party feasibility and catalog threat-model pentest.

Exit criteria: remote catalog state never implies an authoritative complete
snapshot without evidence. `v0.101.0 implementation stop reached. Run pentest
for this exact commit.`

### v0.101.1 — External Columnar Reader And Predicate Safety

Status: conditional on admission at `v0.100.2`

Goal: read the admitted external format with bounded native code before VQL
pushdown is allowed.

Deliverables:

- checked metadata/page/encoding reader with byte/depth/row/value limits;
- projection and predicate evaluation with exact null/type/time semantics;
- encrypted bounded cache/spill and range-read integrity evidence;
- corruption, unsupported-codec and partial-object outcomes.

Verification:

- malformed metadata/pages, decompression bombs, integer/offset overflow and
  adversarial nesting/cardinality;
- reference-reader differential fixtures and projection/predicate equivalence;
- sustained fuzzing, allocation failure and parser pentest.

Exit criteria: hostile remote columnar data cannot escape parser or work bounds.
`v0.101.1 implementation stop reached. Run pentest for this exact commit.`

### v0.101.2 — External VQL Planning Coverage And Pushdown

Status: conditional on admission at `v0.100.2`

Goal: integrate external scans without weakening VQL policy or completeness.

Deliverables:

- catalog/snapshot-aware logical and physical scan operators;
- policy-safe projection/predicate pushdown with local recheck;
- expected-set/coverage manifests, cost uncertainty and partial-result reasons;
- cancellation, checkpoint, replan and remote-rate/cost admission.

Verification:

- malicious statistics, changing snapshot, unsafe pushdown, policy drift and
  partial range reads;
- local reference equivalence and exact incomplete-result behavior;
- hostile cost, cancellation, privacy and query pentest.

Exit criteria: query-in-place is policy-equivalent and never hides missing or
changing remote data. `v0.101.2 implementation stop reached. Run pentest for
this exact commit.`

### v0.101.3 — External Data-Lake Scope Closure

Status: conditional on `v0.100.2`

Goal: close the 1.0 query-in-place decision without hiding implementation work.

Deliverables:

- admitted path integration of `v0.101.0`–`v0.101.2`, or enforced unsupported
  API/config/UI behavior when rejected;
- named format/provider support inventory and no implied lakehouse claim;
- capacity, outage, migration, support and release-note evidence.

Verification:

- live/offline representative stores, schema evolution, outage and rollback for
  admitted scope;
- rejection-path and unsupported-provider claim scans;
- independent query-in-place architecture and exact-commit pentest.

Exit criteria: external query-in-place is either bounded and proven or
conclusively absent from 1.0. `v0.101.3 implementation stop reached. Run pentest
for this exact commit.`

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

### v0.140.1 — Authoritative Active Rule-Set And Cohort Commitment

Status: planned

Goal: define the complete rule population applicable to an input range and
rollout cohort before a worker may claim detection processing.

Deliverables:

- canonical expected-rule-set commitment issued by control/rule-rollout
  authority, binding tenant/source scope, policy epoch, rollout cohort, input/
  fact range and rule-package/execution identities;
- explicit disposition for every applicable rule: required active, disabled by
  policy, shadow, canary or unavailable, with no worker-selected omission;
- commitment element count, canonical ordering, duplicate rejection, authority/
  signer identity and activation generation;
- baseline static/default-cohort authority adapter; staged shadow/canary/rollout
  assignment remains unavailable until its `v0.190.0` adapter passes;
- range-splitting and checkpoint rules for rule, rollout, cohort or policy change
  during processing; one commitment cannot cross an applicability boundary;
- lookup/opening verification or a narrowly identified trusted expander using
  the same expected-set security contract as `v0.79.2`.

Verification:

- omitted/extra/duplicate/substituted rule, wrong tenant/source/cohort/range and
  forged/stale commitment;
- disabled, shadow and canary rule handling cannot silently shrink the required
  active set or become a successful active-rule outcome;
- mid-range rule enable/disable, rollout promotion/rollback and policy change;
- authority/worker confusion, compromised/unavailable expander and mixed-version
  commitment canonicalization.

Exit criteria: the expected active rule population comes from authoritative
policy/rollout state and cannot be selected by a detection worker. `v0.140.1
implementation stop reached. Run pentest for this exact commit.`

### v0.140.2 — Detection Progress Acknowledgement Activation

Status: planned

Goal: activate `DetectionProcessed` only from durable, attributable detection
progress over the authoritative expected rule set rather than successful
dispatch, a worker-selected subset or an in-memory rule run.

Deliverables:

- durable progress checkpoint/cursor binding tenant, source/session/input range,
  fact generation and terminal per-rule outcome set;
- exact `v0.140.1` expected-rule-set commitment, rollout cohort, policy epoch and
  one terminal outcome for every required active rule;
- complete `v0.115.0` rule/schema/mapping/policy/content/engine/configuration
  execution identity plus detection-state generation and worker identity;
- progress verifier issuing the scoped `v0.31.4`
  `ClaimPermit<DetectionProcessed>` only after expected/observed reconciliation;
- explicit `Partial`, `Unavailable`, `PolicyLimited` and `Changed` progress when
  a required rule/index/input/state partition is missing or an applicability
  epoch changes; these cannot emit complete `DetectionProcessed`.

Verification:

- crash before/after execution, checkpoint persistence and acknowledgement;
- omitted/duplicate rule, smaller worker-chosen set, stale cursor, input-range
  gap, configuration/rule/cohort/policy swap, state rollback, eviction and replay;
- missing index, disabled rule, shadow/canary disposition and mid-range rule-set
  change remain explicit non-complete progress states;
- `DurableLocal.fact`, `Indexed` or successful finding emission cannot imply
  detection progress, and one rule-set claim cannot imply another;
- current/previous mixed-version, downgrade and checkpoint-recovery properties.

Exit criteria: `DetectionProcessed` proves a durable terminal outcome for the
exact authoritative active rule set, covered inputs and execution identity;
every incomplete condition remains explicit. `v0.140.2 implementation stop
reached. Run pentest for this exact commit.`

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

### v0.178.1 — ATT&CK Current Data Model And Provenance

Status: planned

Goal: track the current ATT&CK defensive model rather than freezing the pre-v18
detection representation.

Deliverables:

- implementation-time latest stable ATT&CK STIX 2.1 collection, currently
  `v19.1`, with signed-source/digest/license/retrieval provenance;
- tactics, techniques/sub-techniques, Detection Strategies, Analytics, Data
  Components, platforms, log sources and mutable elements as versioned objects;
- explicit handling for deprecated Data Sources and renamed/split tactics,
  including Stealth and Defense Impairment;
- Enterprise, Mobile and ICS domain separation with no implied domain coverage.

Verification:

- official STIX bundles, object relationships, revoked/deprecated/replaced IDs
  and current/previous-version differences;
- malicious bundles, reference cycles, ID reuse and cross-domain confusion;
- deterministic import, fixture freshness and licensing review.

Exit criteria: Vakaheim represents current ATT&CK defensive objects and their
exact source version. `v0.178.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.178.2 — Detection Strategy Analytic And Telemetry Coverage Graph

Status: planned

Goal: connect Vakaheim rules and source health to ATT&CK Detection Strategies and
platform-specific Analytics.

Deliverables:

- many-to-many rule/package-to-strategy/analytic/technique/platform mappings;
- analytic log-source/Data Component requirements mapped to concrete Vakaheim
  facts, source profiles and completeness states;
- coverage statuses implemented, partial, unavailable, policy-limited, untested
  and stale with explanation;
- migration history from legacy technique-only/data-source coverage.

Verification:

- missing required telemetry, one rule mapped to several analytics, platform
  mismatch and stale/revoked ATT&CK objects;
- coverage inflation, deprecated-source fallback and malicious content mapping;
- deterministic coverage graph and gap-report fixtures.

Exit criteria: every claimed ATT&CK detection coverage path reaches tested rules
and currently healthy required telemetry. `v0.178.2 implementation stop reached.
Run pentest for this exact commit.`

### v0.178.3 — ATT&CK Upgrade Shadow Migration And Freshness Gate

Status: planned

Goal: absorb ATT&CK releases without silently rewriting historical coverage or
detection claims.

Deliverables:

- staged current/new collection registry and shadow coverage recomputation;
- tactic/technique/strategy/analytic/data-component diff and owner review;
- preserved historical reports pinned to prior ATT&CK versions;
- scheduled freshness monitor that creates a new version stop for material
  stable updates before release freeze.

Verification:

- rename/split/revoke, relationship changes, missing collection and rollback;
- old/new coverage comparison and unchanged-rule drift detection;
- offline update bundle, migration and claim-boundary pentest.

Exit criteria: ATT&CK updates are reviewed migrations, never mutable labels.
`v0.178.3 implementation stop reached. Run pentest for this exact commit.`

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

### v0.180.4 — Sigma 2.1 Rule And Taxonomy Profile

Status: planned

Goal: bind a precise current Sigma support profile instead of promising a generic
mapping.

Deliverables:

- implementation-time latest stable Sigma selection, currently specification
  `2.1.0`, with grammar/schema/source/license digest;
- admitted logsource, detection, modifier, condition, taxonomy, metadata and
  package semantics plus explicit exclusions;
- canonical bounded parser and normalized Sigma IR with unknown-field handling;
- mapping from Sigma logsources/fields into exact Vakaheim schema and telemetry
  requirements.

Verification:

- official/representative rules, every modifier/condition boundary, duplicate
  YAML keys, aliases, recursion and oversized input;
- taxonomy ambiguity, unsupported feature and lossy mapping diagnostics;
- parser/type-checker fuzzing and reproducible compilation.

Exit criteria: Sigma support is versioned and feature-exact rather than a best-
effort query translation. `v0.180.4 implementation stop reached. Run pentest for
this exact commit.`

### v0.180.5 — Sigma Correlation And Filter Compilation

Status: planned

Goal: support admitted Sigma 2.1 correlations and reusable filters without
bypassing Vakaheim state/resource limits or tuning audit.

Deliverables:

- correlation rule references, grouping, aliases, timespan and condition mapping
  into bounded predicate/temporal IR;
- reusable filter identity, scope, version, author/reviewer and rule-binding
  provenance;
- compile-time state/cardinality/work estimates and unsupported correlation
  diagnostics;
- environment tuning as signed overlay packages, never silent source edits.

Verification:

- missing/cyclic rule references, conflicting aliases, unbounded grouping,
  filter precedence and stale filter/rule versions;
- Sigma/reference examples and native-equivalent execution comparisons;
- hostile correlation/filter corpus, state exhaustion and tuning pentest.

Exit criteria: correlation and filtering remain bounded, attributable and
reviewable. `v0.180.5 implementation stop reached. Run pentest for this exact
commit.`

### v0.180.6 — Sigma Interoperability Upgrade And Closure Gate

Status: planned

Goal: close current Sigma import support across compilation, simulation and
rollout while preserving unsupported semantics honestly.

Deliverables:

- native-versus-imported rule/correlation/filter conformance corpus;
- package, test, ATT&CK mapping, rollout and rollback integration;
- current/previous Sigma migration and material-update freshness policy;
- import report listing every preserved, transformed, lost and rejected element.

Verification:

- official SigmaHQ representative content, hostile packages and version skew;
- old/new compiler differential, round-trip where defined and semantic-loss
  review;
- independent interoperability, licensing and exact-commit pentest.

Exit criteria: admitted Sigma 2.1 content follows the same security lifecycle as
native content. `v0.180.6 implementation stop reached. Run pentest for this exact
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
- tenant/region/group/source/percentage/time rollout and rollback thresholds;
- `v0.44.5` timed rollout profile with policy/rule identity, cancellation,
  misfire/catch-up/skip and rollback checkpoint behavior;
- authoritative `v0.140.1` cohort/rule-set commitment adapter for every rollout
  assignment/change, forcing `v0.140.2` progress ranges to split at boundaries.

Verification:

- old/new deterministic comparisons and canary fault/noise/load scenarios;
- unauthorized activation, stale signature, rollback and configuration drift;
- worker-selected cohort, omitted shadow/canary disposition and progress permit
  spanning a rollout/rollback boundary;
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

### v0.292.1 — AWS CloudTrail Integrity And Data-Event Profile

Status: planned

Goal: make AWS audit coverage precise enough for security claims.

Deliverables:

- management/data/network-activity event profiles, trail/channel/lake identity,
  organization scope, digest validation and selector/exclusion evidence;
- S3, Lambda and other admitted high-value data-event mappings;
- delivery latency, duplication, region/global-service and permission coverage;
- exact supported AWS API/schema surface and current/live fixtures.

Verification:

- digest failure, selector gap, disabled trail, organization move, late/duplicate
  delivery and partial permissions;
- cross-account/region/source confusion and malicious event payloads;
- live AWS interoperability and source-completeness pentest.

Exit criteria: CloudTrail coverage states exactly which activity classes and
scopes are visible. `v0.292.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.292.2 — AWS GuardDuty And Security Hub Profile

Status: planned

Goal: ingest AWS-native findings without treating vendor classification as
Vakaheim evidence or incident authority.

Deliverables:

- GuardDuty finding and Security Hub ASFF profiles with stable IDs, updates,
  workflow/status, resources, severity and product provenance;
- source-finding version/dedup/supersession and raw-capsule preservation;
- account/region/organization coverage and delegated-administrator semantics;
- mapping to immutable Vakaheim findings with explicit vendor-trust limits.

Verification:

- update/retraction, duplicate aggregation, stale finding, product spoof and
  delegated-admin changes;
- cross-account resource reuse and partial product permissions;
- live interoperability, mapping conformance and connector pentest.

Exit criteria: AWS findings remain attributable inputs, never automatic Vakaheim
incidents. `v0.292.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.292.3 — AWS Network DNS And Edge Security Profile

Status: planned

Goal: cover admitted AWS network and edge evidence with sampling and visibility
limits explicit.

Deliverables:

- VPC Flow Logs, Route 53 Resolver query logs and WAF log profiles;
- interface/VPC/account/region identity, aggregation/sampling, action and rule
  provenance;
- delivery/sink/exclusion health and high-volume capacity profiles;
- entity/network mapping and ATT&CK analytic telemetry bindings.

Verification:

- aggregation window, skipped records, interface reuse, resolver/WAF disable,
  schema drift and rate pressure;
- NAT/proxy ambiguity and cross-account network identity;
- live fixtures, load campaign and provider-profile pentest.

Exit criteria: AWS network/edge visibility is measurable and never represented
as unsampled completeness. `v0.292.3 implementation stop reached. Run pentest
for this exact commit.`

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

### v0.294.1 — Microsoft Entra Identity Security Profile

Status: planned

Goal: implement named Entra sign-in, audit and identity-risk evidence with exact
tenant and licensing/permission visibility.

Deliverables:

- sign-in, service-principal, managed-identity, audit, provisioning and admitted
  risk event/detection profiles;
- conditional-access/MFA/session/device/application context and stable IDs;
- API retention, latency, paging, license/scope and partial-permission health;
- identity reuse, guest/cross-tenant and role/group change semantics.

Verification:

- deleted/recreated principals, guest tenants, risk update, paging gaps, license
  loss and conditional-access schema change;
- token/app confusion, cross-tenant leakage and incomplete scopes;
- live Entra interoperability and identity-profile pentest.

Exit criteria: every Entra identity claim exposes tenant, source, permission and
freshness limits. `v0.294.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.294.2 — Microsoft Defender XDR Profile

Status: planned

Goal: ingest Defender XDR alerts/incidents and advanced-hunting evidence without
ceding Vakaheim alert or incident authority.

Deliverables:

- named alert, incident, evidence/entity and admitted event API profiles;
- external update/supersession, severity/status and product/service provenance;
- stable link to raw source records and immutable Vakaheim findings;
- permission, retention, API quota and delayed-availability health.

Verification:

- external incident merge/split/close, alert update/retract, ID reuse and API
  partial outage;
- vendor severity/status attempting to mutate internal incident state;
- live Defender XDR interoperability and mapping pentest.

Exit criteria: Defender XDR contributes attributable evidence while Vakaheim
retains internal workflow authority. `v0.294.2 implementation stop reached. Run
pentest for this exact commit.`

### v0.294.3 — Azure Platform And Resource Security Profile

Status: planned

Goal: complete named Azure Activity, resource, policy and admitted security-
control evidence.

Deliverables:

- Activity Log, resource graph/inventory, policy and admitted Defender for Cloud
  finding profiles;
- tenant/subscription/resource-group/resource identity and movement history;
- diagnostic-setting/export/exclusion and delegated-management visibility;
- region, latency, cursor, throttling and permission coverage.

Verification:

- subscription transfer, resource ID reuse, diagnostic disable, policy update,
  paging and partial delegated scope;
- cross-tenant resource confusion and poisoned inventory/finding inputs;
- live Azure platform interoperability and connector pentest.

Exit criteria: Azure platform scope and every visibility exclusion are explicit.
`v0.294.3 implementation stop reached. Run pentest for this exact commit.`

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

### v0.296.1 — Google Security Command Center Profile

Status: planned

Goal: ingest Security Command Center findings with organization/folder/project
scope and source-product authority explicit.

Deliverables:

- SCC finding, mute/state, source, resource and vulnerability/exposure profiles;
- update/supersession, stable identity and raw-source preservation;
- service tier, activation, organization scope, latency and permission health;
- immutable Vakaheim finding mapping without automatic incident creation.

Verification:

- finding update/reopen/mute, source spoof, project move, service-tier loss and
  partial permissions;
- cross-organization resource reuse and stale inventory links;
- live SCC interoperability and finding-mapping pentest.

Exit criteria: SCC output is attributable vendor evidence with visible coverage
and authority limits. `v0.296.1 implementation stop reached. Run pentest for
this exact commit.`

### v0.296.2 — GCP Network DNS And Workload Security Profile

Status: planned

Goal: cover admitted GCP network, DNS and workload audit evidence under exact
sink/exclusion semantics.

Deliverables:

- VPC Flow Logs, Cloud DNS logs and admitted GKE/workload audit profiles;
- organization/folder/project/network/resource identity, sampling and aggregation;
- log-router sink/exclusion, region, latency and permission health;
- ATT&CK analytic and source-assurance mappings.

Verification:

- sampling, excluded logs, sink change, project move, workload identity reuse and
  throttling;
- NAT/proxy ambiguity, poisoned labels and cross-project linkage;
- live GCP fixtures, load campaign and profile pentest.

Exit criteria: GCP network/workload coverage states every sample, sink and
permission limitation. `v0.296.2 implementation stop reached. Run pentest for
this exact commit.`

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

### v0.298.1 — Data Asset Classification And Lineage Model

Status: conditional on admission at `v0.100.2`

Goal: model sensitive data assets before DSPM findings or exposure scores depend
on them.

Deliverables:

- datastore/bucket/database/table/object/data-set identities and lifecycle;
- classification labels, sensitivity confidence, owner, jurisdiction, purpose,
  lineage and source provenance;
- discovery/classifier conflict, staleness and unknown semantics;
- field-minimized metadata model that does not require ingesting protected data.

Verification:

- renamed/moved/reused assets, conflicting labels, stale scans and poisoned
  ownership/classification;
- cross-tenant lineage and sensitive sample leakage;
- deterministic identity/merge and privacy review.

Exit criteria: data context remains attributable metadata rather than assumed
truth. `v0.298.1 implementation stop reached. Run pentest for this exact commit.`

### v0.298.2 — Data Access Exposure And Control Graph

Status: conditional on admission at `v0.100.2`

Goal: represent who can reach sensitive data and which controls mediate access.

Deliverables:

- principal/role/service/network/public path to data-asset relationships;
- encryption, key, policy, sharing, backup and residency control observations;
- effective-time, confidence, permission-limited and unknown graph edges;
- bounded attack/exposure path computation over source-backed relationships.

Verification:

- inherited/conditional permissions, stale policies, public-link expiry, role
  churn and graph fan-out;
- false exposure from identity merge and poisoned control status;
- path evidence, incompleteness and tenant-isolation tests.

Exit criteria: every data-exposure path decomposes into current source-backed
edges and visible unknowns. `v0.298.2 implementation stop reached. Run pentest
for this exact commit.`

### v0.298.3 — Data Security Finding And Risk Integration

Status: conditional on admission at `v0.100.2`

Goal: create explainable data-security findings without converting classification
or exposure tools into incident authority.

Deliverables:

- OCSF-aligned data-security finding profile and immutable source finding;
- rules for public/overbroad access, weak controls, anomalous access and residency
  conflict with exact prerequisites;
- decomposable sensitivity/exposure/control/activity risk contribution;
- alert/incident promotion and corrective-action links through ordinary gates.

Verification:

- stale classification, missing activity, vendor finding update and risk
  inflation;
- unauthorized sensitive context disclosure and cross-tenant correlation;
- end-to-end data finding/alert/incident tabletop and pentest.

Exit criteria: DSPM evidence follows normal finding authority and privacy rules.
`v0.298.3 implementation stop reached. Run pentest for this exact commit.`

### v0.298.4 — External Attack-Surface Discovery Authority

Status: conditional on admission at `v0.100.2`

Goal: discover externally visible assets without allowing uncontrolled scanning
or guessed ownership.

Deliverables:

- explicit authorized domains, address ranges, cloud tenants and scan limits;
- passive DNS/certificate/domain and approved active observation source models;
- attribution confidence, ownership claim/review and third-party-hosting ambiguity;
- target authorization, rate, jurisdiction, opt-out and evidence retention.

Verification:

- unauthorized target expansion, shared hosting/CDN, domain takeover, IP reuse,
  wildcard certificates and stale passive data;
- scan abuse, service disruption and cross-tenant attribution;
- legal/abuse/security review and bounded discovery pentest.

Exit criteria: no asset is scanned or assigned to a tenant without explicit
authority and evidence. `v0.298.4 implementation stop reached. Run pentest for
this exact commit.`

### v0.298.5 — External Exposure Change And Finding Engine

Status: conditional on admission at `v0.100.2`

Goal: turn attributable perimeter changes into reviewable findings.

Deliverables:

- service/certificate/DNS/cloud-edge/software exposure observations and history;
- new/disappeared/changed exposure, weak TLS, expired certificate and admitted
  vulnerability correlation rules;
- confidence, freshness, validation and false-positive suppression evidence;
- links to asset/vulnerability/risk and ordinary alert promotion.

Verification:

- transient services, honeypots, CDN/proxy, scan blocking, banner deception and
  vulnerability-version ambiguity;
- false ownership and stale observation attacks;
- controlled perimeter fixtures and finding-quality pentest.

Exit criteria: external exposure findings remain evidence-backed and uncertainty-
aware. `v0.298.5 implementation stop reached. Run pentest for this exact commit.`

### v0.298.6 — DSPM And EASM Scope Closure

Status: conditional on `v0.100.2`

Goal: close data-security and external-attack-surface scope before provider and
content claims expand.

Deliverables:

- admitted path integration of `v0.298.1`–`v0.298.5`, or tested disabled
  API/config/UI paths for rejected capabilities;
- named discovery/classification/scanner support inventory;
- privacy, authorization, support, capacity and limitation documentation.

Verification:

- full data/external-exposure tabletop on admitted paths;
- rejected-path and implied-provider/capability claim scans;
- independent privacy, safety and exact-commit pentest.

Exit criteria: DSPM/EASM are proven bounded capabilities or explicit 1.0 non-
goals. `v0.298.6 implementation stop reached. Run pentest for this exact commit.`

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

### v0.302.1 — Okta Identity And System Log Profile

Status: planned

Goal: implement named Okta identity, authentication, policy and administration
evidence with cursor and permission health.

Deliverables:

- System Log, user/group/application/session/authentication/policy profiles;
- stable organization/object IDs, lifecycle, pagination, polling and hook identity;
- rate/retention/schema/permission coverage and source-capsule preservation;
- exact supported API/event-type matrix and entity mappings.

Verification:

- actor/target reuse, deleted users/apps, cursor expiry, duplicate events,
  throttling and permission loss;
- webhook spoof, organization confusion and schema drift;
- live Okta interoperability and connector pentest.

Exit criteria: Okta visibility and every missing scope are independently proven.
`v0.302.1 implementation stop reached. Run pentest for this exact commit.`

### v0.302.2 — Google Workspace Identity And Admin Profile

Status: planned

Goal: implement named Google Workspace identity, login, token and administration
evidence.

Deliverables:

- Admin, Login, Token, SAML and admitted directory activity profiles;
- customer/domain/user/application identity, rename/deletion and delegated admin;
- reporting latency, retention, paging, authorization and partial-data health;
- Workspace-to-cloud-project identity conflicts represented explicitly.

Verification:

- renamed/reused accounts, alias/domain changes, late activity, paging gaps and
  delegated-scope loss;
- cross-customer leakage, application/token confusion and malicious fields;
- live Workspace interoperability and identity pentest.

Exit criteria: Workspace identity evidence has stable customer scope and visible
API limits. `v0.302.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.302.3 — Named Identity Provider Integration Gate

Status: planned

Goal: prove Entra, Okta and Google Workspace identity semantics coexist without
unsafe automatic merging.

Deliverables:

- cross-provider alias/link conflict and manual resolution workflows;
- source-specific completeness, latency and permission health comparison;
- identity-risk/behavioral model inputs retaining source provenance;
- named support matrix and update/freshness ownership.

Verification:

- same email/different principal, tenant/customer migration, provider outage and
  conflicting lifecycle states;
- poisoned merge and cross-tenant identity-link attacks;
- multi-provider replay, behavior/risk and integration pentest.

Exit criteria: named identity providers add context without silently collapsing
principal identity. `v0.302.3 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.304.1 — Microsoft 365 Unified Audit Profile

Status: planned

Goal: implement named Microsoft 365 audit coverage across admitted collaboration
services.

Deliverables:

- Unified Audit profiles for Exchange, SharePoint, OneDrive, Teams and admitted
  administration activities;
- workload/tenant/user/object identity, record version, duplication and latency;
- subscription, retention, licensing, permission and throttling health;
- source-specific raw capsules and explicit unsupported workloads/operations.

Verification:

- delayed/duplicate records, workload outage, subscription stop, license/scope
  loss and schema-version drift;
- tenant/user/object reuse and malicious message/file metadata;
- live Microsoft 365 interoperability and connector pentest.

Exit criteria: every claimed Microsoft 365 workload has measured collection and
permission coverage. `v0.304.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.304.2 — Google Workspace Collaboration Audit Profile

Status: planned

Goal: implement named Gmail, Drive and collaboration administration evidence
separately from identity events.

Deliverables:

- admitted Gmail, Drive, Meet/Chat and administration activity profiles;
- customer/user/object/message/file identity, visibility and shared-drive scope;
- report latency, paging, retention, authorization and application-access health;
- policy-safe metadata mapping with content collection disabled by default.

Verification:

- shared object moves, deleted/recreated files, delayed reports, paging gaps and
  permission changes;
- content/metadata leakage, cross-customer IDs and malicious filenames/URLs;
- live Workspace interoperability and privacy pentest.

Exit criteria: collaboration activity is attributable without silently ingesting
content or claiming unavailable events. `v0.304.2 implementation stop reached.
Run pentest for this exact commit.`

### v0.304.3 — Slack Enterprise Audit Profile

Status: planned

Goal: implement a bounded named messaging/administration audit profile.

Deliverables:

- admitted Slack Enterprise audit actions, actor/entity/context and organization/
  workspace identity;
- cursor, retention, plan/permission, rate and delayed-availability health;
- content minimization, link/file metadata redaction and legal-hold interaction;
- exact supported action/version matrix.

Verification:

- organization/workspace changes, actor deletion, cursor replay, rate limit and
  permission loss;
- malicious text/URL metadata, content leakage and cross-workspace confusion;
- live Slack interoperability and connector pentest.

Exit criteria: named messaging audit support remains metadata-minimized and
scope-exact. `v0.304.3 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.305.2 — ServiceNow Transport And Schema Profile

Status: planned

Goal: implement a named ServiceNow boundary before any incident action or
synchronization path claims support.

Deliverables:

- pinned ServiceNow API, authentication, instance, table/schema and attachment
  profiles with capability discovery and explicit unsupported behavior;
- polling cursor and authenticated webhook ingestion, stable remote identity,
  pagination, rate-limit, retry-after and schema-version semantics;
- connector-vault credentials, least-privilege scopes, egress allowlist,
  residency/redaction preview and dry-run capability;
- live interoperability fixture and support matrix; this milestone transports
  records only and does not yet activate write actions or bidirectional sync.

Verification:

- wrong instance/table/schema, renamed/deleted fields, paging loops, throttling,
  outage, stale credentials and permission drift;
- webhook spoof/replay, remote-ID reuse, oversized attachment metadata, tenant/
  instance confusion and redaction-preview bypass;
- representative live ServiceNow interoperability and connector-host pentest.

Exit criteria: ServiceNow transport and schema limits are independently proven;
write activation waits for `v0.453.3` and reconciliation for `v0.453.4`.
`v0.305.2 implementation stop reached. Run pentest for this exact commit.`

### v0.305.3 — GitHub Organization And Audit Profile

Status: planned

Goal: implement named GitHub organization, repository, identity and workflow
security evidence.

Deliverables:

- organization/enterprise audit, repository, branch/ruleset, deployment,
  workflow and token/application profiles;
- stable enterprise/org/repository/actor/application identity and rename/delete;
- cursor/webhook, permission, retention, rate and schema health;
- exact supported GitHub API/event matrix and raw source capsules.

Verification:

- organization/repository transfer, actor deletion, webhook replay, cursor gap,
  rate limit and permission drift;
- fork/repository ID confusion, malicious workflow metadata and app spoofing;
- live GitHub interoperability and connector pentest.

Exit criteria: GitHub support has explicit enterprise/org/repository coverage and
cannot infer visibility from webhook success. `v0.305.3 implementation stop
reached. Run pentest for this exact commit.`

### v0.305.4 — GitLab Group Project And Audit Profile

Status: planned

Goal: implement named GitLab group/project, identity and pipeline security
evidence.

Deliverables:

- audit, group/project, protected branch, pipeline/job, runner, token and
  application profiles for admitted editions/deployment modes;
- instance/namespace/project/user identity, moves/renames/deletion and version;
- paging/webhook, permissions, rate, retention and self-managed-version health;
- explicit unsupported feature/edition matrix.

Verification:

- namespace/project move, ID reuse, self-managed upgrade, webhook replay, paging
  and permission loss;
- runner/token confusion and malicious pipeline metadata;
- live supported GitLab interoperability and connector pentest.

Exit criteria: GitLab claims name exact deployment/version and visible scopes.
`v0.305.4 implementation stop reached. Run pentest for this exact commit.`

### v0.305.5 — Named Source-Control Integration Gate

Status: planned

Goal: close GitHub/GitLab source-control coverage and common detection mappings.

Deliverables:

- common repository/identity/workflow facts with provider-specific provenance;
- provider capability/coverage comparison and fail-closed unsupported behavior;
- signed detections for token abuse, protection change, suspicious workflow and
  runner/deployment activity;
- update/freshness and live interoperability ownership.

Verification:

- cross-provider ID/name collision, migration, duplicate signals and outage;
- common mapping semantic loss and detection equivalence;
- integrated source-control attack exercises and pentest.

Exit criteria: named source-control support is useful and provider distinctions
remain visible. `v0.305.5 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.312.1 — Palo Alto PAN-OS Security Profile

Status: planned

Goal: implement named PAN-OS traffic, threat, URL, system and configuration
evidence.

Deliverables:

- exact admitted PAN-OS/syslog/API versions and log-type mappings;
- device/virtual-system/interface/rule/session/NAT identity and sequence health;
- configuration/policy version, HA member and collector transport provenance;
- truncation/rate/loss/schema and unsupported-feature matrix.

Verification:

- HA failover, rule rename/reorder, NAT ambiguity, log loss, version upgrade and
  malformed extensions;
- device/tenant confusion and external verdict provenance;
- live PAN-OS interoperability and provider pentest.

Exit criteria: PAN-OS evidence retains exact device, policy and session context.
`v0.312.1 implementation stop reached. Run pentest for this exact commit.`

### v0.312.2 — Fortinet FortiGate Security Profile

Status: planned

Goal: implement named FortiGate traffic, UTM, VPN, system and configuration
evidence.

Deliverables:

- exact admitted FortiOS/syslog/API versions and event families;
- device/VDOM/interface/policy/session/NAT/VPN identity;
- HA, configuration version, sequence/loss and source-health evidence;
- field/version drift and unsupported-feature matrix.

Verification:

- VDOM/HA changes, policy reuse, session collision, upgrade, loss and malformed
  key/value payloads;
- cross-tenant/device confusion and vendor-verdict trust boundaries;
- live FortiGate interoperability and provider pentest.

Exit criteria: FortiGate support is versioned, VDOM-aware and source-attributable.
`v0.312.2 implementation stop reached. Run pentest for this exact commit.`

### v0.312.3 — Zscaler Cloud Security Profile

Status: planned

Goal: implement named Zscaler web/private-access security evidence with cloud-
service delivery limitations explicit.

Deliverables:

- admitted ZIA/ZPA audit, web, tunnel, policy and session profiles;
- tenant/user/device/application/location identity and policy version;
- streaming/polling cursor, delay, rate, permission and service-health evidence;
- URL/content minimization, residency and unsupported-surface matrix.

Verification:

- delayed/duplicate streams, tenant/location move, policy change, outage and
  permission loss;
- URL leakage, user/device ambiguity and malicious remote metadata;
- live supported Zscaler interoperability and provider pentest.

Exit criteria: Zscaler collection has explicit cloud-delivery and identity
coverage. `v0.312.3 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.313.1 — Microsoft Defender For Office 365 Profile

Status: planned

Goal: implement named Microsoft email-security alerts, investigations and
message-event evidence.

Deliverables:

- admitted alert, campaign, investigation, quarantine and message trace profiles;
- tenant/message/network-message/recipient/attachment/URL identity and updates;
- API/license/retention/latency/permission health and raw provenance;
- strict separation from Defender XDR incident authority.

Verification:

- alert/campaign update, message-ID collision, delayed trace, license/scope loss
  and malicious message metadata;
- content/redaction leakage and tenant confusion;
- live Defender for Office 365 interoperability and privacy pentest.

Exit criteria: email-security evidence is message-attributable and does not
silently become an internal incident. `v0.313.1 implementation stop reached. Run
pentest for this exact commit.`

### v0.313.2 — Proofpoint Email Security Profile

Status: planned

Goal: implement a second independent named email-security profile to prove the
provider contract is not vendor-shaped.

Deliverables:

- admitted message, threat, quarantine, URL/attachment and administration APIs;
- organization/message/recipient/campaign identity and update semantics;
- cursor/rate/retention/permission/schema health and source-native capsules;
- exact product/service/version and unsupported-feature matrix.

Verification:

- duplicate/update/retract, cursor gap, rate/outage, message-ID reuse and schema
  drift;
- malicious content metadata, redaction and cross-customer isolation;
- live supported Proofpoint interoperability and connector pentest.

Exit criteria: Proofpoint support independently satisfies the email-security
contract. `v0.313.2 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.314.1 — Microsoft Defender For Endpoint Profile

Status: planned

Goal: implement named endpoint alerts, incidents, device inventory and admitted
advanced event evidence.

Deliverables:

- alert, evidence, device, vulnerability and admitted advanced-hunting profiles;
- tenant/device/agent/user/process/file/network identity and update lineage;
- retention, latency, API/license/permission and sensor-health evidence;
- vendor finding/incident state kept separate from Vakaheim authority.

Verification:

- device reimage/reuse, alert update, incident merge, sensor outage, license loss
  and delayed evidence;
- external-state overwrite attempts and cross-tenant device linkage;
- live Defender for Endpoint interoperability and profile pentest.

Exit criteria: Defender endpoint evidence is source-backed and internal workflow
remains authoritative. `v0.314.1 implementation stop reached. Run pentest for
this exact commit.`

### v0.314.2 — CrowdStrike Falcon Profile

Status: planned

Goal: implement a second named EDR profile with detection, incident and host
visibility limits explicit.

Deliverables:

- admitted detection, incident, host, identity and event-stream profiles;
- customer/host/agent/process/file/network identity, update and containment state;
- cursor/rate/retention/permission/sensor-health and API-version evidence;
- exact supported Falcon service/API matrix and raw source capsules.

Verification:

- host reinstall/reuse, detection update, stream gap, sensor impairment, rate
  limit and permission loss;
- vendor containment/status attempting internal mutation and tenant confusion;
- live supported Falcon interoperability and connector pentest.

Exit criteria: Falcon support independently preserves vendor provenance and
Vakaheim authority. `v0.314.2 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.318.0 — OT ICS Asset Zone And Safety Model

Status: conditional on admission at `v0.100.2`

Goal: model operational-technology identity and safety boundaries before any
protocol parsing or response claim.

Deliverables:

- site/zone/conduit/controller/device/module/engineering-station identities;
- safety criticality, process role, owner, maintenance state and uncertainty;
- passive-observation authority, tap/interface provenance and no-active-scan
  default;
- binding prohibition on automatic OT response for 1.0 unless a later explicit
  safety-reviewed milestone is inserted.

Verification:

- shared/reused addresses, redundant controllers, failover, stale inventory and
  safety-zone conflict;
- unauthorized active probe/action and cross-site identity merge;
- OT safety/domain review and model pentest.

Exit criteria: OT evidence cannot create unsafe collection or response behavior.
`v0.318.0 implementation stop reached. Run pentest for this exact commit.`

### v0.318.1 — Passive Industrial Protocol Framing Foundation

Status: conditional on admission at `v0.100.2`

Goal: provide bounded passive flow/session/transaction parsing shared by admitted
industrial protocols.

Deliverables:

- capture/flow direction, endpoint/role, transaction and retransmission identity;
- checked length/function/object framing with fragmentation and timeout bounds;
- no packet generation, connection establishment or device interaction;
- raw packet references, parser outcomes and protocol impairment health.

Verification:

- truncation, overlap, retransmit, malformed length/function, evasion and state
  exhaustion;
- role/address ambiguity and tap loss;
- differential fixtures, fuzzing and passive-parser pentest.

Exit criteria: hostile industrial traffic remains bounded and collection stays
strictly passive. `v0.318.1 implementation stop reached. Run pentest for this
exact commit.`

### v0.318.2 — Modbus TCP Evidence Profile

Status: conditional on admission at `v0.100.2`

Goal: decode admitted Modbus/TCP activity into attributable OT facts.

Deliverables:

- MBAP, unit/function, address/range, read/write/exception and role semantics;
- broadcast/gateway, transaction pairing and register meaning left source-
  specific unless configured;
- write/configuration/safety-sensitive activity facts and coverage limits;
- conformance corpus without active device testing outside an authorized lab.

Verification:

- malformed lengths/functions, transaction reuse, gateway/unit ambiguity, scan
  storms and parser evasions;
- authorized lab captures and hostile fixture fuzzing;
- safety and protocol pentest.

Exit criteria: every Modbus fact retains packet, endpoint, unit and uncertainty
lineage. `v0.318.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.318.3 — DNP3 Evidence Profile

Status: conditional on admission at `v0.100.2`

Goal: decode admitted DNP3 link/transport/application evidence safely.

Deliverables:

- address, control, sequence, fragmentation, function/object and indication facts;
- master/outstation role, unsolicited response and command/operate lineage;
- time-quality and protocol-error semantics;
- exact admitted serial-over-IP/profile limits.

Verification:

- CRC/fragment/sequence errors, object explosion, address reuse, unsolicited
  storms and role inversion;
- official/lab fixtures, fuzzing and allocation failure;
- safety and parser pentest.

Exit criteria: DNP3 state and command observations are bounded and source-
attributable. `v0.318.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.318.4 — OPC UA Evidence Profile

Status: conditional on admission at `v0.100.2`

Goal: observe admitted OPC UA security/session/service activity without becoming
an OPC UA client or trust authority.

Deliverables:

- endpoint, application, certificate, secure-channel, session and service facts;
- security mode/policy, identity-token type and certificate validation evidence;
- bounded binary framing/message/chunk handling for admitted services;
- encrypted-uninspectable and unsupported-service outcomes.

Verification:

- chunk/message bombs, certificate/application spoof, session reuse, downgrade
  and encrypted visibility gaps;
- lab/official fixtures, fuzzing and crypto-boundary review;
- protocol and privacy pentest.

Exit criteria: OPC UA observations state exact security and visibility limits.
`v0.318.4 implementation stop reached. Run pentest for this exact commit.`

### v0.318.5 — OT Behavioral Detection And ATT&CK ICS Content

Status: conditional on admission at `v0.100.2`

Goal: add first-party passive OT detections mapped to current ATT&CK ICS
strategies/analytics.

Deliverables:

- role/function baseline, new device/path, engineering change, write/command,
  unsafe mode and protocol-impairment detections;
- ATT&CK ICS strategy/analytic/Data Component and required-telemetry mappings;
- safety-aware severity, maintenance-window and expected-operation overlays;
- lab replay, tuning guidance and incident runbooks.

Verification:

- maintenance/failover false positives, incomplete tap visibility, address reuse,
  malicious commands and baseline poisoning;
- representative lab attack/normal corpora and deterministic replay;
- independent OT detection review and pentest.

Exit criteria: OT detections are passive, explainable and tested against normal
operations. `v0.318.5 implementation stop reached. Run pentest for this exact
commit.`

### v0.318.6 — OT ICS Scope Closure

Status: conditional on `v0.100.2`

Goal: close 1.0 OT/ICS support and safety claims.

Deliverables:

- admitted integration of `v0.318.0`–`v0.318.5`, or enforced disabled parser/
  API/UI paths when rejected;
- exact protocol/platform/domain support matrix and passive-only limitation;
- operations, performance, privacy, safety and incident-response documentation.

Verification:

- lab end-to-end normal/attack/impairment campaign for admitted scope;
- rejection/no-active-scan/no-automatic-response proofs;
- independent OT safety/security assessment and exact-commit pentest.

Exit criteria: OT/ICS is either safely bounded and evidenced or an explicit 1.0
non-goal. `v0.318.6 implementation stop reached. Run pentest for this exact
commit.`

### v0.329.0 — Source Onboarding Workspace Model

Status: planned

Goal: make source onboarding a governed lifecycle rather than scattered parser,
mapping and connector configuration.

Deliverables:

- draft, sampled, mapped, validated, canary, active, impaired, rolled-back and
  retired source states;
- source owner, purpose, tenant, credential, schema/mapping, capacity, retention
  and approval bindings;
- optimistic version, idempotency and immutable change/audit journal;
- server-owned transition/authorization contract for later API/UI.

Verification:

- stale/concurrent activation, source-ID reuse, credential/purpose change and
  rollback/retirement races;
- cross-tenant sample/mapping access and audit omission;
- exhaustive onboarding state-machine tests and pentest.

Exit criteria: no source becomes active outside one attributable reviewed
onboarding lifecycle. `v0.329.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.329.1 — Safe Sample Capture And Replay

Status: planned

Goal: inspect representative source data without bypassing quarantine, privacy
or bounded parsing.

Deliverables:

- bounded encrypted sample capture with source capsule, consent/purpose,
  retention and deletion;
- sensitive-field discovery/redaction preview and raw-access approval;
- deterministic sample replay across candidate parser/mapping versions;
- malformed/outlier sampling and coverage caveats.

Verification:

- secret/PII leakage, oversized/malicious samples, biased sampling, retention
  expiry and unauthorized export;
- old/new parser replay and quarantine conservation;
- privacy, parser-isolation and sample-workflow pentest.

Exit criteria: onboarding samples remain protected evidence and reproducible test
inputs. `v0.329.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.329.2 — Parser Mapping Preview And Field Lineage

Status: planned

Goal: preview normalization outcomes and losses before activation.

Deliverables:

- source/raw-to-parser-to-schema-to-fact field lineage and transformation view;
- parsed, normalized, conflict, unknown, dropped, redacted and quarantined
  outcomes with reasons;
- candidate mapping edit/compile/test workflow and immutable package identity;
- representative/outlier coverage and required-field validation.

Verification:

- silent drop/coercion, duplicate fields, timezone/unit/encoding loss, mapping
  conflict and malicious values;
- field-policy/redaction change and cross-tenant preview;
- golden sample comparison, fuzz and mapping pentest.

Exit criteria: operators can see every field transformation and loss before a
mapping activates. `v0.329.2 implementation stop reached. Run pentest for this
exact commit.`

### v0.329.3 — Schema Drift Diff And Historical Shadow Replay

Status: planned

Goal: evaluate source/schema changes against historical samples and data before
production activation.

Deliverables:

- current/candidate schema/parser/mapping structural and semantic diff;
- bounded historical shadow replay with fact/field/quarantine/loss differences;
- downstream rule/coverage/dashboard impact inventory;
- migration, new-source-only or rollback decision with approval evidence.

Verification:

- field rename/type/enum/unit change, partial replay, stale sample and downstream
  dependency omission;
- candidate package substitution and unauthorized bulk replay;
- deterministic before/after corpus and migration pentest.

Exit criteria: schema drift is an explicit reviewed change, never silent
normalization drift. `v0.329.3 implementation stop reached. Run pentest for this
exact commit.`

### v0.329.4 — Volume Cardinality Cost And Capacity Preview

Status: planned

Goal: estimate source resource impact before it can overload ingestion, storage,
query or detection.

Deliverables:

- event/byte rate, burst, field/cardinality, raw/index/retention and detection-
  state projections with uncertainty;
- tenant/source quotas, sampling/summarization proposal and data-loss disclosure;
- hardware/topology capacity comparison and cost/showback estimate;
- worst-case rather than expected-only admission bound.

Verification:

- biased samples, rare cardinality explosion, burst/seasonality, compression
  error and underestimated state growth;
- quota bypass and cost-estimate manipulation;
- replayed actual-versus-estimate and overload pentest.

Exit criteria: no source activates without explicit worst-case capacity and loss
understanding. `v0.329.4 implementation stop reached. Run pentest for this exact
commit.`

### v0.329.5 — Permission Completeness And Canary Activation

Status: planned

Goal: prove collection visibility and safe production behavior before full
activation.

Deliverables:

- least-privilege permission/capability discovery and expected-scope inventory;
- cursor/sequence/time/schema/source-health baseline and completeness test;
- bounded canary cohort, success/rollback thresholds and automatic expiry;
- activation evidence linking packages, credentials, capacity and approvals.

Verification:

- partial permissions, deleted scope, cursor reset, delayed data, canary false
  health and rollback failure;
- unauthorized expansion, stale approval and credential substitution;
- representative live canary and onboarding pentest.

Exit criteria: active sources have proven permissions, coverage, capacity and a
tested rollback. `v0.329.5 implementation stop reached. Run pentest for this
exact commit.`

### v0.329.6 — Source Onboarding API And Conformance Gate

Status: planned

Goal: expose the complete onboarding workflow safely and prove every named
provider uses it.

Deliverables:

- versioned sample/preview/diff/capacity/permission/canary/activate APIs;
- server-generated forms, authorization, pagination/watch and audit;
- common conformance suite for native files, agents, OTLP and named connectors;
- provider-specific extensions without bypassing common gates.

Verification:

- stale/duplicate requests, cross-tenant samples, forged health/capacity and API
  downgrade;
- every named provider and offline/air-gap onboarding path;
- independent API/workflow and exact-commit pentest.

Exit criteria: every source family reaches activation through the same governed
contract. `v0.329.6 implementation stop reached. Run pentest for this exact
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

### v0.336.0 — First-Party Security Content Constitution

Status: planned

Goal: make Vakaheim ship as a useful SIEM rather than only a detection engine.

Deliverables:

- first-party content catalog covering rule, behavioral analytic, hunt, dashboard,
  runbook and response-playbook package kinds;
- stable IDs, owner, severity/confidence, required telemetry, ATT&CK strategy/
  analytic, tests, tuning and support metadata;
- supported/default/optional/experimental/deprecated/quarantined lifecycle;
- minimum platform/domain coverage policy and no unsupported-coverage claim.

Verification:

- orphan content, missing owner/tests/telemetry/runbook, duplicate IDs and unsafe
  severity/response coupling;
- catalog version/compatibility and no-content fallback;
- independent content architecture and security review.

Exit criteria: every first-party item has one governed identity, purpose and
quality contract. `v0.336.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.336.1 — Signed Content Distribution Update And Revocation

Status: planned

Goal: deliver first-party content safely in connected and air-gapped deployments.

Deliverables:

- signed immutable release bundles, manifest/digest/dependency/engine profiles;
- online staged channel plus offline transfer bundle, transparency history and
  rollback/revocation/compromise procedure;
- tenant pinning, shadow/canary activation and previous-version retention;
- freshness monitor and emergency security-content release process.

Verification:

- tamper, rollback, freeze, equivocation, signer compromise, partial bundle and
  expired/revoked content;
- disconnected update/recovery and mixed engine/content versions;
- supply-chain, signing and update-channel pentest.

Exit criteria: content updates are attributable, reversible and safe offline.
`v0.336.1 implementation stop reached. Run pentest for this exact commit.`

### v0.336.2 — Windows First-Party Detection Pack

Status: planned

Goal: ship tested Windows endpoint and identity detections over admitted native
and forwarded telemetry.

Deliverables:

- process/script/service/task/registry/logon/credential/persistence/defense-
  impairment and lateral-movement rule/analytic set;
- current ATT&CK Detection Strategy/Analytic mappings and telemetry prerequisites;
- Sysmon/ETW/Event Log/WEF variant mappings where admitted;
- normal/attack fixtures, tuning overlays and investigation runbooks.

Verification:

- representative benign administration and attack chains, missing telemetry,
  version/policy variants and adversarial evasion;
- replay, performance, false-positive/negative and content-signing tests;
- independent Windows detection review and pentest.

Exit criteria: supported Windows telemetry has a useful tested default detection
baseline. `v0.336.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.336.3 — Linux First-Party Detection Pack

Status: planned

Goal: ship tested Linux host, authentication and container-adjacent detections.

Deliverables:

- process/shell/auth/sudo/service/package/file/kernel/audit/eBPF/defense-
  impairment and persistence content;
- distro/init/audit configuration variants and required-telemetry mappings;
- current ATT&CK strategy/analytic coverage, tuning and runbooks;
- normal/attack fixtures including living-off-the-land behavior.

Verification:

- distro/kernel/config variation, missing audit/eBPF, benign automation, evasion
  and overload;
- deterministic replay, FP/FN and resource tests;
- independent Linux content review and pentest.

Exit criteria: supported Linux profiles have useful explainable default
detections. `v0.336.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.336.4 — macOS BSD And Mobile First-Party Detection Pack

Status: planned

Goal: cover supported non-Windows/Linux native platforms without implying sensor
capabilities they cannot provide.

Deliverables:

- macOS process/auth/persistence/TCC/launch/file/network content;
- FreeBSD/OpenBSD auth/process/service/package/pf/audit content;
- Android/iOS security/audit/permission/lifecycle content within platform limits;
- platform-specific ATT&CK Enterprise/Mobile mappings, fixtures and runbooks.

Verification:

- OS/version/permission differences, mobile background gaps, BSD audit variants,
  benign administration and evasion;
- missing-sensor honest coverage and cross-platform content confusion;
- independent platform content review and pentest.

Exit criteria: every supported native platform ships bounded content matching its
actual visibility. `v0.336.4 implementation stop reached. Run pentest for this
exact commit.`

### v0.336.5 — Identity And SaaS First-Party Detection Pack

Status: planned

Goal: ship provider-aware identity, token, application and SaaS abuse detections.

Deliverables:

- password spray, impossible/anomalous access, MFA/policy impairment, privilege/
  group changes, token/app abuse and suspicious administration content;
- Entra/Okta/Google Workspace/Microsoft 365/Slack source variants;
- peer/baseline/risk integration with explicit cold-start and source gaps;
- ATT&CK strategy/analytic mappings, fixtures, tuning and runbooks.

Verification:

- travel/VPN/proxy, service accounts, automation, tenant migration, provider
  outage and poisoned identity merges;
- provider semantic equivalence and source-specific limitations;
- identity attack tabletop and content pentest.

Exit criteria: supported identity/SaaS sources produce useful default detections
without unsafe provider conflation. `v0.336.5 implementation stop reached. Run
pentest for this exact commit.`

### v0.336.6 — AWS First-Party Detection Pack

Status: planned

Goal: detect AWS control, identity, data and network abuse across admitted
profiles.

Deliverables:

- root/IAM/role/key, trail/log impairment, policy/security-group, data access,
  persistence, discovery and exfiltration content;
- GuardDuty/Security Hub correlation without verdict trust;
- account/organization/region coverage and ATT&CK cloud analytics;
- fixtures, tuning, investigation and containment runbooks.

Verification:

- normal automation, organization changes, partial regions/permissions, delayed
  data and attacker log impairment;
- multi-account attack chains, replay and FP/FN evaluation;
- AWS content review and pentest.

Exit criteria: admitted AWS telemetry has tested multi-account security content.
`v0.336.6 implementation stop reached. Run pentest for this exact commit.`

### v0.336.7 — Azure Microsoft 365 And GCP First-Party Detection Pack

Status: planned

Goal: ship cloud/control/collaboration detections for the remaining named
hyperscaler ecosystems.

Deliverables:

- Azure/Entra/Microsoft 365 identity, control, resource, log-impairment and data-
  access content;
- GCP IAM/control/project/log-router/network/SCC and Workspace attack content;
- tenant/subscription/project/organization coverage and current ATT&CK analytics;
- provider-specific fixtures, tuning and runbooks.

Verification:

- normal automation, hierarchy moves, partial scopes, delayed APIs, provider
  findings and log exclusions;
- cross-cloud identity/resource confusion and multi-stage attacks;
- independent Azure/GCP content review and pentest.

Exit criteria: all named cloud ecosystems have tested source-aware default
detections. `v0.336.7 implementation stop reached. Run pentest for this exact
commit.`

### v0.336.8 — Kubernetes And Container First-Party Detection Pack

Status: planned

Goal: detect control-plane, workload, identity and container abuse with cluster
and namespace visibility explicit.

Deliverables:

- RBAC/admission/exec/secret/service-account/image/workload/network and audit-
  impairment content;
- host/container/cloud identity joins and cluster/namespace source prerequisites;
- current ATT&CK container/cloud analytics, fixtures and tuning;
- investigation and safe containment runbooks.

Verification:

- controller automation, workload churn, missing audit, identity reuse, noisy
  namespaces and malicious admission changes;
- multi-cluster attacks, replay and load/FP/FN evaluation;
- Kubernetes content review and pentest.

Exit criteria: Kubernetes content remains cluster/namespace attributable and
coverage honest. `v0.336.8 implementation stop reached. Run pentest for this
exact commit.`

### v0.336.9 — Network Email And External Security Product Detection Pack

Status: planned

Goal: turn admitted network, DNS, VPN, firewall, proxy, email and EDR evidence
into first-party multi-vendor detections.

Deliverables:

- beaconing, exfiltration, scanning, tunneling, suspicious DNS, VPN/session,
  policy impairment, phishing and malicious-message content;
- PAN-OS/FortiGate/Zscaler/email/EDR source variants preserving vendor provenance;
- current ATT&CK strategy/analytic requirements, fixtures, tuning and runbooks;
- external vendor alerts treated as inputs, not truth.

Verification:

- NAT/proxy/VPN ambiguity, sampling, vendor outage/verdict drift, benign scanners
  and bulk mail;
- multi-source chain replay, FP/FN/load and evasion tests;
- network/email/EDR content review and pentest.

Exit criteria: admitted external products contribute to tested Vakaheim-native
detections. `v0.336.9 implementation stop reached. Run pentest for this exact
commit.`

### v0.336.10 — Cross-Domain Living-Off-The-Land Detection Pack

Status: planned

Goal: detect multi-stage behavior chains that isolated source rules miss.

Deliverables:

- identity-to-endpoint-to-cloud-to-network sequence and graph analytics;
- signed-binary/interpreter/admin-tool abuse and defense-impairment strategies;
- exact entity-resolution, timing, source-completeness and state budgets;
- campaign fixtures, explanations, tuning and hunt/runbook links.

Verification:

- benign administration/deployment, incomplete sources, late/reordered events,
  poisoned entities and state exhaustion;
- current CISA living-off-the-land scenarios and ATT&CK analytics;
- multi-domain detection and adversarial-evasion pentest.

Exit criteria: cross-domain detections are evidence-backed, bounded and useful
under partial visibility. `v0.336.10 implementation stop reached. Run pentest for
this exact commit.`

### v0.336.11 — First-Party Investigation Dashboard And Runbook Packs

Status: planned

Goal: pair detections with usable investigation context rather than leaving
analysts with isolated alerts.

Deliverables:

- per-domain saved searches, timelines, entity pivots and coverage dashboards;
- alert-specific triage questions, expected evidence, false-positive guidance,
  escalation and containment runbooks;
- exact rule/source/schema/query/package version bindings;
- accessibility, localization and disconnected operation.

Verification:

- stale queries/schema, missing source, misleading complete dashboard, unsafe
  runbook instruction and authorization changes;
- full analyst exercises for representative content families;
- usability, policy and content pentest.

Exit criteria: every high-severity first-party alert has tested investigation
and coverage guidance. `v0.336.11 implementation stop reached. Run pentest for
this exact commit.`

### v0.336.12 — First-Party Safe Response Playbook Packs

Status: planned

Goal: provide reviewed default playbooks without bypassing later action authority
or enabling premature automation.

Deliverables:

- proposal-only investigation/containment playbooks bound to content families;
- required approvals, preconditions, targets, evidence, verification,
  compensation and kill-switch metadata;
- unavailable placeholders until each action implementation passes Phase J;
- no automatic execution from a finding/alert by default.

Verification:

- stale target/content, missing action, approval bypass, irreversible step,
  simulation divergence and kill-switch behavior;
- safe disabled behavior before action activation;
- response-domain review and playbook pentest.

Exit criteria: first-party playbooks improve readiness without granting action
authority early. `v0.336.12 implementation stop reached. Run pentest for this
exact commit.`

### v0.336.13 — First-Party Content Minimum-Coverage Gate

Status: planned

Goal: prove the default installation contains useful maintained content across
every claimed source and platform.

Deliverables:

- signed minimum catalog/ATT&CK strategy/analytic/source coverage matrix;
- required telemetry, rule, dashboard, runbook and safe-playbook linkage audit;
- default/optional content installation and upgrade/rollback evidence;
- unsupported-source/domain and residual coverage-gap documentation.

Verification:

- fresh install, disconnected install, update, rollback, revoked bundle and
  partial source configurations;
- no-content/orphan/missing-runbook/false-coverage scans;
- independent detection-content assessment and exact-commit pentest.

Exit criteria: Vakaheim ships with a defensible useful content baseline, not only
an engine. `v0.336.13 implementation stop reached. Run pentest for this exact
commit.`

### v0.337.0 — Detection Effectiveness Evidence Model

Status: planned

Goal: measure detection quality without presenting uncertain labels as ground
truth.

Deliverables:

- test/scenario/population/outcome/label provenance and confidence model;
- detected/missed/noisy/indeterminate/unobservable outcomes and coverage context;
- exact rule/content/source/schema/cohort/time identity;
- privacy-preserving production and controlled-test evidence separation.

Verification:

- label leakage, biased population, duplicate outcomes, missing telemetry and
  changed rule/source identity;
- false precision/recall claims from unknown ground truth;
- statistical semantics and privacy review.

Exit criteria: every effectiveness number exposes population, labels, coverage
and uncertainty. `v0.337.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.337.1 — Alert Disposition And Production Feedback Loop

Status: planned

Goal: connect analyst outcomes to content improvement without allowing mutable
feedback to rewrite historical findings.

Deliverables:

- structured disposition/tuning/corrective-action aggregation by exact rule;
- delayed/reopened/duplicate/incident-confirmed outcome handling;
- minimum sample/confidence and anti-gaming/poisoning controls;
- signed proposed tuning/test changes through ordinary review and rollout.

Verification:

- malicious/mistaken disposition, analyst bias, reopen, duplicate alerts and
  changed rule versions;
- feedback poisoning and unauthorized automatic suppression;
- end-to-end disposition-to-reviewed-content test.

Exit criteria: feedback creates attributable proposals, never silent rule
mutation. `v0.337.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.337.2 — Controlled Precision Recall And Miss Evaluation

Status: planned

Goal: quantify first-party detection behavior on controlled labeled corpora.

Deliverables:

- per-scenario true/false positive/negative and indeterminate accounting;
- precision/recall/rate metrics only where population/labels justify them;
- severity, latency, evidence quality and resource regression thresholds;
- platform/source/content-version comparison reports.

Verification:

- imbalanced/duplicate/leaked datasets, ambiguous labels, missing source and
  threshold manipulation;
- reproducible holdout and adversarial variants;
- independent methodology and metric review.

Exit criteria: detection-quality claims are reproducible and cannot hide
unobservable cases. `v0.337.2 implementation stop reached. Run pentest for this
exact commit.`

### v0.337.3 — Adversary Emulation And Purple-Team Validation

Status: planned

Goal: validate telemetry, detections and workflows against controlled end-to-end
attacker behavior.

Deliverables:

- signed safe emulation scenario format with prerequisites and cleanup;
- current ATT&CK strategy/analytic chains across endpoint, identity, cloud,
  network, SaaS and admitted OT labs;
- observe-only, simulation and authorized lab execution modes;
- result chain from source health through finding, alert and runbook.

Verification:

- unsafe target/scope, incomplete cleanup, scenario drift, telemetry impairment
  and false success;
- expected miss/partial/complete outcomes and kill controls;
- independent purple-team and safety assessment.

Exit criteria: claimed critical detection paths have controlled end-to-end proof.
`v0.337.3 implementation stop reached. Run pentest for this exact commit.`

### v0.337.4 — Detection Ownership Review And Tuning Debt

Status: planned

Goal: prevent stale, noisy or broadly suppressed content from remaining silently
active.

Deliverables:

- owner/reviewer, review interval, telemetry dependency and support state;
- suppression/tuning/exception debt with approver, expiry and affected coverage;
- noise, miss, impairment and stale-dependency thresholds;
- quarantine, rollback and emergency-disable workflow preserving coverage gaps.

Verification:

- expired owner/review/suppression, broad filter, stale source, noisy rule and
  emergency disable;
- debt hiding through package/version changes;
- lifecycle state-machine and governance pentest.

Exit criteria: every active rule is owned, current and free of invisible tuning
debt. `v0.337.4 implementation stop reached. Run pentest for this exact commit.`

### v0.337.5 — Continuous Detection Validation Scheduler

Status: planned

Goal: rerun bounded content tests when rules, mappings, sources or ATT&CK content
change.

Deliverables:

- dependency-triggered unit/simulation/shadow/emulation test selection;
- durable checkpoints, coalescing, cancellation, resource admission and results;
- regression quarantine and rollout blocking thresholds;
- offline deterministic execution plus separate live-provider validation.

Verification:

- missed dependency, test storm, stale result, cancellation, partial corpus and
  scheduler outage;
- malicious content attempting to skip tests;
- change-to-test completeness and recovery properties.

Exit criteria: material content/source changes cannot bypass relevant validation.
`v0.337.5 implementation stop reached. Run pentest for this exact commit.`

### v0.337.6 — Detection Effectiveness Integration Gate

Status: planned

Goal: close first-party content quality before alert notification and analyst
product phases depend on it.

Deliverables:

- per-content-family coverage/effectiveness/debt/readiness report;
- critical strategy/analytic controlled-validation evidence;
- accepted residual gaps, owners, compensating hunts and release notes;
- no unsupported numerical quality claims.

Verification:

- missing family/scenario/telemetry, stale metrics, unresolved high noise/miss and
  expired debt;
- independent content and purple-team review;
- exact-commit detection pentest.

Exit criteria: first-party content is measurable, maintained and honest about
remaining gaps. `v0.337.6 implementation stop reached. Run pentest for this exact
commit.`

### v0.342.0 — Generic Notification Substrate And Durable Outbox

Status: planned

Goal: provide generic outbound delivery without depending on mutable alert
state.

Deliverables:

- typed notification envelope, transactional outbox, delivery attempts and
  terminal outcome ledger;
- sandboxed email/webhook/messaging adapters with secret/egress capabilities;
- idempotency, rate/fairness, retry/dead-letter, redaction and audit policy;
- `v0.44.4` handoff plus `v0.44.9` spent-key retention, and registration of every
  delayed/unknown/dead-letter delivery in the `v0.44.10` epoch-advance barrier.

Verification:

- crash between enqueue/send/ack, duplicate, reorder, provider timeout and
  unknown outcome;
- candidate replay-fence advance while an older delivery/dead letter remains;
- webhook redirect/rebinding, secret leakage, cross-tenant and flood attacks;
- conservation and user-visible delivery-status tests.

Exit criteria: generic notification requests and outcomes are durable and
auditable, with no alert-transaction claim. `v0.342.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.343.0 — Security Data Export Authority And Envelope

Status: planned; disabled by default

Goal: provide optional portable event/finding/alert egress without weakening
internal operation, evidence custody or air-gap defaults.

Deliverables:

- typed export envelope for source/raw references, normalized facts, findings,
  alerts and approved incident summaries with distinct authority;
- tenant/source/query/snapshot/schema/mapping/policy/purpose/residency bindings;
- redaction/minimization, recipient capability, payload digest and audit;
- global and per-tenant disable switch; no configured sink means no egress.

Verification:

- unauthorized class/field/tenant export, stale policy, schema confusion and
  source-versus-derived truth conflation;
- disable/air-gap proof and export audit conservation;
- privacy, custody and authority pentest.

Exit criteria: export is explicit opt-in and internal SIEM operation never
depends on it. `v0.343.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.343.1 — Durable Export Subscription Cursor And Outcome Ledger

Status: planned; disabled by default

Goal: make continuous exports restartable and loss/duplication outcomes visible.

Deliverables:

- immutable subscription definition, expected-set/snapshot and per-partition
  cursor/checkpoint;
- transactional outbox, idempotency/correlation, terminal receipt/rejection/
  `UnknownOutcome` and reconciliation;
- pause/resume/cancel/backfill with policy re-evaluation;
- rate/fairness/backpressure/dead-letter and impairment facts.

Verification:

- crash before/after select/enqueue/send/receipt/checkpoint, replay, reorder and
  sink outage;
- policy/schema change mid-range and cursor rollback;
- conservation/model tests and export-ledger pentest.

Exit criteria: every admitted export item reaches a durable explicit outcome.
`v0.343.1 implementation stop reached. Run pentest for this exact commit.`

### v0.343.2 — OCSF Security Data Export Profile

Status: planned; disabled by default

Goal: export admitted normalized security records through exact OCSF mappings.

Deliverables:

- `v0.18.1`–`v0.18.3` class/profile/version selection per subscription;
- batch/framing, mapping-loss and source-extension manifests;
- exact schema/content digest and producer identity;
- downgrade/unsupported consumer behavior.

Verification:

- lossy/unknown fields, class/profile mismatch, mixed versions, oversized batch
  and malicious recipient negotiation;
- round-trip where defined and declared-loss validation;
- representative consumer interoperability and export pentest.

Exit criteria: OCSF export is version-exact and never hides mapping loss.
`v0.343.2 implementation stop reached. Run pentest for this exact commit.`

### v0.343.3 — OTLP And Syslog Security Export Profiles

Status: planned; disabled by default

Goal: support common security-event sinks without inventing provider authority.

Deliverables:

- OTLP log/event export plus bounded RFC syslog and admitted CEF/LEEF output
  profiles;
- transport authentication, framing/batching, schema/mapping and retry semantics;
- recipient-specific redaction and unsupported-field/loss reports;
- no custom durability claim inserted into external protocols.

Verification:

- framing/escaping, partial success, reconnect, duplicate, downgrade, TLS and
  hostile sink behavior;
- field truncation/loss and cross-tenant destination confusion;
- representative receiver interoperability and transport pentest.

Exit criteria: common sinks receive bounded attributable data with honest
delivery and mapping outcomes. `v0.343.3 implementation stop reached. Run pentest
for this exact commit.`

### v0.343.4 — Object Archive And Message Stream Export

Status: planned; disabled by default

Goal: provide bulk and streaming portability for approved security data.

Deliverables:

- signed encrypted object/archive manifests with partitions, schema, record/
  byte counts, checksums and snapshot coverage;
- provider-neutral message-stream sink contract with partition/key/order/cursor
  semantics;
- credential/egress/residency/cost limits and immutable delivery journal;
- each named store/broker requires its own later provider admission.

Verification:

- partial object, overwrite, listing inconsistency, partition loss, stream
  rebalance, duplicate/reorder and unknown outcome;
- recipient key/policy change and cross-region/tenant leakage;
- offline archive verification and sink-contract pentest.

Exit criteria: bulk/stream export preserves exact scope, order limits and custody.
`v0.343.4 implementation stop reached. Run pentest for this exact commit.`

### v0.343.5 — Data Portability Migration And Re-Import Proof

Status: planned; disabled by default

Goal: prove customers can leave or migrate without treating exported derivatives
as original source truth.

Deliverables:

- full authorized export inventory for raw references, facts, findings, alerts,
  content/configuration and audit-safe metadata;
- manifest/verifier and controlled re-import preserving source/derived identity;
- omissions, inaccessible/held/deleted data and unsupported object disclosure;
- large-volume checkpoint/resume and migration runbook.

Verification:

- tamper/omit/reorder, interrupted resume, policy/hold conflict, wrong tenant and
  re-import duplication;
- source-versus-exported-copy truth and custody tests;
- clean-room migration exercise and portability pentest.

Exit criteria: approved data is portable with independently verifiable scope and
no provenance inflation. `v0.343.5 implementation stop reached. Run pentest for
this exact commit.`

### v0.343.6 — Security Data Export Integration Gate

Status: planned; disabled by default

Goal: close egress safety and interoperability before analyst workflows expose
export controls.

Deliverables:

- every export class/profile/subscription/disable/reconciliation matrix;
- air-gap/no-sink/internal-only proof and independent egress inventory;
- performance, capacity, privacy, residency and support evidence;
- named-sink claim register with generic contracts implying no provider.

Verification:

- malicious/unavailable sink, policy change, failover/restart and export storm;
- no-egress build/config and network-deny validation;
- independent export architecture and exact-commit pentest.

Exit criteria: optional export is useful and safe while a fully internal SIEM
remains complete. `v0.343.6 implementation stop reached. Run pentest for this
exact commit.`

### v0.344.1 — Alert Incident Case And Graph Semantic Boundaries

Status: planned

Goal: define the framework-neutral analyst entities before workflow or legal
packages can blur their authority.

Deliverables:

- immutable evidence and findings, mutable triage alerts, formally declared
  incidents, collaborative cases and explanatory `IncidentGraph` as distinct
  typed records with stable tenant-scoped IDs;
- explicit links: findings feed alerts, validated alerts promote to incidents,
  one incident owns one primary case by default, and graphs model correlation
  without becoming incident authority;
- optional compartmented subcase relationship contract that never creates a
  second primary incident or weakens the primary case/audit lineage;
- authority, optimistic-version, audit, timestamp, retention, compartment and
  immutable-reference boundaries for every entity.

Verification:

- type/ID confusion, cross-tenant linkage, mutable finding/evidence attempts and
  graph state incorrectly used as incident declaration;
- primary-case duplication, orphan/subcase reassignment, compartment change and
  retention/audit propagation;
- model fixtures for the complete evidence-to-finding-to-alert-to-incident-to-
  case relationship.

Exit criteria: every analyst entity has one non-overlapping purpose and
authority; correlation can never silently declare or close an incident.
`v0.344.1 implementation stop reached. Run pentest for this exact commit.`

### v0.344.2 — Signed Framework Package Manifest And Canonical Encoding

Status: planned

Goal: define immutable, verifiable framework packs without executable plugin
authority.

Deliverables:

- bounded canonical manifest/package encoding with stable framework/package IDs,
  kind, edition, semantic version, effective/expiry dates and engine version;
- operational-lifecycle, regulatory-obligation, classification/taxonomy,
  reporting and organization-overlay package kinds;
- jurisdiction/sector applicability and classification predicates,
  dependencies/incompatibilities, required fields, workflow/allowed-transition
  constraints, deadlines/escalations, approvals, report schemas/templates,
  taxonomy mappings, localization, migrations and fixtures;
- package digest, signer/trust-chain evidence, conformance corpus and negative
  tests; unknown critical semantics fail closed;
- portable `no_std + alloc` data model and decoder with explicit byte, depth,
  cardinality and localization limits and no third-party crates.

Verification:

- non-canonical/duplicate fields, truncation, deep/wide packages, invalid dates/
  versions, dependency cycles and incompatible engine profiles;
- digest/signature substitution, signer revocation, kind confusion, malicious
  localization/schema/template data and unknown critical fields;
- positive/negative canonical conformance fixtures for every package kind;
- cross-platform canonical vectors, round trips, fuzzing and allocation-failure
  campaigns.

Exit criteria: every pack is immutable, bounded and digest-addressed, and a
parsed package grants no execution or compliance authority by itself.
`v0.344.2 implementation stop reached. Run pentest for this exact commit.`

### v0.344.3 — Deterministic Bounded Framework Policy IR

Status: planned

Goal: evaluate authoritative framework logic without native or opaque code.

Deliverables:

- typed declarative IR for Boolean logic, comparisons, set membership,
  thresholds, durations, explicit missing/unknown values, incident/entity facts
  and obligation proposals;
- deterministic compiler/evaluator with instruction, expression-depth,
  collection-cardinality, memory and output limits;
- no ambient time, I/O, network, evidence mutation or undeclared tenant data;
  time and authorized inputs arrive only as explicit versioned facts;
- complete decision explanation binding input digests, package digest, rule path,
  missing/unknown values and produced classification/obligation candidates;
- authoritative Wasm/native package logic prohibited for 1.0; `v0.420.0` may
  host optional suggestions/formatting only and cannot issue legal decisions.

Verification:

- deterministic cross-target vectors, threshold/duration boundaries, unknown
  propagation, instruction/depth/cardinality exhaustion and cancellation;
- unauthorized fact access, ambient-time/I/O attempts, malicious package denial
  of service and explanation/result mismatch;
- property/model tests proving same canonical inputs and package digest yield the
  same decision and explanation.

Exit criteria: authoritative assessments are bounded, deterministic and fully
explainable, with no hidden executable policy path.
`v0.344.3 implementation stop reached. Run pentest for this exact commit.`

### v0.344.4 — Framework Registry Trust And Activation Scope

Status: planned

Goal: install and activate immutable package versions without crossing tenant or
trust boundaries.

Deliverables:

- installed-version registry with digest identity, signer/trust status,
  dependencies, incompatibilities, engine compatibility and revocation;
- tenant-scoped staged/active/disabled/quarantined lifecycle, activation epoch,
  approval evidence and exact package-set commitment;
- mandatory conformance-corpus execution before activation plus fail-closed
  behavior for missing, revoked, expired, incompatible or unavailable packages;
- isolation rule that a malicious/unavailable optional pack cannot stop the base
  incident workflow; its assessments become explicit unavailable/invalid states;
- signer rotation, rollback prevention, audit history and cross-tenant package/
  activation separation.

Verification:

- package substitution, rollback, equivocation, revoked signer, dependency race,
  partial activation, registry outage and failed conformance corpus;
- tenant/package-set confusion, unauthorized activation, stale cache and package
  failure while the default incident process remains available;
- install/activate/disable/revoke/recover state-machine and registry pentest.

Exit criteria: only an approved exact package-set commitment evaluates for a
tenant, and optional package failure cannot block framework-neutral handling.
`v0.344.4 implementation stop reached. Run pentest for this exact commit.`

### v0.344.5 — Framework Composition Applicability And Conflict Rules

Status: planned

Goal: compose multiple packs without erasing independent legal or operational
decisions.

Deliverables:

- separate per-package applicability assessments, classifications, obligations
  and deadlines; the UI may highlight an earliest deadline but storage never
  collapses distinct obligations;
- deterministic precedence: core evidence/authorization/audit invariants cannot
  be overridden, packs may add but not remove core requirements, and organization
  overlays may tighten but not silently weaken regulatory requirements;
- conflicting classifications remain separate, `Unknown` never silently becomes
  `NotApplicable`, and human overrides bind reason, actor, authority and evidence;
- disabling a pack stops new binding but preserves prior assessments/reports and
  active obligations; cancellation requires a formal authorized record;
- package data-access capabilities and redacted input views preventing packs from
  reading unauthorized evidence or leaking across tenants.

Verification:

- conflicting deadlines/classifications/transitions, unknown applicability,
  weakening overlay, disable with active obligations and override races;
- malicious pack attempting evidence mutation, base-workflow denial, cross-pack/
  tenant access or removal of core audit/authorization rules;
- order-independent composition/model tests and complete explanation/audit proof.

Exit criteria: every pack retains independent attributable outcomes and no
composition order can weaken core or regulatory safeguards.
`v0.344.5 implementation stop reached. Run pentest for this exact commit.`

### v0.344.6 — Framework Version Pinning Shadow Replay And Migration

Status: planned

Goal: patch immutable packs without silently rewriting open or historical
incident decisions.

Deliverables:

- incident binding to exact package version/content digest and package-set
  activation epoch; open incidents remain pinned by default;
- staged install, dependency/engine validation, conformance execution, historical
  shadow replay and assessment/obligation/deadline diff before approval;
- new-incident activation separate from explicit authorized reassessment/
  migration of open incidents;
- append-only revised assessments preserving prior decisions, reports,
  obligations, overrides and explanations;
- disable/removal semantics from `v0.344.5`, including continued active
  obligations and reason/approval when cancellation is requested.

Verification:

- upgrade/downgrade/rollback, changed applicability/deadline, failed migration,
  partial activation and concurrent incident creation;
- historical replay mismatch, package-version substitution, obligation loss,
  disable/remove and unauthorized bulk reassessment;
- old/new engine compatibility and deterministic before/after decision diffs.

Exit criteria: a framework patch is a new immutable version whose impact is
reviewable before activation and never rewrites prior truth.
`v0.344.6 implementation stop reached. Run pentest for this exact commit.`

### v0.344.7 — Framework Pack 1.0 Scope And Authority Decision

Status: planned

Goal: close the named framework/package set and authority limits before analyst
workflow implementation.

Deliverables:

- mandatory framework-neutral engine and `vakaheim.default.incident/1` decision;
- admit optional-at-runtime ENISA operational, NIS2 EU base, DORA classification/
  reporting and GDPR breach packs for implementation at `v0.360.5`–`v0.360.10`;
- national NIS2 overlay contract admitted at `v0.360.7`; each named country pack
  still requires its own later legal-source/interoperability stop before support;
- admit the current NIST SP 800-61r3 operational profile at `v0.360.13`; SANS,
  VERIS and other named future packs remain explicit 1.0 non-goals unless their
  own implementation milestones are inserted and passed before `v0.730.0`;
  package kinds remain extensible;
- authoritative native/Wasm framework decisions are a binding 1.0 non-goal;
  `v0.420.0` closes suggestion/formatting isolation;
- no pack claims legal compliance automatically; source edition, effective date,
  jurisdiction and operator/legal approval remain visible limitations.

Verification:

- signed owner/decision record for every named pack and national-profile claim;
- reject implied support from a generic package kind, template or authoring SDK;
- documentation/config/API scan for automatic-compliance or opaque-code claims.

Exit criteria: every framework option and named 1.0 support claim is admitted to
a concrete stop or explicitly excluded before implementation proceeds.
`v0.344.7 implementation stop reached. Run pentest for this exact commit.`

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

### v0.345.1 — Explicit Alert Triage State Machine

Status: planned

Goal: make alert triage a versioned audited workflow rather than an open-ended
status field.

Deliverables:

- states `New`, `Assigned`, `InTriage`, `WaitingForEvidence`, `Closed` and
  `Promoted`, with guarded transitions and terminal-state semantics;
- stable alert ID, optimistic version, assignee/queue, priority/severity, source
  finding set and evidence references;
- authorized assign, begin-triage, wait/resume, close, promote and reopen
  operations; reopening appends an immutable transition event;
- transition journal binding actor, authorization/policy epoch, `TimeTrust`,
  reason, prior/new version and notification intent.

Verification:

- exhaustive transition model, stale/concurrent clients, duplicate retries,
  assignment races, close/promote/reopen conflicts and authorization changes;
- immutable finding/evidence linkage, cross-tenant access and audit omission;
- restart/replay recovery and UI/API-independent state-machine conformance.

Exit criteria: every alert transition is authorized, version-checked and audited,
and no terminal alert exists outside `Closed` or `Promoted`.
`v0.345.1 implementation stop reached. Run pentest for this exact commit.`

### v0.345.2 — Alert Closure Dispositions And Tuning Feedback

Status: planned

Goal: prevent unstructured closure from hiding detection defects, gaps or active
incidents.

Deliverables:

- closed disposition enum: rule-defect false positive, authorized-expected-
  behavior false positive, benign true positive, duplicate, incident-covered,
  insufficient evidence, telemetry gap, not-security-relevant and approved
  policy suppression with expiry;
- mandatory actor/time, explanation, finding/evidence, rule/package version,
  duplicate/incident reference where applicable, tuning suggestion and task-
  created fields;
- automatic idempotent rule-tuning task for rule-defect false positives by
  default, with explicit approved reason to suppress task creation;
- tuning/corrective-action linkage that never edits the original finding or
  historical rule identity.

Verification:

- reject missing explanation/reference/approver/expiry, invalid disposition,
  self-duplicate, cross-tenant incident and stale rule identity;
- duplicate closure retry, auto-task crash boundaries, suppression expiry and
  reopen while tuning is pending;
- conservation proof that every closed alert has one structured disposition and
  every rule-defect path has a task or authorized exception.

Exit criteria: an alert cannot disappear into a generic closed state and tuning
feedback remains linked to immutable detection evidence.
`v0.345.2 implementation stop reached. Run pentest for this exact commit.`

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

### v0.346.1 — Atomic Idempotent Alert-To-Incident Promotion

Status: planned

Goal: turn one or more validated alerts into exactly one formal incident and
primary workspace across timeout/retry and crash boundaries.

Deliverables:

- authorization and optimistic alert-version/state validation plus canonical
  `PromotionKey` and linearizable put-if-absent stable `IncidentId` allocation;
- one committed promotion bundle linking every selected alert/finding, earliest
  known awareness/detection times, formal incident, primary case and incident-
  graph root;
- exact active package-set evaluation request, resulting assessment/obligation
  intents, transactional notification outbox records and complete immutable
  audit event;
- alert `Promoted(incident_id)` transition only after the bundle is durable;
  recovery finishes an incomplete bundle and retry returns the same incident;
- same key/different alert-set or digest is an integrity incident, never a second
  promotion.

Verification:

- crash/timeout at every validate/allocate/link/case/graph/framework/outbox/audit/
  promoted boundary and concurrent promotion attempts;
- stale authorization/version, mixed tenants, already promoted/closed alerts,
  package failure and notification/audit outage;
- state-machine/property proof that one promotion key yields one stable incident,
  one primary case and one graph root with complete immutable links.

Exit criteria: promotion is logically atomic and idempotent; no retry, failover
or partial subsystem outage can create a second incident or orphan authority.
`v0.346.1 implementation stop reached. Run pentest for this exact commit.`

### v0.346.2 — Formal Incident Record And Lifecycle Journal

Status: planned

Goal: implement the authoritative incident declaration independently from its
correlation graph and case workspace.

Deliverables:

- stable `IncidentId`, declaration actor/reason, earliest occurrence/detection/
  awareness timestamps with uncertainty, owner, severity, confidentiality,
  taxonomy, impact and package-set bindings;
- lifecycle `Declared`, `Investigating`, `Containing`, `Eradicating`,
  `Recovering`, `Monitoring`, `Resolved`, `Closed`, `PostAnalysisComplete`;
- profile-controlled phase skips only with reason/authority, optimistic version,
  immutable transition journal and separate state timestamps;
- distinct `Resolved`, `Closed` and `PostAnalysisComplete` meanings with no
  automatic collapse; case and graph references never replace incident state.

Verification:

- exhaustive transition/skip model, stale/concurrent update, authorization and
  severity/confidentiality races;
- attempted awareness-time advancement, graph/case state confusion, duplicate ID
  and cross-tenant reference;
- restart/replay and audit completeness for every lifecycle edge.

Exit criteria: incident handling has one formal attributable record whose state
cannot be inferred from a graph, case or external ticket.
`v0.346.2 implementation stop reached. Run pentest for this exact commit.`

### v0.346.3 — Incident Merge Split Reopen And Control Operations

Status: planned

Goal: support complex incident evolution without resetting history, clocks or
obligations.

Deliverables:

- authorized declassify-with-justification, reopen, merge, split, ownership
  transfer, hold, severity escalation and approval-gated severity reduction;
- immutable lineage linking predecessor/successor incidents, alerts, cases,
  graphs, assessments, obligations, reports and audit events;
- earliest awareness/detection/occurrence timestamps and existing regulatory
  deadlines can only remain or become earlier across merge/split/reopen;
- deterministic obligation reassignment/copy/reference rules preserving each
  package's independent legal record and no ID reuse;
- idempotent operation keys and reconciliation for partial multi-record changes.

Verification:

- merge/split cycles, overlapping alerts, concurrent reopen/close, declassify/
  hold/ownership races and unauthorized severity reduction;
- deadline/time reset attempts, obligation loss/duplication, primary-case and
  graph lineage corruption;
- model proof of stable lineage and non-increasing earliest awareness/deadlines.

Exit criteria: structural incident operations preserve all prior evidence,
authority, clocks and obligations without silent duplication or erasure.
`v0.346.3 implementation stop reached. Run pentest for this exact commit.`

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

### v0.360.1 — Formal Incident And IncidentGraph Binding

Status: planned

Goal: associate correlation graphs with formal incidents without conflating
their states or lifecycles.

Deliverables:

- one formal incident-to-primary-graph-root binding with versioned additional
  investigative views and explicit graph lineage;
- graph grouping/split/merge proposals require authorized incident operations;
  graph confidence/hypotheses never alter incident declaration or severity;
- propagation rules for alert/finding/entity links, compartments, redaction,
  holds, retention and evidence access revocation;
- independent incident and graph journals joined by immutable references.

Verification:

- graph regroup/revert concurrent with incident merge/split/reopen/close;
- orphan/duplicate root, cross-tenant graph, stale compartment, redaction and
  graph-derived unauthorized incident transition;
- complete lineage/explanation replay from incident to every graph revision.

Exit criteria: the graph explains an incident but can neither declare it nor
replace its formal state. `v0.360.1 implementation stop reached. Run pentest for
this exact commit.`

### v0.360.2 — Regulatory Assessment And Applicability Records

Status: planned

Goal: record package-specific applicability and classification without turning
uncertainty into a compliance assertion.

Deliverables:

- immutable assessment ID, incident/package version/digest, input snapshot,
  applicability `Applicable`/`NotApplicable`/`Unknown`, classification and
  complete explanation;
- exact jurisdiction, sector, organization/entity role, authority, source
  timestamps, rule IDs and missing/unknown facts;
- append-only reassessment supersession, human override with reason/authority/
  evidence and independent outcomes for every active pack;
- authorized incident/entity attribute view enforcing field/purpose, compartment,
  residency and tenant isolation before evaluation.

Verification:

- missing/conflicting jurisdiction/sector/entity facts, unknown propagation,
  stale package/input, override/reassessment races and package-order changes;
- unauthorized evidence/attribute access, cross-tenant assessment leakage and
  result/explanation/package-digest substitution;
- deterministic replay and one independent outcome per applicable package.

Exit criteria: every applicability/classification result is immutable,
explainable and pinned to exact inputs and package content.
`v0.360.2 implementation stop reached. Run pentest for this exact commit.`

### v0.360.3 — Obligation Deadline Escalation And Overdue Engine

Status: planned

Goal: implement independent regulatory and operational clocks without silently
merging or resetting deadlines.

Deliverables:

- immutable obligation ID bound to incident, assessment, package digest, rule,
  source timestamp, computed deadline, uncertainty and required action/report;
- states pending, due-soon, in-progress, submitted/completed, overdue, cancelled,
  superseded and `Unknown`, with append-only transitions and approvals;
- conservative `v0.4.4` time arithmetic, visible safety margin, warnings,
  escalations and `v0.44.5` scheduler profile; unavailable/uncertain time fails
  toward earlier action and never extends a legal deadline;
- separate obligations for every pack/rule; merge/split/reopen and pack disable
  cannot move an existing deadline forward or erase it;
- requested intermediate reports, correction/follow-up events, authorized
  cancellation and exception evidence without false completion.

Verification:

- exact boundary arithmetic, forward/backward clock jumps, uncertainty growth,
  missed scheduler execution and notification outage;
- awareness-time correction, merge/split/reopen, pack upgrade/disable, duplicate
  obligation creation and conflicting legal clocks;
- model proof that source timestamp/rule are visible and no deadline silently
  moves later, collapses with another or disappears.

Exit criteria: every clock is independently attributable and conservative, and
an overdue/unknown obligation remains visible until formally resolved.
`v0.360.3 implementation stop reached. Run pentest for this exact commit.`

### v0.360.4 — Default Vakaheim Incident Handling Pack

Status: planned

Goal: ship a useful framework-neutral incident process that requires no legal,
ENISA or external-ITSM package.

Deliverables:

- immutable signed `vakaheim.default.incident/1` package over the `v0.344.2`–
  `v0.344.6` engine;
- default alert/incident states, triage dispositions, severity/priority,
  assignment, escalation, tasks, comments, evidence and generic SLA rules;
- closure validation and post-incident review requirements compatible with
  `v0.345.1`–`v0.346.3` and `v0.375.0`;
- complete conformance/negative corpus, localization baseline and migration
  fixture;
- explicit statement that this operational process makes no legal-compliance
  claim.

Verification:

- end-to-end alert promotion, incident phases, case work and post-analysis with
  every optional regulatory pack absent/unavailable/malicious;
- package tamper/revoke/upgrade/disable, missing localization and base-workflow
  denial attempts;
- deterministic cross-platform package/evaluator results and tabletop exercise.

Exit criteria: Vakaheim provides a complete native incident workflow by default,
independent of optional frameworks and external systems.
`v0.360.4 implementation stop reached. Run pentest for this exact commit.`

### v0.360.5 — ENISA Operational Lifecycle Pack

Status: planned; optional tenant activation

Goal: provide an independently patchable ENISA-oriented operational overlay
without claiming that use establishes legal compliance.

Deliverables:

- signed package mapping detection/registration, triage/classification/
  prioritization/assignment, resolution, closure and post-analysis onto the
  default incident process;
- exact ENISA guide edition/source digest, terminology/taxonomy mappings,
  required fields, transition overlays and conformance fixtures;
- additive workflow constraints only; base evidence, authorization, audit and
  incident invariants remain non-overridable;
- source and limitation documentation linking the official ENISA incident-
  management guidance and stating its non-regulatory nature:
  [ENISA incident-management guide announcement](https://www.enisa.europa.eu/news/enisa-news/new-guide-on-cyber-security-incident-management-to-support-the-fight-against-cyber-attacks).

Verification:

- every lifecycle mapping/phase/skip, conflicting organization overlay, missing
  data, pack disable/upgrade and historical replay;
- ENISA pack failure cannot stop default incident handling or erase obligations;
- independent content/domain review, deterministic evaluation and pack pentest.

Exit criteria: tenants may activate a versioned ENISA operational profile while
the default process and legal claims remain separate.
`v0.360.5 implementation stop reached. Run pentest for this exact commit.`

### v0.360.6 — NIS2 EU Base Obligation Pack

Status: planned; optional tenant activation

Goal: encode a source-pinned EU NIS2 base assessment and reporting clock without
pretending to replace national transposition or legal advice.

Deliverables:

- entity/sector applicability and significant-incident assessment with explicit
  unknowns and exact Directive (EU) 2022/2555 source/edition;
- earliest awareness handling plus independent Article 23 obligations: early
  warning within 24 hours, notification within 72 hours, requested intermediate
  report and final report within one month after incident notification;
- ongoing-incident progress/final-report handling, source fields, recipient
  extension points, submission/correction linkage and explanations;
- pinned official source: [NIS2 Article 23](https://eur-lex.europa.eu/eli/dir/2022/2555/art_23/oj);
- no national-recipient/procedure or automatic-compliance claim; `v0.360.7`
  supplies the overlay contract.

Verification:

- awareness and 24-hour/72-hour/one-month boundaries under uncertainty, late
  discovery, ongoing incident and intermediate-report request;
- applicable/not-applicable/unknown entity and significant-incident criteria,
  package patch, national conflict and deadline non-collapse;
- independent legal-content review against the pinned official source plus
  deterministic fixtures and adversarial package tests.

Exit criteria: NIS2 EU-base assessments and clocks are exact-package attributable,
conservative and visibly incomplete until required national context is supplied.
`v0.360.6 implementation stop reached. Run pentest for this exact commit.`

### v0.360.7 — National NIS2 Overlay Contract

Status: planned

Goal: support national transpositions without baking mutable country law into the
EU base engine or implying unnamed jurisdiction support.

Deliverables:

- signed overlay schema for jurisdiction, competent authority/CSIRT, recipients,
  entity/sector rules, thresholds, additional fields, procedures/channels,
  language, effective/expiry dates and legal-source provenance;
- dependency on an exact NIS2 EU base digest, deterministic additive/conflict
  behavior and independent assessments/obligations where national rules differ;
- authority review, activation scope and migration/reassessment requirements for
  legal changes;
- each named country overlay requires its own patch/intermediate implementation,
  current-source review, conformance corpus and pentest before support is claimed.

Verification:

- wrong/missing jurisdiction, expired/future law, base-version mismatch,
  conflicting deadline/recipient and unknown national applicability;
- overlay attempting to weaken EU/core invariants, cross-jurisdiction leakage,
  silent fallback to another country and stale legal source;
- synthetic national-overlay fixtures and admission rejection for unnamed packs.

Exit criteria: national rules are independently versioned and attributable; the
generic contract alone claims support for no country.
`v0.360.7 implementation stop reached. Run pentest for this exact commit.`

### v0.360.8 — DORA Major Incident Classification Pack

Status: planned; optional tenant activation

Goal: classify DORA major ICT-related incidents separately from notification
deadlines.

Deliverables:

- financial-entity/applicability, critical-service and materiality evaluation
  pinned to Commission Delegated Regulation (EU) 2024/1772;
- criteria for clients/financial counterparts/transactions, reputation,
  duration/service downtime, geographic spread, data loss, economic impact and
  critical services with explicit estimates/unknowns;
- recurring-incident aggregation using source-pinned recurrence/root-cause/
  review-window rules and exclusions, without altering original incidents;
- major-classification timestamp and exact inputs/explanation for later report
  clocks;
- pinned official source: [DORA classification criteria](https://eur-lex.europa.eu/eli/reg_del/2024/1772/oj).

Verification:

- every materiality threshold boundary, missing/estimated inputs, critical-
  service dependency and interdependent criteria;
- recurring incidents across window/root-cause/entity exclusions, late
  reclassification and assessment supersession;
- independent legal-content review, official-source fixture provenance,
  deterministic replay and classification-pack pentest.

Exit criteria: DORA classification is a versioned explainable assessment with a
distinct classification time, never inferred from NIS2 clocks.
`v0.360.8 implementation stop reached. Run pentest for this exact commit.`

### v0.360.9 — DORA Notification And Reporting Pack

Status: planned; optional tenant activation

Goal: implement DORA reporting clocks, content and forms independently from
NIS2 and from major-incident classification.

Deliverables:

- initial notification due within four hours after major classification and no
  later than 24 hours after awareness, including later-than-24-hour
  classification handling;
- intermediate report due within 72 hours after initial notification, recovery
  updates, and final report due within one month after the latest applicable
  intermediate report;
- delay-notice/reason, correction/update, financial/operational impact, affected
  clients/counterparties/transactions, downtime, geography, root cause and
  recovery fields;
- versioned forms/templates/procedures pinned to Commission Delegated Regulation
  (EU) 2025/301 and Implementing Regulation (EU) 2025/302;
- official sources [DORA reporting deadlines](https://eur-lex.europa.eu/eli/reg_del/2025/301/oj)
  and [DORA report forms and procedures](https://eur-lex.europa.eu/eli/reg_impl/2025/302/oj).

Verification:

- four-hour/24-hour dual boundary, late classification, 72-hour intermediate,
  repeated update and latest-intermediate one-month boundary under uncertainty;
- missing classification/awareness/recovery time, delayed-report explanation,
  template version mismatch and NIS2 deadline non-collapse;
- independent legal/content/template review, canonical form fixtures, package
  replay and reporting-pack pentest.

Exit criteria: DORA obligations and forms follow their own source-pinned clocks
and never borrow NIS2 timing semantics.
`v0.360.9 implementation stop reached. Run pentest for this exact commit.`

### v0.360.10 — GDPR Personal-Data Breach Pack

Status: planned; optional tenant activation

Goal: cover the regulatory-pack example for GDPR breach handling as a separate
assessment and obligation set.

Deliverables:

- controller/processor role, personal-data breach, risk/high-risk applicability
  assessments and explicit unknown/missing facts;
- Article 33 supervisory notification without undue delay and where feasible
  within 72 hours of awareness unless unlikely risk, including late reason,
  phased information and breach documentation;
- processor-to-controller notification and Article 34 high-risk data-subject
  communication without undue delay, including source-pinned exceptions;
- pinned official source: [GDPR](https://eur-lex.europa.eu/eli/reg/2016/679/oj),
  exact package digest and no automatic-compliance claim.

Verification:

- 72-hour boundary, awareness correction, risk/high-risk/exception decisions,
  phased data, late reason and processor/controller role conflict;
- composition with NIS2/DORA without deadline collapse or disclosure leakage;
- independent legal-content review, deterministic fixtures and privacy/redaction
  pentest.

Exit criteria: GDPR breach handling is independently attributable and cannot be
confused with NIS2 or DORA assessment/reporting authority.
`v0.360.10 implementation stop reached. Run pentest for this exact commit.`

### v0.360.11 — Internal Framework Authoring Validation And Conformance SDK

Status: planned; private workspace tooling

Goal: let maintainers author and test packs without granting publication or
runtime authority.

Deliverables:

- private authoring model/CLI for manifests, policy IR, applicability,
  obligations, schemas/templates, localization, mappings and migrations;
- canonical build/digest, lint, dependency/compatibility checks, fixture runner,
  negative corpus, explanation snapshots and package diff;
- historical shadow-replay and migration preview against redacted authorized
  incident fixtures;
- signing-request/verification workflow separated from authoring identity and
  production activation authority;
- no crates.io publication; future public SDK admission remains solely
  `v0.660.0` and this tool never implies support/compliance for authored packs.

Verification:

- malformed/hostile source, nondeterministic build, fixture omission, dependency
  confusion, unauthorized signing/activation and secret/evidence leakage;
- cross-platform reproducible package output, negative fixtures and compiler/
  evaluator differential tests;
- shadow replay at scale, migration preview correctness and authoring-tool pentest.

Exit criteria: pack authors can produce reproducible conformance evidence, but
only the registry trust/approval path can activate a package.
`v0.360.11 implementation stop reached. Run pentest for this exact commit.`

### v0.360.12 — Baseline Framework Pack Integration Gate

Status: planned

Goal: integrate the legal/ENISA baseline before adding the independent NIST
operational profile.

Deliverables:

- integrated default, ENISA, NIS2 EU, national-overlay contract, DORA
  classification/reporting and GDPR packs over one package engine;
- default-only and every meaningful multi-pack composition/disable/upgrade/
  reassessment matrix with independent assessments, obligations and reports;
- exact legal/guidance source inventory, edition/effective-date review owner,
  update monitoring policy and release-note limitations;
- proof that optional pack failure cannot block base triage/containment/evidence,
  and opaque Wasm/native logic cannot make authoritative 1.0 determinations;
- documentation explicitly distinguishes operational guidance, product support,
  legal assessment evidence and actual compliance responsibility.

Verification:

- cross-pack conflicting applicability/classification/deadline, unknowns,
  disable with active obligation, source update and historical shadow migration;
- malicious/revoked/unavailable pack, registry outage, tenant leakage and
  authoritative-Wasm bypass attempt while default workflow remains usable;
- independent security, privacy and legal/domain review plus exact-commit pentest.

Exit criteria: the baseline legal/ENISA packs are integrated without claiming
that the final 1.0 framework set is closed.
`v0.360.12 implementation stop reached. Run pentest for this exact commit.`

### v0.360.13 — NIST SP 800-61r3 Operational Profile Pack

Status: planned; optional tenant activation

Goal: implement current NIST incident-response guidance as a source-pinned
operational overlay without replacing the default process or claiming compliance.

Deliverables:

- signed pack pinned to final NIST SP 800-61 Revision 3 and its CSF 2.0 Community
  Profile source/digest;
- Govern/Identify/Protect preparation and Detect/Respond/Recover incident-
  response outcome mappings onto Vakaheim workflow, tasks and post-analysis;
- roles, communications, prioritization, recovery, lessons and improvement
  requirements with exact guidance references;
- explicit revision-2 supersession and migration/limitation documentation.

Verification:

- every admitted outcome mapping, optional/recommended distinction, phase/role
  conflict and missing organizational context;
- composition with ENISA/default/legal packs without deadline or authority
  collapse;
- independent incident-response domain review and package pentest.

Exit criteria: tenants can activate an exact NIST SP 800-61r3 operational profile
while default/legal authority remains separate. `v0.360.13 implementation stop
reached. Run pentest for this exact commit.`

### v0.360.14 — Final Framework Pack Integration And Claim Closure

Status: planned

Goal: close the complete admitted 1.0 framework set after every pack has its own
implementation evidence.

Deliverables:

- integrated default, ENISA, NIST SP 800-61r3, NIS2, DORA and GDPR pack matrix;
- all composition/disable/upgrade/migration/unknown/conflict combinations;
- final source/version/effective-date/freshness owner and support-claim inventory;
- named national-profile decision evidence and explicit SANS/VERIS non-goals
  unless later implemented stops exist.

Verification:

- cross-operational/legal conflict, source update, malicious/unavailable pack,
  tenant leakage and authoritative-Wasm bypass;
- default-only operation and every admitted multi-pack composition;
- independent security, privacy, legal/domain and exact-commit pentest.

Exit criteria: every admitted pack and non-goal is closed with no implied
compliance or framework support. `v0.360.14 implementation stop reached. Run
pentest for this exact commit.`

### v0.360.15 — Named National NIS2 Profile Closure

Status: conditional on `v0.100.2`

Goal: close the exact 1.0 national NIS2 profile set without allowing the generic
overlay contract to imply country support.

Deliverables:

- signed jurisdiction list selected at `v0.100.2` with legal owner and sources;
- one separately inserted implementation/pentest stop per admitted country before
  this closure; this milestone contains no hidden country implementation;
- rejected/absent country API/config/package behavior and support documentation;
- base/overlay version, effective date, recipient/channel and migration evidence.

Verification:

- reject any named support lacking its own current-law implementation stop;
- wrong jurisdiction, expired source, base mismatch and implied fallback;
- independent legal-claim and exact-commit pentest.

Exit criteria: each named country is independently implemented and current, or
explicitly unsupported for 1.0. `v0.360.15 implementation stop reached. Run
pentest for this exact commit.`

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

### v0.375.1 — Incident Closure Validation And Post-Incident Review

Status: planned

Goal: prevent `Resolved`, `Closed` or `PostAnalysisComplete` from becoming
interchangeable unchecked labels.

Deliverables:

- close-readiness validator for category/taxonomy, root cause/contributing
  factors, CIA impact, affected assets/services/identities/organizations,
  geography/jurisdiction and containment/eradication/recovery evidence;
- residual risk, evidence references, lessons learned, corrective actions/
  owners, regulatory assessments/submissions and required package fields;
- separate guards for resolve, close and post-analysis completion, including
  unresolved/overdue obligations, open holds/tasks and unknown outcomes;
- explicit field-level authorized exceptions with approver, reason, evidence,
  expiry/review and immutable audit event;
- primary case/post-analysis review linkage without making case closure mutate
  the incident automatically.

Verification:

- every missing/unknown field, incomplete obligation/report, open action/hold,
  stale recovery evidence and invalid phase skip;
- exception authority/collusion/expiry, concurrent close/reopen, package change
  and graph/case status confusion;
- tabletop closure and post-analysis exercises across default and regulatory packs.

Exit criteria: an incident reaches each terminal phase only with complete
structured evidence or an explicit authorized exception.
`v0.375.1 implementation stop reached. Run pentest for this exact commit.`

### v0.375.2 — Corrective Actions Tuning And Effectiveness Verification

Status: planned

Goal: turn triage defects and lessons learned into owned measurable improvement
without rewriting historical detections.

Deliverables:

- corrective-action record with source alert/incident/case/lesson, owner,
  priority, due date, approval, evidence and status journal;
- links to `v0.345.2` rule-tuning tasks, detection package changes, telemetry-gap
  remediation, control changes and risk acceptance;
- effectiveness plan, success criteria, observation window, verification query/
  evidence and explicit effective/ineffective/inconclusive outcome;
- scheduler notifications/escalation, duplicate consolidation and immutable
  before/after rule/package/source identities;
- post-analysis completion policy requiring disposition of mandatory corrective
  actions without claiming that task closure proves effectiveness.

Verification:

- duplicate/abandoned action, owner/authorization change, overdue task,
  ineffective fix, telemetry unavailable and package rollback;
- tuning link substitution, historical finding mutation, false-success evidence
  and cross-tenant leakage;
- end-to-end rule-defect alert through tuning, rollout and effectiveness review.

Exit criteria: every required improvement is owned and evidence-verified, while
the original alert, finding and incident history remains immutable.
`v0.375.2 implementation stop reached. Run pentest for this exact commit.`

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

### v0.376.1 — Alert Incident Assessment Obligation And Report APIs

Status: planned

Goal: expose the implemented workflow and framework records without permitting
clients to invent state or legal decisions.

Deliverables:

- versioned alert transition/disposition/promotion, formal incident lifecycle/
  control operation and incident-graph binding schemas;
- read/evaluate/reassess APIs for package bindings and assessments, plus
  obligation transition/escalation/exception and report-version/approval state;
- optimistic version, canonical idempotency key, package/input digest, tenant/
  compartment/purpose authorization, pagination/watch and immutable audit binding;
- server-generated transition forms and explanations; clients cannot supply an
  authoritative assessment, deadline, incident ID or completion assertion;
- service-identity-only profile until `v0.396.0` activates human sessions.

Verification:

- stale/concurrent transition, duplicate promotion, package/digest substitution,
  forged deadline/completion, pagination snapshot and old/new client behavior;
- cross-tenant/compartment assessment/report access, redaction, hold and purpose
  changes during requests;
- API/state-machine/package-engine conformance and independent API pentest.

Exit criteria: the API exposes only implemented authorized transitions and exact
framework records, never caller-authored incident or regulatory truth.
`v0.376.1 implementation stop reached. Run pentest for this exact commit.`

### v0.376.2 — External Ticket Link Inbox And Sync Journal APIs

Status: planned

Goal: model external workflow synchronization durably without making an ITSM
record authoritative by accident.

Deliverables:

- external link with provider profile, Vakaheim incident/case IDs, remote record
  ID/URL, correlation/idempotency IDs and external schema/API profile;
- per-field authority map, last synchronized version, last confirmed remote
  state, conflict state, delivery outcome, retry/reconciliation state and
  redaction/residency policy;
- append-only outbound/inbound synchronization journal, inbox/outbox,
  loop-prevention token and unknown-outcome state;
- APIs for preview/dry-run, approve, enqueue, observe, reconcile, reject/import
  permitted remote changes and inspect health/conflicts;
- default internal authority; no blind last-write-wins and external outage never
  blocks local triage, containment or evidence preservation.

Verification:

- replay/loop, remote-ID reuse, stale local/remote versions, simultaneous edits,
  field-authority conflict and unknown send outcome;
- provider outage/schema drift, redaction/residency change, unauthorized import,
  attachment substitution and cross-tenant link;
- journal conservation, deterministic conflict surfacing and API pentest.

Exit criteria: neither side is silently overwritten and every synchronization
attempt/outcome is durable, attributable and reconcilable.
`v0.376.2 implementation stop reached. Run pentest for this exact commit.`

### v0.377.0 — Formal Threat Hunt Record And Lifecycle

Status: planned

Goal: make proactive hunting a first-class governed workflow distinct from a
saved query, alert, incident or case.

Deliverables:

- stable `HuntId`, hypothesis, rationale, scope, owner/team, priority, status,
  start/end, review and confidentiality;
- draft, approved, running, paused, completed, inconclusive, cancelled and
  converted lifecycle with optimistic version and immutable journal;
- source/query/rule/content/ATT&CK/package/policy identities and expected evidence;
- explicit links to findings, alerts, incidents, cases and corrective actions.

Verification:

- exhaustive transitions, stale/concurrent updates, unauthorized scope, cross-
  tenant links and audit omission;
- saved-query/case/incident state confusion;
- state-machine replay and hunt-model pentest.

Exit criteria: every proactive investigation has an attributable hypothesis,
scope and outcome. `v0.377.0 implementation stop reached. Run pentest for this
exact commit.`

### v0.377.1 — Hunt Snapshot Coverage And Query Evidence

Status: planned

Goal: bind hunt conclusions to exact data, query and visibility context.

Deliverables:

- query text/IR/plan, parameters, time range, snapshot and expected-set coverage;
- source health, unavailable/cold/policy-limited data and completeness record;
- result-set digest, analyst annotations and retained evidence references;
- re-run semantics preserving original and revised executions separately.

Verification:

- changed query/schema/mapping/policy/source set, partial cold retrieval and
  stale snapshot;
- result substitution, omitted gaps and unauthorized annotations;
- deterministic rerun and coverage-honesty tests.

Exit criteria: a hunt outcome cannot outlive or hide its exact query and coverage
evidence. `v0.377.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.377.2 — Hunt Execution Checkpoint And Collaboration

Status: planned

Goal: support long-running collaborative hunts without duplicate work or hidden
state loss.

Deliverables:

- durable execution/checkpoint/cancel/pause/resume and bounded scheduled tasks;
- assignments, notes, hypotheses/sub-hypotheses, evidence bookmarks and peer
  review with compartment authorization;
- query/result lineage and handoff journal across analysts/shifts;
- resource/cost admission and impairment outcomes.

Verification:

- crash/restart, duplicate execution, cancellation race, analyst removal,
  compartment change and query cost overrun;
- stale handoff, annotation leakage and checkpoint rollback;
- long-running collaborative hunt and recovery pentest.

Exit criteria: hunt work survives handoff and failure with complete attributable
history. `v0.377.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.377.3 — Hunt Outcome Promotion And Detection Engineering Loop

Status: planned

Goal: convert hunt discoveries through ordinary authority boundaries rather than
copying mutable conclusions into production.

Deliverables:

- promote evidence to immutable finding, alert, incident or primary-case link;
- generate signed draft rule/test/content/tuning proposal with exact hunt inputs;
- negative/inconclusive finding and coverage-gap/corrective-action outcomes;
- duplicate/idempotency and required review/approval per destination.

Verification:

- duplicate promotion, stale hunt/query, unsupported conclusion, cross-tenant
  target and direct rule activation attempt;
- finding/evidence immutability and content-review enforcement;
- hunt-to-detection-to-alert end-to-end tabletop.

Exit criteria: hunts feed detection and response only through existing reviewed
authority paths. `v0.377.3 implementation stop reached. Run pentest for this
exact commit.`

### v0.377.4 — Recurring Threat Hunt Program

Status: planned

Goal: run approved recurring hunts as measurable security work rather than
unowned scheduled queries.

Deliverables:

- recurrence, owner, hypothesis review/expiry, trigger and required coverage;
- scheduler checkpoint/misfire/catch-up/skip and result comparison;
- intelligence/ATT&CK/content/source-change triggers and automatic review task;
- effectiveness, findings, gaps and retirement rationale.

Verification:

- missed/duplicate schedule, stale hypothesis, owner departure, source change,
  intelligence revoke and cost growth;
- recurrence cannot auto-promote or bypass review;
- multi-cycle program and recovery tests.

Exit criteria: recurring hunts remain current, owned and outcome-measured.
`v0.377.4 implementation stop reached. Run pentest for this exact commit.`

### v0.377.5 — Threat Hunt API And Integration Gate

Status: planned

Goal: expose the full hunt lifecycle and close its security/coverage semantics
before UI implementation.

Deliverables:

- versioned hunt lifecycle/query/execution/collaboration/promotion APIs;
- server-generated forms, idempotency, pagination/watch and audit;
- ATT&CK/content/intelligence/case integration and export restrictions;
- hunt conformance corpus and support documentation.

Verification:

- stale/duplicate API calls, query injection, cross-tenant/compartment access,
  result pagination and unauthorized promotion;
- full hunt lifecycle under source impairment and policy change;
- independent API/workflow and exact-commit pentest.

Exit criteria: hunt clients cannot invent evidence, completeness or promotion
authority. `v0.377.5 implementation stop reached. Run pentest for this exact
commit.`

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

### v0.390.1 — Versioned Regulatory Report Generation Review And Approval

Status: planned

Goal: generate package-defined reports without confusing a draft, approved
version or forensic report.

Deliverables:

- immutable report ID/version binding incident, assessment, obligation, exact
  framework/report package digest, template/schema and canonical input snapshot;
- deterministic field mapping with source/evidence citations, missing/unknown/
  estimated markers, localization and redaction/residency policy;
- draft, review, changes-requested, approved, superseded and withdrawn states
  with optimistic version and required role/two-person approvals;
- canonical rendered payload plus structured payload digest; manual edits become
  a new attributable version and cannot detach required source fields;
- separation from `v0.390.0` forensic packages while permitting approved custody-
  safe evidence/report attachments.

Verification:

- template/package/input substitution, omitted required field, stale approval,
  concurrent edit, localization drift and redaction bypass;
- assessment/obligation supersession, incident merge/split, late correction and
  historical report verification after package upgrade;
- deterministic render/schema fixtures and report-generation pentest.

Exit criteria: every approved regulatory report is immutable, exact-input and
exact-package attributable with all uncertainty and omissions visible.
`v0.390.1 implementation stop reached. Run pentest for this exact commit.`

### v0.390.2 — Signed Submission Receipt And Correction Workflow

Status: planned

Goal: track regulatory submission as an uncertain external effect with exact
payload and receipt evidence.

Deliverables:

- approved report-to-submission envelope binding channel/recipient profile,
  payload digest, signer, obligation, idempotency key and approval evidence;
- durable outbox/inbox states prepared, dispatched, acknowledged, rejected,
  `UnknownOutcome`, reconciled and corrected/superseded;
- signed/verified receipt or explicit absence/unknown outcome, remote reference,
  submission time with `TimeTrust`, response digest and complete audit journal;
- correction/update workflow creating a new report/submission version without
  erasing the original payload, receipt, lateness or regulator response;
- provider-neutral manual/offline export baseline; each electronic authority
  channel requires its own later named interoperability stop.

Verification:

- crash/timeout before/after send/remote accept/receipt persist, duplicate retry,
  receipt forgery, wrong recipient and idempotency collision;
- rejected/late/partial submission, lost receipt, correction race, revoked signer,
  clock uncertainty and channel outage;
- conservation proof that every dispatch has exact payload digest and receipt or
  remains explicit `UnknownOutcome`; submission-workflow pentest.

Exit criteria: no report is called submitted without exact payload and receipt
evidence, and uncertainty is never converted into success or safe retry.
`v0.390.2 implementation stop reached. Run pentest for this exact commit.`

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

### v0.404.1 — Alert Triage Queue And Disposition UI

Status: planned

Goal: make the explicit alert lifecycle usable without permitting client-side
state or authorization shortcuts.

Deliverables:

- queue/filter/assignment/priority/SLA views with finding/evidence/rule/package
  context and source-assurance gaps;
- server-issued forms for begin triage, wait/resume, structured close, promote
  and reopen using optimistic version/idempotency tokens;
- complete disposition-specific required fields, duplicate/incident selection,
  suppression approval/expiry and rule-tuning task preview/status;
- stale/conflict resolution and immutable transition/audit timeline.

Verification:

- stale tab/concurrent analyst, duplicate submit, close/promote race, queue
  reassignment and authorization/compartment change;
- required-field bypass, cross-tenant duplicate/incident lookup, unsafe evidence
  rendering and tuning-task omission;
- accessible end-to-end triage, browser security and analyst workflow pentest.

Exit criteria: every UI action is a server-validated `v0.345.1`/`v0.345.2`
transition and terminal alerts remain fully explained.
`v0.404.1 implementation stop reached. Run pentest for this exact commit.`

### v0.404.2 — Incident Lifecycle And Investigation Workspace

Status: planned

Goal: present the formal incident, primary case and graph as related but distinct
work areas.

Deliverables:

- incident declaration/lifecycle/severity/owner/hold views, primary case tasks/
  notes/evidence/playbooks and separate graph/hypothesis exploration;
- server-issued merge/split/reopen/declassify/transfer/severity forms with lineage,
  earliest-awareness and obligation impact preview;
- structured resolve/close/post-analysis readiness, required fields, exceptions,
  corrective actions and effectiveness status;
- compartment-aware timelines exposing immutable incident/case/graph/audit
  events without conflating their states.

Verification:

- stale/concurrent lifecycle and structural operations, graph/case status
  confusion, awareness/deadline reset preview and primary-case duplication;
- compartment/membership/redaction change, unsafe comments/evidence, hold and
  exception-approval bypass;
- full incident tabletop, accessibility, browser security and workspace pentest.

Exit criteria: analysts can run the complete native incident process while the
server remains the sole authority for state, clocks and evidence access.
`v0.404.2 implementation stop reached. Run pentest for this exact commit.`

### v0.404.3 — Obligation Countdown Report Approval And Submission UI

Status: planned

Goal: display independent framework decisions and deadlines without false
certainty or silent legal conflation.

Deliverables:

- per-package applicability/classification explanation, package version/digest,
  source timestamps, uncertainty and independent obligation countdowns;
- earliest-pending summary that never replaces the underlying separate deadlines;
- report field/source/unknown review, version diff, required approval, payload
  digest, submission/receipt/unknown-outcome and correction views;
- authorized reassessment, override, exception and package migration previews
  with immutable before/after outcomes;
- explicit operational-guidance/product-support/legal-compliance limitations.

Verification:

- deadline ordering/uncertainty/overdue display, conflicting packs, unknown
  applicability, stale package and disabled pack with active obligation;
- approval/submission duplicate, payload mismatch, forged/missing receipt,
  correction race and authorization/redaction changes;
- accessible regulatory tabletop, browser security and disclosure pentest.

Exit criteria: the UI exposes exact package/rule/time evidence and never presents
an aggregate countdown or generated report as proof of compliance/submission.
`v0.404.3 implementation stop reached. Run pentest for this exact commit.`

### v0.404.4 — External Ticket Health Conflict And Reconciliation UI

Status: planned

Goal: make external synchronization failure and field authority visible without
blocking internal incident handling.

Deliverables:

- link/provider/remote identity, field-authority map, last confirmed remote/local
  versions, delivery health and synchronization journal views;
- dry-run/redaction/residency preview, per-action approval and loop-prevention/
  idempotency evidence;
- explicit conflict/`UnknownOutcome` resolution comparing both values and their
  provenance; no blind last-write-wins control;
- polling/webhook status, retry/reconcile and imported-update approval while
  internal triage/containment controls remain available during provider outage.

Verification:

- stale/conflicting local/remote edit, duplicate/loop, unknown outcome, provider
  outage/schema drift and field-authority policy change;
- redaction/attachment leakage, malicious remote content, cross-tenant link and
  UI attempt to make external state authoritative;
- accessible failure/reconciliation exercises, browser security and UI pentest.

Exit criteria: analysts can see and reconcile every sync conflict without silent
overwrite or loss of internal workflow availability.
`v0.404.4 implementation stop reached. Run pentest for this exact commit.`

### v0.404.5 — Threat Hunt Workspace UI

Status: planned

Goal: make formal hunts usable without turning browser state into query,
completeness or promotion authority.

Deliverables:

- hypothesis/scope/owner/lifecycle, execution/checkpoint and coverage views;
- query/result/evidence lineage, sub-hypotheses, notes, peer review and handoff;
- finding/alert/incident/rule-proposal promotion previews using server forms;
- recurring-hunt health, outcome and coverage-gap views.

Verification:

- stale tabs, concurrent analysts, unsafe query/result rendering, compartment
  change and promotion race;
- hidden partial data, cross-tenant evidence and client-authored completeness;
- accessible hunt tabletop, browser security and UI pentest.

Exit criteria: analysts can run complete hunts while the server owns evidence,
coverage and transitions. `v0.404.5 implementation stop reached. Run pentest for
this exact commit.`

### v0.404.6 — Source Onboarding And Data Quality UI

Status: planned

Goal: expose safe sample, mapping, drift, capacity, permission and canary
workflows before source administration is considered complete.

Deliverables:

- onboarding lifecycle and protected sample/redaction views;
- parser/mapping field-lineage, loss, schema-diff and shadow-replay views;
- volume/cardinality/cost/capacity and permission/completeness previews;
- canary/activation/rollback forms plus continuous source-health dashboards.

Verification:

- unsafe sample render, field leak, forged capacity/health, stale activation,
  cross-tenant mapping and rollback conflict;
- representative native/OTLP/cloud/SaaS source onboarding;
- accessibility, browser security and workflow pentest.

Exit criteria: operators can safely onboard and diagnose sources without bypassing
server validation. `v0.404.6 implementation stop reached. Run pentest for this
exact commit.`

### v0.404.7 — Security Data Export Administration UI

Status: planned; disabled by default

Goal: expose opt-in export configuration and outcomes without normalizing egress
or weakening internal-only operation.

Deliverables:

- subscription/scope/schema/recipient/redaction/residency preview and approval;
- cursor, coverage, delivery, receipt, dead-letter, `UnknownOutcome` and reconcile
  views;
- global/tenant disable and air-gap/internal-only evidence;
- migration export manifests and independent verification workflow.

Verification:

- stale policy/recipient, cross-tenant scope, redaction bypass, duplicate submit,
  unknown outcome and malicious sink metadata;
- disabled/no-sink UI and API paths;
- accessibility, egress/privacy and browser pentest.

Exit criteria: every export is visibly optional, scoped and reconcilable.
`v0.404.7 implementation stop reached. Run pentest for this exact commit.`

### v0.404.8 — Detection Content And Effectiveness UI

Status: planned

Goal: make content coverage, quality, debt and update state actionable to
detection engineers and analysts.

Deliverables:

- catalog/package/version/source/ATT&CK strategy and telemetry coverage views;
- tests, simulation, purple-team, production feedback and uncertainty displays;
- owner/review/tuning/suppression debt, quarantine and rollout controls;
- signed update/offline bundle and before/after coverage diffs.

Verification:

- misleading percentages, unknown labels, stale results, unauthorized activation,
  debt hiding and malicious content rendering;
- complete content update/rollback/effectiveness workflows;
- accessibility, browser security and detection-engineering pentest.

Exit criteria: content quality and gaps remain visible and all mutations follow
server review gates. `v0.404.8 implementation stop reached. Run pentest for this
exact commit.`

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

### v0.406.0 — SOC Operational Metric Semantics

Status: planned

Goal: define trustworthy operational measurements before dashboards incentivize
incorrect behavior.

Deliverables:

- canonical detection, awareness, assignment, acknowledgement, containment,
  recovery, resolution, closure and post-analysis timestamps with `TimeTrust`;
- active/waiting/hold/external-dependency and uncertainty interval rules;
- cohort/population/scope, exclusions and revision identity for every metric;
- prohibition on presenting uncertain or incomparable intervals as exact ranks.

Verification:

- clock uncertainty, corrected awareness, reopen/merge/split, waiting/hold abuse
  and missing timestamps;
- gaming by premature acknowledge/resolve/close;
- hand-calculated metric and anti-gaming review.

Exit criteria: each SOC metric states exactly what time, population and uncertainty
it measures. `v0.406.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.406.1 — Alert Queue Workload And Triage Quality Metrics

Status: planned

Goal: measure queue health and analyst workload without turning throughput into
the sole objective.

Deliverables:

- queue age, assignment delay, acknowledgement, SLA, waiting reason, reopen,
  duplicate and disposition distributions;
- workload by queue/team/content/severity with authorization-preserving aggregates;
- noise/tuning debt and source-impairment context;
- minimum cohort/privacy thresholds and no individual productivity ranking by
  default.

Verification:

- reassignment/close/reopen gaming, tiny cohorts, compartment inference and
  duplicated alerts;
- source outage/noise spikes and changing rule versions;
- privacy, fairness and metric correctness review.

Exit criteria: queue metrics expose service health and quality without unsafe
surveillance or incentives. `v0.406.1 implementation stop reached. Run pentest
for this exact commit.`

### v0.406.2 — Incident Response And Corrective Action Metrics

Status: planned

Goal: measure incident response and improvement outcomes across their distinct
states.

Deliverables:

- time-to-declare/contain/recover/resolve/close/post-analysis intervals;
- severity change, reopen, obligation lateness, external wait and exception rates;
- corrective-action ownership, overdue, effectiveness and recurrence metrics;
- per-framework/source/topology context without collapsing obligations.

Verification:

- merge/split/reopen, corrected awareness, late evidence, exception abuse and
  external-provider outage;
- regulatory deadline versus internal SLA confusion;
- tabletop metric reproduction and privacy review.

Exit criteria: response metrics preserve incident/obligation semantics and never
reward premature closure. `v0.406.2 implementation stop reached. Run pentest for
this exact commit.`

### v0.406.3 — SOC Metric Dashboard Export And Governance Gate

Status: planned

Goal: expose governed operational metrics with exact definitions, access and
change history.

Deliverables:

- versioned dashboards/reports and metric-definition registry;
- drill-down to source records where authorized, with aggregate privacy controls;
- threshold/SLO alerting, scheduled reports and signed export;
- owner/review/change/retirement lifecycle and interpretation guidance.

Verification:

- definition drift, stale dashboards, aggregate inference, unauthorized drill-
  down and misleading comparison;
- historical regeneration after metric revision;
- independent analytics, privacy and dashboard pentest.

Exit criteria: SOC measurements are reproducible governed evidence, not mutable
dashboard formulas. `v0.406.3 implementation stop reached. Run pentest for this
exact commit.`

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
- isolated worker process/OS sandbox and evidence-only handles;
- optional framework suggestions or document formatting are visibly
  non-authoritative; only `v0.344.3` declarative IR can create an assessment,
  obligation, deadline or legal/reporting determination.

Verification:

- malformed module/component, capability forgery, escape and confused deputy;
- fuel/memory/output/host-call exhaustion, cancellation and worker crash;
- suggestion/result substitution, forged assessment/obligation, package-engine
  delegation and disable-path tests while native incident handling continues;
- differential sandbox review and independent Wasm-host pentest.

Exit criteria: the Wasm runtime is defense-in-depth, bounded and read-only, and
cannot become authoritative framework logic in 1.0.
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
- every pending/unknown/reconciliation/verification/compensation/delayed state
  registers its minimum live anti-replay epoch with the `v0.44.10` advance
  barrier and unregisters only at a durable terminal/spent transition;
- immutable execution audit and deterministic dry-run plan.

Verification:

- exhaustive small-workflow transitions and crash/retry/cancel at every state;
- duplicate delivery, stale approval, timeout and compensation failures;
- epoch advance with an older live state, missing registry entry or crash between
  terminal transition and spent-key publication;
- workflow fuzz/model checking and replay.

Exit criteria: no workflow step executes from an invalid or unaudited state.
`v0.430.0 implementation stop reached. Run pentest for this exact commit.`

### v0.430.1 — CACAO 2.0 Playbook Data Model And Parser

Status: planned

Goal: admit portable signed playbook interchange without granting imported
content execution authority.

Deliverables:

- pinned OASIS CACAO Security Playbooks `2.0` schema/taxonomy/source/license;
- bounded model/parser for playbooks, steps, commands, agents, targets,
  extensions, markings and signatures;
- exact supported object/property/extension matrix and unknown-critical handling;
- package provenance and no-activation-on-import rule.

Verification:

- official examples/schema, malformed graph, cycles, deep/wide objects, signature
  substitution and malicious extensions;
- allocation limits, canonicalization and fuzzing;
- licensing and parser pentest.

Exit criteria: CACAO content is bounded and inert until validated and approved.
`v0.430.1 implementation stop reached. Run pentest for this exact commit.`

### v0.430.2 — CACAO Import Translation And Semantic-Loss Review

Status: planned

Goal: translate admitted CACAO workflows into Vakaheim proposals with every
authority or semantic mismatch explicit.

Deliverables:

- object/step/condition/variable/command/target/marking mapping report;
- unsupported/lossy/stricter Vakaheim safety semantics and required human edits;
- capability, secret, approval, idempotency and compensation gaps;
- translated package tests, simulation and exact source linkage.

Verification:

- unsafe command/target, missing approval/compensation, extension ambiguity,
  data-marking conflict and variable injection;
- imported-versus-native dry-run differences;
- hostile playbook and semantic-review pentest.

Exit criteria: imported CACAO playbooks cannot bypass Vakaheim's action model.
`v0.430.2 implementation stop reached. Run pentest for this exact commit.`

### v0.430.3 — CACAO Export Conformance And Closure Gate

Status: planned

Goal: export portable playbooks where semantics fit and disclose every non-
portable Vakaheim control.

Deliverables:

- canonical signed CACAO export with markings, extensions and source package;
- export report for omitted/approximated/non-portable capabilities;
- import-export round-trip subset and current/previous version behavior;
- conformance, support and limitation documentation.

Verification:

- signature/marking loss, extension collision, round-trip drift and downgrade;
- external consumer examples and disabled interoperability mode;
- independent CACAO interoperability and exact-commit pentest.

Exit criteria: CACAO interchange is exact where claimed and cannot weaken native
safety. `v0.430.3 implementation stop reached. Run pentest for this exact
commit.`

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
  providers without reliable idempotency keys;
- `v0.44.10` live-epoch registration for dispatch, `UnknownOutcome`, manual/
  automatic reconciliation and compensation, blocking fence advancement until
  durable terminal/spent proof.

Verification:

- crash or partition before/after every send, provider apply and response write;
- stale worker, duplicate dispatch, idempotency collision/expiry, unverifiable
  target and provider lying/timeout;
- attempted fence advance/GC while any older action state remains live or its
  provider outcome is unknown;
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

### v0.450.2 — OpenC2 2.0 Language And Message Profile

Status: planned

Goal: parse and represent portable cyber-defense commands without granting them
execution authority.

Deliverables:

- pinned OASIS OpenC2 Language Specification `2.0` source/schema/license;
- bounded action/target/args/actuator/profile/status/request/response model;
- canonical identity, producer/consumer authentication and replay protection;
- exact supported language/profile matrix and inert-on-import behavior.

Verification:

- malformed/oversized messages, unknown action/target, extension collision,
  replay and identity spoof;
- canonical vectors, fuzzing and unsupported-profile rejection;
- protocol/parser pentest.

Exit criteria: an OpenC2 message is only an authenticated proposal until ordinary
Vakaheim policy approves an exact effect plan. `v0.450.2 implementation stop
reached. Run pentest for this exact commit.`

### v0.450.3 — OpenC2 Action And Outcome Translation

Status: planned

Goal: map admitted OpenC2 profiles to narrow Vakaheim actions and outcomes with
all semantic differences visible.

Deliverables:

- action/target/argument-to-native profile mappings and unsupported/loss report;
- exact target/precondition/effect/approval/idempotency/verification binding;
- response/status mapping preserving `UnknownOutcome` and compensation state;
- no mapping to arbitrary command execution.

Verification:

- target ambiguity/reuse, stale command, action widening, missing approval,
  status confusion and unknown-outcome collapse;
- native/OpenC2 simulation comparisons;
- hostile command and translation pentest.

Exit criteria: OpenC2 interoperability cannot broaden native action capability or
outcome truth. `v0.450.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.450.4 — OpenC2 Conformance And Closure Gate

Status: planned

Goal: close the admitted OpenC2 profile set across transport, execution and
reconciliation.

Deliverables:

- supported actuator/profile/version matrix and conformance corpus;
- current/previous message compatibility and signed interoperability evidence;
- disabled mode and no-provider/no-action behavior;
- documentation separating language support from actuator/provider support.

Verification:

- representative producer/consumer exchange, duplicate/replay/outage and schema
  migration;
- implied actuator/provider claim scans and disabled behavior;
- independent OpenC2 interoperability and exact-commit pentest.

Exit criteria: OpenC2 support is profile-exact and retains every native safety
gate. `v0.450.4 implementation stop reached. Run pentest for this exact commit.`

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

### v0.453.3 — ServiceNow Incident Action Activation

Status: planned

Goal: activate narrowly typed ServiceNow writes over the proven provider,
external-link and action ledgers.

Deliverables:

- create incident, update allowed severity/assignment/status fields, add comment,
  attach approved redacted evidence/report package and resolve/close actions;
- exact `v0.305.2` schema capability, `v0.376.2` link/field-authority map and
  `v0.447.0` idempotency/unknown-outcome binding per action;
- link-back to Vakaheim, correlation/loop token, expected remote version,
  precondition snapshot and post-action verification;
- dry-run, per-action automatic/human/two-person policy, residency/redaction/
  attachment custody and egress controls;
- internal incident remains authoritative by default and provider outage never
  blocks local triage, containment, evidence or closure decisions.

Verification:

- every action under wrong table/field/record/version, duplicate retry, timeout,
  rate limit, eventual consistency and provider apply-with-lost-response;
- approval/redaction/residency bypass, malicious comment/URL, wrong attachment,
  remote-ID reuse and loop attempt;
- representative live ServiceNow create/update/comment/attachment/resolve/close
  interoperability and independent action pentest.

Exit criteria: each supported ServiceNow write is typed, approved, idempotent and
verified, with uncertain effects remaining `UnknownOutcome`.
`v0.453.3 implementation stop reached. Run pentest for this exact commit.`

### v0.453.4 — ServiceNow Bidirectional Reconciliation And Recovery

Status: planned

Goal: import permitted ServiceNow changes and recover uncertain outcomes without
silent overwrite or synchronization loops.

Deliverables:

- polling/webhook reconciliation over `v0.305.2` with cursor/event identity,
  origin/loop token and durable inbound journal;
- per-field local/remote/shared authority, permitted status/assignment/comment
  imports and explicit conflict objects; blind last-write-wins prohibited;
- last synchronized/confirmed remote versions, unknown-outcome verification,
  replay-safe retry and manual resolution preserving both sides' provenance;
- schema/profile migration, remote deletion/reopen handling, link repair and
  health/impairment facts;
- approved imported values pass ordinary Vakaheim authorization and incident
  transition rules; remote state cannot bypass closure or regulatory obligations.

Verification:

- simultaneous local/remote edits, out-of-order/duplicate webhook, polling race,
  loop, remote rollback/delete/reopen and schema drift;
- unknown create/update outcome, stale expected version, field-authority change,
  reconciliation crash and provider outage/recovery;
- live bidirectional ServiceNow campaign, journal conservation, conflict non-loss
  proof and independent synchronization pentest.

Exit criteria: ServiceNow and Vakaheim can reconcile supported fields while
conflicts and uncertainty stay explicit and internal handling remains available.
`v0.453.4 implementation stop reached. Run pentest for this exact commit.`

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
  measured boot/remote attestation, plus per-platform hardware/OS monotonic
  anti-replay fence anchoring;
- platform availability, trust anchor, freshness, privacy, recovery, operations,
  zero-third-party feasibility and support-cost analysis;
- admitted routes through `v0.456.2`–`v0.456.4`; rejected routes require tested
  non-goals at `v0.456.5` and remain `Unverifiable` where appropriate;
- rejecting `HardwareMonotonic` never removes the mandatory `v0.44.10`
  `ExternalWitnessed` baseline or effect-disable behavior when unverifiable.

Verification:

- signed decision/owner for each option and exact admitted platforms/assurance;
- challenge self-measurement, compromised-process, replay and downgrade claims;
- counter rollback/reset/reprovision and attempts to label a file/ordinary
  keystore value as hardware monotonic;
- reject any plan that converts an unavailable/untrusted report into healthy.

Exit criteria: all three optional assurance capabilities are admitted with
bounded platform scope or explicitly rejected for 1.0 without weakening the
external-witness baseline. `v0.456.0 implementation stop reached. Run pentest for
this exact commit.`

### v0.456.1 — Node Measurement Assurance Model

Status: planned

Goal: distinguish software-integrity evidence without implying remote attestation.

Deliverables:

- assurance states for signed-build verification, startup file/config measurement,
  privileged/OS-backed runtime measurement, hardware measured boot/remote
  attestation and `Unverifiable`;
- evidence issuer, target build/config, freshness, nonce, trust, policy and
  limitation fields with monotonic non-upgrade rules;
- separate `v0.44.10` fence-anchor assurance dimension: node measurement or
  attestation never implies rollback prevention; only counter/witness evidence
  can yield `HardwareMonotonic`/`ExternalWitnessed`, otherwise `Unverifiable`;
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
- capability discovery, freshness, failure and unsupported-platform semantics;
- if separately admitted, OS monotonic-counter adapter with authenticated
  counter identity/value, reset/reprovision state and `v0.44.10` binding.

Verification:

- compromised/unavailable helper, process replacement, stale PID/image and TOCTOU;
- forged/replayed evidence, permission loss and platform update matrix;
- counter rollback/reset/reprovision, cloned host and fallback-to-file downgrade;
- no-third-party feasibility and privileged-boundary pentest.

Exit criteria: admitted OS-backed evidence cannot be replaced by process self-
report. `v0.456.2 implementation stop reached. Run pentest for this exact commit.`

### v0.456.3 — Hardware Measured-Boot Evidence Acquisition

Status: conditional on admission at `v0.456.0`

Goal: acquire admitted hardware/firmware-backed boot measurements and identity.

Deliverables:

- supported root-of-trust, boot/event-log and device identity profiles;
- nonce-bound evidence acquisition with firmware/boot-chain/config provenance;
- enrollment, key rotation/revocation, privacy and unavailable-state behavior;
- if separately admitted, hardware monotonic-counter evidence distinct from
  measured-boot evidence, including reset/replacement/reprovision semantics.

Verification:

- replay, cloned identity, stale boot log, reset/reprovision and trust-root change;
- counter/boot-evidence confusion and counter reset masked by valid measured boot;
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

Goal: close all optional node/fence-assurance decisions before server integrity
ships.

Deliverables:

- if admitted: integrate and independently audit the applicable `v0.456.2`–
  `v0.456.4` paths with platform/support boundaries;
- if rejected: explicit 1.0 non-goal, disabled configuration/API/claim paths and
  mandatory `Unverifiable` handling;
- close `HardwareMonotonic` per platform; rejection preserves
  `ExternalWitnessed` and disables effects whenever no current witness exists;
- either path updates cluster admission, operations, SDK/API and documentation.

Verification:

- admitted path: end-to-end evidence, downgrade, outage and real-platform matrix;
- rejected path: configuration/API rejection and support-claim audit;
- self-report can never be promoted to OS-backed or hardware-attested health;
- ordinary local storage/keystore or measured boot alone can never be promoted
  to monotonic anti-replay fence assurance.

Exit criteria: privileged runtime measurement, hardware remote attestation and
hardware/OS monotonic fence anchoring are each implemented within admitted bounds
or conclusively excluded from 1.0 without weakening witnessed fail-closed fencing.
`v0.456.5 implementation stop reached. Run pentest for this exact commit.`

### v0.457.0 — Server And Node Software Integrity Baseline

Status: planned

Goal: give server/node runtimes mandatory signed/startup identity protections
without overstating the optional assurance closed at `v0.456.5`.

Deliverables:

- signed server binary/component/update manifests with build/toolchain identity;
- startup binary/build/configuration digest measurement labeled under `v0.456.1`;
- anti-rollback, incompatible-feature rejection and revoked-build policy;
- label whether each platform prevents rollback or only detects build/config
  inconsistency; this startup control cannot imply a `v0.44.10` monotonic fence;
- explicit impaired/unmeasurable state rather than false healthy integrity;
- optional OS/hardware evidence only through admitted `v0.456.5` paths; ordinary
  process self-measurement never claims remote attestation.

Verification:

- binary/helper/config/manifest substitution, signature confusion and rollback;
- full disk-image/host rollback distinguishes detection from prevention and
  forces effect-fence `Unverifiable` where no current witness/counter remains;
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
- identifier/pseudonym/re-identification specifics delegated to the binding
  `v0.457.2`–`v0.457.5` series;
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

### v0.457.2 — Tenant Identifier And Pseudonym Policy Decision

Status: planned

Goal: bind post-destruction identity semantics before tombstone implementation.

Deliverables:

- permanently non-reusable opaque internal tenant-ID policy;
- class-specific reuse/cooldown/approval policy for human/external domains,
  organization names, account handles and other reassigned identifiers;
- signed stable/rotating/purpose-specific audit-pseudonym decision;
- binding decision permitting narrowly separated re-identification authority or
  forbidding it entirely, including linkage behavior after key expiry/shred.

Verification:

- privacy/security/legal analysis for linkage, collision and reassignment;
- reject policy that requires permanent unnecessary external identifying data;
- reject any reuse path that can revive the destroyed internal ID/key domain.

Exit criteria: internal reuse, external reassignment, pseudonym stability and
re-identification each have one approved pre-1.0 decision. `v0.457.2
implementation stop reached. Run pentest for this exact commit.`

### v0.457.3 — Permanent Tenant Tombstone And External-ID Reassignment

Status: planned

Goal: prevent internal identity resurrection while allowing only approved
external-identifier reassignment.

Deliverables:

- minimal permanent tombstone containing opaque internal ID, destruction epoch
  and non-reusable key-domain identity without names/domains/account handles;
- collision/reuse registry and restore/import checks across backups and regions;
- external-identifier quarantine/cooldown/approval records that expire according
  to `v0.457.2`; reassignment always creates a new opaque internal ID/key domain;
- historical display/disambiguation that cannot merge old/new tenant evidence.

Verification:

- internal ID/key-domain collision, forced import, stale backup and concurrent
  reassignment;
- external domain/org/account reuse before/after policy expiry;
- prove permanent prevention retains no unnecessary external identifying value.

Exit criteria: opaque internal identities never repeat, while permitted human
identifier reuse cannot join old and new authority. `v0.457.3 implementation
stop reached. Run pentest for this exact commit.`

### v0.457.4 — Audit Pseudonym And Re-Identification Lifecycle

Status: planned

Goal: implement the selected audit pseudonym stability and linkage policy.

Deliverables:

- stable/rotating/purpose-specific pseudonym derivation selected at `v0.457.2`;
- separate pseudonym/linkage keys, rotation, expiry, crypto-shred and retained-
  record behavior after linkage becomes unavailable;
- if permitted: independently authorized re-identification vault, purpose,
  approval, expiry and immutable audit; if forbidden: no linkage/API/key path;
- pseudonyms remain data labels only and cannot address, authenticate or authorize.

Verification:

- cross-purpose correlation, rotation boundary, key expiry/loss/shred and restore;
- unauthorized re-identification, linkage-vault compromise and inference attacks;
- forbidden-path API/config rejection or permitted-path separation/pentest.

Exit criteria: audit linkage matches the approved policy, and loss or use of
linkage authority cannot restore tenant authority. `v0.457.4 implementation stop
reached. Run pentest for this exact commit.`

### v0.457.5 — Post-Destruction Identifier Semantics Closure

Status: planned

Goal: close identifier reuse and audit-linkage decisions before all-plane testing.

Deliverables:

- integrated `v0.457.1`–`v0.457.4` retention, tombstone and pseudonym contract;
- support/non-goal documentation for re-identification and each external-ID class;
- migration/upgrade/backup representation and SDK/API/audit semantics.

Verification:

- policy/implementation/claim trace, malformed legacy identity and downgrade;
- destroyed-to-reassigned identifier end-to-end trace with no authority merge;
- independent privacy, audit, identity and resurrection pentest.

Exit criteria: every post-destruction identifier is permanently forbidden,
policy-reassignable or policy-pseudonymized with no undecided behavior. `v0.457.5
implementation stop reached. Run pentest for this exact commit.`

### v0.458.0 — Single-Node Tenant Lifecycle Integration Gate

Status: planned

Goal: prove `v0.17.1` across every completed local product plane before clustering.

Deliverables:

- suspend/read-only/quarantine/hold/offboard/destroy propagation through sessions,
  agents, connectors, ingest, storage, queries, detection, cases, reports, jobs,
  actions, caches, exports, keys and backups, including framework activations,
  assessments, obligations/submissions and external synchronization links;
- all-plane lifecycle conformance harness and transition/denial evidence;
- restore/resurrection, tenant-ID/key-domain tombstone and deletion-proof audit;
- `v0.457.5` disposition across local audit, vault remnants, notification
  delivery and action receipts with retained evidence unable to restore authority.

Verification:

- transition at every queued/running/checkpointed/cached/exported state;
- stale tokens/agents/jobs/actions/caches, concurrent hold/offboard/destroy and
  restore from every local backup/cold/spill class;
- retained/pseudonymized audit access, expiry and non-reactivation tests;
- retained obligation/report/receipt policy and package/external-link cleanup
  cannot reactivate tenant authority or leak another tenant's assessment data;
- external identifier reassignment, pseudonym rotation/shred and any admitted
  re-identification authority under `v0.457.2` decisions;
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
  incident graphs, framework activations/bindings, assessments, obligations,
  report/submission/external-sync journals, export subscriptions/cursors,
  hunts/collaboration, content rollout/effectiveness/debt, SOC metric revisions,
  source-onboarding state, playbooks/actions/approvals, live-query leases and
  saved queries;
- human sessions/WebAuthn credentials/revocations/elevation, notification
  outbox/delivery, acquisition/custody, backfill/reprocessing, API idempotency,
  audit records and audit cursors;
- allowed/revoked build identity, `v0.456.1` assurance level, node measurement,
  admission, drain and quarantine state from `v0.457.0`;
- durable scheduler jobs for cold rehydration, backup/restore, repair/reindex,
  rule/content rollout and validation, recurring/retro hunt, risk recompute,
  report/export, certificate/key renewal, tenant offboarding and playbook wait/
  compensation, including classes whose RPO is rebuild from immutable evidence;
- authority, partition key, consistency, fencing, replication, RPO, RTO,
  backup/restore, migration and loss/impairment semantics per class;
- explicit routing decision separating control metadata, immutable evidence and
  high-volume mutable operational state.

Verification:

- architecture/tabletop review for crash, partition, stale owner, corruption,
  failover, region loss and restore per state class;
- reject undefined RPO/RTO or accidental metadata-log placement;
- cross-state transaction and irreversible-loss analysis, including atomic alert
  promotion, hunt promotion, content activation and report/submission/external-
  sync/export unknown outcomes.

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
- explicit 1.0 non-goal for Byzantine or cryptographically proven truth from a
  compromised query/ingest/data-plane backend; signatures authenticate claims;
- containment, key rotation, membership recovery and operator trust boundaries.

Verification:

- architecture review against partitions, crash, disk, clock and key compromise;
- claim audit for malicious backend results/acknowledgements and assurance limits;
- CFT/BFT claim audit and misuse/operational tabletop;
- decision record approved before implementation.

Exit criteria: no documentation or API implies Byzantine safety or backend truth
from authenticated CFT, signatures or node-attestation evidence. `v0.462.0
implementation stop reached. Run pentest for this exact commit.`

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
  migration, RPO/RTO and impairment interfaces;
- monotonic cluster anti-replay fence register in a dedicated control/anchor
  group, excluded from ordinary workload snapshots and exposing signed witness
  checkpoints for independent audit/operator comparison; this group is
  replicated operational state and cannot itself claim `ExternalWitnessed`.

Verification:

- implementation/model trace comparison under deterministic network schedules;
- concurrent/stale writes, leader/owner loss, partition, duplicate/reorder,
  snapshot/compaction race, watch gap, restore and tenant isolation;
- workload-snapshot restore cannot lower the anchor-group fence; whole-cluster
  restore behind an external witness becomes `Unverifiable` rather than current;
- rollback every anchor-group member, snapshot and recovery credential together
  while an independent witness remains ahead; the group cannot authorize effects;
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
- `v0.457.5` tenant-destruction disposition for delivery records and external
  action receipts, retaining no routable tenant authority;
- fenced ownership, progress/custody checkpoints, retry/unknown-outcome and
  per-class RPO/RTO;
- replicated minimum-live effect epochs for notification/delivery state, feeding
  the `v0.44.10` cluster advance barrier before tombstone GC/fence advancement.

Verification:

- failover at every job checkpoint, acquisition custody step, notification send
  and API side effect;
- stale worker, duplicate retry, unknown outcome, cancellation and restore;
- fence advance while an older delivery/unknown/dead-letter state exists on any
  owner, replica or backup;
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
- independently signed witness chain for `v0.44.10` anti-replay fence epochs,
  retained outside operational-state/workload snapshot and restore authority;
- independently deployed audit consensus groups with separate administrative,
  scheduler, storage and failure domains from operational state, plus separate
  signing keys and consensus/recovery credentials;
- witness authority-class inventory proving the audit witness shares none of the
  protected workload's snapshot/restore, storage-failure, administrative,
  signing-key or consensus/recovery domains;
- current signed `WitnessDispatchPermit` service binding exact witness record
  digest/epoch/identity/authority class and `TimeTrust` lease interval without
  joining the operational effect authority;
- witness-signer successor chain and status history implementing the `v0.44.10`
  old/new identity, minimum-epoch, quorum-authorization, compromise/revocation
  and historical-verification contract;
- append sequencing, remote placement, acknowledgement, gap and retention RPO/
  RTO while preserving independent writer/reader roles;
- `v0.457.5` retained/pseudonymized tenant identity, separate audit key domains,
  legal/statutory hold precedence and post-destruction access/expiry policy;
- independent audit replicas participate explicitly in retention, crypto-shred
  and deletion proofs without joining tenant authority;
- failover/restore verification and explicit unavailable-audit behavior.

Verification:

- writer/admin/replica failure, partition, omission, reorder, duplicate, stale
  cursor, full destination and restore;
- compromised operational authority cannot alter replicated audit history;
- missing/conflicting fence checkpoint, operational rollback and attempted audit-
  witness rollback/fork;
- common-mode attempt to roll back every operational consensus member, workload
  snapshot, administrator and recovery credential while the audit witness stays
  ahead; restored operations remain read-only;
- expired permit, stale/offline interval, authority-class confusion and shared-
  domain misclassification;
- signer rotation during audit failover, revoked/compromised signer attempting a
  new permit or reuse of an existing permit after status change, conflicting old/
  new successors, fork/lower-epoch replacement and historical verification
  before/after compromise discovery;
- loss/compromise of the operational-state cluster does not remove the audit
  replica set or its recovery authority;
- tenant destruction cannot erase required retained audit, reactivate authority
  through it or leave an undeclared independently replicated copy;
- offline sequence/signature comparison after failover.

Exit criteria: audit HA increases availability while remaining outside all five
required authority/failure domains and never merging audit with operational
effect authority. `v0.467.3 implementation stop reached. Run pentest for this
exact commit.`

### v0.467.4 — Durable Scheduler HA Adapter

Status: planned

Goal: fail over `v0.44.1`–`v0.44.10` scheduler state/dispatch semantics through
the replicated operational-state engine without duplicate authority.

Deliverables:

- `v0.44.2` job/trigger/checkpoint store adapter over `v0.465.3` with fencing
  epochs and leases;
- partition/tenant placement, failover, snapshot/restore and watch-driven worker
  dispatch;
- preservation of monotonic-versus-wall schedule, misfire/catch-up/skip,
  cancellation, dependency and idempotency semantics;
- HA `HandoffPending`/outbox durability protocol preserving the complete
  `v0.44.4` authority-domain/consumer/job/ordinal/logical-ledger `HandoffKey`,
  with linearizable `put_if_absent`, `v0.44.8` single-writer generation fencing,
  validated routing/commit-epoch receipt and one `v0.467.2` outbox record across
  owner/leader or ledger-generation failover;
- replicated `v0.44.9` spent-key commitments, coordinated replay-horizon GC and
  monotonic minimum-accepted anti-replay epoch in the `v0.465.3` anchor group,
  checked against the `v0.467.3` independent witness or operator-quorum record;
- `v0.44.10` assurance gate: current `ExternalWitnessed` (or later admitted
  `HardwareMonotonic`) permits dispatch; missing/conflicting/behind evidence is
  `Unverifiable` and permits read-only recovery/reconciliation only;
- dispatch authorization consumes a `v0.44.10` permit for the exact witness
  digest/epoch/identity/authority class and requires both its signed `TimeTrust`
  lease and the consumer effect class's maximum offline/stale interval to hold;
  expiry or witness disagreement deterministically becomes `Unverifiable`;
- lease admission uses the full `v0.4.4` uncertainty interval and current
  `v0.467.3` signer-successor/status chain; clock discontinuity or any unresolved
  old/new signer conflict disables dispatch rather than choosing a local winner;
- same handoff key/different digest integrity incident and the `v0.44.4`
  cancellation precedence preserved across separate replicated state groups;
- per-job-class RPO/RTO and rebuild-from-immutable-evidence option where declared.

Verification:

- owner loss/partition/clock change at every claim/checkpoint/complete boundary;
- failover at each scheduler-intent/outbox-durable/HandedOff boundary and
  cancellation after handoff;
- leader change between put-if-absent and receipt validation, receipt replay and
  conflicting digest;
- cross-authority-domain/consumer/logical-ledger collision, tenant destruction/
  ID reassignment, system-domain isolation and destination-ledger migration/split
  during owner or leader failover;
- restore an operational-state snapshot older than outbox/dedup/tombstone cleanup
  and prove the replicated replay fence still rejects its intents;
- whole-cluster restore behind the independent witness, missing/conflicting
  witness, anchor-group rollback and attempted fresh epoch initialization;
- co-rollback every operational member and snapshot while `v0.467.3` remains
  ahead, plus exact-permit substitution, lease expiry and different effect-class
  offline/stale limits;
- forward/backward time jumps, reboot without monotonic continuity, source loss,
  excessive uncertainty and signer rotation/compromise at every dispatch edge;
- epoch advance is rejected while any node/partition/backup can retain older
  pending/unknown/reconciliation/compensation/delayed effect state;
- stale worker, duplicate dispatch, lease expiry, dependency storm, restore and
  tenant/noisy-neighbor failures;
- local/HA scheduler state-machine equivalence and canonical idempotent outcomes.

Exit criteria: scheduled work survives failover within declared RPO/RTO without
exactly-once claims or concurrent unfenced owners, and effect dispatch remains
disabled whenever the current cluster fence cannot be independently verified.
`v0.467.4 implementation stop reached. Run pentest for this exact commit.`

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

### v0.468.1 — Framework Binding Assessment Obligation And Deadline HA

Status: planned

Goal: replicate framework state and regulatory clocks without changing package
decisions or moving deadlines during failover.

Deliverables:

- operational-state adapters for tenant package-set activation, incident package
  pins, assessments/reassessments, overrides, obligations and escalation state;
- fenced ownership, optimistic versions, immutable package/input references,
  scheduler checkpoints and per-class RPO/RTO;
- replicated earliest source timestamps and computed deadline/uncertainty records;
  failover cannot recalculate from a later clock or collapse independent packs;
- restore/rebuild from package registry, incident journal and immutable audit
  evidence with explicit unavailable package/time states.

Verification:

- failover during activate/disable/migrate/evaluate/override/obligation transition
  and exact deadline warning/overdue boundary;
- stale owner, partition, package registry outage, clock uncertainty, merge/split/
  reopen and restore older than current assessment;
- state-machine equivalence proving no duplicate/lost assessment or obligation and
  no deadline moves forward under HA recovery.

Exit criteria: framework and obligation state meets declared RPO/RTO without
changing deterministic outcomes, clocks or audit lineage.
`v0.468.1 implementation stop reached. Run pentest for this exact commit.`

### v0.468.2 — Report Submission And External Synchronization Journal HA

Status: planned

Goal: fail over regulatory reporting and external-ticket synchronization without
duplicating effects or losing conflicts/receipts.

Deliverables:

- replicated report version/approval, submission outbox/inbox/receipt/correction
  and external link/sync journal adapters over `v0.465.3`;
- fenced workers, idempotency/correlation/loop tokens, remote expected versions,
  `UnknownOutcome`, conflict and reconciliation state;
- exact payload/attachment digest, redaction/residency policy, field-authority map
  and immutable audit/custody references;
- per-class RPO/RTO and minimum-live anti-replay epochs feeding `v0.44.10` until
  every submission/sync outcome is terminal or reconciled.

Verification:

- leader/owner loss before/after send/remote apply/receipt/import/conflict persist,
  stale worker and partition;
- duplicate submission/ServiceNow action, lost receipt, webhook/poll replay,
  provider outage, schema change and concurrent manual reconciliation;
- conservation/model proof for payload-to-receipt-or-unknown and local/remote
  values through failover, restore and region loss.

Exit criteria: HA cannot turn an uncertain external effect into success/retry,
erase a synchronization conflict or lose an exact report/receipt chain.
`v0.468.2 implementation stop reached. Run pentest for this exact commit.`

### v0.468.3 — Export Subscription And Portability State HA

Status: planned

Goal: fail over optional export without duplicates, cursor rollback, policy bypass
or accidental egress activation.

Deliverables:

- replicated export definitions, expected-set snapshots, cursors, outbox/receipt,
  dead-letter, `UnknownOutcome` and reconciliation state;
- fenced workers, idempotency and anti-replay minimum-live epochs;
- policy/redaction/residency/recipient versions and global/tenant disable state;
- per-class RPO/RTO and internal-only recovery behavior.

Verification:

- failover before/after select/send/receipt/checkpoint, duplicate sink effects,
  stale policy/recipient and cursor rollback;
- restore cannot enable disabled/no-sink egress;
- conservation, chaos and export-HA pentest.

Exit criteria: HA preserves opt-in egress, exact scope and explicit uncertainty.
`v0.468.3 implementation stop reached. Run pentest for this exact commit.`

### v0.468.4 — Hunt Content Effectiveness And SOC Metric HA

Status: planned

Goal: replicate collaborative security-program state without changing evidence,
coverage or measurement semantics.

Deliverables:

- hunt lifecycle/execution/checkpoint/collaboration and recurring schedule state;
- content rollout/revocation/validation/effectiveness/debt state;
- metric definitions/materializations with source record and revision identity;
- fenced ownership, RPO/RTO, rebuild and stale-result invalidation.

Verification:

- failover during hunt query/promotion, content update/test/quarantine and metric
  recomputation;
- duplicate promotion, lost debt, stale validation and changed metric result;
- state-machine equivalence and HA pentest.

Exit criteria: failover cannot fabricate hunt conclusions, content quality or
SOC measurements. `v0.468.4 implementation stop reached. Run pentest for this
exact commit.`

### v0.469.0 — Playbook And Action State HA

Status: planned

Goal: fail over approvals, playbooks and external-effect ledgers without
duplicating or forgetting side effects.

Deliverables:

- playbook/action/approval/outbox adapters over `v0.465.3`;
- replicated playbook state, approvals, outbox/inbox and idempotency ledger;
- fenced worker recovery and `UnknownOutcome` reconciliation after owner loss;
- RPO/RTO and durable linkage to action envelopes, verification and audit;
- replicated minimum-live epochs for every pending/unknown/reconciliation/
  compensation state, blocking `v0.44.10` fence advancement until terminal/spent.

Verification:

- failover before/after dispatch/provider apply/receipt/verification;
- stale worker, duplicate send, approval race, compensation and region partition;
- fence advance/GC with an older live effect state on a failed owner or replica;
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

### v0.470.1 — Cluster Ingestion Acknowledgement Extension

Status: planned

Goal: extend the canonical local acknowledgement envelope with the exact
cluster context required for a future quorum-durability claim.

Deliverables:

- versioned extension of `v0.31.1`, retaining its payload/request,
  source/session/sequence, receipt and durability-vector bindings;
- write-shard, placement and quorum epochs, commit-index field, participating
  durability components and the claimed failure envelope;
- backend signer/key epoch and `v0.456.1` node-assurance evidence digest, under
  the `v0.31.2` replay/retention/historical-verification lifecycle;
- capability/state rule that the extension is parseable and testable here but
  leaves the `DurableQuorum` permit unavailable until `v0.471.0` active
  replication proves it.

Verification:

- payload/request substitution, acknowledgement replay, source/session swap and
  digest conflict inherited from the local envelope suite;
- stale/wrong shard, placement/quorum epoch, commit index, signer rotation and
  assurance downgrade;
- crash before/after commit/manifest emission and proxy-forwarding conformance;
- mixed local/cluster envelope and unsupported-extension downgrade tests;
- claim audit: authentication does not prove a compromised backend truthful.

Exit criteria: the canonical acknowledgement format can identify exactly what
would be quorum committed, in which cluster state and by whom, but cannot claim
that state before replication proves it. `v0.470.1 implementation stop reached.
Run pentest for this exact commit.`

### v0.471.0 — Active-Write Replication And Quorum Acknowledgement

Status: planned

Goal: make low-latency `DurableQuorum` truthful for unsealed WAL and hot batches.

Deliverables:

- write-shard leader/ownership epoch, fenced writers and replicated WAL/hot-
  batch records;
- raw-object chunks/manifests and mapping/provenance records required by each hot
  batch, preserving atomic fact/reference/object publication;
- source/session/sequence deduplication, quorum commit index and stable-media
  acknowledgement mapping into the `v0.470.1` cluster envelope;
- quorum durable-state verifier that issues a `v0.31.4` `DurableQuorum` permit
  only per vector component whose exact covered commit range and documented
  failure envelope verify;
- crash/re-election recovery, divergent-tail truncation and handoff to immutable
  segment replication.

Verification:

- leader crash/partition before and after local/remote write/fsync/ack;
- crash before/after quorum-state verification and permit issuance for every
  independently claimed vector component/range;
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
  operational state and per-tenant key domains, including framework package-set
  activation, assessments, obligations, reports/submissions and external links;
- hold/export precedence, distributed crypto-shred/deletion proof and permanent
  tenant-ID/key-domain tombstone;
- recovery/failover rules that cannot revive suspended/offboarding/destroyed
  authority from stale replicas or backups;
- `v0.457.5` disposition for credential-vault remnants, notification records,
  external action receipts and separately keyed independent audit replicas;
- legal-hold/statutory-retention precedence and opaque permanent
  non-authority tombstones across regions;
- shared conformance suite proving local and distributed lifecycle outcomes do
  not diverge.

Verification:

- partition/region outage during activate/suspend/hold/offboard/destroy;
- stale session/agent/job/cache/action, failover, restore and rolling upgrade;
- deletion/shred proof across replicas, cold tiers, backup, spill and operational
  state plus independent audit replicas and tenant-ID/key reuse attacks;
- package/assessment/report/external-sync state cannot leak across tenant
  lifecycle, and retained legal obligations/receipts convey no tenant authority;
- retained audit/remnant access cannot mint credentials, address notifications,
  invoke actions or restore tenant/session identity;
- external identifier reassignment always creates a new internal tenant/key
  domain and obeys pseudonym/re-identification policy across regions;
- single-node/distributed trace equivalence for every lifecycle transition.

Exit criteria: tenant lifecycle state and denial propagate within declared bounds,
and destroyed authority/data cannot resurrect. `v0.474.1 implementation stop
reached. Run pentest for this exact commit.`

### v0.474.2 — MSSP Tenant Hierarchy And Delegated Authority Model

Status: conditional on admission at `v0.100.2`

Goal: support managed-security hierarchy without weakening tenant isolation or
making a parent an implicit data owner.

Deliverables:

- provider/organization/customer/tenant relationship and immutable hierarchy
  epochs;
- separately granted management, content, hunt, triage and incident capabilities;
- field/compartment/purpose/residency limits and customer revocation;
- no inherited evidence access without a scoped grant.

Verification:

- parent/child confusion, hierarchy move, provider compromise, customer revoke,
  delegated-admin escalation and cross-customer inference;
- capability attenuation and audit completeness;
- formal authorization review and tenancy pentest.

Exit criteria: MSSP delegation is explicit, revocable and never erases customer
authority. `v0.474.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.474.3 — Cross-Customer SOC Queue And Workflow Isolation

Status: conditional on admission at `v0.100.2`

Goal: let authorized managed analysts work across customers without combining
evidence, metrics or incidents.

Deliverables:

- federated queue metadata with per-item tenant/compartment capability checks;
- tenant-preserving assignment, handoff, escalation and SLA policies;
- no cross-customer bulk evidence/query by default and safe aggregate counts;
- per-customer audit, notification and incident authority.

Verification:

- stale queue authorization, analyst/customer removal, sort/filter side channel,
  wrong-tenant action and bulk export;
- noisy customer fairness and compartment changes;
- multi-customer SOC tabletop and UI/API pentest.

Exit criteria: one analyst experience cannot turn into shared customer data or
authority. `v0.474.3 implementation stop reached. Run pentest for this exact
commit.`

### v0.474.4 — Shared Content With Customer-Specific Policy

Status: conditional on admission at `v0.100.2`

Goal: distribute provider-managed content without sharing customer evidence or
silently overriding local policy.

Deliverables:

- signed provider content channels and customer pin/approve/override/disable;
- provider base plus customer overlays with deterministic precedence;
- aggregate effectiveness only under privacy/minimum-cohort policy;
- per-customer rollout, rollback, coverage and audit evidence.

Verification:

- malicious provider package, customer override loss, cross-customer feedback,
  rollout cohort confusion and revocation;
- content update while provider/customer relationship changes;
- isolation, supply-chain and governance pentest.

Exit criteria: content may be shared; evidence, decisions and private tuning are
not. `v0.474.4 implementation stop reached. Run pentest for this exact commit.`

### v0.474.5 — MSSP Hierarchy HA And Lifecycle Propagation

Status: conditional on admission at `v0.100.2`

Goal: replicate delegation and customer lifecycle without stale cross-customer
authority during failure.

Deliverables:

- hierarchy/delegation epoch replication, fencing, watches and revocation RPO/RTO;
- provider/customer offboarding, transfer and emergency suspension propagation;
- queue/content/session cache invalidation across nodes/regions;
- audit evidence for every stale-deny/fail-closed decision.

Verification:

- failover during grant/revoke/move/offboard, stale region, partition and restore;
- old provider session/content/queue replay;
- distributed authorization model and chaos pentest.

Exit criteria: failure cannot resurrect provider access or cross-customer state.
`v0.474.5 implementation stop reached. Run pentest for this exact commit.`

### v0.474.6 — MSSP Scope Closure

Status: conditional on `v0.100.2`

Goal: close hierarchical managed-security support before federation expands.

Deliverables:

- admitted integration of `v0.474.2`–`v0.474.5`, or enforced rejection of
  hierarchy/delegation APIs/config/UI;
- exact provider/customer responsibility and support model;
- privacy, residency, audit, incident and exit/portability documentation.

Verification:

- full provider compromise/customer revocation/offboarding tabletop;
- rejection-path and implied-MSSP claim scans;
- independent multi-tenant security assessment and exact-commit pentest.

Exit criteria: MSSP operation is demonstrably isolated or an explicit 1.0 non-
goal. `v0.474.6 implementation stop reached. Run pentest for this exact commit.`

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

### v0.475.1 — Distributed Query Result And Coverage Extension

Status: planned

Goal: extend the canonical local coverage model to authenticated distributed
fragments before distributed physical execution can emit results.

Deliverables:

- versioned extension of `v0.79.1` retaining query/plan, tenant,
  authorization, policy and snapshot epochs;
- expected shard/partition/segment set as a bounded canonical list or a
  `v0.79.2` commitment with algorithm/version, canonical ordering, duplicate
  rejection, element count, catalog generation/root, snapshot, retention and
  cold-catalog watermarks;
- membership/opening verification or the explicitly trusted catalog expander,
  with catalog generation pinned throughout execution;
- every fragment identity, assigned backend and terminal status;
- result digest plus aggregate/checkpoint digests and explicit `Pending`,
  `Complete`, `Partial`, `Unavailable`, `Truncated` and `PolicyLimited` states;
- backend/coordinator signer and key epochs plus `v0.456.1` assurance evidence
  digests, all in a bounded signed encoding.

Verification:

- canonicalization, omission, insertion, duplicate fragment, count and
  set-commitment/opening attacks;
- stale catalog/root/generation, retention/cold watermark, tenant/policy/
  snapshot/plan/signer/assurance epochs and catalog movement during execution;
- trusted-expander compromise/outage and list/commitment equivalence;
- round-trip, malformed, fuzz, scale and mixed-version manifest tests.

Exit criteria: each distributed result package can state exact authoritative
expected coverage and claimant identities before any execution layer may call it
complete. `v0.475.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.476.0 — Distributed Physical Query Execution

Status: planned

Goal: execute federated plans across workers with bounded exchange, coordination
and failure semantics.

Deliverables:

- authenticated fragment distribution and tenant/snapshot/policy-bound exchange;
- repartition/shuffle, partial aggregation, distributed joins and bounded graph
  traversal;
- coordinator/worker memory limits, backpressure, cancellation, retry,
  duplicate-fragment identity, straggler and worker-loss handling;
- every fragment/result uses the `v0.475.1` extension, but execution emits only
  `Pending` or an explicit non-complete terminal state until `v0.476.1`
  reconciliation succeeds.

Verification:

- fragment substitution/replay, stale policy/snapshot, skewed shuffle, coordinator
  exhaustion, worker loss, partition, retry duplicate and straggler;
- distributed/local result and completeness equivalence;
- noisy-tenant fairness, cancellation propagation and cross-worker leakage.

Exit criteria: distributed execution cannot exceed coordinator/tenant authority
or present partial worker results as complete; this stop cannot emit `Complete`.
`v0.476.0 implementation stop reached. Run pentest for this exact commit.`

### v0.476.1 — Distributed Coverage Reconciliation

Status: planned

Goal: derive terminal query state by reconciling the expected coverage manifest.

Deliverables:

- coordinator derivation of expected coverage from authorized plan, snapshot,
  placement and the pinned `v0.475.1` catalog/commitment context;
- terminal fragment ledger and digest/aggregate/checkpoint reconciliation;
- `Complete` only after every expected element has one compatible terminal
  success; all absence, denial, truncation or unavailability selects its explicit
  non-complete state;
- threat-limit statement: manifests stop proxy forgery but signatures/attestation
  do not make a compromised backend truthful under the 1.0 CFT model.

Verification:

- missing/duplicate/replayed fragment, worker loss, retry and topology change;
- commitment opening/element count/catalog generation mismatch and catalog
  movement during execution;
- false-success worker, conflicting digest, stale snapshot/policy and truncated
  stream/aggregate;
- local/distributed result-state equivalence and adversarial coordinator pentest.

Exit criteria: no coordinator or proxy can label unreconciled expected coverage
`Complete`; the remaining compromised-backend limit is explicit. `v0.476.1
implementation stop reached. Run pentest for this exact commit.`

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
- native end-to-end binding of `v0.31.1`/`v0.470.1` acknowledgement envelopes and
  `v0.475.1`/`v0.476.1` query result/coverage manifests, including source/session/
  sequence, snapshot/policy, backend service/build and assurance identity;
- proxy capabilities that cannot forge `DurableQuorum`, widen authority,
  substitute tenant/source, or convert backend failure/partial results to success;
- where OTLP/browser standards terminate at the proxy, explicit proxy membership
  in that protocol's TCB, narrow service identity, authenticated backend hop,
  audit and disclosed claim limits;
- threat-model statement that binding prevents proxy forgery but does not make a
  compromised backend truthful under `v0.462.0` CFT/non-Byzantine limits.

Verification:

- compromised proxy forges ack/completeness/backend identity or swaps tenant;
- replay/substitution across backend, route, session, snapshot and policy epochs;
- acknowledgement/coverage manifest omission, replacement and terminal-state
  laundering;
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
- full disaster runbooks, clean-room bootstrap and recovery verification;
- export signed hardware/external fence evidence and compare restore state with
  the current independent `v0.44.10` witness; backup contents cannot lower it;
- `Unverifiable` read-only recovery plus operator-quorum reconciliation when no
  current non-rollback anchor can be established;
- restored effect dispatch requires a current exact witness permit and applicable
  effect-class stale window plus current signer-successor/status chain, never
  merely a matching cluster-local checkpoint.

Verification:

- stale/partial/corrupt backup, missing key, incompatible version and interrupted
  restore;
- entire cluster/host restored behind the witnessed epoch, replacement-machine
  clone, missing/conflicting witness and attempted fresh epoch initialization;
- restore across signer rotation/compromise discovery cannot revive an old
  permit, choose a conflicting successor or lower the current minimum epoch;
- point-in-time/state-class RPO checks and post-restore authorization/audit;
- independent clean-environment disaster exercise.

Exit criteria: restored state is complete to declared recovery points, and every
unavailable class is explicit; recovery cannot lower the effect fence or dispatch
while its anchor is unverifiable. `v0.481.0 implementation stop reached. Run
pentest for this exact commit.`

### v0.482.0 — Air-Gapped And Sovereign Operations

Status: planned

Goal: operate, update and exchange approved evidence without online trust or
control dependencies.

Deliverables:

- signed offline update, trust, configuration, rule and component bundles;
- policy-aware evidence/import export, transfer custody and replay protection;
- offline freshness/revocation limitations and deterministic re-entry workflow;
- operator-quorum-signed chained anti-replay fence bundle carrying authority/
  consumer epochs and prior digest; import rejects older/forked bundles and can
  never lower a locally current hardware/external witness;
- externally retained quorum record and permit carry witness identity/authority
  class, exact record digest/epoch and signed `TimeTrust` lease; every effect class
  declares its maximum disconnected/stale interval;
- offline signer-successor bundles bind old/new identities and current minimum
  epoch under operator quorum; revoked/compromised keys cannot issue new permits
  or let existing permits authorize new dispatch, and conflicting rotations
  import as `Unverifiable` rather than selecting one;
- missing current fence bundle yields `Unverifiable` read-only operation with
  effect dispatch disabled until authorized reconciliation; lease expiry or the
  class-specific offline limit is never extended from a local clock/assertion.

Verification:

- tampered/stale/replayed bundle, revoked signer, clock uncertainty and partial
  transfer;
- old air-gap fence bundle replay, forked quorum records, removable-media rollback
  and reconciliation after prolonged disconnection;
- permit expiry immediately before/after each effect-class offline limit and
  disagreement between removable-media, local and externally retained records;
- forward/backward local-clock movement, reboot without monotonic continuity,
  signer compromise learned offline and conflicting successor-bundle replay;
- cross-domain policy/redaction/custody and removable-media attacks;
- prolonged disconnected operation and reconnection rehearsal.

Exit criteria: air-gapped operation neither bypasses trust/policy nor claims
fresh online revocation/fence knowledge, and stale/missing fence bundles disable
effects. `v0.482.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.483.0 — Rolling Upgrade And Deterministic Rollback

Status: planned

Goal: upgrade every distributed plane while mixed versions remain safe and
rollback limits are explicit.

Deliverables:

- compatibility matrix, staged/canary order, drain/handoff and feature gates;
- signed server update manifests, allowed-build epoch transitions and anti-rollback;
- `v0.44.7` scheduler-journal/outbox schema compatibility, `v0.44.8` ledger-
  generation fencing/deduplication preservation and `v0.44.9` tombstone/replay-
  fence compatibility and GC order;
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

### v0.485.0 — AI Scope Authority And Threat Constitution

Status: planned

Goal: bind AI monitoring and proposal-only assistance boundaries before any model
is connected to Vakaheim data.

Deliverables:

- separate monitored external AI workloads from Vakaheim's optional assistant;
- proposal-only allowed uses and binding prohibitions on autonomous state change,
  authority, evidence claims, rule activation, incident decisions and actions;
- prompt/context/model/tool/output trust boundaries and AI-specific threat model;
- global/tenant/use-case disable, fail-closed unavailable behavior and non-AI
  feature equivalence.

Verification:

- direct/indirect prompt injection, evidence exfiltration, cross-tenant context,
  false citation and fact/inference confusion;
- attempted authority/tool/action/rule/incident bypass and disabled-mode proof;
- independent AI threat-model, privacy and architecture pentest.

Exit criteria: AI output cannot mutate authoritative state without normal human
gates. `v0.485.0 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.1 — AI Model Provider And Artifact Registry

Status: planned; optional and disabled by default

Goal: make every model/provider/runtime/configuration an attributable reviewed
artifact.

Deliverables:

- model/provider/version/digest/license/source/runtime/quantization identity;
- trust, approval, revocation, capability, context/output and resource limits;
- local/external provider distinction and network/credential capabilities;
- immutable activation epoch and no unpinned model aliases.

Verification:

- model substitution, mutable alias, malicious artifact, license/provenance gap,
  provider drift and rollback;
- wrong tenant/use-case activation and revoked model cache;
- registry supply-chain and model-loading pentest.

Exit criteria: no inference runs without an approved exact model/provider
identity. `v0.485.1 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.2 — Prompt Context Retrieval And Tool Provenance

Status: planned; optional and disabled by default

Goal: bind every AI input and proposed tool use to exact authorized sources.

Deliverables:

- versioned system/developer/user prompt-template digests and parameter identity;
- selected evidence/query/result/retrieval source digests, coverage and redaction;
- context ordering/truncation/token budget and untrusted-content labels;
- proposed tool name/arguments/result lineage with no direct execution capability.

Verification:

- hidden/stale prompt, retrieval poisoning, evidence substitution, truncation,
  cross-tenant context and tool-argument injection;
- citation/result/context consistency;
- provenance model and prompt-boundary pentest.

Exit criteria: each output can be traced to exact prompts, authorized context and
proposed tools. `v0.485.2 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.3 — AI Data Policy Minimization And Retention

Status: planned; optional and disabled by default

Goal: prevent AI assistance from becoming an uncontrolled evidence-copying or
provider-retention path.

Deliverables:

- field/purpose/residency/compartment/legal-hold checks before context selection;
- prompt/output/cache/conversation classification, encryption and retention;
- provider training/retention/region policy and no-send denial;
- deletion, export, audit and subject-request propagation.

Verification:

- secret/PII/classified evidence exfiltration, cache/index leakage, provider
  policy change and deletion/hold conflict;
- inference from aggregates and cross-session/tenant reuse;
- privacy impact assessment and data-lifecycle pentest.

Exit criteria: AI sees and retains only explicitly authorized minimized context.
`v0.485.3 implementation stop reached. Run pentest for this exact commit.`

### v0.485.4 — Indirect Prompt Injection And Content Isolation

Status: planned; optional and disabled by default

Goal: treat all evidence, tickets, intelligence, webhooks and model output as
untrusted instructions.

Deliverables:

- structured context channels separating data from trusted prompt instructions;
- untrusted-content encoding, origin labels and instruction-suppression policy;
- output parser/schema validation and safe rendering;
- canary/secret-leak and forbidden-action detectors that block output use.

Verification:

- direct/indirect/multilingual/encoded injection, poisoned documents, tool-output
  injection, data exfiltration and rendered active content;
- multi-turn persistence and retrieval-store poisoning;
- sustained adversarial corpus and AI boundary pentest.

Exit criteria: untrusted evidence cannot acquire instruction or tool authority.
`v0.485.4 implementation stop reached. Run pentest for this exact commit.`

### v0.485.5 — Grounded Query Explanation And Citation Assistance

Status: planned; optional and disabled by default

Goal: provide summaries/explanations that distinguish source facts, calculated
results and model inference.

Deliverables:

- query/result/coverage-bound summaries with field/evidence citations;
- statement-level fact/inference/unknown labels and unsupported-claim rejection;
- citation verification against authorized immutable source snapshots;
- abstention and missing/partial-data behavior.

Verification:

- false/mismatched citation, unsupported conclusion, partial result, redacted
  evidence and stale snapshot;
- prompt injection and confident fabrication corpus;
- human/domain evaluation and explanation pentest.

Exit criteria: AI prose never masquerades as evidence and every factual claim is
verifiably grounded or rejected. `v0.485.5 implementation stop reached. Run
pentest for this exact commit.`

### v0.485.6 — Query Rule Test And Hunt Drafting Assistance

Status: planned; optional and disabled by default

Goal: draft security artifacts while preserving ordinary parsing, testing,
review and activation gates.

Deliverables:

- VQL, rule/test, hunt-hypothesis and tuning proposal generation;
- schema/telemetry/content/version context and resource-budget preview;
- mandatory compile/validate/simulate/review with model output retained as source;
- no direct save-overwrite, activation or production execution.

Verification:

- injection, unsafe/unbounded query/rule, missing tests, fabricated fields,
  malicious content and direct activation attempts;
- disabled mode and model/provider changes;
- detection-engineer evaluation and drafting pentest.

Exit criteria: AI creates reviewable drafts only; native validators remain the
authority. `v0.485.6 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.7 — Incident Case And Response Suggestion Assistance

Status: planned; optional and disabled by default

Goal: summarize cases and suggest next steps without altering incident,
obligation or action state.

Deliverables:

- evidence-grounded timeline/summary, missing-data and investigation suggestions;
- response/playbook proposals bound to exact targets/preconditions and simulations;
- regulatory content limited to cited package explanations, never legal decisions;
- explicit human approval and ordinary server transition/action forms.

Verification:

- malicious case/evidence text, stale incident state, unsafe response, deadline
  invention and external-ticket injection;
- attempted state/action/obligation mutation and approval bypass;
- incident tabletop and suggestion pentest.

Exit criteria: AI can advise but cannot declare, close, classify, submit or act.
`v0.485.7 implementation stop reached. Run pentest for this exact commit.`

### v0.485.8 — AI Evaluation TEVV And Quality Contract

Status: planned; optional and disabled by default

Goal: evaluate security, grounding and usefulness before a model/use case is
activated.

Deliverables:

- versioned use-case corpora for correctness, citation, abstention, safety,
  privacy, bias, prompt injection and resource behavior;
- exact model/prompt/context/runtime/configuration identity and repeated-run
  distribution;
- minimum thresholds, confidence intervals and unacceptable-failure gates;
- human/domain review with protected test/holdout separation.

Verification:

- benchmark contamination, test leakage, nondeterminism, small/biased samples,
  threshold gaming and evaluation harness compromise;
- adversarial and out-of-distribution corpora;
- independent TEVV methodology and security review.

Exit criteria: each AI use case has reproducible evidence and fails closed below
thresholds. `v0.485.8 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.9 — AI Shadow Canary Upgrade And Drift Lifecycle

Status: planned; optional and disabled by default

Goal: change models/prompts/providers without silent behavior or privacy drift.

Deliverables:

- staged/shadow/canary/active/quarantined/rolled-back lifecycle;
- old/new output, citation, safety, latency, resource and data-policy comparison;
- drift monitors and automatic quarantine thresholds;
- explicit tenant/use-case approval and immutable migration history.

Verification:

- provider/model alias drift, prompt change, degraded grounding, policy/region
  change, rollback and mixed versions;
- canary cohort leakage and stale cache/context;
- historical shadow replay and upgrade pentest.

Exit criteria: AI changes are measured migrations, never transparent provider
updates. `v0.485.9 implementation stop reached. Run pentest for this exact
commit.`

### v0.485.10 — Local AI Runtime Sandbox And Resource Isolation

Status: planned; optional and disabled by default

Goal: run admitted local models outside trusted services with bounded resources
and no ambient capabilities.

Deliverables:

- isolated process/OS sandbox, authenticated IPC and model artifact verification;
- CPU/memory/GPU/time/context/output/concurrency quotas and cancellation;
- no ambient network/filesystem/secrets and evidence-only scoped handles;
- crash, corruption, update and zeroization behavior.

Verification:

- malicious model, parser/runtime exploit, resource exhaustion, cancellation,
  device reset and sandbox escape attempts;
- model/context residue and cross-tenant scheduling;
- runtime hardening and independent sandbox pentest.

Exit criteria: a compromised local model/runtime cannot reach authoritative state
or unrelated data. `v0.485.10 implementation stop reached. Run pentest for this
exact commit.`

### v0.485.11 — External AI Provider Gateway And Unknown Outcomes

Status: planned; optional and disabled by default

Goal: govern optional external inference as an uncertain data-egress operation.

Deliverables:

- named provider admission, exact API/model/region/retention policy and credentials;
- request digest, redaction, idempotency, rate/cost and response provenance;
- timeout/partial/stream interruption, `UnknownOutcome` and reconciliation;
- provider outage/disable cannot block non-AI SIEM workflows.

Verification:

- provider drift, redirect/rebinding, lost response, replay, quota/cost abuse,
  retention-policy change and malicious output;
- cross-tenant credential/context and unknown-outcome retry;
- live provider interoperability and gateway pentest.

Exit criteria: external AI is named, opt-in and never a hidden availability or
egress dependency. `v0.485.11 implementation stop reached. Run pentest for this
exact commit.`

### v0.485.12 — AI Assistance Integration Gate

Status: planned

Goal: integrate proposal-only AI assistance before AI-specific detection content
and final closure.

Deliverables:

- AI telemetry/detection, model/prompt/context/tool/output provenance and use-case
  matrix;
- every model/provider/use case TEVV, shadow/rollback and disable evidence;
- autonomous/authoritative AI as an explicit enforced 1.0 non-goal;
- current NIST AI RMF/GenAI and Cyber AI guidance review with limitations.

Verification:

- end-to-end monitored AI attack and assistant prompt-injection scenarios;
- no-model/no-network/disabled/provider-outage equivalence for core SIEM;
- independent AI red team, privacy assessment and exact-commit pentest.

Exit criteria: assistance is useful where enabled but remains outside the trusted
authority path. `v0.485.12 implementation stop reached. Run pentest for this
exact commit.`

### v0.485.13 — AI Workload Threat Detection Content

Status: planned

Goal: ship first-party detections for monitored AI systems independently from
whether Vakaheim assistance is enabled.

Deliverables:

- prompt-injection, sensitive-context/output, unsafe tool/agent behavior, model/
  prompt/config change, anomalous usage and provider impairment content;
- AI model/prompt/tool/data entities and attack-chain graph analytics;
- exact OCSF/OpenTelemetry AI telemetry prerequisites, gaps and privacy limits;
- tests, tuning, hunts, dashboards and incident runbooks.

Verification:

- benign prompt/tool variation, redacted payloads, missing telemetry, adversarial
  injection/exfiltration and poisoned model/provider metadata;
- deterministic replay, FP/FN evaluation and cross-tenant isolation;
- independent AI-security content review and pentest.

Exit criteria: monitored AI workloads have useful evidence-backed security
content even when Vakaheim AI assistance is disabled. `v0.485.13 implementation
stop reached. Run pentest for this exact commit.`

### v0.485.14 — AI Monitoring And Assistance Closure Gate

Status: planned

Goal: close AI workload monitoring, detection and proposal-only assistance before
privacy and release-hardening phases.

Deliverables:

- final telemetry/detection/model/prompt/context/tool/output/use-case matrix;
- every model/provider/use case TEVV, shadow/rollback and disable evidence;
- autonomous/authoritative AI as an explicit enforced 1.0 non-goal;
- current NIST AI RMF/GenAI and Cyber AI guidance review with limitations.

Verification:

- end-to-end monitored AI attack and assistant prompt-injection scenarios;
- no-model/no-network/disabled/provider-outage equivalence for core SIEM;
- independent AI red team, privacy assessment and exact-commit pentest.

Exit criteria: AI monitoring is useful and assistance is opt-in, while neither
can become trusted authority. `v0.485.14 implementation stop reached. Run pentest
for this exact commit.`

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

- retention evaluation for facts, raw data, indexes, cold tiers, caches, source
  samples, hunt/results, effectiveness/metric records, exports and AI prompts/
  context/outputs;
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

- source/relay/ingest throughput, latency, burst reserve and backpressure across
  logs, traces, metrics, profiles, AI telemetry and named providers;
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

- query, external-lake, dashboard, report, graph, live and cold-rehydration
  latency evidence;
- detection throughput/state, recurring/retro hunt, first-party content
  validation, risk, intelligence-match and effectiveness evidence;
- framework package composition/evaluation/shadow-replay and obligation/report
  generation bounds;
- analyst/API/ServiceNow/export reconciliation, SOC metric and optional local-AI
  concurrency, cancellation, fairness and worst-case cost results.

Verification:

- skew, high cardinality, adversarial query/rule and cold/partial data;
- concurrent ingest/detection/query/report/analyst load and noisy tenants;
- adversarial pack budgets, incident storms, deadline escalations, report versions
  and external-sync conflicts/outages;
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
- framework/obligation/report/submission/external-sync/export/hunt/content/metric
  failover RPO/RTO and duplicate-effect/deadline invariants;
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
- framework manifest/policy IR/localization/migration and regulatory report/
  submission template fuzz campaigns;
- OCSF/Sigma/ATT&CK/OpenTelemetry/industrial protocol/CACAO/OpenC2/content/export
  and AI telemetry format fuzz campaigns;
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
- alert/incident/promotion, framework composition/obligation clocks and report/
  external-sync unknown-outcome state models;
- hunt/promotion, content rollout/effectiveness, export cursor/outcome and MSSP
  delegated-authority state models;
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
- conservation, durability-vector, impairment and recovery evidence bundles;
- full-host/disk-image/whole-cluster rollback and `v0.44.10` hardware/external/
  unverifiable fence-assurance campaigns.

Verification:

- faults at each durable transition and simultaneous dependent failures;
- faults at every alert promotion, package activation/evaluation/migration,
  obligation transition, report submission and ServiceNow sync boundary;
- faults at source activation, content update/validation, hunt promotion, export
  select/send/checkpoint, AI provider/local runtime and MSSP delegation boundaries;
- stale/partial restore, corrupt backup, uncertain clock and operator error;
- replacement-machine clone, old air-gap bundle, missing/conflicting witness,
  counter reset and read-only recovery/reconciliation under effect-disable gates;
- simultaneous rollback of all operational consensus/recovery state while the
  five-domain-independent witness stays ahead, plus lease expiry and effect-class
  maximum-staleness boundary campaigns;
- forward/backward clock jumps, reboot/time-source loss/excess uncertainty and
  witness-signer rotation, revocation, compromise, fork and recovery campaigns;
- independent chaos schedule reproduction and invariant review.

Exit criteria: every promised recovery path survives its declared fault model or
fails visibly within a documented boundary. `v0.600.0 implementation stop
reached. Run pentest for this exact commit.`

### v0.610.0 — Compatibility Upgrade And Reproducibility Verification

Status: planned

Goal: prove compatibility and reproducibility independently from chaos testing.

Deliverables:

- wire/storage/API/CLI/rule/content/hunt/export/schema/SDK/framework-package/
  OCSF/OpenTelemetry/Sigma/ATT&CK/CACAO/OpenC2/report-template/named-provider
  compatibility matrices;
- install, migration, rolling upgrade, rollback and downgrade-boundary evidence;
- reproducible builds, archives, packages, SBOM, provenance and signatures.

Verification:

- every supported version pair and mixed-version topology;
- package pin/shadow migration, obligation/report historical verification and
  external schema/profile upgrade/downgrade;
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
- framework package/evaluator/registry, alert/incident/case, obligation/report/
  submission, ServiceNow synchronization and legal-source limitation scopes;
- first-party content/effectiveness, source onboarding, threat hunts, export,
  SOC metrics, AI monitoring/assistance, industrial protocols and MSSP scopes;
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
- default and multi-pack incident handling, deadline/report/submission exercises
  plus ServiceNow normal/outage/conflict operation;
- first-party content/update/effectiveness, source onboarding, threat-hunt,
  optional export, named-provider, SOC metric and AI enabled/disabled exercises;
- issue telemetry, support bundles, triage and safe feedback procedures.

Verification:

- long-duration operation and real operator/analyst exercises;
- crash, disk pressure, recovery, upgrade and workload-growth rehearsals;
- full alert-to-post-analysis tabletop with NIS2/DORA/GDPR obligation boundaries,
  package migration and report receipt/unknown outcome;
- beta finding capture and exact-commit pentest.

Exit criteria: single-node beta operation exposes no untracked release blocker.
`v0.670.0 implementation stop reached. Run pentest for this exact commit.`

### v0.680.0 — Cluster Public Beta

Status: planned

Goal: operate production-like clustered deployments independently of other betas.

Deliverables:

- supported cluster bootstrap, expansion, repair, evacuation and administration;
- realistic multi-tenant ingest/query/detection/response and scheduled workloads;
- framework/obligation/report/external-sync HA under tenant isolation;
- export/hunt/content/metric HA and admitted MSSP hierarchy isolation;
- failover, observability, support and issue-evidence procedures.

Verification:

- long duration, rolling failure/upgrade, rebalance and noisy-tenant exercises;
- operator error, stale topology, quorum impairment and recovery game days;
- assessment/deadline failover, duplicate submission/ServiceNow prevention and
  cross-tenant package/obligation leakage tests;
- real operator/analyst exercises and cluster beta pentest.

Exit criteria: cluster beta operation exposes no untracked release blocker.
`v0.680.0 implementation stop reached. Run pentest for this exact commit.`

### v0.690.0 — Multi-Region And Air-Gap Public Beta

Status: planned

Goal: beta sovereign multi-region and disconnected operation as distinct modes.

Deliverables:

- multi-region placement/failover/residency beta deployments;
- air-gap install, trust, update, content, backup and transfer workflows;
- disconnected first-party/ATT&CK/framework/AI-model update and no-egress proofs;
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

- operator, security, developer, SDK, detector, threat-hunter, content-author,
  source-onboarding, MSSP and incident-response manuals;
- framework pack author/validator, package-source/limitation, obligation/report/
  submission and ServiceNow field-authority/reconciliation manuals;
- named-provider, OCSF/OpenTelemetry/Sigma/ATT&CK, data export/portability,
  CACAO/OpenC2, SOC metric and AI monitoring/assistance manuals;
- installation, capacity, backup/recovery, upgrade/rollback and failure runbooks;
- security response, support escalation, maintenance and compatibility policies.

Verification:

- clean-room documentation exercises by each intended role;
- broken-link/example/command/version drift and accessibility review;
- official legal/guidance source-link, edition/effective-date and named-provider
  support-matrix freshness review;
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
  skipped intermediate belongs only to an explicitly rejected capability;
- mandatory-prerequisite audit proving five-domain-independent external witness
  profiles, conservative time-uncertainty lease evaluation, signer lifecycle and
  fail-closed lease/staleness handling were not made optional;
- framework/provider audit proving every `v0.344.7` named-pack/national-profile/
  authoritative-Wasm decision and the ServiceNow claim closed at its exact stop.
- modern-SIEM audit proving `v0.100.2` external-lake, DSPM/EASM, OT/ICS, MSSP and
  named-national-profile decisions reached their reserved closure gates;
- mandatory first-party content, current OCSF/OpenTelemetry/ATT&CK/Sigma support,
  hunt/effectiveness/export/onboarding/SOC-metric and AI closure audit.

Verification:

- reject any conditional/TBD option, missing closure, unimplemented support
  decision or undocumented non-goal;
- reject an admitted option with a skipped required series stop or a rejected
  option whose implementation surface remains reachable;
- reject any plan that treats cluster-local consensus as external witnessing or
  defers external-witness authority/freshness/signer-lifecycle policy as a
  post-1.0 option;
- reject implied compliance, unnamed national/framework/provider support,
  authoritative framework Wasm or a skipped admitted pack/ServiceNow stop;
- reject a generic engine with no minimum first-party content, stale ATT&CK/
  schema/rule standards, absent hunt/effectiveness workflows, implicit egress,
  autonomous AI authority or an unresolved extended-scope option;
- scan APIs/configuration/UI/docs for implied or orphaned support claims;
- independent scope-closure and product-claim pentest.

Exit criteria: every option is closed before compatibility freeze begins.
`v0.730.0 implementation stop reached. Run pentest for this exact commit.`

### v0.740.0 — Public API Wire And Format Freeze

Status: planned

Goal: freeze externally observable compatibility surfaces after scope is closed.

Deliverables:

- public API, CLI, wire, storage, rule, framework-package, regulatory-report,
  submission-receipt, external-sync, export, hunt, content/effectiveness,
  OCSF/OpenTelemetry/Sigma/ATT&CK/CACAO/OpenC2, named-provider, AI, schema and
  admitted SDK baselines;
- compatibility manifests, migration guarantees and explicit unstable exclusions;
- change-control rule allowing only security/correctness/release-blocking fixes.

Verification:

- previous-version clients/data/rules/framework packages/reports/receipts/
  synchronization journals/configurations and mixed-version operation;
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
- application packages, approved signed framework packs, regulatory templates,
  first-party content, ATT&CK/schema/semantic-convention fixtures, AI model/
  prompt assets where admitted, conformance corpora, archives, SBOM, provenance,
  checksums and signing procedures;
- installation metadata and publication prohibition for every internal crate.

Verification:

- clean-room byte/checksum reproduction on supported builders;
- archive/application/framework-package secret, signer/trust-chain, internal-
  file, legal-source/template, license and provenance audit;
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
- end-to-end qualification of current OCSF/OpenTelemetry/ATT&CK/Sigma profiles,
  first-party content, source onboarding, hunting, effectiveness measurement,
  data export, SOC metrics, CACAO/OpenC2 and admitted AI boundaries;
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
- Exact admitted OCSF and OpenTelemetry semantic-convention versions are pinned,
  upgrade-tested and mapped across logs, traces, metrics, events/profiles and AI
  workload telemetry without silently inventing correlation or completeness.
- AWS, Azure/Entra, GCP, Okta, Google Workspace, Microsoft 365, Slack, GitHub,
  GitLab, ServiceNow, PAN-OS, FortiGate, Zscaler, Defender for Office 365,
  Proofpoint, Defender for Endpoint and CrowdStrike each pass their own named
  schema, permission, cursor, outage, drift and live-interoperability gate.
- New-source onboarding proves bounded safe sampling, mapping/lineage, schema-
  drift replay, volume/cardinality/cost, permissions/completeness and canary
  rollback before production activation.
- Source lineage, immutable facts, telemetry gaps and completeness are queryable.
- Trusted-time bootstrap/refinement and PKI issuance, renewal, revocation and
  compromise recovery pass their cross-platform and ceremony exercises.
- Every acknowledgement claim/component is emitted only through its verified
  `v0.31.3` registry entry and matching scoped `v0.31.4` state-verifier permit;
  schema/version labels, another component and a weaker state cannot activate it
  across downgrade, failover or mixed versions.
- `Indexed` binds the exact covered fact range and index definition/generation;
  `DetectionProcessed` binds the authoritative active-rule-set commitment,
  rollout cohort, policy epoch and input range, with every incomplete state
  explicit.
- Durable local and HA jobs/timers prove declared time bases, misfire policy,
  fencing, idempotency, cancellation, dependency and checkpoint semantics;
  storage durability/recovery remains available without scheduler workers/state,
  and mixed-version effect handoff uses a durable intent, non-null tenant-or-
  system authority domain, canonical consumer/job/ordinal/logical-ledger key and
  digest, linearizable put-if-absent and validated receipt to create one outbox
  record per handoff key; ledger migration fences generations and preserves the
  deduplication index without placing the routing epoch in that key, while
  non-identifying spent-key commitments and a current `HardwareMonotonic` or
  `ExternalWitnessed` fence reject old journals/messages/restores after ordinary
  record retention. `ExternalWitnessed` requires a current exact-record permit
  from an authority outside all five workload rollback domains; cluster-local
  consensus alone is insufficient. The full conservative `TimeTrust` interval
  must fit the signed lease, and quorum-authorized signer successors preserve the
  epoch across rotation/compromise. Expired/disagreeing permits, uncertain time,
  a revoked/compromised permit signer, signer-chain conflict or exceeded effect-
  class stale windows become `Unverifiable`: recovery is read-only for effects,
  never initializes a fresh epoch, and fence advancement proves no older pending/
  unknown/reconciliation/compensation/delayed state remains.
- Storage survives crash, corruption, node/rack/region loss and rolling upgrade.
- Historical hot/cold, live, temporal, graph, federated and distributed-physical
  VQL queries work safely with canonical coverage manifests, verifiable
  authoritative expected-set commitments and honest complete/partial/
  unavailable/truncated/policy-limited behavior.
- `DurableQuorum` evidence proves fact, raw-capsule and mapping/provenance
  durability independently; its acknowledgement manifest binds request digest,
  durability class and placement/quorum epoch; transport replay expiry is
  separate from retained historical signature/trust verification, and raw
  reconstruction is never implied without quorum-durable chunks/manifests.
- Predicate, temporal, stateful, graph, behavioral and integrity detection work.
- ATT&CK strategy/analytic and Sigma 2.1 rule/correlation/filter support is
  current, version-pinned, upgrade-tested and represented without treating a
  technique tag as proof that required telemetry or an effective analytic exists.
- Threat-intelligence live/retro matching and entity-risk threshold findings
  are deterministic, evidence-backed and poisoning-resistant.
- Simulation, shadow, canary, rollback and deterministic finding replay work.
- Signed first-party content covers every admitted platform and named source at
  the documented minimum level, including detections, hunts, dashboards,
  investigation runbooks and safe response playbooks; offline distribution,
  revocation, provenance and rollback work.
- Detection effectiveness is continuously evidenced through analyst disposition
  feedback, controlled miss/precision/recall evaluation, adversary emulation,
  purple-team exercises, review ownership, tuning/suppression debt and recurring
  validation rather than alert-count metrics alone.
- Evidence/findings remain immutable; alerts are mutable triage objects, formal
  incidents are authoritative declarations, cases are collaborative workspaces
  and incident graphs remain explanatory models rather than incident state.
- Every terminal alert is promoted or has one structured disposition; promotion
  retry returns the same incident/primary case/graph root, and every incident
  transition is authorized, version-checked and audited.
- Incident merge/split/reopen/declassify/transfer/hold/severity operations preserve
  complete lineage and can never move earliest awareness or an existing deadline
  forward; `Resolved`, `Closed` and `PostAnalysisComplete` remain distinct.
- The default incident process works with every optional pack and external ITSM
  unavailable. Framework evaluation is bounded/deterministic for exact inputs and
  package digest, cannot access unauthorized evidence, and produces complete
  explanations with `Unknown` preserved.
- Default, ENISA, NIS2 EU, national-overlay contract, DORA and GDPR packs are
  signed/immutable/patchable and independently assessed; disabling a pack cannot
  delete active obligations, and organization overlays cannot silently weaken
  regulatory or core requirements.
- Every obligation exposes its package/rule/source timestamp, calculation,
  uncertainty/safety margin and independent deadline; merge/split/reopen, pack
  migration and HA failover cannot reset or collapse it.
- Every approved/submitted regulatory report binds exact package/input/payload
  digests and has a verified receipt or explicit `UnknownOutcome`; corrections
  preserve the original version and outcome.
- Incident closure fails on incomplete required fields, corrective actions or
  obligations unless a specific authorized audited exception exists, and
  framework upgrades pass historical shadow replay before activation.
- Formal hunts bind hypothesis, scope, snapshot, query, coverage and evidence;
  support collaboration, recurrence and immutable results; and promote
  idempotently into governed rules, findings, incidents and content packages.
- NIST SP 800-61r3 joins the independently assessed default/ENISA/NIS2/DORA/GDPR
  pack set, and every admitted named national NIS2 profile has its own completed
  implementation stop; unsupported profiles are explicit rather than implied.
- ServiceNow failure never blocks internal handling; field authority is explicit,
  loops/unknown outcomes are reconciled, and conflicts never silently overwrite
  either side. Generic provider contracts imply no other named vendor support.
- Wasm is capability-limited and OS-isolated; response requires correct approval,
  idempotency, verification and compensation.
- CACAO 2.0 import/export and OpenC2 2.0 translation preserve semantic loss,
  authority, approval, idempotency and unknown outcomes; interoperability never
  bypasses the native playbook/action security model.
- Live forensic acquisition is authenticated, elevated, independently audited
  and custody-bound; ordinary collection authority cannot invoke it.
- SOAR cooldown/concurrency/recursion/target serialization and every scoped kill
  switch behave correctly for queued, in-flight and unknown-outcome actions.
- Multi-tenancy, field policy, residency and purpose enforcement pass independent
  assessment.
- Normalized security-data export is disabled by default, tenant-authorized,
  policy-filtered, cursor/checkpoint-bound and auditable; OCSF, OTLP, syslog,
  archive/object and message-stream profiles survive interruption, HA and
  re-import without making external delivery necessary for internal operation.
- Tenant provisioning, suspension, read-only/quarantine, hold, export,
  offboarding and cryptographic destruction propagate across every product plane;
  tenant identifiers and key domains cannot be reused or resurrected, while any
  lawfully retained independent audit/remnant evidence conveys no authority.
- Opaque internal tenant IDs are permanently non-reusable; human/external
  identifiers, audit pseudonyms, linkage-key expiry and any re-identification
  authority follow the closed `v0.457.2` policy without retaining excess identity.
- Single-node, cluster, sovereign multi-region and air-gap operation are tested.
- Hunt, first-party content, detection-effectiveness, SOC-metric and optional
  export state have explicit HA, recovery, RPO/RTO and no-duplicate-effect proof.
- Cluster discovery and authenticated data-plane routing preserve loop,
  backpressure, sequence, retry and acknowledgement truth through drain,
  leader movement, partition and stale-route failure; cross-region routing occurs
  only after committed failover authority, and proxy trust termini/backend
  bindings are explicit per protocol; bindings authenticate backend claims but
  do not imply Byzantine truth from a compromised backend.
- Backup, restore, repair, reindex, migration, upgrade and rollback are complete.
- The SDK publication decision is explicit; internal crates remain unpublished.
- Dashboards, scheduled analytics reports, analyst and administration interfaces,
  and complete operator/developer/security documentation exist.
- SOC metrics use canonical timestamps, populations and censoring rules and
  expose alert workload/quality, incident response and corrective-action
  outcomes without rewarding premature closure or hiding incomplete data.
- AI workload monitoring detects unsafe access, prompt/context/tool misuse,
  sensitive-data exposure and model/runtime drift. Optional AI assistance is
  disabled by default, proposal-only, provenance- and policy-bound, resistant to
  prompt injection, grounded with citations, TEVV-tested and unable to close an
  alert, declare an incident, determine an obligation or dispatch an action.
- Conditional external query-in-place, DSPM/EASM, passive OT/ICS, MSSP tenancy
  and named national NIS2 scope each has completed implementation evidence or a
  tested explicit non-goal; admitted OT remains passive and automatic OT response
  remains outside the 1.0 claim.
- Every optional capability in the pre-1.0 decision register is implemented and
  evidenced or is an explicit tested non-goal; none remains conditional or `TBD`.
- No critical or high assessment finding remains.
- Wire, storage, rule-package, schema, SDK and public API formats are stable.
- Builds and release artifacts are reproducible, signed and provenance-bound.
- Any regulated cryptographic-mode claim names an applicable validated boundary;
  otherwise documentation explicitly states that no such claim exists.
