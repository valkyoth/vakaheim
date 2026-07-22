# Initial Vakaheim Product Idea

> Historical design record: version numbers in this document are illustrative.
> The canonical [release plan](RELEASE_PLAN.md) uses unbounded small pre-1.0
> review stops and may continue through `v0.1000.0` or beyond.

Your final refinement is the correct foundation: keep deterministic security logic in portable no_std crates, then surround it with narrowly scoped OS, storage, networking, and UI adapters that may use std.

I would take that architecture much further than the attached proposal.

Ultimate Rust SIEM Architecture and Implementation Plan
1. Executive decision

This should not be designed as a faster log-search product.

It should be designed as a distributed security evidence, reasoning, detection, investigation, and response platform.

The foundational model is:

Raw observations become immutable security facts. Facts retain their provenance. Detection produces explainable findings. Findings form incidents. Incidents may trigger controlled, reversible actions.

The system must run as:

A small single-node appliance.
A distributed enterprise cluster.
An endpoint or edge collector.
A disconnected or air-gapped deployment.
A multi-region sovereign deployment.
An embedded collector using only selected no_std crates.

The central server must not require Kafka, Elasticsearch, PostgreSQL, Redis, ClickHouse, an external object database, or an external workflow platform. Those systems may be supported as import or export targets, but the SIEM must remain fully functional without them.

Version 1.0.0 must include the complete product:

Cross-platform collection.
Durable ingestion.
Security-native storage.
Historical and live search.
Stateful detection.
Behavioral analytics.
Alert and incident management.
Case management.
WebAssembly-based enrichment and response.
Multi-tenancy.
High availability.
Multi-region federation.
Analyst UI.
Administration UI.
Public SDK.
Upgrade, backup, recovery, and migration tooling.
Security assurance documentation.

No major subsystem should be postponed until after 1.0.0.

2. What should change from the original proposal
2.1 Keep the hybrid no_std architecture

The final part of the attached idea correctly separates pure logic from operating-system integration. That should become a strict architectural law rather than merely a workspace convention.

no_std should be used to remove environmental assumptions from:

Event types.
Parsing.
Schema handling.
Query parsing and intermediate representation.
Detection state machines.
Rule validation.
Policy decisions.
Evidence construction.
Storage and wire-format definitions.
Cryptographic provider interfaces.
SDK types.

Rust’s no_std mode provides core rather than operating-system integration, while heap-backed collections remain available separately through alloc. This makes a core / alloc / std layering more useful than treating all no_std code as allocation-free.

no_std is therefore a portability and auditability boundary, not a requirement that the entire SIEM run without an operating system.

2.2 Do not cast untrusted bytes into #[repr(C)] structures

The raw pointer-casting approach in the original idea is too dangerous for a security product.

Problems include:

Misalignment.
Endianness.
Invalid enum discriminants.
Padding bytes.
Integer overflow.
Truncated input.
Uninitialized data.
Format-version differences.
Accidental dependence on Rust or platform ABI layout.

Instead, build a dependency-free checked cursor:

pub struct ByteCursor<'a> {
    input: &'a [u8],
    position: usize,
}

It should expose explicit methods such as:

read_u8()
read_be_u16()
read_le_u32()
read_var_u64()
take_exact()
take_bounded()
read_utf8()
read_ascii()

Every operation must:

Check bounds before access.
Use checked arithmetic.
Return structured errors.
Never panic on malformed input.
Avoid copying unless ownership is explicitly requested.
Preserve the original byte range for provenance.

The resulting parsers can still be zero-copy through borrowed views without invoking undefined behavior.

2.3 Do not discard “90% of known-safe events” at the kernel

Early filtering is necessary, but declaring traffic or activity “known safe” creates dangerous blind spots.

The edge should support three explicit policies:

Policy	Meaning
Preserve	Send or spool the complete event.
Summarize	Maintain counts, sketches, ranges, exemplars, and integrity metadata.
Suppress	Drop only under a signed, time-limited policy while recording exactly what was suppressed.

Every suppression policy must emit:

Policy identifier and version.
Start and end time.
Number of suppressed events.
Source and category distribution.
Sampling exemplars.
Buffer-pressure context.
Identity of the approver.
Integrity signature.

Authentication, privilege, process creation, security-control modification, collector-health, and evidence-integrity events should be non-suppressible by default.

2.4 Do not make OCSF the internal truth

OCSF should be a first-class compatibility format, but not the only internal representation.

OCSF is intentionally vendor-neutral, extensible, and independent of storage or ETL implementation. That makes it an excellent interchange schema but also means the SIEM should preserve source-specific semantics that do not map cleanly into it.

Use three layers:

Source capsule
Exact source bytes or source-native structured representation.
Internal security fact model
Stable IDs, entities, relationships, provenance, uncertainty, policy labels, and typed values.
Compatibility mappings
OCSF, OpenTelemetry, Sigma, STIX, CEF, LEEF, JSON, CSV, and other formats.

OpenTelemetry’s log data model is currently stable and supports meaningful mappings from differing log sources, so OTLP should also be a native ingestion boundary.

2.5 Do not use WebAssembly for every high-volume detection

Wasm is valuable for extensibility, but invoking a general Wasm module for every event would add unnecessary cost and enlarge the attack surface.

Use two execution systems:

Deterministic detection IR

A compact, bounded, no_std intermediate representation for:

Predicates.
Field extraction.
Thresholds.
Sequences.
Sliding windows.
Finite-state machines.
Entity joins.
Graph patterns.
Risk aggregation.
Sketch updates.
Finding construction.

This is the high-volume execution path.

WebAssembly components

Use Wasm for:

Complex optional detectors.
Enrichment.
Connectors.
Report generators.
SOAR playbooks.
Customer-specific processing.
Experimental analytics.

The WebAssembly Component Model provides self-describing components and typed WIT interfaces, making it appropriate for defining narrow SIEM capabilities.

For constrained or edge deployments, Wasmi currently supports no_std, deterministic interpretation, limits, and fuel metering.

However, Wasm must not be treated as the sole security boundary. Wasmtime’s 2026 security releases included fixes for sandbox escapes, out-of-bounds access, data leakage, and host panics. The Wasm host must therefore run inside an additional operating-system sandbox or isolated worker process.

2.6 Never allow AI to deploy detection or response directly

The attached idea proposes having AI generate and hot-swap detection modules automatically.

That is too dangerous.

AI may:

Propose queries.
Propose rules.
Generate test cases.
Explain findings.
Compare rule versions.
Suggest incident grouping.
Summarize evidence.
Recommend response steps.

AI may not independently:

Activate a rule.
Change collection policy.
Suppress events.
Modify retention.
Close an incident.
Execute a response action.
Grant permissions.
access unapproved evidence.

Every AI-generated artifact must pass the same validation, simulation, review, signing, and rollout process as human-authored content.

2.7 Do not build a Parquet-only or raw-NVMe-only storage system

Parquet should be an export and cold-storage compatibility option, not the core database.

A raw circular NVMe log is useful for a specialized sensor but inadequate for:

Long-term evidence.
Legal holds.
Fine-grained retention.
Distributed replication.
Multi-tenancy.
Indexed investigation.
Schema evolution.
Deletion workflows.
Case evidence.
Access control.
Data sovereignty.

The project needs its own append-only security segment format and query engine.

2.8 Replace arbitrary file-length rules with architectural metrics

The proposed automatic 500-line split is not a meaningful security boundary.

