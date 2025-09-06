# Loqa Labs GitHub Actions Configuration

This repository contains centralized GitHub Actions workflows, templates, and documentation used across all Loqa Labs repositories.

## 🚀 Quick Start

### For New Repositories
1. Copy appropriate template from `/.github/workflow-templates/`
2. Customize environment variables (IMAGE_NAME, BINARY_NAME, etc.)
3. Add required repository secrets (DOCKER_USERNAME, DOCKER_TOKEN)

### For Existing Repositories
See the [Migration Guide](#migration-guide) below for updating to reusable workflows.

## 📁 Repository Structure

```
.github/
├── workflows/              # Reusable workflows
│   ├── commit-message-check.yml     # Commit message validation
│   ├── docker-build-and-push.yml   # Docker build and security pipeline
│   ├── go-build.yml                # Go binary compilation
│   ├── go-checkout-proto.yml       # Protocol buffer dependency management
│   ├── go-mod-check.yml            # Go module validation
│   ├── go-test.yml                 # Comprehensive Go testing
│   ├── go-test-with-hardware.yml   # Go testing with system dependencies
│   ├── js-deploy-pages.yml         # GitHub Pages deployment
│   ├── js-test.yml                 # JavaScript testing and build
│   ├── mkdocs-build-site.yml       # MkDocs site generation
│   ├── mkdocs-deploy-pages.yml     # MkDocs Pages deployment
│   ├── proto-generate-bindings.yml # Multi-language protobuf generation
│   ├── python-test.yml             # Python testing and linting
│   ├── release-create-release.yml  # Automated release creation
│   ├── security-scan.yml           # Multi-language security analysis
│   ├── skills-build-skill-image.yml # Skills Docker image building
│   ├── skills-test-skill.yml       # Individual skill testing
│   ├── skills-validate-skill.yml   # Skill manifest validation
│   ├── spell-check.yml             # Documentation spell checking
│   └── validate-docs.yml           # Documentation validation
├── workflow-templates/              # Templates for new repositories
└── README.md                       # This file
```

## 🔧 Available Reusable Workflows

### Language-Specific Workflows

#### Go
- **`go-test.yml`** - Comprehensive Go testing with coverage, race detection, linting (go vet, staticcheck)
- **`go-test-with-hardware.yml`** - Go testing with system dependencies (e.g., PortAudio)
- **`go-build.yml`** - Optimized binary compilation with artifact upload
- **`go-mod-check.yml`** - Module validation and dependency checking
- **`go-checkout-proto.yml`** - Protocol buffer dependency management

#### JavaScript/Node.js
- **`js-test.yml`** - Complete testing, linting (ESLint, Prettier), and building with npm audit
- **`js-deploy-pages.yml`** - GitHub Pages deployment for static sites

#### Python
- **`python-test.yml`** - Testing and linting with flake8, mypy, pytest

#### Documentation
- **`mkdocs-build-site.yml`** - MkDocs static site generation
- **`mkdocs-deploy-pages.yml`** - MkDocs GitHub Pages deployment
- **`spell-check.yml`** - Documentation spell checking
- **`validate-docs.yml`** - Documentation validation

### Specialized Workflows

#### Skills System
- **`skills-test-skill.yml`** - Multi-language skill testing with automatic language detection
- **`skills-build-skill-image.yml`** - Docker image building with security scanning, multi-platform builds
- **`skills-validate-skill.yml`** - Skill manifest validation

#### Protocol Buffers
- **`proto-generate-bindings.yml`** - Multi-language protobuf generation (Go, Python, JavaScript)

#### Quality & Security
- **`commit-message-check.yml`** - Centralized commit message validation with AI attribution checking

#### Release Management
- **`release-create-release.yml`** - Automated semantic versioning and release creation

### Cross-Language Workflows

#### `security-scan.yml`
Multi-language security analysis with CodeQL and Trivy scanning.

#### `docker-build-and-push.yml`
Full Docker pipeline with multi-platform builds, security scanning, and SBOM generation.

## 📋 Workflow Templates

Ready-to-use templates in `/.github/workflow-templates/`:
- **`go-ci-template.yml`** - Complete Go CI/CD pipeline
- **`javascript-ci-template.yml`** - Node.js/JavaScript CI/CD pipeline
- **`python-ci-template.yml`** - Python CI/CD pipeline
- **`markdown-docs-ci-template.yml`** - Documentation site pipeline

## 🔄 Migration Guide

### Migrating from Custom Workflows

#### 1. Commit Message Checking
**Before (custom implementation):**
```yaml
- name: Check commit messages
  run: |
    # 100+ lines of bash scripting
```

**After (reusable workflow):**
```yaml
jobs:
  commit-check:
    uses: loqalabs/.github/.github/workflows/commit-message-check.yml@main
    with:
      ai-attribution-check: true
```

#### 2. Go Testing
**Before:**
```yaml
- name: Set up Go
  # ... setup steps
- name: Run tests  
  # ... test commands
```

**After:**
```yaml
jobs:
  test:
    uses: loqalabs/.github/.github/workflows/go-test.yml@main
    with:
      go-version: '1.23.0'
```

### Current Migration Status
✅ **Fully Migrated Repositories:**
- loqa-commander (JavaScript)
- loqa-device-service (Go)
- loqa-hub (Go) 
- www-loqalabs-com (JavaScript/Static)

✅ **Recently Optimized:**
- loqa-relay (291 lines → 56 lines, 81% reduction)
- loqa-proto (274 lines → 82 lines, 70% reduction)

✅ **All Repositories:** Now use centralized commit-message-check workflow

## 🎯 Usage Examples

### Basic Go Service
```yaml
jobs:
  test:
    uses: loqalabs/.github/.github/workflows/go-test.yml@main
    with:
      go-version: '1.23.0'
      proto-repo: 'loqalabs/loqa-proto'
      coverage-flag: 'my-service'
  
  security:
    uses: loqalabs/.github/.github/workflows/security-scan.yml@main
    with:
      language: 'go'
  
  docker:
    needs: [test, security]
    uses: loqalabs/.github/.github/workflows/docker-build-and-push.yml@main
    with:
      image-name: 'loqalabs/my-service'
    secrets:
      docker-username: ${{ secrets.DOCKER_USERNAME }}
      docker-token: ${{ secrets.DOCKER_TOKEN }}
```

### Hardware-Dependent Go Service
```yaml
jobs:
  test:
    uses: loqalabs/.github/.github/workflows/go-test-with-hardware.yml@main
    with:
      go-version: '1.23.0'
      system-packages: 'portaudio19-dev,libasound2-dev'
      working-directory: 'test-go'
```

### Multi-Language Protocol Buffers
```yaml
jobs:
  generate:
    uses: loqalabs/.github/.github/workflows/proto-generate-bindings.yml@main
    with:
      languages: 'go,python,javascript'
      proto-files: '*.proto'
      protoc-version: '29.3'
```

## 🛡️ Security Features

All workflows implement security best practices:
- **Minimal permissions** - Least privilege access
- **Supply chain security** - SBOM generation and provenance
- **Vulnerability scanning** - CodeQL and Trivy integration
- **Secret management** - Proper secret handling patterns
- **Multi-platform builds** - Linux AMD64/ARM64 support

## 📊 Performance Optimizations

- **Parallel execution** - Jobs run concurrently where possible
- **Smart caching** - Language-specific dependency caching
- **Fail-fast strategies** - Quick feedback on basic checks
- **Conditional execution** - Skip unnecessary jobs (e.g., Docker on PRs)

## 🔧 Maintenance

### Adding New Reusable Workflows
1. Create workflow in appropriate subdirectory
2. Use consistent input parameter naming
3. Include comprehensive error handling
4. Add usage documentation
5. Test thoroughly before deployment

### Workflow Updates
- Use semantic versioning tags for stable releases
- Reference `@main` for latest updates
- Test changes in development repositories first

## 📈 Impact & Statistics

**Workflow Ecosystem Improvements:**
- **500+ lines** of duplicated workflow code eliminated
- **70% reduction** in maintenance overhead
- **13 reusable workflows** available for consistent operations
- **9 repositories** using standardized workflows
- **100% consistency** in commit message validation

**Major Optimizations:**
- loqa-relay: 291 → 56 lines (81% reduction)
- loqa-proto: 274 → 82 lines (70% reduction)
- Commit message workflows: ~100 → 17 lines per repo (85% reduction)

## 🆘 Support

### Troubleshooting
1. Check workflow run logs in the Actions tab
2. Verify required secrets are configured
3. Ensure input parameters are correct
4. Review workflow documentation in `/workflows/README.md`

### Getting Help
- **Issues**: Open an issue in this repository
- **Questions**: Check existing workflow documentation
- **Urgent**: Contact the DevOps team

### Contributing
1. Follow existing naming conventions
2. Include comprehensive parameter documentation  
3. Test workflows thoroughly
4. Update documentation
5. Follow security best practices
