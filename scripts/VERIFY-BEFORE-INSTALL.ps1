# ============================================
# 🌟 SenaiVerse - Claude Code Agent System
# Version: 1.0.0
# Created: 2025-10-03
# ============================================
#
# Quick verification script - Run this before installation
Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " INSTALLATION READINESS CHECK" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

$sourceDir = Join-Path $PSScriptRoot "..\ready-to-use"

Write-Host "Checking source files..." -ForegroundColor Yellow

# Count files
$agentFiles = @(Get-ChildItem -Path (Join-Path $sourceDir "agents") -Recurse -Filter "*.md")
$commandFiles = @(Get-ChildItem -Path (Join-Path $sourceDir "commands") -Filter "*.md")
$settingsExists = Test-Path (Join-Path $sourceDir "templates\settings.json")
$claudeExists = Test-Path (Join-Path $sourceDir "templates\CLAUDE.md")

Write-Host "  Agent files found: $($agentFiles.Count)" -ForegroundColor $(if ($agentFiles.Count -ge 7) {'Green'} else {'Red'})
Write-Host "  Command files found: $($commandFiles.Count)" -ForegroundColor $(if ($commandFiles.Count -ge 3) {'Green'} else {'Red'})
Write-Host "  settings.json: $(if ($settingsExists) {'Found'} else {'MISSING'})" -ForegroundColor $(if ($settingsExists) {'Green'} else {'Red'})
Write-Host "  CLAUDE.md: $(if ($claudeExists) {'Found'} else {'MISSING'})`n" -ForegroundColor $(if ($claudeExists) {'Green'} else {'Red'})

if ($agentFiles.Count -ge 7 -and $commandFiles.Count -ge 3 -and $settingsExists -and $claudeExists) {
    Write-Host "[OK] Ready to install!`n" -ForegroundColor Green
    Write-Host "Run: .\install-agents.ps1`n" -ForegroundColor Cyan
} else {
    Write-Host "[ERROR] Missing files - installation will fail!`n" -ForegroundColor Red
    exit 1
}