Crates should be separated when they differ in:

no_std, alloc, or std requirements.
Operating-system support.
Privilege level.
Unsafe-code allowance.
Fuzzing target.
Public API stability.
Security boundary.
Release lifecycle.
Dependency policy.

Track instead:

Cyclomatic and cognitive complexity.
Number of unsafe blocks.
Maximum call depth.
Parser state count.
Public API surface.
Dependency fan-out.
Panic paths.
Allocation paths.
Lock acquisition graph.
Fuzz coverage.
Verification coverage.
3. Product architecture
3.1 Major planes
┌───────────────────────────────────────────────────────────────┐
│                        Analyst Plane                          │
│ Search · Timeline · Graph · Cases · Reports · Rule Studio    │
└───────────────────────────────────────────────────────────────┘
                              │
┌───────────────────────────────────────────────────────────────┐
│                  Incident and Response Plane                  │
│ Findings · Correlation · Incidents · SOAR · Approvals        │
└───────────────────────────────────────────────────────────────┘
                              │
┌───────────────────────────────────────────────────────────────┐
│                Query and Detection Plane                      │
│ Streaming · Historical · Temporal · Graph · Behavioral       │
└───────────────────────────────────────────────────────────────┘
                              │
┌───────────────────────────────────────────────────────────────┐
│                    Security Fact Plane                        │
│ Typed facts · Entities · Relations · Provenance · Policies   │
└───────────────────────────────────────────────────────────────┘
                              │
┌───────────────────────────────────────────────────────────────┐
│                 Ingestion and Routing Plane                   │
│ Validation · Batching · Deduplication · Spooling · Relays     │
└───────────────────────────────────────────────────────────────┘
                              │
┌───────────────────────────────────────────────────────────────┐
│                       Sensor Plane                            │
│ Linux · Windows · macOS · BSD · Cloud · Identity · Network   │
└───────────────────────────────────────────────────────────────┘

Cross-cutting planes:
Control · Identity · Policy · Keys · Cluster · Audit · Health
3.2 Primary component roles

A deployment may combine these roles into one binary or distribute them:

Role	Responsibility
Sensor	Collects native telemetry and performs safe edge processing.
Relay	Buffers, validates, prioritizes, and forwards telemetry.
Ingest node	Authenticates sources, decodes batches, assigns partitions, and persists the durable log.
Fact compiler	Converts source records into internal facts while preserving source fidelity.
Detection worker	Evaluates live stateful detection.
Storage node	Stores, indexes, compacts, encrypts, and replicates segments.
Query worker	Executes historical, temporal, graph, and federated queries.
Incident node	Groups findings and maintains incident state.
Action worker	Runs isolated enrichment and response components.
Control node	Manages configuration, enrollment, policy, schema, rule, and cluster metadata.
API node	Serves analyst, administration, and SDK APIs.
UI node	Serves the analyst and administration interface.
3.3 Deployment topologies
Embedded collector

A subset of no_std crates, fixed buffers, local detection, and a narrow transport adapter.

Endpoint deployment

A low-privilege agent plus a small privileged sensor helper where required.

Single-node appliance

All server roles in one process group with local storage.

Enterprise cluster

Separate ingest, detection, query, storage, control, and action workers.

Multi-region sovereign deployment

Regional data remains local. Queries and detection plans are federated subject to policy.

Air-gapped deployment

Offline update bundles, local trust roots, removable-media import and export, no mandatory cloud dependency.

4. The internal security fact model

The internal model is the most important architectural decision.

4.1 Record categories
Observation

Something a source reported or the platform directly observed.

Fact

A typed, immutable interpretation of one or more observations.

Entity

A stable or partially stable subject such as:

Device.
User.
Account.
Process.
File.
Service.
Container.
Workload.
Certificate.
Network endpoint.
Domain.
Cloud resource.
Application.
Session.
Relationship

An evidence-backed connection between entities:

Parent process.
Logged in to.
Connected to.
Created.
Modified.
Authenticated as.
Executed on.
Resolved to.
Member of.
Assumed role.
Downloaded.
Communicated with.
Finding

A detector’s conclusion, supported by an evidence bundle.

Incident

A mutable investigation object grouping findings, entities, timelines, actions, and analyst work.

Action request

A proposed, approved, running, completed, failed, compensated, or cancelled response action.

Telemetry gap

A first-class fact describing missing, delayed, suppressed, corrupted, or inaccessible telemetry.

4.2 Required envelope fields

Every observation and fact carries:

record_id
tenant_id
source_id
source_instance_id
source_sequence
source_time
observation_time
ingest_time
normalization_time
clock_uncertainty
schema_id
schema_version
parser_id
parser_version
raw_digest
raw_location
integrity_state
policy_labels
security_classification
residency_labels
retention_policy
provenance_chain
4.3 Time model

Do not use one timestamp.

Store:

Source-reported time.
Collector observation time.
Server receipt time.
Normalization time.
Effective time.
Clock uncertainty.
Known clock offset.
Late-arrival status.
Ordering confidence.

This permits honest temporal reasoning when endpoint clocks are inaccurate or events arrive late.

4.4 Truth and uncertainty model

Values should distinguish:

Known
Unknown
Unavailable
Redacted
NotApplicable
Conflicted
Malformed

Claims should distinguish:

Observed
SourceAsserted
Derived
Inferred
AnalystAsserted

This prevents the system from treating missing evidence as false.

4.5 Source preservation

Normalization must never silently destroy source meaning.

A normalized fact references a source capsule containing:

Exact source bytes when retention policy permits.
Source format.
Content type.
Source metadata.
Parser version.
Mapping version.
Byte ranges supporting each extracted field.
Parse warnings.
Fields that could not be represented.
Integrity digest.

For low-value, high-volume sources, policy may retain only the digest, selected raw fields, exemplars, or a short raw-retention window. The UI must state when exact source reconstruction is unavailable.

5. Workspace structure

All internal crates remain in one Cargo workspace and default to publish = false.

5.1 Product binaries
siem
siemd
siem-agent
siem-relay
siem-action-worker
siemctl
siem-migrate
siem-repair
siem-bench-node
siem-ui-server
5.2 Foundation crates
siem-core
siem-bytes
siem-codec
siem-id
siem-time
siem-types
siem-value
siem-schema
siem-event
siem-entity
siem-policy
siem-provenance
siem-integrity
siem-crypto-api

These should be no_std, with selected crates supporting an optional alloc feature.

5.3 Ingestion crates
siem-ingest-core
siem-ingest-runtime
siem-parser-sdk
siem-source-capsule
siem-syslog
siem-json
siem-otlp
siem-ocsf
siem-cef
siem-leef
siem-stix
siem-taxii
siem-file-tail
siem-flow
siem-pcap
5.4 Platform crates
siem-linux
siem-linux-ebpf
siem-linux-audit
siem-windows
siem-windows-etw
siem-windows-eventlog
siem-macos
siem-macos-endpoint-security
siem-bsd
siem-kubernetes
5.5 Runtime and transport crates
siem-runtime-core
siem-runtime-linux
siem-runtime-windows
siem-runtime-kqueue
siem-buffer-pool
siem-channel
siem-protocol
siem-transport
siem-transport-tcp
siem-transport-quic
siem-enrollment

The project should build its own small event reactor abstraction rather than making Tokio part of every binary.

