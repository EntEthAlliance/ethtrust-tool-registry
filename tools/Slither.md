## Slither Static Analysis Tool

**Version:** v0.10.4

**Website:** [https://github.com/crytic/slither](https://github.com/crytic/slither)

**Description:** Slither is a static analysis framework for Solidity, used for finding vulnerabilities, optimizing code, and creating detailed reports.

**Supported Security Levels:** 

### Level S
    - No selfdestruct()
    - Use Check-Effects-Interaction Pattern
    - No Hashing Consecutive Variable Length Arguments
    - Check External Calls Return
    - No delegatecall()
    - No tx.origin
    - Explicit Storage
    - Explicit Constructors

### Level M
    -  TBC

### Other Information

_For detailed compliance data, including details of each security level, please see [`implementation-status.md`](implementation-status.md) file._