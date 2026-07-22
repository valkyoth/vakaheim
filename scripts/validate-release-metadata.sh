#!/usr/bin/env sh
set -eu

if [ -f PENTEST.md ]; then
    echo "PENTEST.md is temporary pentest input; resolve and remove it" >&2
    exit 1
fi

required="
README.md
ARCHITECTURE.md
LICENSE
SECURITY.md
CHANGELOG.md
Cargo.toml
Cargo.lock
deny.toml
rust-toolchain.toml
docs/IMPLEMENTATION_PLAN.md
docs/RELEASE_PLAN.md
docs/VERSION_PLAN.md
docs/initial-idea.md
docs/threat-model.md
docs/security-controls.md
docs/release-runbook.md
release-notes/RELEASE_NOTES_0.1.0.md
security/pentest/README.md
scripts/validate-release-readiness.sh
"

for path in $required; do
    if [ ! -f "$path" ]; then
        echo "missing required release metadata: $path" >&2
        exit 1
    fi
done

grep -q '^version = "0.1.0"$' Cargo.toml
grep -q '^rust-version = "1.97.1"$' Cargo.toml
grep -q '^channel = "1.97.1"$' rust-toolchain.toml
grep -q '^license = "EUPL-1.2"$' Cargo.toml
grep -q '^## \[0.1.0\]' CHANGELOG.md
grep -q '^# Vakaheim 0.1.0 Release Notes' release-notes/RELEASE_NOTES_0.1.0.md
grep -q 'workflow_dispatch:' .github/workflows/release.yml
! grep -q 'tags:' .github/workflows/release.yml
! grep -Eq 'cargo[[:space:]]+publish' .github/workflows/*.yml scripts/*.sh
