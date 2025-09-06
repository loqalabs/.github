# Migration Guide: Adopting Loqa Labs Reusable Workflows

This guide helps you migrate from custom GitHub Actions workflows to our centralized reusable workflows.

## 🎯 Migration Benefits

- **70-85% reduction** in workflow code maintenance
- **Consistent security practices** across all repositories
- **Automatic updates** when central workflows are improved
- **Enhanced features** (better error reporting, caching, etc.)
- **Reduced technical debt** and duplication

## 🔄 Common Migration Patterns

### 1. Commit Message Checking

**❌ Before (Custom Implementation):**
```yaml
# Typical custom implementation: 38-116 lines
jobs:
  check-ai-attribution:
    name: Check Commit Messages for AI Attribution
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v5
      with:
        fetch-depth: 0
    - name: Check commit messages
      run: |
        # 50+ lines of bash scripting with:
        # - Color output definitions
        # - Pattern matching arrays
        # - Complex git log parsing
        # - Error handling
        COMMITS=$(git log --pretty=format:"%s%n%b" ...)
        # ... extensive bash logic
```

**✅ After (Reusable Workflow):**
```yaml
# Clean implementation: 17 lines
jobs:
  commit-check:
    name: Check Commit Messages
    uses: loqalabs/.github/.github/workflows/commit-message-check.yml@main
    with:
      ai-attribution-check: true
      allow-merge-commits: true
```

**Migration Impact:** 85-95% code reduction, enhanced features

### 2. Go Testing & Building

**❌ Before (Custom Implementation):**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v5
    - name: Set up Go
      uses: actions/setup-go@v6
      with:
        go-version: '1.23.0'
    - name: Cache dependencies
      uses: actions/cache@v4
      # ... cache configuration
    - name: Install dependencies
      run: go mod download
    - name: Run tests
      run: go test -v -race -coverprofile=coverage.out ./...
    - name: Upload coverage
      uses: codecov/codecov-action@v5
      # ... coverage configuration
    # ... additional setup for linting, vet, etc.
  
  build:
    runs-on: ubuntu-latest
    steps:
    # ... similar repetitive setup
    - name: Build binary
      run: go build -v -o bin/service ./cmd
```

**✅ After (Reusable Workflows):**
```yaml
jobs:
  test:
    uses: loqalabs/.github/.github/workflows/go-test.yml@main
    with:
      go-version: '1.23.0'
      proto-repo: 'loqalabs/loqa-proto'  # optional
      coverage-flag: 'my-service'
      coverage-name: 'my-service'
  
  build:
    needs: test
    uses: loqalabs/.github/.github/workflows/go-build.yml@main
    with:
      go-version: '1.23.0'
      binary-name: 'my-service'
```

**Migration Impact:** Significant code reduction, enhanced caching, better error handling

### 3. Docker Build & Security

**❌ Before (Complex Custom Implementation):**
```yaml
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v5
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v3
    - name: Log in to Registry
      uses: docker/login-action@v3
      # ... login configuration
    - name: Extract metadata
      uses: docker/metadata-action@v5
      # ... metadata configuration
    - name: Build and push
      uses: docker/build-push-action@v6
      # ... build configuration
    - name: Security scan
      # ... custom security scanning setup
    - name: Generate SBOM
      # ... custom SBOM generation
    # ... 50+ lines of Docker and security logic
```

**✅ After (Reusable Workflow):**
```yaml
jobs:
  docker:
    uses: loqalabs/.github/.github/workflows/docker-build-and-push.yml@main
    with:
      registry: docker.io
      image-name: loqalabs/my-service
      platforms: linux/amd64,linux/arm64
    secrets:
      docker-username: ${{ secrets.DOCKER_USERNAME }}
      docker-token: ${{ secrets.DOCKER_TOKEN }}
