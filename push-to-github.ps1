# ============================================
# Push to GitHub - Automated Script
# Repository: claude-code-reactnative-expo-agent-system
# ============================================

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Push to GitHub - Automated Setup" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

# Get GitHub username
$username = Read-Host "Enter your GitHub username"

if ([string]::IsNullOrWhiteSpace($username)) {
    Write-Host "[ERROR] Username cannot be empty" -ForegroundColor Red
    exit 1
}

Write-Host "`n[1/6] Initializing Git..." -ForegroundColor Yellow
git init
if ($LASTEXITCODE -ne 0) {
    Write-Host "[INFO] Git already initialized" -ForegroundColor Gray
}

Write-Host "[2/6] Adding all files..." -ForegroundColor Yellow
git add .

Write-Host "[3/6] Creating commit..." -ForegroundColor Yellow
git commit -m "feat: Initial release v1.2.0 - AI Agent System for React Native/Expo

Production-ready system with 7 core AI agents for mobile app development:
- Grand Architect (meta-orchestration)
- Design Token Guardian (design system enforcement)
- A11y Compliance Enforcer (WCAG 2.2 accessibility)
- Smart Test Generator (automated testing)
- Performance Budget Enforcer (performance tracking)
- Performance Prophet (predictive analysis)
- Security Penetration Specialist (OWASP Mobile Top 10)

Features:
- Interactive Windows installation script
- Project-scoped and global installation modes
- 3 custom slash commands (/feature, /review, /test)
- 20-agent system design with expansion templates
- Comprehensive documentation (9 guides)
- MIT License
- Contributing guidelines

Built specifically for React Native/Expo mobile apps.

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Commit failed" -ForegroundColor Red
    exit 1
}

Write-Host "[4/6] Adding remote..." -ForegroundColor Yellow
$repoUrl = "https://github.com/$username/claude-code-reactnative-expo-agent-system.git"

# Check if remote exists, remove if it does
$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    Write-Host "[INFO] Removing existing remote" -ForegroundColor Gray
    git remote remove origin
}

git remote add origin $repoUrl

Write-Host "[5/6] Renaming branch to main..." -ForegroundColor Yellow
git branch -M main

Write-Host "[6/6] Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n============================================" -ForegroundColor Green
    Write-Host "SUCCESS! Repository pushed to GitHub" -ForegroundColor Green
    Write-Host "============================================`n" -ForegroundColor Green

    Write-Host "Repository URL:" -ForegroundColor White
    Write-Host "  https://github.com/$username/claude-code-reactnative-expo-agent-system`n" -ForegroundColor Cyan

    Write-Host "Next Steps:" -ForegroundColor White
    Write-Host "  1. Add repository topics (see TODO-AFTER-PUSH.md)" -ForegroundColor Gray
    Write-Host "  2. Update author info in README.md" -ForegroundColor Gray
    Write-Host "  3. Create v1.2.0 release (optional)" -ForegroundColor Gray
    Write-Host "  4. Delete helper files: GIT-COMMANDS.md, TODO-AFTER-PUSH.md, push-to-github.ps1`n" -ForegroundColor Gray

} else {
    Write-Host "`n[ERROR] Push failed" -ForegroundColor Red
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "  - Repository not created on GitHub yet" -ForegroundColor Gray
    Write-Host "  - Incorrect username" -ForegroundColor Gray
    Write-Host "  - Authentication required (run: gh auth login)`n" -ForegroundColor Gray
}
