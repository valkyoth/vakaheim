# Release Runbook

No step in this runbook authorizes tagging, publishing, pushing, deploying, or
creating a GitHub release. Those actions require an explicit maintainer request.

## Implementation Stop

1. Complete only the selected version's deliverables.
2. Update threat model, documentation, tests, and release notes.
3. Run `scripts/checks.sh`, `cargo deny check`, `cargo audit`, SBOM validation,
   supported-target checks, and the version gate.
4. Run `scripts/check_latest_tools.sh` with network access.
5. Record the exact full implementation commit.
6. Stop and state: `vX.Y.Z implementation stop reached. Run pentest for this
   exact commit.`

## Pentest And Remediation

1. The tester records temporary findings in root `PENTEST.md`.
2. Fix findings; add regressions and update documentation and notes.
3. Remove `PENTEST.md` before the remediation commit.
4. Rerun all gates and inspect GitHub CI and CodeQL default results.
5. Pentest the final implementation commit again.
6. Add `security/pentest/vX.Y.Z.md` with `Status: PASS`, tester, date, scope,
   exact reviewed commit, tools, evidence, and residual risks.
7. Commit only the permanent report as the direct child of the reviewed commit.
8. Run readiness validation again.

## Release Evidence

Every release retains release notes, threat delta, test/gate output, dependency
and unsafe diffs, SBOM, known limitations, pentest evidence, and exact commit.
Patch releases follow the same process and may not smuggle unrelated features.
