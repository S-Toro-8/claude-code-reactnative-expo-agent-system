# ============================================
# 🌟 SenaiVerse - Claude Code Agent System
# Version: 1.2.0
# Created: 2025-10-03
# Updated: 2025-10-04
# ============================================
#
# Claude Code Agent System - Windows Installation Script
# Supports BOTH global and project-scoped installation
#
# Usage:
#   .\install-agents.ps1              # Interactive mode (prompts user to choose)
#   .\install-agents.ps1 -Scope global    # Force global installation
#   .\install-agents.ps1 -Scope project   # Force project installation
#   .\install-agents.ps1 -ProjectPath "C:\path\to\project"  # Specify project path

param(
    [ValidateSet("auto", "global", "project")]
    [string]$Scope = "auto",

    [string]$ProjectPath = ""
)

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Claude Code Agent System Installer" -ForegroundColor Cyan
Write-Host "Expo/React Native Development" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

# Check if Claude Code is installed
Write-Host "Checking Claude Code installation..." -ForegroundColor Yellow
try {
    $claudeVersion = claude --version 2>&1
    Write-Host "[OK] Claude Code found: $claudeVersion`n" -ForegroundColor Green
} catch {
    Write-Host "[X] Claude Code not found!" -ForegroundColor Red
    Write-Host "Please install Claude Code first: npm install -g @anthropic-ai/claude-code" -ForegroundColor Red
    exit 1
}

# Determine installation scope
$sourceDir = Join-Path $PSScriptRoot "..\ready-to-use"