```

**Migration Impact:** Built-in security scanning, SBOM generation, multi-platform builds

### 4. Protocol Buffer Generation

**❌ Before (Monolithic Custom Implementation):**
```yaml
# loqa-proto had 274 lines of complex logic for:
jobs:
  validate:
    # ... protoc validation setup
  generate-go:
    # ... Go binding generation
  generate-python:  
    # ... Python binding generation
  generate-javascript:
    # ... JavaScript binding generation
  # ... sequential execution, complex dependency management
```

**✅ After (Optimized Reusable Workflow):**
```yaml
jobs:
  generate-bindings:
    uses: loqalabs/.github/.github/workflows/proto-generate-bindings.yml@main
    with:
      protoc-version: '29.3'
      languages: 'go,python,javascript'
      proto-files: 'audio.proto'
      generate-script: './generate.sh'
```

**Migration Impact:** 70% code reduction, parallel execution, better artifact handling

## 📋 Step-by-Step Migration Process

### Phase 1: Assessment
1. **Inventory Current Workflows**
   ```bash
   find .github/workflows -name "*.yml" -exec wc -l {} +
   ```

2. **Identify Migration Candidates**
   - Commit message checking workflows
   - Language-specific testing (Go, Python, JavaScript)
   - Docker build processes
   - Security scanning implementations
   - Protocol buffer generation

3. **Check Dependencies**
   - Required secrets (DOCKER_USERNAME, DOCKER_TOKEN, CODECOV_TOKEN)
   - Special requirements (hardware dependencies, custom build steps)

### Phase 2: Migration
1. **Start with Low-Risk Workflows**
   ```yaml
   # Begin with commit message checking (lowest risk)
   jobs:
     commit-check:
       uses: loqalabs/.github/.github/workflows/commit-message-check.yml@main
   ```

2. **Migrate Testing Workflows**
   ```yaml
   # Language-specific testing
   test:
     uses: loqalabs/.github/.github/workflows/go-test.yml@main
     # or
     uses: loqalabs/.github/.github/workflows/js-test.yml@main  
     # or
     uses: loqalabs/.github/.github/workflows/python-test.yml@main
   ```

3. **Update CI/CD Pipelines**
   ```yaml
   # Complete pipeline with proper dependencies
   jobs:
     test:
       uses: loqalabs/.github/.github/workflows/go-test.yml@main
     
     security:
       uses: loqalabs/.github/.github/workflows/security-scan.yml@main
       with:
         language: 'go'
     
     docker:
       needs: [test, security]
       uses: loqalabs/.github/.github/workflows/docker-build-and-push.yml@main
   ```

### Phase 3: Validation
1. **Test Thoroughly**
   - Create test PRs to validate workflow behavior
   - Verify all required secrets are configured
   - Confirm artifact generation works correctly

2. **Monitor Initial Runs**
   - Check workflow logs for any issues
   - Validate security scan results
   - Confirm deployment processes work

3. **Update Documentation**
   - Update README files with new workflow references
   - Document any custom configuration needed

## 🔧 Special Migration Cases

### Hardware Dependencies (e.g., PortAudio)
```yaml
# For services like loqa-relay requiring system packages
test:
  uses: loqalabs/.github/.github/workflows/go-test-with-hardware.yml@main
  with:
    go-version: '1.23.0'
    system-packages: 'portaudio19-dev,libasound2-dev'
    working-directory: 'test-go'
```

### Complex Skills Architecture
```yaml
# For loqa-skills multi-service architecture
discover-skills:
  # Keep custom skill discovery logic
  
test-skills:
  uses: loqalabs/.github/.github/workflows/skills-test-skill.yml@main
  
build-images:
  uses: loqalabs/.github/.github/workflows/skills-build-skill-image.yml@main
```

### Multi-Repository Coordination
```yaml
# For repositories that depend on generated artifacts
depends-on-proto:
  needs: generate-bindings
  uses: loqalabs/.github/.github/workflows/go-test.yml@main
  with:
    proto-repo: 'loqalabs/loqa-proto'
