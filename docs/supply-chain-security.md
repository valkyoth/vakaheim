# Supply-Chain Security

Vakaheim currently has no third-party runtime, build, or development crates.
Only workspace path dependencies may appear in product manifests.

## Required Controls

- Pin the latest stable Rust patch in `rust-toolchain.toml` and
  `workspace.package.rust-version`.
- Pin CI tools to exact versions and GitHub Actions to full commit SHAs.
- Commit `Cargo.lock` and use `--locked` in gates and CI.
- Reject wildcard, git, registry, or other sourced product dependencies.
- Run `cargo deny`, `cargo audit`, metadata source validation, and SBOM checks.
- Review all changes to manifests, lockfiles, workflows, scripts, and release
  metadata as security-sensitive.
- Keep GitHub CodeQL default setup enabled; do not add advanced CodeQL workflow
  configuration while default setup is active.
- Produce release artifacts only after exact-commit pentest evidence.

## Freshness

`scripts/check_latest_tools.sh` performs the networked freshness gate for
stable Rust, cargo-deny, cargo-audit, cargo-sbom, and GitHub Action pins. Run it
regularly and before every release. Normal offline checks intentionally do not
depend on upstream network availability.

## Future Dependency Exception

The standing policy is no third-party crates. If a future security requirement
cannot be met safely under that policy, implementation stops for a written
decision covering need, alternatives, source, license, maintainership,
features, `no_std` impact, transitive graph, unsafe code, cryptographic review,
tests, update plan, replacement plan, and pentest scope. Admission is not
implied by documentation and requires explicit maintainer direction.