if ($Scope -eq "auto") {
    # Interactive mode: Ask user to choose scope
    Write-Host "`n╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║          Choose Installation Scope                       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

    Write-Host "  1️⃣  Project-Scoped (Recommended for Teams)" -ForegroundColor Green
    Write-Host "      📁 Installs to: .claude/ in your project folder" -ForegroundColor Gray
    Write-Host "      ✅ Team sync via git (version controlled)" -ForegroundColor Gray
    Write-Host "      ✅ Project-specific customization" -ForegroundColor Gray
    Write-Host "      ✅ Higher priority than global agents`n" -ForegroundColor Gray

    Write-Host "  2️⃣  Global (Personal Use)" -ForegroundColor Yellow
    Write-Host "      🌍 Installs to: ~/.claude/ in your home folder" -ForegroundColor Gray
    Write-Host "      ✅ Available in all projects" -ForegroundColor Gray
    Write-Host "      ✅ Install once, use everywhere`n" -ForegroundColor Gray

    $choice = Read-Host "Enter your choice (1 or 2)"

    if ($choice -eq "1") {
        # Project-scoped chosen - scan for package.json
        $currentDir = Get-Location
        $packageJsonPath = Join-Path $currentDir "package.json"

        Write-Host "`nScanning current directory for package.json..." -ForegroundColor Yellow

        if (Test-Path $packageJsonPath) {
            # Read project name from package.json
            try {
                $packageJson = Get-Content $packageJsonPath | ConvertFrom-Json
                $projectName = if ($packageJson.name) { $packageJson.name } else { "Unnamed Project" }
            } catch {
                $projectName = "Unnamed Project"
            }

            Write-Host "`n╔══════════════════════════════════════════════════════════╗" -ForegroundColor Green
            Write-Host "║          ✅ PROJECT DETECTED                             ║" -ForegroundColor Green
            Write-Host "╚══════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

            Write-Host "  Project Name: $projectName" -ForegroundColor Cyan
            Write-Host "  Location: $currentDir" -ForegroundColor Gray
            Write-Host "  package.json: Found ✓`n" -ForegroundColor Gray

            # Preview what will be installed
            Write-Host "  Installation Preview:" -ForegroundColor Yellow
            $agentFiles = Get-ChildItem -Path "$sourceDir\agents" -Recurse -Filter "*.md" -ErrorAction SilentlyContinue
            $commandFiles = Get-ChildItem -Path "$sourceDir\commands" -Filter "*.md" -ErrorAction SilentlyContinue
            $agentCount = if ($agentFiles) { $agentFiles.Count } else { 0 }
            $commandCount = if ($commandFiles) { $commandFiles.Count } else { 0 }

            Write-Host "    • $agentCount AI agents" -ForegroundColor Gray
            Write-Host "    • $commandCount slash commands" -ForegroundColor Gray
            Write-Host "    • 1 settings.json configuration" -ForegroundColor Gray
            Write-Host "    • 1 CLAUDE.md template`n" -ForegroundColor Gray

            $confirm = Read-Host "Proceed with PROJECT installation? (Y/N)"

            if ($confirm -eq "Y" -or $confirm -eq "y") {
                $Scope = "project"
                Write-Host "`n[OK] Starting project-scoped installation...`n" -ForegroundColor Green
            } else {
                Write-Host "`n[CANCELLED] Installation aborted by user.`n" -ForegroundColor Yellow
                exit 0
            }
        } else {
            Write-Host "`n╔══════════════════════════════════════════════════════════╗" -ForegroundColor Red
            Write-Host "║          ❌ ERROR: NO PROJECT FOUND                      ║" -ForegroundColor Red
            Write-Host "╚══════════════════════════════════════════════════════════╝`n" -ForegroundColor Red

            Write-Host "  Current directory: $currentDir" -ForegroundColor Gray
            Write-Host "  package.json: Not found ✗`n" -ForegroundColor Gray

            Write-Host "📌 Tip: Navigate to your Expo/React Native project root first:" -ForegroundColor Yellow
            Write-Host "   cd C:\path\to\your\expo-project" -ForegroundColor Yellow
            Write-Host "   Then run this installer again.`n" -ForegroundColor Yellow

            Write-Host "Or use -ProjectPath parameter:" -ForegroundColor Yellow
            Write-Host "   .\install-agents.ps1 -ProjectPath 'C:\path\to\project'`n" -ForegroundColor Yellow

            exit 1
        }

    } elseif ($choice -eq "2") {
        # Global chosen
        $Scope = "global"
        Write-Host "`n[OK] Starting global installation...`n" -ForegroundColor Green

    } else {
        # Invalid choice
        Write-Host "`n[ERROR] Invalid choice: '$choice'" -ForegroundColor Red
        Write-Host "Please enter 1 or 2.`n" -ForegroundColor Yellow
        exit 1
    }
}

# Define paths based on scope
if ($Scope -eq "project") {
    $projectRoot = if ($ProjectPath) {
        if (!(Test-Path $ProjectPath)) {
            Write-Host "[X] Project path not found: $ProjectPath" -ForegroundColor Red
            exit 1
        }
        $ProjectPath
    } else {
        Get-Location
    }

    # Validate project structure
    if (!(Test-Path (Join-Path $projectRoot "package.json"))) {
        Write-Host "[X] Not a valid project directory (package.json not found)" -ForegroundColor Red
        Write-Host "Tip: Run this from your Expo/React Native project root, or use -ProjectPath" -ForegroundColor Yellow
        exit 1
    }

    $claudeDir = Join-Path $projectRoot ".claude"
    $installLocation = "PROJECT: $projectRoot"
    Write-Host "Installing to PROJECT directory" -ForegroundColor Green
    Write-Host "  Location: $claudeDir`n" -ForegroundColor Gray
} else {
    $userHome = $env:USERPROFILE
    $claudeDir = Join-Path $userHome ".claude"
    $installLocation = "GLOBAL: $userHome"
    Write-Host "Installing to GLOBAL directory" -ForegroundColor Green
    Write-Host "  Location: $claudeDir`n" -ForegroundColor Gray
}

$agentsDir = Join-Path $claudeDir "agents"
$commandsDir = Join-Path $claudeDir "commands"
$hooksDir = Join-Path $claudeDir "hooks"