5.6 Storage crates
siem-storage-format
siem-storage-engine
siem-storage-memory
siem-wal
siem-segment
siem-index
siem-compaction
siem-retention
siem-replication
siem-object-adapter
siem-evidence-vault
siem-backup
siem-repair-core
5.7 Query crates
siem-query-syntax
siem-query-ast
siem-query-ir
siem-query-typecheck
siem-query-plan
siem-query-cost
siem-query-exec
siem-query-stream
siem-query-temporal
siem-query-graph
siem-query-federated

The syntax, AST, type checker, and IR should remain no_std + alloc.

5.8 Detection crates
siem-rule-model
siem-rule-compiler
siem-rule-package
siem-detect-core
siem-detect-predicate
siem-detect-temporal
siem-detect-state
siem-detect-graph
siem-detect-risk
siem-detect-content
siem-behavior
siem-sigma
siem-attack
siem-rule-simulator
5.9 SOAR and extension crates
siem-wasm-abi
siem-wasm-validate
siem-wasm-host
siem-soar-core
siem-soar-runner
siem-playbook-model
siem-action-model
siem-connector-sdk
siem-secrets
siem-approval
5.10 Control and cluster crates
siem-control
siem-config
siem-fleet
siem-auth
siem-authorization
siem-audit
siem-cluster
siem-consensus
siem-membership
siem-partition
siem-federation
siem-upgrade
5.11 Analyst-facing crates
siem-finding
siem-alert
siem-incident
siem-case
siem-report
siem-api
siem-sdk
siem-ui-model
5.12 Verification crates
siem-testkit
siem-fixtures
siem-attack-scenarios
siem-fuzz
siem-kani
siem-loom
siem-conformance
siem-bench

This is a large number of crates, but the boundaries correspond to target, privilege, fuzzing, dependency, and security boundaries. They do not need separate repositories or crates.io releases.

6. Dependency and unsafe policy
6.1 Dependency tiers
Tier 0: dependency-free

The following should aim for zero runtime dependencies:

Bytes and cursors.
IDs.
Time primitives.
Value model.
Event model.
Schema model.
Query syntax and IR.
Rule model and detection IR.
Policy model.
Storage format definitions.
Wire format definitions.
Tier 1: tightly controlled exceptions

External crates may be accepted for:

Audited cryptographic primitives.
TLS.
Platform API bindings.
WebAssembly execution.
Hardware-backed key APIs.
Optional compression.
Unicode tables where implementing them incorrectly would be worse.
Tier 2: isolated convenience dependencies

UI, development tooling, CLI formatting, migration tools, benchmarks, and test harnesses may use broader dependencies because they are outside the trusted ingestion and detection path.

6.2 Prohibited dependency classes in the trusted path

Do not use:

General web frameworks in ingestion workers.
General async runtimes in no_std or core computation.
ORM layers.
General serialization frameworks for internal hot-path encoding.
Reflection-driven event processing.
Plugin systems with native dynamic libraries.
Runtime code generation for ordinary detection.
Hidden global executors.
Libraries that panic on untrusted input.
6.3 Cryptography

Do not implement cryptographic primitives from scratch.

Create siem-crypto-api with traits for:

Hashing.
Message authentication.
Digital signatures.
AEAD.
Key wrapping.
Random generation.
Certificate validation.
Key derivation.

Provide audited implementations in replaceable adapter crates.

6.4 Unsafe-code law

Use:

#![forbid(unsafe_code)]

throughout most of the workspace.

Unsafe code is permitted only in named crates such as:

Platform FFI adapters.
Memory-mapped storage.
Direct I/O.
eBPF bindings.
Selected ring-buffer internals.
Hardware key integration.

Every unsafe block requires:

A documented invariant.
A safety review.
Miri coverage where possible.
Fuzz or property tests.
A dedicated maintainer.
Inclusion in the per-release unsafe diff.
No expansion during release-candidate freeze without a security exception.
7. Ingestion architecture
7.1 Source lifecycle
Receive
  → Authenticate source
  → Frame
  → Validate size and limits
  → Record source capsule
  → Decode source record
  → Normalize into facts
  → Apply policy labels
  → Assign partition
  → Evaluate edge rules
  → Persist durable batch
  → Acknowledge source
7.2 Delivery semantics

Do not claim magical end-to-end “exactly once.”

Use:

At-least-once transport.
Stable source sequence numbers.
Deterministic event identifiers.
Batch identifiers.
Idempotent writes.
Deduplication windows.
Persistent checkpoints.
Replay-safe detection.
Idempotent response actions.

Acknowledgements should have explicit levels:

Received
Validated
DurableLocal
DurableQuorum
Indexed
DetectionProcessed

Sources can choose the required acknowledgement level.

7.3 Bounded overload behavior

Every queue has:

Fixed or configured maximum capacity.
Priority class.
High-water and low-water marks.
Spill-to-disk policy.
Drop policy.
Source-specific limits.
Metrics.
Telemetry-gap generation.

Under overload, the system must degrade in this order:

Delay low-priority normalization.
Spill to local disk.
Reduce optional enrichment.
Summarize explicitly permitted sources.
Reject or drop only according to signed policy.
Emit a durable telemetry-gap fact.

Never silently discard data.

7.4 Edge spool

Agents and relays need an encrypted local spool with:

Append-only segments.
Sequence checkpoints.
Priority lanes.
Configurable size.
Crash recovery.
Key rotation.
Tamper evidence.
Expiry.
Remote health reporting.
Protection against one noisy source consuming the entire spool.
7.5 Parser architecture

Each parser exposes:

probe(input) -> confidence
begin(context)
push(bytes) -> NeedMore | Records | Rejected
finish() -> Records | Truncated | Rejected

Parsers must be:

Streaming.
Bounded.
Incremental.
Panic-free.
Able to report malformed fields without losing the entire record.
Able to preserve unknown fields.
Fuzzed independently.
Versioned independently from schemas.
7.6 Protocol support before 1.0

Required:

Syslog over UDP, TCP, and TLS.
JSON lines.
Framed JSON.
OTLP logs.
OCSF JSON.
CEF.
LEEF.
STIX and TAXII.
File and directory tailing.
Windows event forwarding or equivalent collection.
Native agent protocol.
Webhook ingestion.
Batch file import.
Flow records.
DNS telemetry.
Kubernetes audit.
Major cloud audit sources.
Major identity-provider audit sources.
8. Native cross-platform sensors
8.1 Linux

Linux support should combine:

Journald.
Syslog.
Audit netlink.
Process lifecycle.
Authentication.
Service and scheduled-task changes.
File integrity.
Network flows.
Container and cgroup context.
Namespace context.
Package changes.
Kernel and security-control health.
Optional eBPF.

The Linux kernel documents eBPF program types, maps, verifier behavior, BTF, helper functions, and userspace interaction. The project should use those facilities through a very small privileged loader and keep most processing in user space.

eBPF programs should:

Capture or summarize, not perform complicated central detection.
Be verifier-friendly.
Use bounded loops.
Avoid large kernel maps.
Emit versioned records.
Support BTF-based portability where possible.
Have a non-eBPF fallback.
Be replaceable without restarting the primary agent.
Report attach failures and kernel capability differences.

Split the agent into:

siem-linux-sensor-helper   privileged
siem-linux-agent           unprivileged
siem-linux-spool           restricted storage access
8.2 Windows

Windows support should combine:

Event Log.
ETW.
Process and thread lifecycle.
Authentication.
Service changes.
Registry changes.
PowerShell and scripting telemetry where available.
Network activity.
Security-product state.
Driver and kernel events.
File integrity.
Scheduled tasks.
WMI activity.
Optional Windows Filtering Platform integration.

