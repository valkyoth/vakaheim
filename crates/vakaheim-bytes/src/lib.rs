//! Checked byte-boundary crate for Vakaheim.
//!
//! The bounded cursor implementation is assigned to `v0.2.0`. This crate is
//! present in `v0.1.0` so the security boundary is explicit before code lands.

#![no_std]
#![forbid(unsafe_code)]

/// Maximum byte offset representable by the initial checked-cursor contract.
///
/// The constant documents that offsets use the target's native `usize`; every
/// future offset transition must use checked arithmetic.
pub const MAX_OFFSET: usize = usize::MAX;

#[cfg(test)]
mod tests {
    #[test]
    fn offset_domain_matches_target_pointer_width() {
        assert_eq!(crate::MAX_OFFSET, usize::MAX);
    }
}
