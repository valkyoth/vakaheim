#!/usr/bin/env sh
set -eu

violations="$(find crates -type f -name '*.rs' -exec wc -l {} \; | awk '$1 > 500 { print }')"
if [ -n "$violations" ]; then
    echo "Rust files exceed 500 lines:" >&2
    echo "$violations" >&2
    exit 1
fi

grep -q '"crates/vakaheim"' Cargo.toml
grep -q '"crates/vakaheim-core"' Cargo.toml
grep -q '"crates/vakaheim-bytes"' Cargo.toml
