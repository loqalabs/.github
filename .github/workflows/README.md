# Loqa Labs Reusable GitHub Actions Workflows

This directory contains centralized reusable workflows used across all Loqa Labs repositories.

## Directory Structure

```
workflows/
├── go/                 # Go-specific workflows
│   ├── test.yml       # Testing with coverage and linting
│   ├── build.yml      # Binary compilation
│   ├── mod-check.yml  # Module validation
│   └── checkout-proto.yml # Proto dependency checkout
├── js/                 # JavaScript/Node.js workflows  
│   ├── test.yml       # Testing, linting, and building
│   ├── deploy-pages.yml # GitHub Pages deployment
│   ├── spell-check.yml # Documentation spell checking
│   ├── validate-docs.yml # Documentation validation
│   └── build-site.yml # Static site generation
├── python/            # Python workflows
│   └── test.yml      # Testing and linting
├── skills/           # Skills-specific workflows
│   ├── test-skill.yml      # Individual skill testing
│   ├── build-skill-image.yml # Docker image building
│   └── validate-skill.yml   # Skill manifest validation
├── docker-build-and-push.yml # Docker image pipeline
└── security-scan.yml        # Security analysis
```

## Language-Specific Workflows

### Go Workflows (`go/`)

#### `test.yml`
Comprehensive Go testing pipeline with coverage reporting.

**Features:**
- Race condition detection
- Coverage reporting to Codecov
- go vet and staticcheck linting
- Optional proto repository checkout

**Usage:**
```yaml
test:
  uses: loqalabs/.github/.github/workflows/go-test.yml@main
  with:
    go-version: '1.23.0'
    proto-repo: 'loqalabs/loqa-proto'  # optional
    coverage-flag: 'my-service'
    coverage-name: 'my-service'
```

#### `build.yml`
Builds optimized Go binaries with artifact upload.

**Usage:**
```yaml
build:
  uses: loqalabs/.github/.github/workflows/go-build.yml@main
  with:
    go-version: '1.23.0'
    binary-name: 'my-service'
```

#### `go-mod-check.yml`
Validates Go module integrity and dependency management.

**Usage:**
```yaml
mod-check:
  uses: loqalabs/.github/.github/workflows/go-mod-check.yml@main
  with:
    go-version: '1.23.0'
    proto-repo: 'loqalabs/loqa-proto'  # optional
```

#### `go-checkout-proto.yml`
Handles protocol buffer dependency checkout for Go projects.

**Usage:**
```yaml
checkout-proto:
  uses: loqalabs/.github/.github/workflows/go-checkout-proto.yml@main
  with:
    go-version: '1.23.0'
    proto-repo: 'loqalabs/loqa-proto'
```

#### `go-test-with-hardware.yml`
Go testing with system-level dependencies and hardware requirements.

**Features:**
- System package installation
- Hardware dependency support (e.g., PortAudio)
- Custom working directory support

**Usage:**
```yaml
test-hardware:
  uses: loqalabs/.github/.github/workflows/go-test-with-hardware.yml@main
  with:
    go-version: '1.23.0'
    system-packages: 'portaudio19-dev,libasound2-dev'
    working-directory: 'test-go'  # optional
```

### JavaScript/Node.js Workflows (`js/`)

#### `test.yml`
Complete Node.js testing and build pipeline.

**Features:**
- ESLint and Prettier formatting checks
- npm audit for security vulnerabilities
- Test execution and coverage reporting
- Build artifact upload

**Usage:**
```yaml
test:
  uses: loqalabs/.github/.github/workflows/js-test.yml@main
  with:
    node-version: '20'
```

#### `deploy-pages.yml`
Automated GitHub Pages deployment for static sites.

**Usage:**
```yaml
deploy:
  uses: loqalabs/.github/.github/workflows/js-deploy-pages.yml@main
  with:
    node-version: '20'
    cname: 'my-domain.com'  # optional
```

### Python Workflows (`python/`)

#### `test.yml`
Python testing and linting pipeline.

**Features:**
- Automatic dependency installation
- flake8 linting
- mypy type checking (when configured)
- pytest test execution (when configured)

