# Contributing To Vakaheim

Vakaheim is security-sensitive evidence infrastructure. Contributions must be
small, explicit, tested, and honest about current capability.

## License

Vakaheim is licensed under EUPL-1.2. By contributing, you agree that your
contribution is provided under the same license. A future approved SDK is the
only possible `MIT OR Apache-2.0` exception.

## Development

Use the pinned toolchain and run:

```bash
cargo check --workspace --all-targets --all-features --locked
cargo test --workspace --all-features --locked
scripts/checks.sh
```

Run the networked `scripts/check_latest_tools.sh` regularly and before release.

## Security-Sensitive Changes

Treat all parsing, evidence, identity, policy, authorization, persistence,
query, detection, response, cryptography, OS/FFI, CI, release, dependency,
unsafe and publishing changes as high risk. Update threat-model and test
evidence with the change.

Do not publish exploitable details in an issue. Follow
[SECURITY.md](../SECURITY.md).

## Dependencies And Publishing

Third-party runtime, build, and development crates are prohibited. Do not add a
registry or git dependency. Every package must retain `publish = false` unless
the future SDK exception has been explicitly approved.

## Code Structure

Rust files may not exceed 500 lines. Split by environment, privilege, security,
testing, API, dependency or release boundary before files become large.
