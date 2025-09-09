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
  {"context": "Check Commit Messages"},
  {"context": "Test"}, 
  {"context": "Build"}
]
```

**Repository-Specific Variations**:
- `loqa-hub`: `"Test"`, `"Build"`
- `loqa-relay`: `"Test Go Client"`, `"Build Go Client"`
- `loqa-skills`: `"Validate Skills"`, `"Test Skills"`
- `loqa-proto`: `"Generate Protocol Buffer Bindings"`

### JavaScript Services
**Repositories**: `loqa-commander`, `www-loqalabs-com`

```json
"required_status_checks": [
  {"context": "Check Commit Messages"},
  {"context": "Test & Lint"}
]
```

**Repository-Specific Variations**:
- `loqa-commander`: `"Test & Lint"`
- `www-loqalabs-com`: `"Test & Build"`

### Documentation Repositories
**Repositories**: `loqa`

```json
"required_status_checks": [
  {"context": "Check Commit Messages"},
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
- **Commit Message Validation**: Required across all repositories (includes AI attribution checks)
- **Signed Commits**: All commits must be cryptographically signed
- **Security Scans**: Run via scheduled workflows (not blocking CI)

## Emergency Override Procedures

**Admin Bypass Capability**:
- Repository Role ID 5 has `"bypass_mode": "always"`
- Use only for critical production fixes
- Document bypass reason in PR description
- Follow up with proper fix that passes all checks

## Implementation Status

✅ **Implemented** (as of 2025-09-08):
- All 7 repositories have updated rulesets with comprehensive quality gates
- Repository-specific status checks match actual CI workflow job names
- Consistent base protection rules across entire organization
- Emergency bypass capabilities preserved

## Maintenance

When adding new repositories:
1. Apply base "Loqa Labs Ruleset" structure
2. Customize `required_status_checks` based on technology stack
3. Ensure CI workflow job names match required status check contexts
4. Test ruleset with sample PR before enabling enforcement

When modifying CI workflows:
1. Update required status checks in repository ruleset
2. Ensure job names in workflows match status check contexts  
3. Test changes in feature branch before merging to main