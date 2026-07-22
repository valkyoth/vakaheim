# Vakaheim 0.1.0 Release Notes

Status: implementation foundation; not tag-ready until pentest passes

## Scope

Version 0.1.0 establishes Vakaheim's architecture and repository constitution.
It creates the dependency-free `no_std` facade and two foundation boundary
crates, pins Rust 1.97.1, defines the complete release road to 1.0, and adds
security, test, dependency, publishing, modularity, and pentest gates.

## Security

- Unsafe Rust is forbidden.
- All product dependencies are local workspace paths.
- Every crate has `publish = false`.
- Rust files are limited to 500 lines.
- GitHub CodeQL uses default setup rather than an advanced workflow.
- Exact-commit pentest evidence is required before a version tag.

## Verification

Run:

```bash
scripts/checks.sh
cargo deny check
cargo audit
scripts/generate-sbom.sh --check
scripts/check_latest_tools.sh
scripts/release_0_1_gate.sh
```

## Known Limitations

This version has no operational ingestion, storage, query, detection, sensor,
incident, response, cluster, SDK, or UI capability. Those claims remain
explicit future milestones.

## Stop

After all checks are clean, stop for an exact-commit pentest. Do not tag,
publish, deploy, or claim production readiness.
