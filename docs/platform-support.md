# Platform Support

## Day-One Architecture Targets

| Platform | Foundation target | Native collection target |
| --- | --- | --- |
| Linux | Portable core and hosted services | journald, audit, process, identity, network, container, optional eBPF |
| Windows | Portable core and hosted services | Event Log, ETW, process, identity, registry, network |
| macOS | Portable core and hosted services | Endpoint Security, Unified Logging, FSEvents |
| FreeBSD/OpenBSD | Portable core and hosted services | syslog, audit/OpenBSM, kqueue, process accounting, pf |
| Android | Portable core and constrained adapter | platform-permitted device/application telemetry |
| iOS | Portable core and constrained adapter | platform-permitted device/application telemetry |
| Aesynx | Architecture must remain compatible | adapter after Aesynx interfaces stabilize |

At 0.1.0, support means the portable architecture and representative compile
checks are established. It does not mean native collectors exist. Each native
support claim requires real-system tests, permission-loss tests, packaging,
upgrade/rollback evidence, performance data, security review, and pentest.

Portable crates must not assume an OS, filesystem, sockets, threads, allocator,
endian order, pointer width, async runtime, process model, or architecture.
