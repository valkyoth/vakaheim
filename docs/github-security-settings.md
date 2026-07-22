# GitHub Security Settings

Repository administrators should enable:

- private vulnerability reporting and security advisories;
- CodeQL default setup for Rust;
- secret scanning and push protection where available;
- Dependabot alerts and the committed update configuration;
- branch protection requiring CI and review;
- signed commits/tags or vigilant mode where organizational policy permits;
- least-privilege workflow token permissions.

Do not commit an advanced CodeQL workflow while default setup is enabled. The
repository CI workflow handles build, test, lint, policy, audit, and SBOM work;
GitHub handles CodeQL default configuration.