ETW supports real-time or file-based consumption of kernel and application events and separates controllers, providers, and consumers. This maps naturally to a Rust adapter feeding the common event model.

Prefer documented user-mode interfaces. An optional signed kernel driver should be introduced only for telemetry that cannot be obtained safely through documented facilities.

8.3 macOS

macOS support should combine:

Endpoint Security.
Unified Logging.
FSEvents.
Authentication and authorization events.
Launch services and persistence.
Network metadata.
System-extension health.
Security-policy changes.

Apple’s Endpoint Security API can notify or authorize process, filesystem, mount, fork, signal, and related security events through a system extension.

The sensor must clearly report when required entitlements or permissions are absent.

8.4 BSD systems

Support FreeBSD and OpenBSD through:

Syslog.
OpenBSM or native audit facilities.
kqueue.
Process accounting.
Authentication records.
pf telemetry.
File integrity.
Package and service changes.

The BSD implementation may offer fewer kernel-level features than Linux or Windows, but it must use the same fact, detection, spool, and transport formats.

8.5 Kubernetes and containers

Collect:

Kubernetes audit events.
Workload identity.
Pod, container, node, namespace, and cluster entities.
Admission decisions.
Role and binding changes.
Secret metadata access.
Exec and attach activity.
Image information.
Runtime lifecycle.
Network policy changes.
Linux host context.

Container identity must be resolved to workload and deployment identity rather than treated as only a transient process ID.

9. Security-native storage engine
9.1 Storage tiers
Hot tier
In-memory state.
Recent event cache.
Detection windows.
Active entity graph.
Live query subscriptions.
Warm tier
Local encrypted security segments.
Full indexing.
Fast investigation.
Replicated storage.
Cold tier
Larger immutable segments.
Reduced index density.
Optional object storage.
Optional Parquet export.
Legal-hold support.
Evidence vault

A separately governed store for:

Raw artifacts.
Files.
Packet excerpts.
Forensic exports.
Incident evidence.
Signed reports.
9.2 Security Segment Format

Create a versioned format such as Security Fact Segment, containing:

Segment header
Tenant and partition identifiers
Time bounds
Schema dictionary
Entity dictionary
Column directory
Column pages
Relationship pages
Raw-capsule references
Index directory
Integrity tree
Encryption metadata
Commit footer
9.3 Column encodings

Implement a small set of deterministic encodings:

Plain fixed-width.
Delta integers.
Delta-of-delta timestamps.
Run-length encoding.
Bit packing.
Dictionary encoding.
Boolean bitmaps.
Optional lightweight compression.
Raw byte blocks.

Do not add dozens of codecs before measuring actual security workloads.

9.4 Indexes

Required indexes:

Time range.
Tenant and partition.
Event class.
Source.
Exact string.
Token.
Prefix and suffix.
Numeric range.
Boolean bitmap.
IP prefix.
Port and protocol.
Hash and identifier.
Entity adjacency.
Relationship type.
Finding and incident references.
Optional vector similarity.

Index selection must be automatic but inspectable through query explanation.

9.5 Integrity

Each committed segment should contain:

Per-block checksum.
Cryptographic block digest.
Merkle root.
Previous-segment linkage.
Writer identity.
Commit sequence.
Signature or authenticated cluster attestation.
Replication acknowledgements.

Integrity verification must be available:

On read.
On schedule.
During replication.
During backup.
During export.
On analyst request.
9.6 Encryption

Use:

Per-tenant data-encryption keys.
Per-segment subkeys.
Envelope encryption.
Hardware-backed wrapping where available.
Online key rotation.
Crypto-shredding support.
Separation of storage access and key access.
Authenticated metadata.

Indexes containing sensitive values must also be encrypted or transformed appropriately.

9.7 Retention and deletion

Retention policies operate on:

Tenant.
Source.
Field.
Event class.
Classification.
Incident association.
Legal-hold status.
Geography.
Purpose.

Deletion should be represented as an auditable lifecycle operation. Compaction removes expired records while preserving proof that the authorized lifecycle operation occurred.

10. The future query language

Call the language SQR: Security Query and Reasoning until a project-specific name is chosen.

It should unify:

Search.
Streaming subscriptions.
Temporal sequences.
Entity graphs.
Detection definitions.
Aggregations.
Historical replay.
Evidence explanation.
Federated queries.
10.1 Design principles

SQR must be:

Typed.
Schema-aware.
Pipeline-friendly.
Temporal.
Graph-capable.
Bitemporal.
Uncertainty-aware.
Policy-aware.
Streamable.
Deterministically compilable.
Able to explain its physical plan.
Able to state when results are incomplete.
10.2 Simple query
from process.start
where process.image.basename == "powershell.exe"
  and process.command_line contains "-enc"
select time, device, user, process, parent_process
order by time desc
limit 200
10.3 Temporal sequence
sequence by device.id, user.id within 10m
    process.start where process.image.basename == "winword.exe"
    process.start where parent.image.basename == "winword.exe"
    network.connect where destination.prevalence < 0.01
emit finding "document-to-rare-network"
10.4 Graph query
match
    (user:User)-[:AUTHENTICATED_TO]->(host:Device)
    -[:SPAWNED]->(process:Process)
    -[:CONNECTED_TO]->(domain:Domain)
where
    domain.first_seen_age < 1h
    and process.signature.trust != "trusted"
return path, evidence, confidence
10.5 Historical perspective
as_of incident.created_at
from identity.permission
where account.id == $account
show differences from now
10.6 Live subscription
watch authentication.failure
group by source.ip, target.account over 5m
having count() > 20 and distinct(target.account) > 10
emit finding "distributed-account-probing"
10.7 Completeness-aware query
from process.start
where device.id == $device
require telemetry(process, network, authentication)
return events, telemetry_gaps, completeness
10.8 Explainability

Every query can request:

explain logical
explain physical
explain cost
explain policy
explain completeness

Results should state:

Which indexes were used.
Which segments were scanned.
Which regions participated.
Which data was unavailable.
Which fields were redacted.
Which late events might alter the result.
Which policy prevented access.
Which approximation was used.
10.9 Query engine architecture
Parser
  → Typed AST
  → Normalized IR
  → Authorization rewrite
  → Residency rewrite
  → Logical plan
  → Cost plan
  → Physical plan
  → Local or federated execution
  → Evidence-aware result

The authorization and residency rewrites must happen before physical execution and be enforced again at storage access.

11. Detection architecture
11.1 Detection classes

The 1.0 engine must support:

Stateless predicates

Simple field and content matching.

Aggregation detections

Counts, distinct counts, rates, ratios, percentiles, and cardinality.

Temporal sequences

Ordered and partially ordered behavior over time.

Stateful automata

Long-lived attack state with explicit transitions and expiry.

Graph detections

Patterns across users, devices, processes, services, resources, and network entities.

Behavioral detections

Deviation from historical, peer, seasonal, or role-based behavior.

Integrity detections

Collector failure, event gaps, sequence resets, clock anomalies, rule tampering, and security-control impairment.

Composite risk detections

Multiple lower-severity findings contributing to a supported incident hypothesis.

11.2 Detection IR

The deterministic IR should support instructions such as:

LoadField
LoadConstant
Compare
Contains
Prefix
Suffix
RegexBounded
JumpIf
UpdateCounter
UpdateDistinctSketch
BeginWindow
ExpireWindow
TransitionState
LookupEntity
TraverseRelation
EmitFinding
AttachEvidence

The IR validator must reject:

Unbounded loops.
Unbounded state.
Unknown field access.
Excessive regex complexity.
Excessive memory.
Unsupported capability use.
Invalid time windows.
Non-deterministic instructions.
Missing expiry policy.
11.3 Rule package

A rule is not one text file. It is a signed package containing:

Manifest
Rule source
Compiled IR
Required schemas
Required telemetry
State and memory limits
Performance budget
ATT&CK mappings
Severity model
Confidence model
Suppression policy
Unit tests
Positive examples
Negative examples
Historical simulation results
Author and reviewer identities
Build provenance
Signature
11.4 Rule lifecycle
Draft
  → Validated
  → UnitTested
  → HistoricalSimulation
  → Shadow
  → Canary
  → Active
  → Limited
  → Quarantined
  → Deprecated
  → Retired

Activation should support staged rollout by:

Tenant.
Region.
Device group.
Source.
Percentage.
Time window.
11.5 Evidence bundle

Every finding contains:

Exact rule package digest.
Rule version.
Rule parameters.
Relevant facts.
Source-capsule references.
State transitions.
Aggregation values.
Entity relationships.
Missing telemetry.
Clock uncertainty.
Confidence explanation.
Severity explanation.
Detection worker identity.
Execution timestamp.

An analyst must be able to replay the finding deterministically.

11.6 Detection placement compiler

One major differentiator should be automatic placement planning.

The compiler evaluates whether a rule can run:

On the endpoint.
At a regional relay.
At the central stream processor.
Only as a historical query.

Placement considers:

Required fields.
State size.
Data locality.
Privacy labels.
Latency.
Event rate.
CPU cost.
Required cross-source joins.
Response urgency.

A human or policy approves the final placement. The system must never quietly move a rule in a way that changes its semantics.

11.7 Behavioral analytics

Build transparent streaming models first:

Exponentially weighted baselines.
Robust median and deviation.
Seasonal time buckets.
Peer-group comparison.
First-seen and rarity.
Change-point detection.
Count-min sketches.
Distinct-value sketches.
Transition probability.
Entity-graph rarity.
Sequence novelty.
Credential-use geography.
Service-account behavior.

Each model must be:

Versioned.
Bounded.
Replayable.
Explainable.
Tenant-specific unless explicitly shared.
Monitored for drift.
Degradable to deterministic rules.
11.8 Standards compatibility

Support:

Sigma import and export where semantics permit.
OCSF mappings.
STIX threat intelligence.
ATT&CK technique, detection-strategy, analytic, and data-component mappings.
OpenTelemetry logs.

As of July 2026, ATT&CK v19.1 is the current published version, so the importer must support versioned ATT&CK content rather than hard-coding one catalog.

Imported content must never bypass validation or testing.

12. Source assurance: detecting what the SIEM cannot see

A future-facing SIEM must detect failures in its own evidence supply.

Create first-class detectors for:

Source stopped reporting.
Unexpected event-rate changes.
Sequence gaps.
Duplicate storms.
Clock drift.
Parser failure increases.
Authentication failures between agent and server.
Agent policy changes.
eBPF detachments.
ETW provider loss.
Endpoint Security permission loss.
Audit subsystem changes.
Disk-spool saturation.
Backpressure.
Retention misconfiguration.
Rule execution failures.
Storage integrity failures.
Replication lag.
Data-residency blocks.
Unavailable cluster partitions.

Every dashboard, incident, and query should be able to show a telemetry completeness score derived from concrete evidence, not a guessed percentage.

This answers a question most log systems cannot answer honestly:

“Did nothing suspicious happen, or did we lack the telemetry needed to observe it?”

13. Alert, incident, and case architecture
13.1 Finding versus alert

A finding is immutable detector output.

An alert is a routed operational representation of one or more findings. Alert state changes must not modify the original findings.

13.2 Incident graph

An incident should be a graph containing:

Findings.
Entities.
Relationships.
Evidence.
Hypotheses.
Actions.
Analyst notes.
Tasks.
Approvals.
External tickets.
Reports.
13.3 Correlation

Findings may be grouped using:

Shared entity.
Shared infrastructure.
Time proximity.
Rule-defined correlation.
Shared evidence.
Attack-path relationship.
Analyst decision.
Behavioral similarity.
Campaign indicator.
Identity session.
Cloud role session.

Every automatic grouping decision must be explainable and reversible.

13.4 Case management

Required before 1.0:

Ownership and assignment.
Priority.
Status.
Tasks and checklists.
Comments.
Evidence attachments.
Timeline.
Entity graph.
Approval requests.
Playbook runs.
SLA tracking.
Legal hold.
Chain of custody.
Report generation.
Export.
External-ticket linkage.
Complete audit history.

Analyst annotations are mutable business records. Original evidence remains immutable.

14. WebAssembly SOAR
14.1 WIT capability worlds

Define custom worlds such as:

siem:detection/read-only
siem:enrichment/network-allowlisted
siem:case/update
siem:response/endpoint
siem:response/identity
siem:response/network
siem:report/generate

A component receives only the interfaces declared in its signed manifest.

14.2 No ambient authority

Wasm components receive no default access to:

Files.
Environment variables.
Network.
System clock.
Randomness.
Process execution.
Secrets.
Other tenants.
Unrelated incidents.
Arbitrary APIs.

They receive narrow host functions and unforgeable handles.

14.3 Resource controls

Each invocation has:

Fuel budget.
Wall-clock deadline.
Memory limit.
Output-size limit.
Host-call limit.
Network-domain allowlist.
Concurrent-execution limit.
State-size limit.
Cancellation.
Audit context.
14.4 Playbook state machine
Proposed
  → PolicyChecked
  → WaitingForApproval
  → Scheduled
  → Running
  → Verifying
  → Completed
  → Failed
  → Compensating
  → Compensated
  → Cancelled
14.5 Safe response principles

Every action must be:

Typed.
Idempotent.
Scoped.
Authenticated.
Authorized.
Audited.
Verifiable.
Retry-aware.
Timeout-aware.
Compensatable where possible.

Avoid a generic “run arbitrary shell command” action. Build specific actions such as:

Disable account.
Revoke session.
Isolate endpoint.
Block indicator.
Quarantine file.
Rotate credential.
Remove cloud permission.
Disable application token.
Collect forensic package.
Increase telemetry level.
Open or update ticket.
14.6 Secrets

Components never receive raw long-lived secrets unless absolutely unavoidable.

The secrets service should provide handles that permit operations such as:

sign_request(handle, request)
fetch_token(handle, audience, lifetime)
perform_authenticated_call(handle, request)
14.7 Approval policy

Examples:

Action	Default approval
Add enrichment tag	Automatic
Increase telemetry temporarily	Automatic within limits
Block malicious domain for one endpoint	Policy-dependent
Disable user account	Human approval
Isolate production server	Two-person approval
Delete cloud resource	Prohibited by default
Run arbitrary command	Prohibited by default
14.8 Simulation and dry run

Every playbook must support:

Dry-run output.
Historical simulation.
Mock connector execution.
Canary execution.
Approval preview.
Expected side effects.
Compensation preview.
15. Control plane and cluster
15.1 Control-plane responsibilities
Node identity.
Agent enrollment.
Trust roots.
Configuration.
Schema registry.
Parser registry.
Rule registry.
Component registry.
Policy.
Tenants.
Users and roles.
Storage topology.
Partition ownership.
Upgrade orchestration.
Health.
Audit.
License state, should commercial licensing later exist.
15.2 Configuration epochs