**Usage:**
```yaml
test:
  uses: loqalabs/.github/.github/workflows/python-test.yml@main
  with:
    python-version: '3.11'
```

### Skills Workflows (`skills/`)

#### `test-skill.yml`
Multi-language skill testing with automatic language detection.

**Usage:**
```yaml
test-skill:
  uses: loqalabs/.github/.github/workflows/skills-test-skill.yml@main
  with:
    skill: 'my-skill-name'
```

#### `build-skill-image.yml`
Docker image building for individual skills with security scanning.

**Features:**
- Multi-platform builds (amd64, arm64)
- SBOM generation
- Container vulnerability scanning
- Automated image pushing

**Usage:**
```yaml
build-skill:
  uses: loqalabs/.github/.github/workflows/skills-build-skill-image.yml@main
  with:
    skill: 'my-skill-name'
```

## Cross-Language Workflows

### `security-scan.yml`
Comprehensive security analysis supporting multiple programming languages.

**Features:**
- CodeQL static analysis
- Trivy filesystem vulnerability scanning
- Multi-language support (Go, JavaScript, Python)
- Automatic language-specific setup

**Usage:**
```yaml
security:
  uses: loqalabs/.github/.github/workflows/security-scan.yml@main
  with:
    language: 'go'  # 'javascript', 'python'
    go-version: '1.23.0'  # language-specific version
```

### `docker-build-and-push.yml`
Full-featured Docker image build and security pipeline.

**Features:**
- Multi-platform builds (Linux AMD64/ARM64)
- Built-in Trivy container scanning
- SBOM (Software Bill of Materials) generation
- GitHub Actions cache optimization
- Supply chain security (provenance & attestation)

**Usage:**
```yaml
docker:
  uses: loqalabs/.github/.github/workflows/docker-build-and-push.yml@main
  with:
    registry: 'docker.io'
    image-name: 'loqalabs/my-service'
    context: '.'                    # optional, default '.'
    dockerfile: 'Dockerfile'        # optional, default 'Dockerfile'
    platforms: 'linux/amd64,linux/arm64'  # optional
  secrets:
    docker-username: ${{ secrets.DOCKER_USERNAME }}
    docker-token: ${{ secrets.DOCKER_TOKEN }}
```

## Best Practices

### Security
- All workflows use minimal required permissions
- Secrets are properly scoped and never logged
- Container images are scanned for vulnerabilities
- Supply chain security features are enabled

### Performance
- Jobs run in parallel where possible
- Dependency caching is implemented across all workflows
- Fail-fast strategies prioritize quick feedback
- Conditional execution prevents unnecessary runs

### Maintainability
- Consistent input parameter naming
- Comprehensive error handling
- Clear step naming and documentation
- Version pinning for external actions

## Common Usage Patterns

### Basic Service Pipeline
```yaml
jobs:
  test:
    uses: loqalabs/.github/.github/workflows/go-test.yml@main
    with:
      go-version: '1.23.0'
  
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

### Dependency Management
- Use `needs:` to create proper job dependencies
- Security scans should run in parallel with tests when possible
- Docker builds should depend on successful tests and security checks

## Troubleshooting

### Common Issues

1. **CodeQL fails on compiled languages**: Ensure build steps are included in the workflow
2. **Docker push permissions**: Verify `DOCKER_USERNAME` and `DOCKER_TOKEN` secrets are configured
3. **SBOM generation fails**: Check that the image was successfully pushed before SBOM generation

## Contributing

When adding new reusable workflows:

1. **Naming**: Use descriptive names following the pattern `action-target.yml`
2. **Documentation**: Include comprehensive parameter documentation
3. **Security**: Follow least-privilege principles
4. **Testing**: Test workflows in a separate repository first
5. **Versioning**: Use semantic versioning tags for releases

## Support

For workflow issues or feature requests, please:
1. Check existing workflow documentation
2. Review workflow run logs for specific error details
3. Open an issue in this repository with relevant details
4. Contact the DevOps team for urgent workflow problems