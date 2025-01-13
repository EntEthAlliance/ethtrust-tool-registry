## Olympix Static Analysis Tool

**Version:** v0.9.43

**Website:** [https://www.olympix.ai/](https://www.olympix.ai/)

**Description:** Static analysis tool for Smart Contracts, covering a wide array of vulnerabilities.

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
    - Strict Ether Balance Check
    - Use of assembly with Caution
    - No Arbitrary delegatecall
    - Explicit Visibility Declarations
    - No Exact Balance Check

### Level M
    - Avoid Reentrancy
    - No Insufficient Parameter Validation
    - Avoid Using Block Randomness
    - Ensure ERC-20 Interface Compliance
    - Avoid Multiple Integer Casts
    - Proper Low-Level Call Parameter Verification
    - Properly Handle Payable Functions
    - Avoid Unbounded pragma Statements
    - Handle transferFrom Securely
    - Avoid Calls in Loop
    - Proper State Keyword Use (view, pure, constant)
    - Prevent Locked Ether
    - No Arbitrary Downcasting of Numbers to Addresses
    - Check Division by Zero
    - Avoid Using External Calls in a Loop
    - Proper Initialization of Local Storage Variables


### Other Information

_For detailed compliance data, including details of each security level, please see [`EEA EthTrust Security Levels Specification`](https://entethalliance.github.io/eta-registry/security-levels-spec.html)._
