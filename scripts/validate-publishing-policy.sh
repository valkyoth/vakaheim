#!/usr/bin/env sh
set -eu

failed=0
for manifest in crates/*/Cargo.toml; do
    if ! grep -q '^publish = false$' "$manifest"; then
        echo "$manifest must set publish = false" >&2
        failed=1
    fi
done

metadata="$(cargo metadata --format-version 1 --locked)"
if printf '%s\n' "$metadata" | grep -Eq '"source":"(registry|git)\+'; then
    echo "third-party registry or git package found in Cargo metadata" >&2
    failed=1
fi

if printf '%s\n' "$metadata" | grep -Eq '"publish":(null|\[[^]]+\])'; then
    echo "one or more workspace packages are publishable" >&2
    failed=1
fi

if rg -n '(^|[[:space:]])cargo[[:space:]]+publish|crates\.io/api/v1/crates/new' . \
    --glob '!docs/initial-idea.md' --glob '!docs/*.md' --glob '!README.md' \
    --glob '!target/**'; then
    echo "repository automation must not publish crates" >&2
    failed=1
fi

exit "$failed"
