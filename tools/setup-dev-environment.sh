#!/bin/bash

# 🚀 Loqa Community Development Environment Setup
# This script provides one-command setup for external contributors

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Emojis
ROCKET="🚀"
CHECK="✅"
WARN="⚠️"
INFO="ℹ️"
TOOLS="🔧"

print_header() {
    echo -e "${CYAN}=================================================${NC}"
    echo -e "${CYAN}${ROCKET} Loqa Development Environment Setup${NC}"
    echo -e "${CYAN}=================================================${NC}"
    echo -e "${YELLOW}Welcome to the Loqa community!${NC}"
    echo -e "${YELLOW}This script will set up everything you need to contribute.${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}${1}${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK} ${1}${NC}"
}

print_warning() {
    echo -e "${YELLOW}${WARN} ${1}${NC}"
}

print_info() {
    echo -e "${PURPLE}${INFO} ${1}${NC}"
}

print_error() {
    echo -e "${RED}❌ ${1}${NC}"
}

# Check if running on supported platform
check_platform() {
    print_step "Checking platform compatibility..."
    
    case "$(uname -s)" in
        Darwin)
            PLATFORM="macOS"
            PACKAGE_MANAGER="brew"
            ;;
        Linux)
            PLATFORM="Linux"
            if command -v apt-get >/dev/null 2>&1; then
                PACKAGE_MANAGER="apt"
            elif command -v yum >/dev/null 2>&1; then
                PACKAGE_MANAGER="yum"
            elif command -v pacman >/dev/null 2>&1; then
                PACKAGE_MANAGER="pacman"
            else
                print_error "Unsupported Linux distribution. Please install Docker manually."
                exit 1
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*)
            PLATFORM="Windows"
            print_warning "Windows detected. Some features require WSL2 or Git Bash."
            ;;
        *)
            print_error "Unsupported platform: $(uname -s)"
            exit 1
            ;;
    esac
    
    print_success "Platform: $PLATFORM ($PACKAGE_MANAGER)"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Docker
install_docker() {
    print_step "Checking Docker installation..."
    
    if command_exists docker; then
        print_success "Docker already installed: $(docker --version)"
        return 0
    fi
    
    print_info "Installing Docker..."
    
    case $PLATFORM in
        "macOS")
            if ! command_exists brew; then
                print_info "Installing Homebrew first..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install --cask docker
            print_info "Please start Docker Desktop manually after installation."
            ;;
        "Linux")
            case $PACKAGE_MANAGER in
                "apt")
                    sudo apt update
                    sudo apt install -y docker.io docker-compose
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo usermod -aG docker $USER
                    ;;
                "yum")
                    sudo yum install -y docker docker-compose
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo usermod -aG docker $USER
                    ;;
                "pacman")
                    sudo pacman -S docker docker-compose
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo usermod -aG docker $USER
                    ;;
            esac
            print_warning "You may need to log out and back in for Docker permissions to take effect."
            ;;
        "Windows")
            print_warning "Please install Docker Desktop for Windows manually from https://docs.docker.com/desktop/install/windows/"
            print_info "Press Enter when Docker is installed..."
            read -r
            ;;
    esac
    
    print_success "Docker installation completed"
}

# Install Git
install_git() {
    print_step "Checking Git installation..."
    
    if command_exists git; then
        print_success "Git already installed: $(git --version)"
        return 0
    fi
    
    print_info "Installing Git..."
    
    case $PLATFORM in
        "macOS")
            brew install git
            ;;
        "Linux")
            case $PACKAGE_MANAGER in
                "apt")
                    sudo apt install -y git
                    ;;
                "yum")
                    sudo yum install -y git
                    ;;
                "pacman")
                    sudo pacman -S git
                    ;;
            esac
            ;;
        "Windows")
            print_warning "Please install Git for Windows from https://git-scm.com/download/win"
            print_info "Press Enter when Git is installed..."
            read -r
            ;;
    esac
    
    print_success "Git installation completed"
}