```

## ⚡ Advanced Workflow Features

### 1. Automated Dependency Updates
```yaml
# .github/workflows/dependencies.yml
name: Weekly Dependency Updates
on:
  schedule:
    - cron: '0 2 * * MON'  # Monday 2 AM

jobs:
  update:
    # Note: Dependency update workflow not yet available in this structure
    # Check loqalabs-github-config for latest maintenance workflows
```

### 2. Automated Release Management
```yaml
# .github/workflows/release.yml  
name: Create Release
on:
  workflow_dispatch:
    inputs:
      release-type:
        type: choice
        options: ['patch', 'minor', 'major']

jobs:
  release:
    uses: loqalabs/.github/.github/workflows/release-create-release.yml@main
    with:
      release-type: ${{ inputs.release-type }}
      changelog-file: 'CHANGELOG.md'
```

## 🚨 Migration Gotchas & Solutions

### Issue 1: Missing Required Secrets
**Problem:** Workflow fails due to missing Docker credentials
**Solution:** 
```bash
# Add to repository secrets:
DOCKER_USERNAME=your-username
DOCKER_TOKEN=your-access-token
CODECOV_TOKEN=your-codecov-token  # Optional for private repos
```

### Issue 2: Go Module Path Mismatch
**Problem:** Build workflow can't find go.mod
**Solution:**
```yaml
# Specify correct working directory
test:
  uses: loqalabs/.github/.github/workflows/go-test-with-hardware.yml@main
  with:
    working-directory: 'subdir'  # If go.mod is in a subdirectory
```

### Issue 3: Custom Build Steps
**Problem:** Need additional build steps not in reusable workflow
**Solution:**
```yaml
jobs:
  # Use reusable workflow for standard steps
  test:
    uses: loqalabs/.github/.github/workflows/go-test.yml@main
  
  # Add custom job for special requirements
  custom-build:
    needs: test
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v5
    - name: Custom build step
      run: ./custom-build.sh
```

### Issue 4: Branch Protection Rules
**Problem:** Branch protection expecting different job names
**Solution:** Update branch protection rules to match new job names:
- `commit-check` (instead of `check-ai-attribution`)
- `test` (standardized across all languages)
- `security` (instead of custom security job names)

## 📊 Migration Success Metrics

Track these metrics to measure migration success:

### Code Reduction
- **Lines of workflow code**: Before vs. After
- **Number of custom jobs**: Reduction count
- **Maintenance complexity**: Subjective rating

### Consistency Improvements  
- **Security scanning**: Now consistent across all repos
- **Error handling**: Standardized patterns
- **Caching strategies**: Optimized and consistent

### Feature Enhancements
- **SBOM generation**: Now available for all Docker builds
- **Multi-platform builds**: Linux AMD64/ARM64 support
- **Enhanced reporting**: Better logs and error messages

## 🎯 Expected Outcomes

After completing the migration:

### Immediate Benefits
- ✅ **70-85% reduction** in workflow maintenance
- ✅ **Consistent security practices** across all repositories  
- ✅ **Enhanced error reporting** and debugging capabilities
- ✅ **Optimized performance** through better caching

### Long-term Benefits
- ✅ **Automatic improvements** when central workflows are updated
- ✅ **Reduced technical debt** and duplication
- ✅ **Faster onboarding** for new repositories
- ✅ **Organization-wide standardization**

## 📞 Support & Troubleshooting

### Getting Help
1. **Check workflow logs** in the GitHub Actions tab
2. **Review documentation** in `/workflows/README.md`
3. **Open an issue** in the loqalabs-github-config repository
4. **Contact DevOps team** for urgent issues

### Common Troubleshooting Steps
1. Verify all required secrets are configured
2. Check input parameter names and types
3. Confirm reusable workflow paths are correct
4. Test with a simple PR first

### Migration Support
For assistance with complex migrations, the DevOps team can provide:
- Migration planning sessions
- Custom workflow development
- Testing and validation support
- Documentation updates