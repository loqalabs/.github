# Loqa Labs GitHub Workflow Templates

This directory contains ready-to-use workflow templates for setting up CI/CD pipelines in new repositories. These templates integrate with the reusable workflows in the parent directory and follow security best practices.

## Available Templates

### `go-ci-template.yml`
Complete CI/CD pipeline for Go services and applications using reusable workflows.

**Features:**
- Proto dependency checkout (for services using loqa-proto)
- Comprehensive testing with coverage reporting via `go/test.yml`
- Go module validation via `go/mod-check.yml` 
- Binary building via `go/build.yml`
- Security analysis via `security-scan.yml` (CodeQL + Trivy)
- Docker image building via `docker-build-and-push.yml` with multi-platform support
- Centralized commit message checking via `quality/commit-message-check.yml`

**Best for:**
- Go microservices
- Go CLI applications  
- Services requiring protobuf definitions

**Template Variables to Update:**
```yaml
env:
  IMAGE_NAME: loqalabs/your-go-service  # Change this
  BINARY_NAME: your-go-service          # Change this
```

**Hardware Dependencies Support:**
For Go services requiring system dependencies (like PortAudio), the template can use the `go/test-with-hardware.yml` workflow instead of standard `go/test.yml`.

### `javascript-ci-template.yml`
CI/CD pipeline for Node.js/JavaScript applications.

**Features:**
- ESLint and Prettier checks
- npm audit security scanning
- Test execution and build processes
- Security analysis for JavaScript
- Docker image building
- Optional GitHub Pages deployment

**Best for:**
- Node.js APIs and services
- React/Vue/Angular applications
- Static site generators
- JavaScript libraries

**Template Variables to Update:**
```yaml
env:
  IMAGE_NAME: loqalabs/your-javascript-service  # Change this
```

### `python-ci-template.yml`
CI/CD pipeline for Python services and applications.

**Features:**
- flake8 linting and mypy type checking
- pytest test execution (when configured)
- Security analysis for Python
- Docker image building with security scanning
- Automatic dependency management

**Best for:**
- Python APIs and services
- Machine learning applications
- Python CLI tools
- Data processing services

**Template Variables to Update:**
```yaml
env:
  IMAGE_NAME: loqalabs/your-python-service  # Change this
```

### `markdown-docs-ci-template.yml`
Documentation site pipeline for markdown-based documentation.

**Features:**
- Markdown validation and spell checking
- Static site generation
- Automated GitHub Pages deployment
- Content validation

**Best for:**
- Documentation repositories
- Static documentation sites
- API documentation
- Project wikis

**Template Variables to Update:**
```yaml
# In deploy job
cname: ''  # Optional: set to your custom domain
```

## How to Use Templates

### Step 1: Copy Template
```bash
cp .github/workflow-templates/go-ci-template.yml .github/workflows/ci.yml
```

### Step 2: Customize Variables
Edit the environment variables at the top of the workflow:

```yaml
env:
  REGISTRY: docker.io
  IMAGE_NAME: loqalabs/your-service-name  # Update this
  BINARY_NAME: your-service-name          # Go projects only
```

### Step 3: Adjust Triggers (Optional)
Modify the workflow triggers based on your branching strategy:

```yaml
on:
  push:
    branches: [ main, develop ]    # Add or remove branches
  pull_request:
    branches: [ main, develop ]
  release:
    types: [ published ]
```

### Step 4: Configure Secrets
Ensure these repository secrets are configured:
- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_TOKEN` - Docker Hub access token
- `CODECOV_TOKEN` - Codecov token (optional, for private repos)

### Step 5: Commit and Test
```bash
git add .github/workflows/ci.yml
git commit -m "Add CI/CD pipeline"
git push
```

## Template Customization Guide

### Adding Custom Build Steps

#### For Go Projects
```yaml
# Add after the build job
custom-build:
  name: Custom Build Steps
  needs: build
  runs-on: ubuntu-latest
  steps:
    - name: Checkout code
      uses: actions/checkout@v5
    - name: Your custom step
      run: echo "Add your custom build logic here"
```

#### For JavaScript Projects
```yaml
# Add to the test job steps
- name: Run custom tests
  run: npm run test:integration
```

### Modifying Security Scans
```yaml
security:
  uses: loqalabs/.github/.github/workflows/security-scan.yml@main
  with:
    language: 'go'
    go-version: '1.21'    # Adjust version as needed
