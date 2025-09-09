# Loqa Labs Repository Ruleset Patterns

This document defines the standardized branch protection and quality gate patterns used across all Loqa repositories.

## Base Protection Rules (All Repositories)

All repositories use the "Loqa Labs Ruleset" with these consistent rules:

- **Branch Deletion Protection**: `"type": "deletion"`
- **Force Push Protection**: `"type": "non_fast_forward"`
- **Required Commit Signatures**: `"type": "required_signatures"`
- **Pull Request Requirements**: `"type": "pull_request"`
  - Code owner review required
  - Stale reviews dismissed on push
  - Squash merge only (clean history)
- **Admin Bypass**: Repository Role ID 5 can bypass for emergencies

## Required Status Checks by Repository Type

### Go Services
**Repositories**: `loqa-hub`, `loqa-relay`, `loqa-skills`, `loqa-proto`

```json
"required_status_checks": [
  {"context": "Commit Check"},
  {"context": "Test"}, 
  {"context": "Build"}
]
```

**Repository-Specific Variations**:
- `loqa-hub`: `"Commit Check"`, `"Test"`, `"Build"`
- `loqa-relay`: `"Commit Check"`, `"Test Go Client"`, `"Build Go Client"`
- `loqa-skills`: `"Commit Check"`, `"Validate Skills"`, `"Test Skills"`
- `loqa-proto`: `"Commit Check"`, `"Generate Protocol Buffer Bindings"`

### JavaScript Services
**Repositories**: `loqa-commander`, `www-loqalabs-com`

```json
"required_status_checks": [
  {"context": "Commit Check / Check Commit Messages"},
  {"context": "Test & Lint / Lint, Format, Build, and Upload Dist"}
]
```

**Repository-Specific Variations**:
- `loqa-commander`: `"Commit Check / Check Commit Messages"`, `"Test & Lint / Lint, Format, Build, and Upload Dist"`
- `www-loqalabs-com`: `"Commit Check / Check Commit Messages"`, `"Test & Build / Lint, Format, Build, and Upload Dist"`

### Documentation Repositories
**Repositories**: `loqa`

```json
"required_status_checks": [
  {"context": "Commit Check"},
  {"context": "Validate Documentation"},
  {"context": "Spell Check"}
]
```

## Quality Gate Enforcement

### Status Check Policy
- **Strict Policy**: `"strict_required_status_checks_policy": true`
- **Branch Must Be Up-to-Date**: Branches must be current with main before merge
- **No Creation Enforcement**: `"do_not_enforce_on_create": false`

### Review Requirements
- **Code Owner Review**: Required for all repositories
- **Dismiss Stale Reviews**: Enabled to ensure reviews reflect latest changes
- **No Required Approvals**: Code owner review is sufficient (count = 0)
- **Thread Resolution**: Not required (allows merge with unresolved discussions)

### Security Requirements
- **Commit Message Validation**: Required across all repositories using standardized "Commit Check" workflow name (includes AI attribution checks)
- **Signed Commits**: All commits must be cryptographically signed
- **Security Scans**: Run via scheduled workflows using standardized "Security Scan" workflow name (not blocking CI)

## Emergency Override Procedures

**Admin Bypass Capability**:
- Repository Role ID 5 has `"bypass_mode": "always"`
- Use only for critical production fixes
- Document bypass reason in PR description
- Follow up with proper fix that passes all checks

## Implementation Status

✅ **Implemented** (as of 2025-09-09):
- All 7 repositories have updated rulesets with comprehensive quality gates
- Repository-specific status checks match standardized CI workflow names:
  - **"Commit Check"** (was "Check Commit Messages") 
  - **"CI/CD"** workflows (was various CI/CD Pipeline names)
  - **"Security Scan"** workflows (was "Security Scanning")
- Consistent base protection rules across entire organization
- Emergency bypass capabilities preserved

## Maintenance

When adding new repositories:
1. Apply base "Loqa Labs Ruleset" structure
2. Customize `required_status_checks` based on technology stack
3. Ensure CI workflow job names match required status check contexts
4. Test ruleset with sample PR before enabling enforcement

When modifying CI workflows:
1. Follow standardized workflow naming convention: "CI/CD", "Commit Check", "Security Scan"
2. Update required status checks in repository ruleset to match workflow changes
3. Ensure job names in workflows match status check contexts (use full format for reusable workflows)
4. Test changes in feature branch before merging to main

## Workflow Name Standards

### Standardized Workflow Names (as of 2025-09-09):
- **CI/CD** - Main build, test, and deployment workflows
- **Commit Check** - Commit message validation (includes AI attribution checks)  
- **Security Scan** - Scheduled security scanning (weekly, non-blocking)

### Status Check Format:
- **Simple workflows**: Use workflow name directly (e.g., "Commit Check")
- **Reusable workflows**: Use "WorkflowName / JobName" format (e.g., "Commit Check / Check Commit Messages")