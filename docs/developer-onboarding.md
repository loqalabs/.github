# 🚀 Developer Onboarding Guide

Welcome to Loqa development! This comprehensive guide will get you from zero to contributing quickly, whether you're new to open source or an experienced developer.

---

## 🎯 Quick Start (5 Minutes)

**Just want to get started fast?** Follow these essential steps:

```bash
# 1. Clone the main repository
git clone https://github.com/loqalabs/loqa.git
cd loqa

# 2. Quick setup (downloads dependencies, starts services)
make setup && make dev

# 3. Verify everything is working
curl http://localhost:3000/health
```

**That's it!** You now have a complete Loqa development environment running locally.

**Next steps:**
- Browse [Good First Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues)
- Join our [Discord community](https://discord.gg/loqa) 
- Read the [Architecture Overview](#architecture-overview) below

---

## 📋 Prerequisites

### Required Software
- **Docker & Docker Compose** - For running services
- **Git** - For version control
- **Text Editor/IDE** - VS Code, Neovim, etc.

### Optional but Recommended
- **Go 1.25+** - For Go service development
- **Node.js 20+** - For frontend development  
- **Make** - For build commands (usually pre-installed)

### Platform-Specific Instructions

**macOS:**
```bash
# Using Homebrew
brew install docker docker-compose git go node

# Start Docker Desktop
open -a Docker
```

**Ubuntu/Debian:**
```bash
# Install Docker
sudo apt update
sudo apt install docker.io docker-compose git

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Install Go and Node.js
sudo apt install golang-go nodejs npm
```

**Windows:**
1. Install [Docker Desktop](https://docs.docker.com/desktop/install/windows/)
2. Install [Git for Windows](https://git-scm.com/download/win)
3. Install [Go](https://golang.org/dl/) and [Node.js](https://nodejs.org/)
4. Use PowerShell or WSL2 for commands

---

## 🏗️ Architecture Overview

Understanding Loqa's architecture helps you contribute effectively:

```
┌─────────────────────────────────────────────────────────────────┐
│                           Loqa System                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────┐ │
│  │ loqa-relay  │  │  loqa-hub   │  │   Skills    │  │ TTS/STT │ │
│  │ (Audio I/O) │◄─┤ (Core API)  │◄─┤  (Plugins)  │◄─┤ Services│ │
│  │             │  │             │  │             │  │         │ │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────┘ │
│         │                  │               │              │     │
│         │                  │               │              │     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────┐ │
│  │loqa-commander│  │ loqa-proto  │  │    NATS     │  │ Ollama  │ │
│  │ (Dashboard) │  │(Protocols)  │  │(Messaging)  │  │  (LLM)  │ │
│  │             │  │             │  │             │  │         │ │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### Core Components

**🎙️ loqa-relay** - Audio capture and playback client
- Captures audio from microphones
- Handles wake word detection
- Streams audio to/from the hub
- **Languages**: Go, embedded firmware
- **Best for**: Hardware, audio processing, embedded development

**🏠 loqa-hub** - Central service and API
- Processes voice commands via STT → LLM → TTS pipeline
- Manages skills and plugins
- Provides HTTP and gRPC APIs
- **Languages**: Go
- **Best for**: Backend, API development, AI integration

**🎮 loqa-commander** - Web-based dashboard
- Administrative interface for managing Loqa
- Real-time monitoring and logs
- User management and configuration
- **Languages**: Vue.js, TypeScript, Tailwind CSS
- **Best for**: Frontend, UI/UX, web development

**🧠 loqa-skills** - Plugin system
- Modular voice assistant skills
- Community-contributed extensions
- Integration with external services
- **Languages**: Go (plugin interface)
- **Best for**: Plugin development, service integrations

**📡 loqa-proto** - Protocol definitions
- gRPC protocol specifications
- Cross-service communication standards
- Generated bindings for multiple languages
- **Languages**: Protocol Buffers
- **Best for**: API design, cross-service communication

---

## 🛠️ Development Setup

### Option 1: Full Docker Setup (Recommended for Beginners)

This approach uses Docker for everything and is the fastest way to get started:

```bash
# Clone the main orchestration repository
git clone https://github.com/loqalabs/loqa.git
cd loqa

# One-command setup
make setup    # Downloads models, clones repos, builds images
make dev      # Starts all services with live reload

# Verify services are running
make status   # Shows service health
```

**What this gives you:**
- ✅ All services running with one command
- ✅ Automatic dependency management
- ✅ Consistent environment across platforms
- ✅ Hot reload for development

### Option 2: Hybrid Setup (For Active Development)

Run some services locally for faster development cycles:

```bash
# Clone repositories you want to develop on
git clone https://github.com/loqalabs/loqa-hub.git
git clone https://github.com/loqalabs/loqa-commander.git

# Start supporting services with Docker
cd loqa
docker-compose up -d nats ollama stt tts

# Develop locally
cd ../loqa-hub
go run ./cmd                    # Hub service

cd ../loqa-commander  
npm install && npm run dev      # Commander dashboard
```

**Best for:**
- Active Go or frontend development
- Faster development cycles
- Debugging with local tools

### Option 3: Individual Repository Setup

Work on a single service in isolation:

```bash
# Choose your service
git clone https://github.com/loqalabs/loqa-commander.git
cd loqa-commander

# Follow service-specific setup
npm install
npm run dev

# Mock external dependencies as needed
```

**Best for:**
- Frontend-only development
- Documentation improvements
- Focused feature development

---

## 🎮 Service-Specific Development

### 🏠 Hub Service (Go)

**Setup:**
```bash
cd loqa-hub
go mod download
go run ./cmd
```

**Development workflow:**
```bash
# Run tests
go test ./...

# Run with hot reload
air  # Requires 'go install github.com/cosmtrek/air@latest'

# Quality checks
make quality-check   # format, lint, vet, test

# Build
go build -o bin/hub ./cmd
```

**Key directories:**
- `cmd/` - Main application entry point
- `internal/` - Private application code
- `pkg/` - Public APIs and utilities
- `tests/` - Integration and e2e tests

### 🎮 Commander Dashboard (Vue.js)

**Setup:**
```bash
cd loqa-commander
npm install
npm run dev
```

**Development workflow:**
```bash
# Development server with hot reload
npm run dev

# Type checking
npm run type-check

# Linting and formatting
npm run lint
npm run format

# Build for production
npm run build

# Quality checks
npm run quality-check
```

**Key directories:**
- `src/components/` - Vue components
- `src/views/` - Page-level components
- `src/stores/` - Pinia state management
- `src/composables/` - Reusable logic
- `tests/` - Component and unit tests

### 🎙️ Relay Client (Go)

**Setup:**
```bash
cd loqa-relay
go mod download

# For hardware testing
go run ./test-go/cmd

# For embedded development
cd firmware/ && make build
```

**Development workflow:**
```bash
# Test client
./tools/run-test-relay.sh

# Embedded build
make embedded

# Hardware testing
make test-hardware
```

### 🧠 Skills Development

**Create a new skill:**
```bash
cd loqa-skills
cp -r example-skill my-new-skill
cd my-new-skill

# Edit manifest.json and implement handler
go build -buildmode=plugin -o my-skill.so .

# Install and load
make install
make load
```

**Development workflow:**
```bash
# Build plugin
make build

# Test locally
make test

# Install to hub
make install

# Check status
make status
```

---

## 🧪 Testing Your Setup

### Verify Core Services

```bash
# Check service health
curl http://localhost:3000/health
curl http://localhost:5173/        # Commander UI
curl http://localhost:8000/health  # STT service
curl http://localhost:8880/health  # TTS service

# Test voice pipeline
echo "test message" | curl -X POST http://localhost:3000/api/tts \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello from Loqa"}'
```

### Test Voice Interaction

```bash
# Start test relay client
cd loqa && ./tools/run-test-relay.sh

# In another terminal, simulate voice command
echo "Hello Loqa, what time is it?" | ./tools/test-voice-command.sh
```

### Access Web Interfaces

- **Commander Dashboard**: http://localhost:5173
- **Hub API**: http://localhost:3000
- **NATS Monitoring**: http://localhost:8222

---

## 🔧 Development Tools

### IDE Configuration

**VS Code Extensions (Recommended):**
```json
{
  "recommendations": [
    "golang.go",
    "vue.volar",
    "bradlc.vscode-tailwindcss",
    "ms-vscode.vscode-proto3",
    "ms-vscode-remote.remote-containers"
  ]
}
```

**VS Code Settings:**
```json
{
  "go.formatTool": "goimports",
  "go.lintTool": "golangci-lint",
  "editor.formatOnSave": true,
  "vue.format.defaultFormatter.html": "prettier"
}
```

### Debugging

**Go Services:**
```bash
# Debug with Delve
dlv debug ./cmd -- --debug

# Add breakpoints in VS Code
# F5 to start debugging
```

**Vue.js Apps:**
```bash
# Browser DevTools + Vue DevTools extension
npm run dev

# Open browser DevTools (F12)
# Vue DevTools tab for component inspection
```

### Code Quality Tools

```bash
# Go services
golangci-lint run          # Comprehensive linting
go vet ./...              # Static analysis
go test -race ./...       # Race condition detection

# JavaScript/Vue
eslint --fix src/         # Linting with auto-fix
prettier --write src/     # Code formatting
vue-tsc --noEmit         # Type checking
```

---

## 🐛 Troubleshooting

### Common Issues

**Docker Issues:**
```bash
# Permission errors on Linux
sudo usermod -aG docker $USER && newgrp docker

# Port conflicts
docker-compose down
lsof -ti:3000 | xargs kill -9  # Kill process using port 3000

# Disk space issues
docker system prune -a
```

**Go Module Issues:**
```bash
# Clear module cache
go clean -modcache

# Refresh dependencies
go mod tidy && go mod download
```

**Node.js Issues:**
```bash
# Clear npm cache
npm cache clean --force

# Remove and reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

### Service-Specific Debugging

**Hub Service Not Starting:**
```bash
# Check logs
docker-compose logs loqa-hub

# Verify dependencies
docker-compose ps
curl http://localhost:11434/api/tags  # Ollama
curl http://localhost:4222           # NATS
```

**Commander UI Build Errors:**
```bash
# Check Node.js version
node --version  # Should be 18+

# Verify dependencies
npm ls

# Clear build cache
rm -rf dist .nuxt
```

**Audio Issues:**
```bash
# Test audio devices
arecord -l     # List recording devices
aplay -l       # List playback devices

# Check permissions (Linux)
sudo usermod -a -G audio $USER
```

---

## 📚 Learning Resources

### Loqa-Specific Documentation
- **[Architecture Deep Dive](./architecture.md)** - Detailed system design
- **[API Documentation](./api.md)** - Service interfaces
- **[Skills Development Guide](./skills.md)** - Creating voice assistant skills
- **[Deployment Guide](./deployment.md)** - Production setup

### Technology Learning Resources

**Go Development:**
- [Go Tour](https://tour.golang.org/) - Interactive Go tutorial
- [Effective Go](https://golang.org/doc/effective_go.html) - Best practices
- [Go by Example](https://gobyexample.com/) - Practical examples

**Vue.js Development:**
- [Vue.js Guide](https://vuejs.org/guide/) - Official documentation
- [Vue School](https://vueschool.io/) - Video tutorials
- [Vue Mastery](https://www.vuemastery.com/) - Advanced techniques

**Protocol Buffers:**
- [Protocol Buffers Guide](https://developers.google.com/protocol-buffers) - Official docs
- [gRPC Basics](https://grpc.io/docs/languages/go/basics/) - Go-specific guide

**Docker & DevOps:**
- [Docker Getting Started](https://docs.docker.com/get-started/) - Container basics
- [Docker Compose](https://docs.docker.com/compose/) - Multi-service applications

---

## 🤝 Getting Help

### Real-Time Support
- **Discord Community**: [Join here](https://discord.gg/loqa)
  - `#general` - General discussion
  - `#help` - Technical questions
  - `#contributors` - Contributor coordination
  - `#random` - Off-topic chat

### Async Support
- **GitHub Discussions**: [Browse here](https://github.com/loqalabs/loqa/discussions)
- **Issue Comments**: Ask questions on specific issues/PRs
- **Community Email**: community@loqalabs.com

### Office Hours
- **When**: Fridays 2-3 PM UTC
- **Where**: Discord voice chat
- **What**: Open Q&A, contribution guidance, technical help

### Mentorship Program
- **For new contributors**: Automatic mentor assignment
- **For experienced contributors**: Volunteer to mentor others
- **Skill-based matching**: Pair contributors by expertise areas

---

## 🚀 Your First Contribution

Ready to make your first contribution? Here's a step-by-step guide:

### 1. Find an Issue
- Browse [Good First Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues)
- Look for issues matching your interests and skills
- Read the issue description and acceptance criteria

### 2. Claim the Issue
```markdown
Comment: "I'd like to work on this!"
```
- Our automation will assign you
- You'll get mentorship support (if new)
- Maintainers will provide guidance

### 3. Set Up Your Environment
```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME

# Set up development environment
make setup && make dev

# Create feature branch
git checkout -b fix/issue-123-description
```

### 4. Make Your Changes
- Read existing code to understand patterns
- Make small, focused changes
- Write tests if applicable
- Update documentation if needed

### 5. Test Your Changes
```bash
# Run tests
make test

# Quality checks
make quality-check

# Manual testing
# Test your specific changes
```

### 6. Submit Your Pull Request
```bash
# Commit changes
git add .
git commit -m "Fix issue with descriptive message

Explains what was changed and why.
References issue number.

Fixes #123"

# Push to your fork
git push origin fix/issue-123-description

# Create PR on GitHub
```

### 7. Code Review Process
- Automated checks run immediately
- Community review within 24-48 hours
- Address feedback with additional commits
- Celebrate when your PR is merged! 🎉

---

## 🎯 Next Steps

**Now that you're set up:**

1. **🌟 Find your first issue** from [Good First Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues)
2. **💬 Join Discord** for community support and real-time help
3. **📖 Read the documentation** relevant to your interests
4. **🤝 Introduce yourself** in GitHub Discussions or Discord
5. **🚀 Make your first contribution!**

**Questions or stuck somewhere?** Don't hesitate to ask for help! The Loqa community is here to support your contribution journey.

**Welcome to the team!** 🎉