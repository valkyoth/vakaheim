# Security Controls

Status: baseline control catalogue

| Control | Baseline requirement |
| --- | --- |
| Unsafe Rust | Forbidden in all current crates; future exceptions require isolated crates and review |
| Dependencies | No third-party runtime, build, or dev crates; workspace-only gate |
| Publishing | `publish = false` on every package; no registry workflow |
| Input safety | Checked bounds/arithmetic, explicit limits, structured errors, no panic on malformed input |
| Memory safety | Safe Rust, bounded collections, explicit secret lifetimes, no ambient raw pointers |
| Data loss | Never silent; preserve/summarize/suppress states and durable gap evidence |
| Provenance | Source bytes or digest, parser, mapping, rule, state, policy, and action lineage |
| Authorization | Deny by default; tenant, field, residency, classification, purpose, and capability checks |
| Privilege | Separate small helpers and isolated workers; least privilege and no ambient authority |
| Integrity | Versioned deterministic formats, checksums, digests, linkage, authentication, verification |
| Secrets | No repository secrets; short-lived scoped handles; never exposed to extensions by default |
| AI | Proposal-only, evidence-bound, audited, disableable, never direct action or rule activation |
| Supply chain | Pinned stable Rust/tools/actions, locked builds, source policy, SBOM, audit, freshness check |
| Modularity | Security-boundary crates and maximum 500-line Rust files |
| Release | Clean gates, threat delta, notes, exact-commit pentest, no tag or publication automation |

Controls become executable as the owning milestone lands. A documented control
without automated evidence is not treated as implemented.