# Install development tools
install_dev_tools() {
    print_step "Installing development tools..."
    
    # Go installation
    if ! command_exists go; then
        print_info "Installing Go..."
        case $PLATFORM in
            "macOS")
                brew install go
                ;;
            "Linux")
                case $PACKAGE_MANAGER in
                    "apt")
                        sudo apt install -y golang-go
                        ;;
                    "yum")
                        sudo yum install -y golang
                        ;;
                    "pacman")
                        sudo pacman -S go
                        ;;
                esac
                ;;
            "Windows")
                print_info "Please install Go from https://golang.org/dl/"
                ;;
        esac
        print_success "Go installed"
    else
        print_success "Go already installed: $(go version)"
    fi
    
    # Node.js installation
    if ! command_exists node; then
        print_info "Installing Node.js..."
        case $PLATFORM in
            "macOS")
                brew install node
                ;;
            "Linux")
                case $PACKAGE_MANAGER in
                    "apt")
                        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
                        sudo apt install -y nodejs
                        ;;
                    "yum")
                        curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
                        sudo yum install -y nodejs
                        ;;
                    "pacman")
                        sudo pacman -S nodejs npm
                        ;;
                esac
                ;;
            "Windows")
                print_info "Please install Node.js from https://nodejs.org/"
                ;;
        esac
        print_success "Node.js installed"
    else
        print_success "Node.js already installed: $(node --version)"
    fi
}

# Clone repositories
clone_repositories() {
    print_step "Cloning Loqa repositories..."
    
    REPOS=(
        "loqa"
        "loqa-hub"
        "loqa-commander" 
        "loqa-relay"
        "loqa-skills"
        "loqa-proto"
        "www-loqalabs-com"
        "loqalabs-github-config"
    )
    
    mkdir -p loqalabs && cd loqalabs
    
    for repo in "${REPOS[@]}"; do
        if [ -d "$repo" ]; then
            print_info "Repository $repo already exists, skipping..."
        else
            print_info "Cloning $repo..."
            git clone "https://github.com/loqalabs/$repo.git"
            print_success "Cloned $repo"
        fi
    done
    
    print_success "All repositories cloned to $(pwd)"
}

# Setup development environment
setup_environment() {
    print_step "Setting up development environment..."
    
    cd loqa || {
        print_error "Could not find loqa directory. Please run clone step first."
        exit 1
    }
    
    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        print_info "Creating .env file..."
        cat > .env << EOF
# Loqa Development Environment Configuration

# Service URLs (Docker Compose defaults)
STT_URL=http://stt:8000
TTS_URL=http://tts:8880/v1
OLLAMA_URL=http://ollama:11434
NATS_URL=nats://nats:4222

# TTS Configuration
TTS_VOICE=af_bella
TTS_SPEED=1.0
TTS_FORMAT=mp3

# Server Configuration
LOQA_PORT=3000
LOQA_GRPC_PORT=50051

# Logging
LOG_LEVEL=info
LOG_FORMAT=json

# Development flags
DEVELOPMENT_MODE=true
HOT_RELOAD=true
EOF
        print_success "Created .env file with development defaults"
    fi
    
    # Build development environment
    print_info "Building Docker images (this may take a few minutes)..."
    if command_exists make; then
        make setup
    else
        docker-compose build
    fi
    
    print_success "Development environment ready"
}

# Verify installation
verify_setup() {
    print_step "Verifying installation..."
    
    # Check Docker
    if ! docker info >/dev/null 2>&1; then
        print_warning "Docker is not running. Please start Docker first."
        return 1
    fi
    
    # Start services
    print_info "Starting Loqa services..."
    if command_exists make; then
        make dev
    else
        docker-compose up -d
    fi
    
    # Wait for services to be ready
    print_info "Waiting for services to start..."
    sleep 10
    
    # Check service health
    HEALTH_CHECKS=(
        "http://localhost:3000/health"
        "http://localhost:5173"
        "http://localhost:8000/health" 
        "http://localhost:8880/health"
    )
    
    for url in "${HEALTH_CHECKS[@]}"; do
        if curl -s "$url" >/dev/null 2>&1; then
            print_success "Service healthy: $url"
        else
            print_warning "Service not responding: $url (this might be normal during startup)"
        fi
    done
    
    print_success "Setup verification completed"
}

