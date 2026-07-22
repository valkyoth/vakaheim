#!/usr/bin/env sh
set -eu

mode="${1:-check}"
targets="
x86_64-unknown-linux-gnu
x86_64-pc-windows-gnu
aarch64-apple-darwin
x86_64-unknown-freebsd
aarch64-linux-android
x86_64-linux-android
aarch64-apple-ios
"

case "$mode" in
    --install)
        # Installation is a networked setup/release action, not a normal check.
        rustup target add --toolchain 1.97.1 $targets
        ;;
    check) ;;
    *)
        echo "usage: scripts/check_portable_targets.sh [check|--install]" >&2
        exit 2
        ;;
esac

installed="$(rustup target list --installed --toolchain 1.97.1)"
for target in $targets; do
    if ! printf '%s\n' "$installed" | grep -qx "$target"; then
        echo "missing Rust target $target; rerun with --install" >&2
        exit 1
    fi
    cargo check --workspace --target "$target" --locked
done
