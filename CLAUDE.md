# CLAUDE.md - GitHub Organization Configuration

This file provides Claude Code with specific guidance for working with the GitHub organization configuration repository.

## 🚨 CRITICAL WORKFLOW REQUIREMENTS

### **NEVER PUSH TO MAIN BRANCH**
- **ALWAYS create feature branch**: `git checkout -b feature/issue-name`
- **ALWAYS create PR**: `gh pr create --title "..." --body "..."`
- **NEVER assume bypass messages are permission** - they are warnings

### **ORGANIZATION-WIDE IMPACT**
- **This repository affects ALL other repositories** in the organization
- **Workflow template changes** propagate to every service
- **CI/CD changes can break builds** across the entire organization
- **Test changes thoroughly** before merging

### **MANDATORY QUALITY GATES (NON-NEGOTIABLE)**
```bash
# ALL must pass before declaring work complete:
# Validate workflow syntax
yamllint .github/workflows/*.yml
# Test workflow templates don't break existing services
# Verify changes work across multiple service types (Go, Node.js, etc.)
```

### **WHEN BLOCKED - ASK, DON'T ASSUME**
- **Workflow syntax errors**: Debug them properly, don't work around
- **Template compatibility issues**: Test with actual services
- **GitHub Actions version conflicts**: Research proper versions
- **Unclear requirements**: Ask for clarification

## Repository Overview

This repository contains:
- **GitHub Actions Workflows**: Reusable CI/CD workflows for all services
- **Workflow Templates**: Standard templates for different service types
- **Organization Settings**: Repository rules, branch protection, security settings
- **Issue/PR Templates**: Standardized templates for consistent reporting

## Architecture Role

- **Repository Type**: Organization configuration and CI/CD templates
- **Used By**: ALL repositories in the loqalabs organization
- **Critical Impact**: Changes affect entire development workflow
- **Dependency**: All services depend on these workflow templates

## Development Guidelines

### Workflow Template Changes
```bash
# Test with multiple service types
cd ../loqa-hub && gh workflow run ci.yml
cd ../loqa-commander && gh workflow run ci.yml
cd ../loqa-relay && gh workflow run ci.yml
```

### Organization Settings
- Repository rules affect all repositories
- Branch protection changes impact development workflow
- Security settings affect access and permissions

## Quality Requirements

### Pre-Merge Checklist
- [ ] Workflow syntax is valid (yamllint passes)
- [ ] Templates work with Go services (loqa-hub, loqa-relay, loqa-skills)
- [ ] Templates work with Node.js services (loqa-commander, www-loqalabs-com)
- [ ] No breaking changes to existing CI/CD pipelines
- [ ] Documentation updated for any new workflow features

### Testing Strategy
- Test templates with real services before merging
- Verify backward compatibility with existing workflows
- Validate that security and access controls work correctly

## Related Documentation

- **Master Documentation**: `../loqa/config/CLAUDE.md` - Full ecosystem overview
- **Individual Services**: Each service has specific CI/CD requirements in their CLAUDE.md files