#!/usr/bin/env sh
set -eu

failed=0

for lib in crates/*/src/lib.rs; do
    if ! grep -q '#!\[no_std\]' "$lib"; then
        echo "$lib must use #![no_std]" >&2
        failed=1
    fi
    if ! grep -q '#!\[forbid(unsafe_code)\]' "$lib"; then
        echo "$lib must use #![forbid(unsafe_code)]" >&2
        failed=1
    fi
done

if rg -n '\bstd::|extern crate std|use std' crates --glob '*.rs'; then
    echo "current crates must not import std" >&2
    failed=1
fi

if rg -n '(^|[^[:alnum:]_])unsafe([^[:alnum:]_]|$)' crates --glob '*.rs'; then
    echo "unsafe Rust is forbidden in current crates" >&2
    failed=1
fi

if rg -n 'target_arch|target_feature|std::arch|core::arch' crates --glob '*.rs'; then
    echo "architecture-specific code requires an admitted adapter boundary" >&2
    failed=1
fi

exit "$failed"
