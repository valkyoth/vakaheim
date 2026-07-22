<p align="center">
  <b>Vakaheim — The Realm of Vigil.</b><br>
  A security-first, evidence-native SIEM platform built in Rust through small, independently reviewed releases.
</p>

<div align="center">
  <a href="docs/IMPLEMENTATION_PLAN.md">Implementation Plan</a>
  ·
  <a href="docs/RELEASE_PLAN.md">Release Plan</a>
  ·
  <a href="docs/threat-model.md">Threat Model</a>
  ·
  <a href="docs/security-controls.md">Security Controls</a>
  ·
  <a href="SECURITY.md">Security</a>
</div>

<br>

<p align="center">
  <a href="https://github.com/valkyoth/vakaheim">
    <img src="https://raw.githubusercontent.com/valkyoth/vakaheim/main/.github/images/vakaheim.webp" alt="Vakaheim — The Realm of Vigil">
  </a>
</p>

# Vakaheim

Vakaheim is a planned distributed security evidence, reasoning, detection,
investigation, and response platform. Raw observations become immutable facts,
facts retain provenance, detections produce explainable findings, findings form
incidents, and incidents may trigger controlled and reversible actions.

The platform is designed to operate as a small appliance, an enterprise
cluster, an endpoint collector, an air-gapped deployment, a sovereign
multi-region system, or a selected embedded `no_std` core. The server will not
require Kafka, Elasticsearch, PostgreSQL, Redis, ClickHouse, an external object
database, or an external workflow platform.

The current version is `0.1.0`. It establishes the architecture constitution,
repository policy, security gates, `no_std` crate boundaries, and release plan.
It is not an operational SIEM, collector, database, query engine, detector, or
response system.

Vakaheim is licensed under the European Union Public Licence 1.2.

## Current Foundation

| Capability | Status | Current scope |
| --- | --- | --- |
| Rust workspace | Active | Edition 2024, resolver 3, stable Rust 1.97.1 pinned |
| `no_std` core | Active | The facade and initial foundation crates compile without `std` |
| Dependency policy | Active | No third-party runtime, build, or development crates |
| Publishing policy | Active | Every crate has `publish = false`; crates.io publication is prohibited |
| Unsafe policy | Active | Unsafe Rust is forbidden in every current crate |
| Modularity gate | Active | Non-generated Rust source files may not exceed 500 lines |
| Security gate | Active | Format, lint, tests, docs, policy checks, SBOM, audit, and pentest handoff |
| Product capabilities | Planned | All operational SIEM features remain milestones on the road to 1.0 |

## Architectural Law

- Deterministic security logic belongs in portable `no_std` crates.
- OS, storage, networking, UI, and other host integrations belong in explicit
  and narrowly scoped `std` adapters.
- Untrusted bytes are decoded with checked cursors; they are never cast into
  Rust or C-layout structures.
- Resource use is bounded, overflow is explicit, malformed input does not
  panic, and silent data loss is prohibited.
- Evidence retains source, parser, mapping, policy, rule, and action lineage.
- AI may propose and explain; it may not activate rules, suppress telemetry, or
  execute response actions.
- Wasm is an extension boundary, not the only sandbox.
- Security-sensitive dependencies are not admitted. The current workspace has
  no third-party crates.
- Every tagged version requires exact-commit pentest evidence.

## Workspace

| Crate | Environment | Purpose | Published |
| --- | --- | --- | --- |
| `vakaheim` | `no_std` | Public internal facade over admitted foundation crates | Never |
| `vakaheim-core` | `no_std` | Portable identity and future shared foundational contracts | Never |
| `vakaheim-bytes` | `no_std` | Checked byte-processing boundary; cursor work begins in 0.2.0 | Never |

New crates are added only when a security, privilege, portability, testing,
public-API, or release boundary justifies the split. Product binaries and host
adapters may use `std` when their milestone begins.

## Build And Test

Use the pinned toolchain:

```bash
cargo build --workspace --locked
cargo test --workspace --locked
scripts/checks.sh
```

The networked freshness check is deliberately separate from the offline local
gate:

```bash
scripts/check_latest_tools.sh
```

Platform-specific compile checks and future fuzzing, Miri, Kani, Loom,
conformance, attack-scenario, upgrade, recovery, and performance gates are
introduced before the milestones that rely on them.

## Platform Direction

Vakaheim is designed from day one for Linux, Windows, macOS, FreeBSD/OpenBSD,
Android, and iOS. The portable core must not assume a particular OS,
architecture, allocator, async runtime, filesystem, network stack, byte order,
or pointer width. Aesynx support is a future adapter target and must remain
possible, but is not claimed today.

## Publishing

No current Vakaheim crate may be published to crates.io or any other registry.
`publish = false` is mandatory and checked by the repository gate. If a public
SDK is approved later, only the explicitly reviewed SDK package may change to
`MIT OR Apache-2.0` and become publishable; all other crates remain private and
EUPL-1.2.

## Release Discipline

Each version is a small implementation stop with a goal, deliverables,
verification, and exit criteria. When implementation and clean retesting are
complete, work stops for an exact-commit pentest. Findings are fixed before a
permanent passing report and tag are allowed.

Tags, registry publication, releases, and external deployment are never
performed automatically by this repository.

## Documentation

- [Architecture](ARCHITECTURE.md)
- [Implementation Plan](docs/IMPLEMENTATION_PLAN.md)
- [Release Plan](docs/RELEASE_PLAN.md)
- [Initial Idea](docs/initial-idea.md)
- [Threat Model](docs/threat-model.md)
- [Security Controls](docs/security-controls.md)
- [Supply-Chain Security](docs/supply-chain-security.md)
- [Unsafe Policy](docs/unsafe-policy.md)
- [Modularity Policy](docs/modularity-policy.md)
- [Toolchain Policy](docs/toolchain-policy.md)
- [Publishing Policy](docs/publishing-policy.md)
- [Platform Support](docs/platform-support.md)
- [Release Runbook](docs/release-runbook.md)
