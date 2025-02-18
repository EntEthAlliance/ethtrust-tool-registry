# EEA EthTrust Tool Implementation Registry

Welcome to the **EthTrust-tool-registry** repository! This repository is designed to serves as a collaborative, community-driven directory for tools that support the [EEA EthTrust Security Levels Specification](https://entethalliance.org/specs/ethtrust-sl/).

This registry is a work in progress, and it will eventually provide a useful resource for organizations looking to adopt the specification. Right now it is in the early stages of design and construction, so we ask for patience and understanding as well as your feedback and contribution.

## What is this Registry?

This repository is a central place to:

*   Document tools that implement at least some part of the specification.
*   Collect Test Cases that can be used to verify Tools' ability to check requirements that are in the specification.
*   Provide structured data about their functionality, such as as testing results.

## Structure

*   **`smart-contracts/` Directory:** Solidity smart contracts to test the proposed tools for each level are in this directory, with links to them in this README.
*   **`templates/` Directory:** stuff that is getting moved into new issue/PR templates.
*   **`tools/` Directory:** Contains individual Markdown (`.md`) files for each tool or implementor listed in the registry. 
These files provide a concise overview of the tool. Detailed compliance data is expected to be available in a separate file referenced in the tool description.
*   **`list-of-tools.md`** This file serves as a central index of the tools/implementors. It's the primary entry point for users browsing the registry. The file may also be in JSON or YAML format.

## Contributing

### Submitting a Tool

Tool developers or implementors can add themselves to the registry by:

1.  Creating a new Issue using the provided template.
2.  Providing the output of the tests against the Level [S] template smart contracts
3.  The working group will review the submitted information, and may ask for further detail
4.  If that review is successful, a member of the group will add your details to the registry and close the Issue.

### Tests

[Testing Smart Contracts](smart-contracts)
