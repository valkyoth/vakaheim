# Threat Model

Status: baseline for version 0.1.0

## Assets

- source evidence, normalized facts, findings, incidents, cases, and reports;
- tenant, identity, residency, classification, purpose, and retention labels;
- cryptographic keys, trust roots, credentials, approvals, and capabilities;
- rules, schemas, parsers, mappings, policies, configuration, and audit logs;
- storage segments, indexes, WAL, spool, backups, exports, and migration state;
- source availability, sequence continuity, clock quality, and completeness;
- analyst, administrator, service, agent, node, connector, and component identity.

## Adversaries

Vakaheim considers malicious external senders, compromised sources, tenants,
insiders, administrators, connectors, cluster nodes, supply-chain actors, and
extension authors. Accidental misconfiguration, software defects, hardware
faults, resource exhaustion, clock skew, and incomplete telemetry are treated
as security-relevant failure sources.

## Principal Threats

- malformed input causing panic, memory corruption, excessive work, or parser
  ambiguity;
- spoofing, replay, reordering, duplication, truncation, or suppression of
  telemetry;
- silent data loss under overload or source/collector failure;
- cross-tenant, cross-region, field-level, or purpose-policy disclosure;
- evidence, rule, schema, index, audit, backup, or configuration tampering;
- privilege escalation through OS helpers, Wasm, connectors, actions, or AI;
- key theft, confused-deputy use, stale authorization, and approval bypass;
- storage corruption, rollback, torn writes, split brain, and stale leaders;
- unbounded query, detection, regex, graph, state, queue, or response work;
- dependency, toolchain, CI, release, artifact, and maintainer compromise;
- incomplete results being presented as complete or inference as fact.

## Trust Boundaries

Every sensor input, transport, parser, codec, host adapter, storage reader,
query API, rule package, Wasm component, connector, response worker, cluster
message, update bundle, backup, and AI exchange is a trust boundary.

## Baseline Controls

- dependency-free `no_std` trusted core and unsafe forbidden by default;
- checked arithmetic, bounded resource policies, structured errors, no panic on
  untrusted input, and deterministic formats;
- authenticated identities, short-lived authority, least privilege, tenant and
  policy enforcement at planning and access;
- immutable evidence with lineage, integrity verification, and independent
  audit stream;
- explicit data-loss evidence and completeness reporting;
- isolated privileged helpers, connectors, Wasm workers, and response actions;
- signed versioned artifacts and staged rollout with rollback;
- exact-commit tests, adversarial verification, pentest, and release evidence.

## Out Of Scope At 0.1.0

The current release is repository scaffolding and architecture documentation.
It processes no telemetry, stores no evidence, opens no network service,
executes no extension, and performs no response. Operational threats become
active only as their release milestones begin, but their boundaries must be
designed before implementation.

## Review Rule

Every release records a threat-model delta. New data flows, privilege,
dependencies, unsafe code, formats, protocols, persistence, cryptography, or
external integrations block release until this model and the relevant tests
are updated.