Every active configuration is an immutable signed epoch.

Agents and nodes report:

Current epoch.
Previous epoch.
Activation time.
Validation result.
Rollback availability.
Local overrides.
Drift.
15.3 Consensus

Use consensus only for small control-plane metadata, not for every event.

The consensus implementation must be:

Formally modeled before production.
Crash-fault tolerant.
Snapshot capable.
Membership-change capable.
Protected against stale leaders.
Extensively fault injected.
Separate from the high-volume data path.
15.4 Data partitioning

Partition by a configurable combination of:

Tenant.
Region.
Time.
Source.
Device or entity key.
Event category.

Detection rules define their required partition key. Cross-partition operations are explicit.

15.5 Replication

Support:

Local replication.
Rack-aware placement.
Region-aware placement.
Quorum durability.
Asynchronous remote replication.
Repair from immutable segments.
Integrity comparison.
Bandwidth limits.
Priority classes.
15.6 Federation and sovereignty

The query planner should send computation to data where appropriate.

A regional node can return:

Aggregates.
Findings.
Redacted facts.
Evidence references.
Policy-denied markers.
Completeness information.

The system must never represent a policy-limited result as globally complete.

16. Authentication and authorization
16.1 Identities

Support:

Human users.
Service identities.
Agents.
Nodes.
Connectors.
Wasm components.
Rule packages.
Automation identities.
16.2 Authentication

Required:

Local bootstrap account.
WebAuthn.
OIDC.
SAML adapter.
Mutual TLS for services and agents.
Short-lived service credentials.
Hardware-backed keys where available.
Break-glass procedure.
16.3 Authorization

Combine:

Role-based access.
Attribute-based access.
Capability handles.
Tenant boundaries.
Field-level policy.
Data classification.
Residency.
Purpose limitation.
Time-limited elevation.
Two-person approval.

Authorization occurs in:

API layer.
Query planner.
Query executor.
Storage.
Evidence vault.
SOAR host.
Connector host.
Export engine.
16.4 Independent security audit log

Administrative and analyst actions go to a dedicated audit stream with:

Separate signing key.
Separate retention policy.
Restricted deletion.
Independent replication.
No administrator exemption.
Access logging.
Export and verification tooling.
17. Public SDK

Do not publish every internal crate.

Publish one project-prefixed SDK before 1.0, for example:

<project>-siem-sdk

Optional companion crates may be published only when justified:

<project>-siem-sdk-macros
<project>-siem-wasm-sdk
17.1 SDK feature structure
types       no_std
events      no_std
query       no_std + alloc
rules       no_std + alloc
connectors  no_std + alloc
playbooks   no_std + alloc
client      std
admin       std
stream      std
17.2 SDK capabilities

Users should be able to:

Submit events.
Create source registrations.
Execute queries.
Stream results.
Subscribe to live queries.
Retrieve findings and incidents.
Update cases.
Request actions.
Review approvals.
Upload rule packages.
Upload Wasm components.
Inspect schemas.
Verify evidence.
Manage agents when authorized.
17.3 Protocol stability

The SDK and wire protocol need:

Version negotiation.
Capability negotiation.
Unknown-field preservation.
Forward-compatible enums.
Request identifiers.
Idempotency keys.
Pagination and resumable streams.
Explicit timeout and cancellation.
Stable error codes.
Complete API audit metadata.

No async runtime should be mandatory. Provide:

Blocking client.
Poll-based client.
Runtime integration traits.
Optional adapters for common runtimes outside the core SDK.
18. Analyst and administration UI

The UI may be a Rust/Wasm application, but it is not part of the trusted no_std core.

Required views:

Analyst workspace
Global search.
Query editor.
Live query.
Event details.
Raw-source view.
Entity view.
Temporal graph.
Incident timeline.
Evidence bundle.
Case workspace.
Playbook approval.
Report generation.
Detection engineering
Rule editor.
Type and schema completion.
Rule validation.
Test cases.
Historical simulation.
Shadow results.
Performance cost.
Required telemetry.
ATT&CK coverage.
Rollout status.
False-positive feedback.
Version comparison.
Data assurance
Source inventory.
Telemetry gaps.
Parser failures.
Schema drift.
Event-rate anomalies.
Agent health.
Buffer and spool health.
Clock drift.
Retention health.
Integrity verification.
Administration
Tenants.
Users.
Roles.
Policies.
Agents.
Nodes.
Regions.
Keys.
Schemas.
Parsers.
Rules.
Components.
Storage.
Backups.
Upgrades.
Audit records.

Every displayed finding should have a clear “Why did this happen?” view based on deterministic evidence rather than generated prose.

19. AI assistance

AI is optional and never part of the trusted correctness path.

19.1 Permitted functions
Natural language to draft SQR.
SQR explanation.
Rule drafting.
Test-case generation.
Incident summarization.
Timeline summarization.
Similar-incident retrieval.
Suggested evidence collection.
Suggested response plan.
Rule-noise analysis.
Coverage-gap analysis.
Analyst report drafting.
19.2 Required controls
Tenant-local context boundaries.
Explicit evidence selection.
Prompt and output audit.
Redaction before model use.
No direct secret access.
No automatic action execution.
No automatic rule activation.
Citation of supporting facts.
Clear distinction between fact and inference.
Configurable local-model adapter.
Complete disable switch.
19.3 AI proposal pipeline
AI proposal
  → Static validation
  → Policy validation
  → Unit tests
  → Generated adversarial tests
  → Historical simulation
  → Human review
  → Signature
  → Shadow deployment
  → Canary
  → Activation
20. Capabilities that make this genuinely different
20.1 Evidence lineage

Every conclusion links to:

Source.
Bytes.
Parser.
Mapping.
Rule.
State.
Model.
Policy.
Action.
20.2 Completeness-aware security

Queries and findings describe missing evidence and telemetry health.

20.3 Deterministic incident replay

Re-run an incident with the exact historical:

Schemas.
Parsers.
Rules.
Models.
Policies.
Facts.
20.4 Counterfactual simulation

Answer:

Would the new rule have detected this?
Would the old policy have suppressed it?
What would happen with a five-minute rather than ten-minute window?
Which additional telemetry would have changed the conclusion?
Would this playbook have taken a different action?
20.5 Policy-aware distributed planning

The system reasons over location, residency, classification, and purpose before moving data.

20.6 Adaptive collection

Detection can request temporary collection increases through a controlled action:

Increase process telemetry on device X for 15 minutes
Capture DNS answers for identity Y
Preserve complete raw events for source Z

These changes are bounded, signed, visible, and automatically reverted.

20.7 Security-control impairment detection

The SIEM treats attempts to disable or degrade telemetry as high-value security events.

20.8 Evidence rather than opaque risk scores

A risk score may be displayed, but it must be decomposable into:

Supporting findings.
Evidence confidence.
Asset criticality.
Identity sensitivity.
Telemetry completeness.
Contradicting evidence.
Time decay.
21. Performance and operational targets

These are release acceptance targets, not marketing promises.

