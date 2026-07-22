# Modularity Policy

Vakaheim uses crates to express environmental, privilege, security, testing,
dependency, API, licensing, and release boundaries. It does not split code only
to satisfy aesthetics, and it does not allow large modules to hide complexity.

## Rules

- Non-generated Rust source files may never exceed 500 lines.
- Split before the limit is crossed; do not wait for the gate to fail.
- Portable domain logic may not import host adapters.
- `std`, OS APIs, FFI, privileged code, and any future unsafe code require an
  explicit boundary crate.
- Parser, codec, state-machine, storage-format, and authorization surfaces
  require independently testable modules and focused fuzz/formal targets.
- Main/facade crates compose and re-export; they do not accumulate thousands of
  lines of implementation.
- The root `README.md` is the single GitHub-facing project overview. Detailed
  crate boundaries, environments, security claims, and publishing status live
  in the canonical `docs/` material and rustdoc, avoiding duplicated per-crate
  README files for private workspace crates.

The gate lives in `scripts/validate-modularity-policy.sh`.
