# Publishing Policy

No current Vakaheim crate may be published to crates.io or another registry.

## Enforcement

- Every package manifest explicitly sets `publish = false`.
- Repository checks inspect Cargo metadata and fail if any package has an
  allowed registry.
- Product dependency sources must be local workspace paths.
- GitHub workflows do not run `cargo publish`, create tags, or push releases.
- Release plans and notes may not instruct operators to publish current crates.

## Future SDK Exception

A future SDK may be considered only at its dedicated pre-1.0 milestone. The
exception requires explicit maintainer approval, API and protocol review,
semver/compatibility tests, package-content review, independent pentest, and a
new workflow decision. Only the approved SDK package may use
`MIT OR Apache-2.0`; all internal crates remain EUPL-1.2 and unpublished.

Until that decision is recorded and implemented, even the SDK workspace crate
must use `publish = false`.
