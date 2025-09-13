# 🤝 Contributing to Loqa - Community Guide

Welcome to the **Loqa Community**! We're thrilled you're interested in contributing to privacy-respecting, local-first voice AI technology.

This guide is specifically designed for **external contributors** who want to get involved with Loqa. Whether you're a seasoned developer or just getting started with open source, we have opportunities for you!

---

## 🌟 Why Contribute to Loqa?

Loqa isn't just another voice assistant - it's a **movement toward user autonomy and privacy**:

- 🔒 **Privacy by Design**: Your voice stays on your device
- 🌟 **Innovation First**: Cutting-edge AI without cloud constraints
- 🤝 **Community Driven**: Features come from real user needs
- 🛠️ **Hackable & Extensible**: Built for makers and developers

**Your contributions help create technology that respects users and enables creative freedom.**

---

## 🎯 Ways to Contribute

### 🐞 Bug Reports & Fixes

- **Found a bug?** [Report it here](https://github.com/loqalabs/loqa/issues/new?template=bug_report.yml)
- **Want to fix it?** We love contributor-driven solutions!
- **New to bug fixing?** Look for [`good first issue`](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues) labels

### 🚀 Feature Development

- **Got a great idea?** [Suggest a feature](https://github.com/loqalabs/loqa/issues/new?template=feature_request.yml)
- **Want to implement features?** Check our [feature backlog](https://github.com/loqalabs/loqa/labels/enhancement)
- **Interested in AI/ML?** Contribute to our STT, TTS, or LLM integrations

### 📚 Documentation

- **Improve setup guides** - Help others get started faster
- **Write tutorials** - Show off cool Loqa use cases
- **API documentation** - Make our interfaces clearer
- **Translate docs** - Help us reach global contributors

### 🧠 Skills & Plugins

- **Create voice skills** - Integrate with smart home, APIs, services
- **Share templates** - Help others build skills faster
- **Build integrations** - Connect Loqa to your favorite tools

### 🧪 Testing & Quality

- **Manual testing** - Try new features and report issues
- **Write automated tests** - Improve our test coverage
- **Performance testing** - Help optimize Loqa's performance
- **Security review** - Help keep Loqa secure

### 🎨 Design & UX

- **UI improvements** - Enhance the Commander dashboard
- **Accessibility** - Make Loqa usable for everyone
- **Design assets** - Icons, graphics, and branding
- **User research** - Help us understand user needs

---

## 🚀 Getting Started

### 1. Choose Your Adventure

**🌱 New to Open Source?**

- Start with [Good First Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues)
- Join our [Discord community](https://discord.gg/loqa) for support
- Read our [Developer Onboarding Guide](./docs/developer-onboarding.md)

**🔧 Experienced Developer?**

- Check out [Help Wanted](https://github.com/search?q=org%3Aloqalabs+label%3A%22help+wanted%22+state%3Aopen&type=issues) issues
- Browse our [Architecture Documentation](./docs/architecture.md)
- Consider [Cross-Repository](https://github.com/search?q=org%3Aloqalabs+label%3A%22cross-repo%22+state%3Aopen&type=issues) coordination issues

**🎯 Specific Interests?**

- **AI/ML**: [`ai`, `llm`, `stt`, `tts`] labels
- **Backend**: [`backend`, `microservice`, `grpc`] labels
- **Frontend**: [`frontend`, `vue`, `ui`] labels
- **DevOps**: [`infrastructure`, `docker`, `deployment`] labels
- **Hardware**: [`hardware`, `embedded`, `esp32`] labels

### 2. Set Up Your Development Environment

**Quick Setup (Recommended):**

```bash
# Clone the main repository
git clone https://github.com/loqalabs/loqa.git
cd loqa

# One-command setup (downloads dependencies, starts services)
make setup && make dev
```

**Manual Setup:**

```bash
# Clone and set up each service
git clone https://github.com/loqalabs/loqa-hub.git
git clone https://github.com/loqalabs/loqa-commander.git
# ... (see full setup guide)

# Start with Docker Compose
docker-compose up -d
```

**Need Help?** Our [Developer Onboarding Guide](./docs/developer-onboarding.md) has detailed instructions for every platform.

### 3. Find Your First Contribution

**Browse Issues by Skill Level:**

- 🌱 [`good first issue`](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues) - Perfect for newcomers
- 🌿 [`help wanted`](https://github.com/search?q=org%3Aloqalabs+label%3A%22help+wanted%22+state%3Aopen&type=issues) - Community contributions welcome
- 🌳 [`advanced`](https://github.com/search?q=org%3Aloqalabs+label%3A%22advanced%22+state%3Aopen&type=issues) - For experienced contributors

**Or Browse by Interest:**

- [📱 Frontend Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22frontend%22+state%3Aopen&type=issues)
- [⚙️ Backend Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22backend%22+state%3Aopen&type=issues)
- [🤖 AI/ML Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22ai%22+state%3Aopen&type=issues)
- [📖 Documentation Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22documentation%22+state%3Aopen&type=issues)

---

## 🛠️ Contribution Workflow

### Step 1: Claim an Issue

```markdown
Comment on the issue: "I'd like to work on this!"
Our automation will:

- Assign you to the issue
- Provide relevant guidance
- Connect you with a mentor (for new contributors)
```

### Step 2: Create Your Branch

```bash
# Fork the repository on GitHub first, then:
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME

# Create a feature branch
git checkout -b feature/your-feature-name
```

### Step 3: Make Your Changes

```bash
# Make your changes
# Write tests (if applicable)
# Update documentation (if needed)

# Test your changes
make test          # For Go services
npm test          # For JS services
make quality-check # Full quality validation
```

### Step 4: Submit Your Pull Request

```bash
# Commit your changes
git add .
git commit -m "descriptive commit message"
git push origin feature/your-feature-name

# Create PR on GitHub with:
# - Clear title describing the change
# - Reference to the issue (e.g., "Fixes #123")
# - Description of what you changed and why
```

### Step 5: Code Review Process

- **Automated checks** run immediately
- **Community review** typically within 24-48 hours
- **Feedback incorporation** - we'll help you through any needed changes
- **Merge celebration** - your contribution becomes part of Loqa! 🎉

---

## 📋 Contribution Standards

### Code Quality

- **Tests Required**: New features need tests
- **Documentation**: Update docs for user-facing changes
- **Code Style**: Automated formatting (`gofmt`, `prettier`)
- **Quality Gates**: All checks must pass before merge

### Commit Messages

- **Be descriptive**: Explain what and why, not just what
- **Reference issues**: Use `Fixes #123` or `Relates to #456`
- **Keep it clean**: No AI attribution (automated enforcement)

Example:

```
Add wake word detection timeout configuration

Allows users to customize wake word timeout via config file.
Fixes timeout issues reported in rural/noisy environments.

Fixes #284
```

### Pull Request Guidelines

- **Small PRs**: Easier to review and merge
- **Single purpose**: One feature/fix per PR
- **Reference issues**: Link to related discussions
- **Test thoroughly**: Run full test suite
- **Update docs**: Keep documentation current

---

## 🤝 Community Guidelines

### 🌈 Code of Conduct

We're committed to providing a welcoming, inclusive environment for all contributors. Please read our [Code of Conduct](./CODE_OF_CONDUCT.md).

**Key principles:**

- **Be respectful** and constructive in all interactions
- **Welcome newcomers** and help them succeed
- **Focus on ideas**, not individuals
- **Assume good intentions** and provide helpful feedback

### 💬 Communication

- **GitHub Issues**: For bugs, features, and technical discussions
- **GitHub Discussions**: For broader community topics
- **Discord**: For real-time chat and support ([Join here](https://discord.gg/loqa))
- **Pull Request Reviews**: For code-specific feedback

### 🆘 Getting Help

**Stuck on something?** We're here to help!

- **Comment on your issue/PR** for specific questions
- **Join Discord** for real-time support
- **Check the FAQ** for common questions
- **Browse past discussions** for similar topics

**For new contributors**, we provide:

- **Mentorship assignment** for guidance
- **Weekly office hours** for questions
- **Peer support network** with other contributors

---

## 🎖️ Recognition & Rewards

We believe in celebrating contributions! Here's how we recognize our community:

### 🌟 Achievement System

- **First Contribution Badge** - Your first merged PR
- **Good First Issue Champion** - Helping newcomers
- **Cross-Repository Contributor** - Working across multiple repos
- **Community Helper** - Supporting other contributors
- **Innovation Award** - Exceptional technical contributions

### 📊 Community Leaderboard

- Monthly contributor highlights
- Hall of Fame for sustained contributions
- Special recognition for mentorship and community building

### 🎁 Perks

- **Discord community role** and recognition
- **GitHub profile badges** for achievements
- **Quarterly newsletter features** highlighting your work
- **Conference speaking opportunities** (for active contributors)
- **Merchandise and swag** for significant contributions

---

## 🔍 Finding Your Niche

### By Technical Interest

**🤖 AI & Machine Learning**

- Integrate new STT/TTS models
- Improve LLM integration and prompt engineering
- Optimize inference performance
- Research and prototype new AI techniques

**⚙️ Backend Development**

- Enhance microservice architecture
- Improve gRPC performance
- Add new API endpoints
- Optimize database operations

**🎨 Frontend & UX**

- Enhance the Commander dashboard
- Improve accessibility compliance
- Create responsive mobile interfaces
- Design better user workflows

**🏗️ DevOps & Infrastructure**

- Improve Docker deployment
- Enhance CI/CD pipelines
- Add monitoring and observability
- Optimize resource usage

**🔌 Hardware & Embedded**

- Improve ESP32 relay firmware
- Optimize audio capture/playback
- Test hardware compatibility
- Create hardware documentation

### By Contribution Style

**🎯 Problem Solvers**

- Browse [`bug`](https://github.com/search?q=org%3Aloqalabs+label%3A%22bug%22+state%3Aopen&type=issues) issues
- Help with [`help wanted`](https://github.com/search?q=org%3Aloqalabs+label%3A%22help+wanted%22+state%3Aopen&type=issues) items
- Investigate performance bottlenecks

**🏗️ Builders**

- Implement [`enhancement`](https://github.com/search?q=org%3Aloqalabs+label%3A%22enhancement%22+state%3Aopen&type=issues) requests
- Create new skills and plugins
- Build development tools

**📚 Educators**

- Improve documentation and guides
- Create tutorials and examples
- Answer community questions
- Write blog posts about Loqa

**🔬 Researchers**

- Experiment with new AI models
- Prototype innovative features
- Conduct performance analysis
- Share findings with the community

---

## 🗺️ Repository Guide

Loqa is organized into multiple repositories. Here's where to contribute:

### Core Services

- **[loqa-hub](https://github.com/loqalabs/loqa-hub)** - Central service (Go)

  - STT/TTS/LLM pipeline
  - gRPC API and HTTP endpoints
  - Skills management
  - Good for: Backend, AI integration, APIs

- **[loqa-commander](https://github.com/loqalabs/loqa-commander)** - Web dashboard (Vue.js)

  - Administrative interface
  - Real-time monitoring
  - User management
  - Good for: Frontend, UI/UX, Vue.js

- **[loqa-relay](https://github.com/loqalabs/loqa-relay)** - Audio client (Go)
  - Audio capture and playback
  - Wake word detection
  - Hardware integration
  - Good for: Hardware, audio processing, embedded

### Extensions & Protocols

- **[loqa-skills](https://github.com/loqalabs/loqa-skills)** - Plugin system

  - Voice assistant skills
  - Integration templates
  - Community contributions
  - Good for: Plugin development, integrations

- **[loqa-proto](https://github.com/loqalabs/loqa-proto)** - Protocol definitions
  - gRPC specifications
  - API documentation
  - Cross-service communication
  - Good for: API design, protocol work

### Infrastructure

- **[loqalabs-github-config](https://github.com/loqalabs/loqalabs-github-config)** - Automation

  - GitHub Actions workflows
  - Community automation
  - Project management
  - Good for: DevOps, automation, community tools

- **[www-loqalabs-com](https://github.com/loqalabs/www-loqalabs-com)** - Website
  - Marketing and documentation site
  - Community resources
  - Blog and updates
  - Good for: Content, design, web development

---

## 📚 Resources & Documentation

### 📖 Essential Reading

- **[Architecture Overview](./docs/architecture.md)** - Understand the system design
- **[Developer Onboarding](./docs/developer-onboarding.md)** - Detailed setup guide
- **[API Documentation](./docs/api.md)** - Service interfaces and endpoints
- **[Skills Development Guide](./docs/skills.md)** - Create voice assistant skills

### 🛠️ Development Tools

- **[Claude Code Integration](./docs/claude-code.md)** - AI-assisted development
- **[Quality Assurance Guide](./docs/quality.md)** - Testing and validation
- **[Debugging Guide](./docs/debugging.md)** - Troubleshooting common issues

### 🎓 Learning Resources

- **[Voice AI Fundamentals](./docs/voice-ai.md)** - Background on voice technology
- **[Privacy & Security](./docs/privacy.md)** - Our approach to user protection
- **[Microservices Pattern](./docs/microservices.md)** - Architectural patterns used

### 🤝 Community Resources

- **[Discord Server](https://discord.gg/loqa)** - Real-time community chat
- **[GitHub Discussions](https://github.com/loqalabs/loqa/discussions)** - Async community discussions
- **[Weekly Office Hours](./docs/office-hours.md)** - Live Q&A sessions
- **[Community Newsletter](./docs/newsletter.md)** - Monthly updates and highlights

---

## 🎯 Success Tips

### For New Contributors

1. **Start small** - Choose `good first issue` items initially
2. **Ask questions** - We're here to help you succeed
3. **Read existing code** - Understand patterns before changing them
4. **Test thoroughly** - Run quality checks before submitting
5. **Be patient** - Learning takes time, and we support your journey

### For Experienced Contributors

1. **Mentor others** - Help new contributors get started
2. **Think architecture** - Consider system-wide impact of changes
3. **Document decisions** - Help future contributors understand your reasoning
4. **Lead initiatives** - Propose and drive larger improvements
5. **Build community** - Participate in discussions and planning

### For All Contributors

- **Stay connected** - Join Discord and follow GitHub discussions
- **Be consistent** - Regular small contributions are better than sporadic large ones
- **Share knowledge** - Write about your experiences and learnings
- **Celebrate others** - Recognize and support fellow contributors
- **Have fun** - Building the future of voice AI should be enjoyable!

---

## 🔮 Future Opportunities

### Emerging Areas

- **Speech-to-Speech Models** - Sub-200ms latency voice interactions
- **Edge AI Optimization** - Better performance on resource-constrained devices
- **Federated Learning** - Privacy-preserving personalization
- **Novel Interaction Modes** - Beyond traditional voice commands

### Community Leadership

- **Working Groups** - Lead specialized development areas
- **Community Events** - Organize meetups, hackathons, workshops
- **Thought Leadership** - Speak at conferences, write blog posts
- **Ecosystem Building** - Create tools and resources for other contributors

---

## 📞 Contact & Support

### Getting Help

- **Technical Questions**: Comment on relevant GitHub issues
- **General Support**: Join our [Discord server](https://discord.gg/loqa)
- **Private Inquiries**: Email community@loqalabs.com
- **Security Issues**: Email security@loqalabs.com

### Community Leads

- **@annabarnes1138** - Project founder and lead maintainer
- **Community Team** - Active in Discord and GitHub discussions

### Office Hours

- **When**: Fridays 2-3 PM UTC
- **Where**: Discord voice chat
- **What**: Open Q&A, contribution guidance, technical discussions

---

## 🎉 Welcome to Loqa!

Thank you for your interest in contributing to Loqa! Whether you're fixing a typo, building a new feature, or helping other contributors succeed, you're part of building a better future for voice AI.

**Your contributions matter.** Every improvement, no matter how small, helps create technology that respects user privacy and enables creative freedom.

**Ready to get started?**

1. 🌟 **Browse [Good First Issues](https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues)**
2. 💬 **Join our [Discord community](https://discord.gg/loqa)**
3. 📖 **Read our [Developer Onboarding Guide](./docs/developer-onboarding.md)**
4. 🚀 **Make your first contribution!**

**Welcome to the community!** We can't wait to see what you'll build with Loqa. 🚀

---

_This guide is a living document. Have suggestions for improvement? [Open an issue](https://github.com/loqalabs/loqalabs-github-config/issues) or submit a PR!_
