//! Vakaheim's dependency-free, `no_std` facade.
//!
//! The current `0.1.0` release establishes repository and architectural
//! boundaries. It intentionally makes no operational SIEM capability claim.

#![no_std]
#![forbid(unsafe_code)]

/// Checked byte-processing boundaries.
pub use vakaheim_bytes as bytes;
/// Shared project identity and foundational contracts.
pub use vakaheim_core as core;

#[cfg(test)]
mod tests {
    #[test]
    fn facade_exposes_project_identity() {
        assert_eq!(crate::core::PROJECT_NAME, "Vakaheim");
        assert_eq!(crate::core::PROJECT_SLOGAN, "The Realm of Vigil");
    }
}