Area	1.0 target
Silent loss	Zero tolerated; every loss produces durable health evidence where technically possible.
Endpoint idle CPU	Under 1% on reference workloads.
Minimal-agent memory	Under 30 MiB.
Full-agent memory	Under 150 MiB under ordinary load.
Ingest throughput	At least 500,000 normalized events/second on the published reference server.
Burst handling	Ten-minute 5× burst without silent loss when spool capacity is available.
Live detection latency	p99 below two seconds for ordinary stream rules.
Selective 24-hour query	p95 below two seconds on the reference dataset.
Quorum-ack RPO	Zero committed records lost under the documented failure model.
Control-plane failover	Below 60 seconds.
Rolling upgrade	No ingestion outage and deterministic rollback.
Agent offline operation	Configurable multi-day encrypted spool.
Evidence verification	Complete segment and export verification tooling.

Every benchmark result must publish:

Hardware.
OS.
Build flags.
Dataset.
Schema.
Rule set.
Index configuration.
Compression.
Replication.
Query.
Exact commit.
22. Per-release security gate

Every tagged release from 0.1.0 onward must satisfy:

A bounded, documented scope.
Threat-model delta.
Architecture-decision record.
No unresolved critical or high security findings.
No panic from known untrusted-input paths.
Unit and integration tests.
Fuzzing for changed parsers and codecs.
Kani checks for applicable bounded state machines.
Loom checks for changed concurrency primitives.
Miri checks for changed unsafe or low-level code.
Unsafe-code diff review.
Runtime dependency diff review.
SBOM generation.
Reproducible build check.
Performance-regression check.
Upgrade and rollback test.
Attack-scenario replay.
Pentest from the previous clean tag to HEAD.
Periodic full-product pentest.
Signed release tag and artifacts.

Patch releases fix defects in a completed milestone. They do not quietly add unrelated features.

23. Version roadmap

The anchor releases below define mandatory vertical slices. Unused minor numbers between anchors remain available for small hardening, compatibility, and remediation releases.

Phase A — Constitutional foundation
0.1.0 — Architecture constitution

Workspace, dependency law, unsafe law, threat model, data-flow diagram, supported targets, release gate, and coding standards.

0.2.0 — Checked byte primitives

Dependency-free bounded byte cursor, integer decoding, varints, slices, limits, and structured parse errors.

0.3.0 — Identity and time primitives

Stable IDs, tenant IDs, source sequences, timestamp types, duration types, clock uncertainty, and checked arithmetic.

0.4.0 — Streaming parser framework

Incremental parser traits, parser limits, partial input, malformed input, source ranges, and fuzz harness.

0.5.0 — Event envelope

Borrowed and owned event representations, typed values, field IDs, metadata, and forward-compatible extensions.

0.6.0 — Provenance and source capsules

Raw digest, parser lineage, mapping lineage, byte ranges, parse warnings, and raw-retention references.

0.7.0 — Canonical binary codec

Versioned deterministic internal codec with streaming decode and unknown-field preservation.

0.8.0 — Policy labels

Tenant, classification, residency, retention, privacy, and purpose labels.

0.9.0 — Bounded memory structures

Fixed queues, buffer pools, bounded maps, backpressure signals, and deterministic overflow behavior.

0.10.0 — Foundation security audit

Full fuzzing, Miri, Kani where applicable, format documentation, compatibility fixtures, and first external design review.

Phase B — Security fact model and interoperability
0.12.0 — Entity model

Users, devices, processes, files, services, identities, network endpoints, resources, and typed entity references.

0.14.0 — Relationship model

Evidence-backed relationships, direction, validity periods, provenance, and confidence.

0.16.0 — Schema registry

Versioned field dictionary, event classes, profiles, extensions, validation, and schema migration planning.

0.18.0 — OCSF compatibility

Bidirectional mappings where lossless, explicit loss reporting where not, and OCSF conformance fixtures.

0.20.0 — OpenTelemetry and parser SDK

OTLP log mapping, standalone parser SDK, example parser, documentation, and external-parser security model.

Phase C — Ingestion and transport
0.22.0 — Local ingestion pipeline

Receive, parse, normalize, route, and observe events in one process with bounded queues.

0.24.0 — Native file ingestion

Safe file tailing, rotation handling, checkpoints, multiline framing, and encoding detection.

0.26.0 — Syslog

UDP, TCP, TLS framing, standards variations, malformed-message handling, and rate control.

0.28.0 — JSON ingestion

Streaming JSON parser, JSON Lines, bounded nesting, duplicate-key policy, and source-field preservation.

0.30.0 — OTLP and OCSF endpoints

Authenticated network ingestion with source registration and schema validation.

0.32.0 — Agent spool

Encrypted append-only local spool, priorities, recovery, expiry, and capacity policy.

0.34.0 — Batching and acknowledgement

Batch IDs, source sequences, resumable transmission, idempotency, deduplication, and acknowledgement levels.

0.36.0 — Enrollment and secure transport

Agent identity, certificate enrollment, key rotation, trust-root rollover, and mutual authentication.

0.38.0 — Relay

Multi-source relay, local policy, buffering, health, routing, and disconnected operation.

0.40.0 — Ingestion security milestone

Load test, malformed-input campaign, packet-loss simulation, replay testing, and external ingestion pentest.

Phase D — Storage
0.42.0 — Security segment format

Documented immutable segment structure, headers, pages, commit footer, and repair scanner.

0.44.0 — Write-ahead log and recovery

Crash-safe commits, replay, torn-write detection, and deterministic recovery.

0.46.0 — Column encodings

Time, numeric, boolean, dictionary, byte, relationship, and raw-reference pages.

0.48.0 — Primary indexes

Time, class, source, numeric range, dictionary, and bitmap indexes.

0.50.0 — Security indexes

Text tokens, IP prefixes, identifiers, hashes, entity adjacency, and relationship indexes.

0.55.0 — Integrity and encryption

Checksums, authenticated encryption, Merkle roots, writer identity, key rotation, and verification CLI.

0.60.0 — Retention and compaction

Lifecycle policies, legal hold, compaction, deletion audit, export, and cold-tier adapters.

Phase E — SQR query system
0.65.0 — SQR lexer and parser

Stable grammar, diagnostics, bounded parsing, and syntax corpus.

0.70.0 — Type checker

Schema resolution, function types, null and uncertainty semantics, and policy-label types.

0.75.0 — Logical planner

Filters, projections, aggregates, joins, windows, graph operators, and plan normalization.

0.80.0 — Single-node execution

Segment scans, vectorized evaluation, limits, cancellation, memory budgets, and result streaming.

0.85.0 — Temporal operations

Event-time windows, late arrivals, watermarks, ordered and partially ordered sequences.

0.90.0 — Graph operations

Entity traversal, path constraints, relationship validity, and evidence-returning paths.

0.95.0 — Live, historical, and explanation modes

watch, as_of, query explanation, completeness reporting, and saved queries.

0.100.0 — Query security milestone

Planner fuzzing, authorization rewrite tests, adversarial-cost tests, index corruption tests, and query pentest.

Phase F — Detection
0.110.0 — Signed rule packages

Manifest, source, compiled IR, tests, telemetry requirements, budgets, provenance, and signatures.

0.120.0 — Predicate detection

Stateless field, content, list, range, and existence matching.

0.130.0 — Temporal automata

Sequences, negative conditions, timeouts, branching states, and explicit expiry.

0.140.0 — Detection state store

Partitioned state, checkpointing, bounded memory, recovery, and replay.

0.150.0 — Findings and evidence bundles

Immutable findings, evidence attachment, severity, confidence, explanations, and replay.

