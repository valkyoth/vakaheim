#!/usr/bin/env sh
set -eu

plan="docs/RELEASE_PLAN.md"
test -f "$plan"

releases="$(grep -c '^### v' "$plan")"
statuses="$(grep -c '^Status: ' "$plan")"
goals="$(grep -c '^Goal: ' "$plan")"
deliverables="$(grep -c '^Deliverables:$' "$plan")"
verification="$(grep -c '^Verification:$' "$plan")"
exits="$(grep -c '^Exit criteria:' "$plan")"

# One document-level status appears before the release sections.
if [ "$statuses" -ne $((releases + 1)) ]; then
    echo "every release must have one Status field" >&2
    exit 1
fi

for count in "$goals" "$deliverables" "$verification" "$exits"; do
    if [ "$count" -ne "$releases" ]; then
        echo "every release needs Goal, Deliverables, Verification, and Exit criteria" >&2
        exit 1
    fi
done

grep -q '^### v0.1.0 ' "$plan"
grep -q '^### v0.500.0 ' "$plan"
grep -q '^### v1.0.0-rc.1 ' "$plan"
grep -q '^### v1.0.0 ' "$plan"
grep -q 'Run pentest for this exact commit' "$plan"