# Create directories
Write-Host "Creating directory structure..." -ForegroundColor Yellow
$dirs = @($claudeDir, $agentsDir, $commandsDir, $hooksDir)
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  Created: $dir" -ForegroundColor Gray
    } else {
        Write-Host "  Exists: $dir" -ForegroundColor Gray
    }
}
Write-Host "[OK] Directories ready`n" -ForegroundColor Green

# Copy agents
Write-Host "Installing agents..." -ForegroundColor Yellow
$agentSourceDir = Join-Path $sourceDir "agents"
if (Test-Path $agentSourceDir) {
    $agentCount = 0
    Get-ChildItem -Path $agentSourceDir -Recurse -Filter "*.md" | ForEach-Object {
        $relativePath = $_.FullName.Substring($agentSourceDir.Length + 1)
        $destPath = Join-Path $agentsDir $relativePath
        $destDir = Split-Path -Parent $destPath

        if (!(Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        Copy-Item -Path $_.FullName -Destination $destPath -Force
        Write-Host "  + $($_.Name)" -ForegroundColor Gray
        $agentCount++
    }
    Write-Host "[OK] Installed $agentCount agents`n" -ForegroundColor Green
} else {
    Write-Host "[WARN] Agent source directory not found`n" -ForegroundColor Yellow
}

# Copy commands
Write-Host "Installing slash commands..." -ForegroundColor Yellow
$commandSourceDir = Join-Path $sourceDir "commands"
if (Test-Path $commandSourceDir) {
    $commandCount = 0
    Get-ChildItem -Path $commandSourceDir -Filter "*.md" | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $commandsDir -Force
        Write-Host "  + /$($_.BaseName)" -ForegroundColor Gray
        $commandCount++
    }
    Write-Host "[OK] Installed $commandCount commands`n" -ForegroundColor Green
} else {
    Write-Host "[WARN] Command source directory not found`n" -ForegroundColor Yellow
}

# Copy configuration
Write-Host "Installing configuration..." -ForegroundColor Yellow
$globalConfigSource = Join-Path $sourceDir "templates\settings.json"
$globalConfigDest = Join-Path $claudeDir "settings.json"
if (Test-Path $globalConfigSource) {
    if (!(Test-Path $globalConfigDest)) {
        Copy-Item -Path $globalConfigSource -Destination $globalConfigDest -Force
        Write-Host "[OK] Installed settings.json" -ForegroundColor Green
    } else {
        Write-Host "[WARN] settings.json already exists (not overwriting)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[WARN] Config template not found" -ForegroundColor Yellow
}

# Copy CLAUDE.md template for project installations
if ($Scope -eq "project") {
    $claudeMdSource = Join-Path $sourceDir "templates\CLAUDE.md"
    $claudeMdDest = Join-Path $projectRoot "CLAUDE.md"
    if (Test-Path $claudeMdSource) {
        if (!(Test-Path $claudeMdDest)) {
            Copy-Item -Path $claudeMdSource -Destination $claudeMdDest -Force
            Write-Host "[OK] Installed CLAUDE.md template (customize for your project)" -ForegroundColor Green
        } else {
            Write-Host "[INFO] CLAUDE.md already exists (not overwriting)" -ForegroundColor Cyan
        }
    }
}
Write-Host "" # Blank line

# Summary
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "============================================`n" -ForegroundColor Cyan

Write-Host "Installation Scope: $Scope ($(if ($Scope -eq 'project') { 'recommended for teams' } else { 'use for personal agents' }))" -ForegroundColor White
Write-Host "Installed to:" -ForegroundColor White
Write-Host "  Agents:   $agentsDir" -ForegroundColor Gray
Write-Host "  Commands: $commandsDir" -ForegroundColor Gray
Write-Host "  Config:   $globalConfigDest`n" -ForegroundColor Gray

if ($Scope -eq "project") {
    Write-Host "✅ PROJECT INSTALLATION" -ForegroundColor Green
    Write-Host "Benefits:" -ForegroundColor White
    Write-Host "  - Agents are version controlled (team can sync via git)" -ForegroundColor Gray
    Write-Host "  - Project-specific customization" -ForegroundColor Gray
    Write-Host "  - Higher priority than global agents`n" -ForegroundColor Gray

    Write-Host "Next Steps:" -ForegroundColor White
    Write-Host "1. Customize CLAUDE.md for your project:" -ForegroundColor Gray
    Write-Host "   code $projectRoot\CLAUDE.md`n" -ForegroundColor Gray

    Write-Host "2. Commit agents to version control:" -ForegroundColor Gray
    Write-Host "   git add .claude/" -ForegroundColor Gray
    Write-Host "   git commit -m 'Add Claude Code agents'`n" -ForegroundColor Gray

    Write-Host "3. Start Claude Code:" -ForegroundColor Gray
    Write-Host "   cd $projectRoot" -ForegroundColor Gray
    Write-Host "   claude`n" -ForegroundColor Gray
} else {
    Write-Host "✅ GLOBAL INSTALLATION" -ForegroundColor Green
    Write-Host "Benefits:" -ForegroundColor White
    Write-Host "  - Available in all projects" -ForegroundColor Gray
    Write-Host "  - Install once, use everywhere`n" -ForegroundColor Gray

    Write-Host "Next Steps:" -ForegroundColor White
    Write-Host "1. Copy CLAUDE.md template to your Expo project:" -ForegroundColor Gray
    Write-Host "   cp $sourceDir\templates\CLAUDE.md [your-project]\CLAUDE.md`n" -ForegroundColor Gray

    Write-Host "2. Navigate to your project and start Claude Code:" -ForegroundColor Gray
    Write-Host "   cd [your-project]" -ForegroundColor Gray
    Write-Host "   claude`n" -ForegroundColor Gray

    Write-Host "Tip: For team projects, consider project-scoped installation:" -ForegroundColor Yellow
    Write-Host "  cd [your-project]" -ForegroundColor Yellow
    Write-Host "  $PSCommandPath -Scope project`n" -ForegroundColor Yellow
}

Write-Host "3. Try invoking an agent:" -ForegroundColor Gray
Write-Host '   > Check accessibility of my components' -ForegroundColor Gray
Write-Host '   > /review src/components/Button.tsx' -ForegroundColor Gray
Write-Host ""

Write-Host "4. Read the documentation:" -ForegroundColor Gray
Write-Host "   - START-HERE.md (quick start)" -ForegroundColor Gray
Write-Host "   - COMPLETE-GUIDE.md (full reference)`n" -ForegroundColor Gray

Write-Host "Available Agents (invoke with @agent-name):" -ForegroundColor White
Write-Host "  - @grand-architect" -ForegroundColor Gray
Write-Host "  - @design-token-guardian" -ForegroundColor Gray
Write-Host "  - @a11y-enforcer" -ForegroundColor Gray
Write-Host "  - @test-generator" -ForegroundColor Gray
Write-Host "  - @performance-enforcer" -ForegroundColor Gray
Write-Host "  - @performance-prophet" -ForegroundColor Gray
Write-Host "  - @security-specialist" -ForegroundColor Gray
Write-Host "  - And more!`n" -ForegroundColor Gray

Write-Host "Available Commands (invoke with /command):" -ForegroundColor White
Write-Host "  - /feature [description]" -ForegroundColor Gray
Write-Host "  - /review [file]" -ForegroundColor Gray
Write-Host "  - /test [file]`n" -ForegroundColor Gray

Write-Host "For help: See START-HERE.md or COMPLETE-GUIDE.md`n" -ForegroundColor Yellow

Write-Host "Happy coding!" -ForegroundColor Cyan