```

### Conditional Docker Builds
```yaml
docker:
  needs: [test, security]
  if: github.event_name != 'pull_request' && github.ref == 'refs/heads/main'
  uses: loqalabs/.github/.github/workflows/docker-build-and-push.yml@main
```

## Best Practices

### Branch Strategy Integration
- **Main Branch**: Full pipeline including Docker builds
- **Feature Branches**: Testing and security scans only
- **Release Tags**: Additional release-specific steps

### Job Dependencies
```yaml
jobs:
  test:      # Runs first
  security:  # Runs in parallel with test
  build:     # Runs after test completes
    needs: test
  docker:    # Runs after both test and security
    needs: [test, security]
```

### Performance Optimization
- Use `needs:` strategically for parallel execution
- Cache dependencies when possible
- Fail fast on linting/formatting issues

### Security Considerations
- Never hardcode secrets in workflows
- Use minimal required permissions
- Scan all dependencies and containers
- Keep action versions pinned

## Troubleshooting Common Issues

### Docker Build Failures
```yaml
# Add debug information
- name: Debug Docker context
  run: |
    ls -la
    docker version
    docker buildx version
```

### Go Module Issues
```yaml
# Clear Go module cache
- name: Clear Go cache
  run: go clean -modcache
```

### Node.js Dependency Issues
```yaml
# Use npm ci instead of install
- name: Install dependencies
  run: npm ci --prefer-offline --no-audit
```

### Python Environment Issues
```yaml
# Pin Python version explicitly
- name: Set up Python
  uses: actions/setup-python@v5
  with:
    python-version: '3.11.5'  # Use specific version
```

## Advanced Workflow Integration

### New Specialized Workflows Available

#### Protocol Buffer Generation
For repositories with `.proto` files, use the advanced protobuf workflow:
```yaml
jobs:
  generate:
    uses: loqalabs/.github/.github/workflows/proto/generate-bindings.yml@main
    with:
      languages: 'go,python,javascript'
      proto-files: '*.proto'
      protoc-version: '29.3'
```

#### Automated Release Management
Add release automation to any repository:
```yaml
# .github/workflows/release.yml
on:
  workflow_dispatch:
    inputs:
      release-type:
        description: 'Release type'
        required: true
        default: 'patch'
        type: choice
        options: ['patch', 'minor', 'major']

jobs:
  release:
    uses: loqalabs/.github/.github/workflows/release/create-release.yml@main
    with:
      release-type: ${{ inputs.release-type }}
      changelog-file: 'CHANGELOG.md'
```

#### Automated Dependency Updates
Set up weekly dependency updates:
```yaml
# .github/workflows/dependencies.yml
on:
  schedule:
    - cron: '0 2 * * MON'

jobs:
  update:
    uses: loqalabs/.github/.github/workflows/maintenance/dependency-update.yml@main
    with:
      package-manager: 'all'
      update-type: 'minor'
      create-pr: true
      auto-merge: false  # Set to true for patch updates
```

## Template Maintenance

### Updating Templates
When updating templates:
1. Test changes in a separate repository first
2. Update version references for actions
3. Update documentation with new features
4. Maintain backward compatibility where possible

### Version Management
Templates should reference stable versions:
```yaml
uses: loqalabs/.github/.github/workflows/security-scan.yml@main  # Use @main for latest
# or
uses: loqalabs/.github/.github/workflows/security-scan.yml@v1.2.3  # Use specific version
```

### New Workflow Adoption
All templates now include:
- ✅ **Centralized commit message checking** - No more duplicated bash scripts
- ✅ **Enhanced security scanning** - Consistent across all repositories  
- ✅ **Optimized Docker builds** - Multi-platform with security scanning
- ✅ **Protocol buffer support** - For microservice architectures
- ✅ **Automated release management** - Semantic versioning and changelog generation

## Support and Contributing

### Getting Help
1. Check the workflow run logs for specific error messages
2. Review the reusable workflow documentation in `../workflows/README.md`
3. Open an issue with the specific template and error details

### Contributing New Templates
1. Follow existing naming conventions
2. Include comprehensive environment variable documentation
3. Test thoroughly with multiple repository types
4. Update this README with the new template

### Template Requests
For new template requests, please open an issue with:
- Target language/framework
- Specific requirements
- Example repository structure
- Expected workflow behavior