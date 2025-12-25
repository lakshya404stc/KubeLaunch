# Contributing to KubeLaunch

Thanks for your interest in contributing to KubeLaunch. This project focuses on correctness, clarity, and production-ready infrastructure automation.

## Prerequisites

- Terraform >= 1.0
- AWS account with sufficient permissions
- Basic understanding of Kubernetes, AWS networking, and Terraform modules

## Local Setup

1. Fork and clone the repository:
   git clone https://github.com/<your-username>/Terraform-Multi-AZ-Multi-Master-Kubernetes-Cluster-AWS.git

2. Navigate to an environment:
   cd envs/dev

3. Initialize Terraform:
   terraform init

## Running Terraform

To validate changes:
- terraform validate
- terraform plan

No infrastructure should be applied unless explicitly testing in your own AWS account.

## Testing Changes

- Changes should not break existing module interfaces
- Avoid hard-coded values, AMI-specific behavior, or region-specific assumptions
- Prefer deterministic and idempotent Terraform logic

## Coding Expectations

- Avoid OS- or distro-specific assumptions unless explicitly handled
- No dead code, commented-out logic, or unused variables
- Changes should be scoped and focused

## Pull Requests

- Reference the related issue
- Keep PRs small and reviewable
- Describe the motivation and impact clearly
