# KubeLaunch - Design Overview

This document outlines the architectural decisions behind KubeLaunch and defines the boundaries of what the project aims to support.

## Design Goals

- High Availability by default
- Deterministic and repeatable infrastructure
- Minimal assumptions about environment and OS
- Production-grade patterns over convenience shortcuts

## Round-Robin AZ Placement

Nodes are distributed across Availability Zones using a round-robin strategy to:
- Avoid single-AZ failure domains
- Ensure even fault tolerance for control plane and workers
- Keep placement logic simple, predictable, and auditable

This approach avoids reliance on AWS-managed schedulers or opaque placement behavior.

## kubeadm-Based Bootstrap

kubeadm is used because:
- It is upstream Kubernetes-supported
- Provides explicit control over cluster initialization and joins
- Avoids vendor lock-in
- Matches common production self-managed Kubernetes setups

The goal is transparency and debuggability over abstraction.

## Private Subnets with Bastion Access

All Kubernetes nodes are deployed in private subnets to:
- Eliminate direct public exposure
- Enforce controlled access patterns
- Align with enterprise security expectations

A bastion host is used as the single controlled entry point for administrative access.

## Stability and Compatibility

Backward compatibility and predictable behavior take precedence over rapid feature addition. Breaking changes should be avoided unless absolutely necessary.
