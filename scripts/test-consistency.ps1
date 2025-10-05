# Test 6: Documentation Consistency Check

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TEST 6 - DOCUMENTATION CONSISTENCY" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$rootDir = Split-Path $PSScriptRoot -Parent
$files = @(
    "README.md",
    "START-HERE.md",
    "COMPLETE-GUIDE.md",
    "TROUBLESHOOTING-AND-FAQ.md",
    "ready-to-use\templates\CLAUDE.md",
    "claude-code-system.html"
)

# Check 1: All files mention interactive mode
Write-Host "CHECK 1: Interactive Mode Mentioned" -ForegroundColor Yellow
foreach ($file in $files) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        if ($content -match "interactive|Interactive|INTERACTIVE") {
            Write-Host "  ✅ $file" -ForegroundColor Green
        } else {
            Write-Host "  ⚠️  $file - No mention of interactive mode" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ❌ $file - File not found" -ForegroundColor Red
    }
}

# Check 2: Command syntax consistency
Write-Host "`nCHECK 2: Command Syntax Consistency" -ForegroundColor Yellow
$commandVariants = @()
foreach ($file in $files) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $matches = [regex]::Matches($content, '(install-agents\.ps1[^\n]*)')
        foreach ($match in $matches | Select-Object -First 3) {
            $commandVariants += "$($file): $($match.Value.Trim())"
        }
    }
}

Write-Host "  Found command variations:"
$commandVariants | Select-Object -First 10 | ForEach-Object {
    Write-Host "    $_" -ForegroundColor Gray
}

# Check 3: Scope terminology consistency
Write-Host "`nCHECK 3: Scope Terminology" -ForegroundColor Yellow
$terms = @("project-scoped", "Project-scoped", "Project-Scoped", "global", "Global")
foreach ($term in $terms) {
    $count = 0
    foreach ($file in $files) {
        $path = Join-Path $rootDir $file
        if (Test-Path $path) {
            $content = Get-Content $path -Raw
            $matches = ([regex]::Matches($content, $term, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
            $count += $matches
        }
    }
    if ($count -gt 0) {
        Write-Host "  '$term': $count occurrences" -ForegroundColor Gray
    }
}

# Check 4: Version consistency
Write-Host "`nCHECK 4: Version Numbers" -ForegroundColor Yellow
$scriptPath = Join-Path $PSScriptRoot "install-agents.ps1"
$scriptContent = Get-Content $scriptPath -Raw
if ($scriptContent -match "Version:\s*([\d\.]+)") {
    $scriptVersion = $matches[1]
    Write-Host "  Script version: $scriptVersion" -ForegroundColor Green
} else {
    Write-Host "  ❌ Script version not found" -ForegroundColor Red
}

# Check 5: Step count in HTML files
Write-Host "`nCHECK 5: HTML Step Count" -ForegroundColor Yellow
foreach ($file in @("claude-code-system.html")) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $stepMatches = [regex]::Matches($content, 'Step\s+(\d+):')
        $maxStep = ($stepMatches | ForEach-Object { [int]$_.Groups[1].Value } | Measure-Object -Maximum).Maximum
        Write-Host "  $file - Maximum step: $maxStep" -ForegroundColor Gray
    }
}

# Check 6: Error message consistency
Write-Host "`nCHECK 6: Error Messages in Script" -ForegroundColor Yellow
$errorMessages = [regex]::Matches($scriptContent, '\[ERROR\][^\n]+').Value
Write-Host "  Found $($errorMessages.Count) error message(s):" -ForegroundColor Gray
$errorMessages | ForEach-Object {
    Write-Host "    $_" -ForegroundColor Gray
}

# Check 7: Success message consistency
Write-Host "`nCHECK 7: Success Messages in Script" -ForegroundColor Yellow
$successMessages = [regex]::Matches($scriptContent, '\[OK\][^\n]+').Value
Write-Host "  Found $($successMessages.Count) success message(s):" -ForegroundColor Gray
$successMessages | Select-Object -First 5 | ForEach-Object {
    Write-Host "    $_" -ForegroundColor Gray
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CONSISTENCY CHECK COMPLETE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
