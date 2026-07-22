//! Dependency-free foundational contracts for Vakaheim.
//!
//! Domain types enter this crate only when they are portable, deterministic,
//! independently testable, and free from operating-system assumptions.

#![no_std]
#![forbid(unsafe_code)]

/// Canonical project name.
pub const PROJECT_NAME: &str = "Vakaheim";

/// Canonical project slogan.
pub const PROJECT_SLOGAN: &str = "The Realm of Vigil";

/// Current workspace version.
pub const VERSION: &str = env!("CARGO_PKG_VERSION");

#[cfg(test)]
mod tests {
    #[test]
    fn project_identity_is_stable() {
        assert_eq!(crate::PROJECT_NAME, "Vakaheim");
        assert_eq!(crate::PROJECT_SLOGAN, "The Realm of Vigil");
        assert_eq!(crate::VERSION, "0.1.0");
    }
}