0.160.0 — Entity and graph detection

Cross-source entity resolution, relationship patterns, and attack-path detection.

0.170.0 — Behavioral engine

Rarity, baselines, peer groups, seasonal models, transition novelty, and drift health.

0.180.0 — Detection-content interoperability

Sigma import, STIX intelligence, ATT&CK mapping, list management, and import validation.

0.190.0 — Rule simulation and rollout

Historical simulation, shadow mode, canary mode, staged rollout, automatic rollback thresholds, and comparison reports.

0.200.0 — Detection security milestone

Deterministic replay campaign, state-exhaustion testing, hostile-rule tests, false-negative scenarios, and external detection review.

Phase G — Native operating-system agents
0.210.0 — Linux base agent

Journald, syslog, authentication, processes, services, packages, file integrity, spool, and health.

0.220.0 — Linux eBPF sensor

BTF-aware optional probes, privileged loader separation, process and network telemetry, detach detection, and fallback paths.

0.230.0 — Windows base agent

Event Log, ETW sessions, process, authentication, service, registry, scheduled-task, and agent-health telemetry.

0.240.0 — Windows advanced telemetry

Network, scripting, security-control health, WMI, optional driver boundary, and response adapters.

0.250.0 — macOS agent

Endpoint Security, Unified Logging, FSEvents, persistence, network metadata, permission health, and system-extension packaging.

0.260.0 — BSD and Kubernetes agents

FreeBSD/OpenBSD sources, pf, audit, Kubernetes audit, workload identity, and container context.

Phase H — SDK and connectors
0.270.0 — Public Rust SDK preview

Crates.io preview, stable core types, event submission, queries, findings, incidents, and streaming.

0.280.0 — Connector SDK

Typed connector lifecycle, checkpoints, rate limits, secret handles, test harness, and simulator.

0.290.0 — Cloud audit connectors

Major cloud control-plane, identity, storage, compute, and network audit sources.

0.300.0 — Identity and SaaS connectors

Major identity providers, productivity platforms, source-code platforms, ticketing, and generic API polling.

0.315.0 — Network-security ingestion

Flow, DNS, DHCP, VPN, firewall, proxy, email-security, and IDS-compatible inputs.

0.330.0 — Adaptive collection and source assurance

Telemetry-gap facts, collection-level requests, bounded escalation, automatic reversion, and completeness scoring.

Phase I — Analyst product
0.345.0 — Alert routing

Finding deduplication, routing, ownership, notification policy, suppression governance, and escalation.

0.360.0 — Incident graph

Automatic and manual grouping, entity timelines, hypotheses, relationship views, and reversible correlation.

0.375.0 — Case management

Tasks, comments, assignments, evidence, SLAs, approvals, collaboration, and complete history.

0.390.0 — Forensic reporting

Evidence exports, chain of custody, legal hold, signed reports, verification utility, and external-ticket linkage.

0.405.0 — Complete analyst and administration UI

Search, query, graph, timeline, cases, rule studio, source assurance, fleet, storage, tenant, and audit interfaces.

Phase J — Wasm and SOAR
0.420.0 — Wasm ABI and read-only host

WIT interfaces, module validation, signatures, fuel, memory limits, isolated worker, and read-only evidence capabilities.

0.430.0 — Playbook engine

Typed workflow state machine, retries, timeouts, branching, waiting, cancellation, and deterministic audit.

0.440.0 — Capability and secrets system

Unforgeable handles, scoped connector access, short-lived credentials, network allowlists, and tenant isolation.

0.450.0 — Response actions

Approvals, two-person rules, endpoint, identity, network, cloud, ticketing actions, verification, compensation, dry run, and canary execution.

Phase K — Cluster and federation
0.460.0 — Control plane

Configuration epochs, schema and rule registry, fleet management, trust roots, policy distribution, and drift detection.

0.465.0 — Metadata consensus

Leader election, replicated metadata, snapshots, membership changes, fault tests, and formal model alignment.

0.470.0 — Data replication

Partition placement, quorum acknowledgement, repair, rebalancing, integrity comparison, and rack awareness.

0.475.0 — Multi-tenancy and federated query

Tenant isolation, regional policy, distributed plans, partial-result semantics, and cross-region authorization.

0.480.0 — Multi-region and disaster recovery

Region loss, backup, restore, air-gap bundles, sovereign operation, rolling upgrade, and rollback.

Phase L — Completion and hardening
0.485.0 — AI assistance

Audited query drafting, rule proposals, incident summaries, evidence citations, local-model adapter, and complete disable mode.

0.490.0 — Privacy and compliance controls

Field policies, purpose limitation, residency, redaction, access reports, retention proofs, and privacy review.

0.492.0 — Performance campaign

Published reference hardware, sustained ingestion, query workloads, detection latency, cluster scaling, and agent overhead.

0.494.0 — Verification campaign

Full fuzzing, Kani, Loom, Miri, chaos testing, corruption testing, power-loss testing, and protocol conformance.

0.496.0 — Independent security assessment

External architecture review, source review, cluster pentest, agent pentest, Wasm-host pentest, cryptography review, and remediation.

0.498.0 — Public beta

Production-like deployments, migration testing, operator documentation, support tooling, and compatibility freeze.

0.499.0 — Release candidate

Feature freeze, API freeze, wire-format freeze, storage-format freeze, only security and correctness fixes accepted.

0.500.0 — Feature-complete stable candidate

All 1.0 capabilities present, all release gates green, complete upgrade path, complete recovery path, signed final audit evidence.

1.0.0 — Full SIEM release

The first stable release includes every product layer described in this plan. Subsequent 1.x releases may deliver security fixes, compatibility updates, performance improvements, standards updates, and new integration content, but must not be used to finish missing foundational SIEM capabilities.

24. Final 1.0 acceptance checklist

Version 1.0.0 is prohibited until all of the following are true:

Linux, Windows, macOS, BSD, and Kubernetes collection are operational.
Cloud, identity, network, syslog, OTLP, OCSF, and file ingestion are operational.
Raw source lineage and normalized facts are queryable.
Storage survives crash, corruption, node loss, and rolling upgrade tests.
Historical, live, temporal, graph, and federated SQR queries are operational.
Stateless, temporal, stateful, graph, behavioral, and integrity detection are operational.
Rule simulation, shadow mode, canary rollout, and rollback are operational.
Findings are deterministically replayable.
Alerting, incidents, cases, evidence, legal hold, and reports are operational.
Wasm components are capability-limited and run in isolated workers.
SOAR actions support approval, verification, idempotency, and compensation.
Multi-tenancy and field-level authorization have been independently tested.
Single-node, clustered, multi-region, and air-gapped deployments are documented and tested.
Backup, restore, repair, reindex, migration, and rollback tooling are complete.
The Rust SDK is published and documented.
Analyst and administration interfaces are complete.
Telemetry gaps and system impairment are first-class security signals.
No critical or high findings remain from the independent assessment.
The storage format, wire protocol, public SDK, and rule-package format are stable.
Reproducible builds and signed release artifacts are available.
Operational, security, developer, detection-engineering, and incident-response documentation is complete.

The result is not simply a Rust replacement for an existing SIEM stack. It is a security evidence system that can explain what it knows, what it inferred, what it could not observe, why a detection fired, and exactly what happened when the platform responded.

A repository-ready ARCHITECTURE.md, workspace dependency graph, and per-release pentest checklist would be the natural next format for this plan.
