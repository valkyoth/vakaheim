#!/usr/bin/env sh
set -eu

ci_file=".github/workflows/ci.yml"
rust_stable_manifest_url="${RUST_STABLE_MANIFEST_URL:-https://static.rust-lang.org/dist/channel-rust-stable.toml}"

pinned_rust="$(sed -n 's/^channel = "\([0-9][0-9.]*\)"$/\1/p' rust-toolchain.toml | head -n 1)"
latest_rust="$(curl -fsSL "$rust_stable_manifest_url" | sed -n '/^\[pkg\.rust\]$/,/^\[/ { s/^version = "\([0-9][0-9.]*\) .*/\1/p; }' | head -n 1)"
test -n "$pinned_rust"
test -n "$latest_rust"
if [ "$pinned_rust" != "$latest_rust" ]; then
    echo "Rust is not latest stable: pinned $pinned_rust, latest $latest_rust" >&2
    exit 1
fi

for tool in cargo-deny cargo-audit cargo-sbom; do
    pinned="$(sed -n "s/.*cargo install --locked $tool --version \([0-9][^ ]*\).*/\1/p" "$ci_file" | head -n 1)"
    latest="$(cargo info "$tool" | sed -n 's/^version: //p' | head -n 1)"
    test -n "$pinned"
    test -n "$latest"
    if [ "$pinned" != "$latest" ]; then
        echo "$tool is not latest: pinned $pinned, latest $latest" >&2
        exit 1
    fi
done

failed=0
while IFS= read -r ref; do
    case "$ref" in
        "") ;;
        [0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) ;;
        *)
            echo "GitHub Action is not pinned to a full SHA: $ref" >&2
            failed=1
            ;;
    esac
done <<EOF
$(sed -n 's/^[[:space:]]*uses: [^@][^@]*@\([^[:space:]]*\).*/\1/p' "$ci_file" .github/workflows/release.yml)
EOF
test "$failed" -eq 0

pinned_checkout="$(sed -n 's/.*actions\/checkout@\([0-9a-f]\{40\}\) # \(v[0-9][0-9.]*\).*/\1 \2/p' "$ci_file" | head -n 1)"
test -n "$pinned_checkout"
pinned_sha="$(printf '%s\n' "$pinned_checkout" | awk '{ print $1 }')"
pinned_tag="$(printf '%s\n' "$pinned_checkout" | awk '{ print $2 }')"
latest_tag="$(git ls-remote --tags --refs https://github.com/actions/checkout.git 'refs/tags/v*' | sed 's#.*refs/tags/##' | grep -E '^v[0-9]+(\.[0-9]+)*$' | sort -V | tail -n 1)"
latest_sha="$(git ls-remote --tags --refs https://github.com/actions/checkout.git "refs/tags/$latest_tag" | awk '{ print $1 }')"
test "$pinned_tag" = "$latest_tag"
test "$pinned_sha" = "$latest_sha"

echo "Rust and pinned CI tooling are current"
