#!/usr/bin/env sh
set -eu

grep -q '#!\[forbid(unsafe_code)\]' crates/vakaheim/src/lib.rs
grep -q 'unknown-git = "deny"' deny.toml
grep -q 'unknown-registry = "deny"' deny.toml
grep -q 'panic = "abort"' Cargo.toml
grep -q 'CodeQL default setup' SECURITY.md
grep -q 'no third-party' docs/supply-chain-security.md
grep -q 'publish = false' docs/publishing-policy.md
test -f docs/github-security-settings.md
test -f docs/unsafe-policy.md
test -f docs/threat-model.md
test -f docs/security-controls.md
test ! -f .github/workflows/codeql.yml
