# Security Policy

Vakaheim is security-sensitive evidence infrastructure. Treat parsing,
identity, policy, authorization, storage, query, detection, sensors, extensions,
response, cluster, cryptography, dependencies, CI and release code as high risk.

## Current Scope

Version 0.1.0 is architecture and repository scaffolding. It has no operational
SIEM capability and should not process or protect production evidence.

## Routine Checks

Run regularly and before a release:

```bash
scripts/checks.sh
cargo deny check
cargo audit
scripts/generate-sbom.sh --check
scripts/check_latest_tools.sh
scripts/release_0_1_gate.sh
```

GitHub Actions run CI. Enable GitHub CodeQL default setup and do not add an
advanced CodeQL workflow while default setup is active. See
[GitHub Security Settings](docs/github-security-settings.md).

## Release Gate

Every release requires a clean implementation stop and exact-commit pentest.
The permanent `security/pentest/vX.Y.Z.md` must have `Status: PASS`, identify
the tester/date/scope, and name the exact full reviewed commit. The report-only
commit is the direct child of the reviewed implementation commit.

Root `PENTEST.md` is temporary findings input. It must be removed after
remediation and must never be committed. No tag, publication, release or
deployment is automatic.

## Dependencies And Publishing

Vakaheim permits no third-party runtime, build or development crates. Product
dependencies must be workspace paths. Every current package has
`publish = false`; no current crate may be uploaded to a registry. See the
[Supply-Chain Security](docs/supply-chain-security.md) and
[Publishing Policy](docs/publishing-policy.md).

## Reporting

Do not disclose exploitable details publicly before a fix is available. Use a
private GitHub security advisory once repository security channels are enabled,
or contact the maintainers privately.

Include the affected version/commit, platform, impact, minimal reproduction,
preconditions and any suggested remediation. Do not include real secrets or
production evidence.
