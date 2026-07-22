#!/usr/bin/env sh
set -eu

scripts/checks.sh
cargo deny check
cargo audit
scripts/generate-sbom.sh --check
scripts/check_latest_tools.sh
scripts/check_portable_targets.sh --install
scripts/validate-release-readiness.sh v0.1.0
