# Toolchain Policy

Vakaheim uses the latest stable Rust release, including the latest stable patch.
The current pin is Rust 1.97.1.

The same value must appear in `rust-toolchain.toml` and Cargo workspace package
metadata. Rustfmt and Clippy are mandatory. CI tools and GitHub Actions are
also pinned to reviewed exact versions or SHAs.

Run `scripts/check_latest_tools.sh` regularly and before every release. If a
new stable Rust or pinned tool exists, update the repository, read its release
and migration notes, fix warnings or semantic changes, rerun all gates and
supported-target checks, update documentation/release notes, and include the
change in pentest scope.

Latest does not mean blindly automatic: no toolchain or action update merges
without clean tests and review.
