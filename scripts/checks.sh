#!/usr/bin/env sh
set -eu

cargo fmt --all --check
scripts/check_shell_syntax.sh
scripts/check_doc_links.sh
scripts/check_release_plan.sh
scripts/validate-release-metadata.sh
scripts/validate-engineering-policy.sh
scripts/validate-modularity-policy.sh
scripts/validate-publishing-policy.sh
scripts/validate-security-policy.sh

cargo check --workspace --all-targets --all-features --locked
cargo clippy --workspace --all-targets --all-features --locked -- -D warnings
cargo test --workspace --all-features --locked
cargo test --workspace --all-features --locked --doc
cargo doc --workspace --all-features --no-deps --locked
