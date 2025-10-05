# Test 1: PowerShell Syntax Validation
$scriptPath = Join-Path $PSScriptRoot "install-agents.ps1"
try {
    $scriptContent = Get-Content $scriptPath -Raw
    $null = [scriptblock]::Create($scriptContent)
    Write-Host "TEST 1 - SYNTAX: ✅ VALID" -ForegroundColor Green
} catch {
    Write-Host "TEST 1 - SYNTAX: ❌ ERROR: $_" -ForegroundColor Red
}

# Test 2: Parameter Validation
Write-Host "`nTEST 2 - PARAMETER PRESERVATION:" -ForegroundColor Cyan
$paramBlock = Select-String -Path $scriptPath -Pattern "param\(" -Context 0,15
if ($paramBlock -match "ValidateSet.*auto.*global.*project") {
    Write-Host "  ✅ ValidateSet intact (auto, global, project)" -ForegroundColor Green
} else {
    Write-Host "  ❌ ValidateSet missing or modified" -ForegroundColor Red
}

if ($paramBlock -match '\$Scope\s*=\s*"auto"') {
    Write-Host "  ✅ Default scope is 'auto'" -ForegroundColor Green
} else {
    Write-Host "  ❌ Default scope changed" -ForegroundColor Red
}

if ($paramBlock -match 'ProjectPath') {
    Write-Host "  ✅ ProjectPath parameter exists" -ForegroundColor Green
} else {
    Write-Host "  ❌ ProjectPath parameter missing" -ForegroundColor Red
}

# Test 3: Conditional Flow Logic
Write-Host "`nTEST 3 - CONDITIONAL FLOW:" -ForegroundColor Cyan
$content = Get-Content $scriptPath -Raw

# Check interactive block exists
if ($content -match 'if \(\$Scope -eq "auto"\)') {
    Write-Host "  ✅ Interactive block trigger found" -ForegroundColor Green
} else {
    Write-Host "  ❌ Interactive block missing" -ForegroundColor Red
}

# Check menu options
if ($content -match 'Read-Host.*choice') {
    Write-Host "  ✅ User choice prompt found" -ForegroundColor Green
} else {
    Write-Host "  ❌ User choice prompt missing" -ForegroundColor Red
}

# Check project scan logic
if ($content -match 'Test-Path.*package\.json') {
    Write-Host "  ✅ package.json scan logic found" -ForegroundColor Green
} else {
    Write-Host "  ❌ package.json scan missing" -ForegroundColor Red
}

# Check confirmation prompt
if ($content -match 'Proceed.*\(Y/N\)') {
    Write-Host "  ✅ Confirmation prompt found" -ForegroundColor Green
} else {
    Write-Host "  ❌ Confirmation prompt missing" -ForegroundColor Red
}

# Test 4: Error Handling
Write-Host "`nTEST 4 - ERROR HANDLING:" -ForegroundColor Cyan

# Check exit codes
$exitCount = ([regex]::Matches($content, "exit\s+[01]")).Count
Write-Host "  ✅ Found $exitCount exit statements" -ForegroundColor Green

# Check error messages
if ($content -match 'NO PROJECT FOUND') {
    Write-Host "  ✅ 'NO PROJECT FOUND' error message exists" -ForegroundColor Green
} else {
    Write-Host "  ❌ Missing project not found error" -ForegroundColor Red
}

if ($content -match 'CANCELLED|cancelled') {
    Write-Host "  ✅ Cancellation handling exists" -ForegroundColor Green
} else {
    Write-Host "  ❌ Missing cancellation handling" -ForegroundColor Red
}

if ($content -match 'Invalid choice') {
    Write-Host "  ✅ Invalid input handling exists" -ForegroundColor Green
} else {
    Write-Host "  ❌ Missing invalid input handling" -ForegroundColor Red
}

# Test 5: Variable Flow
Write-Host "`nTEST 5 - VARIABLE STATE:" -ForegroundColor Cyan

# Check $Scope assignment in interactive block
$scopeAssignments = ([regex]::Matches($content, '\$Scope\s*=\s*"(project|global)"')).Count
if ($scopeAssignments -ge 2) {
    Write-Host "  ✅ Scope variable assigned in both paths ($scopeAssignments assignments)" -ForegroundColor Green
} else {
    Write-Host "  ❌ Missing scope assignments" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VALIDATION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