# Print next steps
print_next_steps() {
    print_step "🎉 Setup completed! Here's what to do next:"
    echo ""
    echo -e "${GREEN}${TOOLS} Access your development environment:${NC}"
    echo -e "  • Hub API: ${CYAN}http://localhost:3000${NC}"
    echo -e "  • Commander UI: ${CYAN}http://localhost:5173${NC}"
    echo -e "  • NATS Monitoring: ${CYAN}http://localhost:8222${NC}"
    echo ""
    echo -e "${GREEN}📚 Learn about Loqa:${NC}"
    echo -e "  • Developer Guide: ${CYAN}docs/developer-onboarding.md${NC}"
    echo -e "  • Architecture: ${CYAN}docs/architecture.md${NC}"
    echo -e "  • Contributing: ${CYAN}CONTRIBUTING-COMMUNITY.md${NC}"
    echo ""
    echo -e "${GREEN}🤝 Join the community:${NC}"
    echo -e "  • Discord: ${CYAN}https://discord.gg/loqa${NC}"
    echo -e "  • GitHub Discussions: ${CYAN}https://github.com/loqalabs/loqa/discussions${NC}"
    echo ""
    echo -e "${GREEN}🎯 Find your first contribution:${NC}"
    echo -e "  • Good First Issues: ${CYAN}https://github.com/search?q=org%3Aloqalabs+label%3A%22good+first+issue%22+state%3Aopen&type=issues${NC}"
    echo -e "  • Help Wanted: ${CYAN}https://github.com/search?q=org%3Aloqalabs+label%3A%22help+wanted%22+state%3Aopen&type=issues${NC}"
    echo ""
    echo -e "${GREEN}🚀 Development commands:${NC}"
    echo -e "  • Start services: ${YELLOW}make dev${NC}"
    echo -e "  • Stop services: ${YELLOW}make stop${NC}"
    echo -e "  • View logs: ${YELLOW}make logs${NC}"
    echo -e "  • Run tests: ${YELLOW}make test${NC}"
    echo ""
    echo -e "${PURPLE}Happy contributing! Welcome to the Loqa community! 🎉${NC}"
}

# Main setup flow
main() {
    print_header
    
    # Parse command line arguments
    QUICK_SETUP=false
    SKIP_CLONE=false
    SKIP_VERIFY=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --quick)
                QUICK_SETUP=true
                shift
                ;;
            --skip-clone)
                SKIP_CLONE=true
                shift
                ;;
            --skip-verify)
                SKIP_VERIFY=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [options]"
                echo "Options:"
                echo "  --quick       Skip interactive prompts"
                echo "  --skip-clone  Skip repository cloning"
                echo "  --skip-verify Skip setup verification"
                echo "  --help        Show this help message"
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
    
    # Confirm setup
    if [[ $QUICK_SETUP != true ]]; then
        echo -e "${YELLOW}This script will install and configure:${NC}"
        echo -e "  • Docker and Docker Compose"
        echo -e "  • Git (if not installed)"
        echo -e "  • Go programming language"
        echo -e "  • Node.js and npm"
        echo -e "  • Loqa source code repositories"
        echo -e "  • Development environment setup"
        echo ""
        read -p "Continue with setup? [Y/n]: " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            print_info "Setup cancelled"
            exit 0
        fi
    fi
    
    # Run setup steps
    check_platform
    install_docker
    install_git
    install_dev_tools
    
    if [[ $SKIP_CLONE != true ]]; then
        clone_repositories
    fi
    
    setup_environment
    
    if [[ $SKIP_VERIFY != true ]]; then
        verify_setup
    fi
    
    print_next_steps
}

# Error handling
trap 'print_error "Setup failed. Please check the output above for errors."' ERR

# Run main function
main "$@"