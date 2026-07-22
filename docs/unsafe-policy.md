# Unsafe Rust Policy

Unsafe Rust is forbidden throughout the current workspace.

Every crate contains `#![forbid(unsafe_code)]`, workspace lint policy also
forbids unsafe code, and repository checks reject unsafe tokens in Rust source.

If a future platform FFI, memory mapping, direct I/O, eBPF, ring buffer, or
hardware-key boundary genuinely requires unsafe Rust, it must be introduced in
a named isolated crate by an explicit release milestone. That milestone must
define invariants, safe wrapper semantics, platform coverage, Miri where
applicable, fuzz/property tests, concurrency analysis, a dedicated reviewer,
an unsafe diff gate, and a safe reference implementation where possible.

No unsafe expansion is allowed during a release-candidate freeze without a
documented security exception and a new candidate.
