# Contributing to Claude Code Agent System

Thank you for your interest in contributing to the Claude Code Agent System! 🎉

This project aims to make React Native/Expo development faster and more reliable through AI-powered agents. Your contributions help the entire mobile development community.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

---

## 📜 Code of Conduct

This project follows a simple rule: **Be kind, be helpful, be respectful.**

- **Be constructive** in feedback and discussions
- **Be patient** with new contributors
- **Be respectful** of different perspectives and experience levels
- **Be collaborative** - we're all here to improve mobile development

---

## 🤝 How Can I Contribute?

### Reporting Bugs

Found a bug? Please create a GitHub Issue with:

1. **Clear title** - What's broken?
2. **Steps to reproduce** - How did you encounter it?
3. **Expected behavior** - What should happen?
4. **Actual behavior** - What actually happened?
5. **System info**:
   - Windows version
   - Claude Code version (`claude --version`)
   - PowerShell version
   - Expo/React Native version (if applicable)

**Example:**
```
Title: "installer-agents.ps1 fails when package.json contains comments"

Steps:
1. Add // comment to package.json
2. Run .\install-agents.ps1 -Scope project
3. Error appears

Expected: Installer should handle JSON with comments
Actual: "Invalid JSON" error

System: Windows 11, Claude Code 2.0.5, PowerShell 7.4
```

---

### Suggesting Enhancements

Have an idea? Create a GitHub Issue with:

1. **Clear description** of the enhancement
2. **Use case** - What problem does it solve?
3. **Examples** - How would it work?
4. **Alternatives** - Have you considered other approaches?

---

### Creating New Agents

Want to add a new agent to the 20-agent system design?

**Requirements:**
1. **Follows existing pattern** - Use AGENTS-REFERENCE.md as template
2. **Solves real problem** - Based on actual React Native pain points
3. **Well-documented** - Clear description, examples, use cases
4. **Tested** - Works on real Expo/React Native projects

**Agent File Structure:**
```markdown
---
name: my-agent
description: Specific description of when to invoke (be precise for auto-invocation)
tools: Read, Grep, Edit  # Only tools actually needed
model: sonnet  # haiku/sonnet/opus based on complexity
---

# My Agent

You are an expert in [domain].

## Your Mission
[What this agent does and when to use it]

## What You Check
- Specific check 1
- Specific check 2

## Output Format
[How findings are reported]

## Examples
[Usage examples]
```

---

### Improving Documentation

Documentation improvements are always welcome!

- Fix typos or unclear wording
- Add examples and use cases
- Improve installation instructions
- Add troubleshooting solutions
- Update for new Claude Code versions

---

### Adding Platform Support

Currently supports **Windows**. Contributions for macOS/Linux welcome!

**What's needed:**
- Bash installation script (equivalent to install-agents.ps1)
- Cross-platform path handling
- Updated documentation
- Testing on target platform

---

## 🛠️ Development Setup

### Prerequisites

1. **Windows 10/11** (or macOS/Linux for porting)
2. **PowerShell 5.1+** (Windows) or Bash (macOS/Linux)
3. **Claude Code v2.0.5+**
4. **Git**

### Setup Steps

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/claude-code-expo-system.git
cd claude-code-expo-system

# 3. Create a feature branch
git checkout -b feature/my-amazing-feature

# 4. Make your changes
# Edit files, create new agents, update docs, etc.

# 5. Test your changes (see Testing Guidelines below)

# 6. Commit your changes
git add .
git commit -m "Add: My amazing feature"

# 7. Push to your fork
git push origin feature/my-amazing-feature

# 8. Create Pull Request on GitHub
```

---

## 🔄 Pull Request Process

### Before Submitting

- [ ] **Test thoroughly** - Verify installation script works
- [ ] **Update documentation** - README, guides, etc.
- [ ] **Follow coding standards** (see below)
- [ ] **Add examples** - Show how new feature works
- [ ] **Check for typos** - Proofread your changes

### PR Title Format

Use conventional commits style:

- `feat: Add bundle-size-assassin agent`
- `fix: Installer handles paths with spaces`
- `docs: Improve installation instructions`
- `refactor: Simplify agent detection logic`
- `test: Add validation for custom commands`

### PR Description

Include:
1. **What** - What does this PR do?
2. **Why** - Why is this change needed?
3. **How** - How does it work?
4. **Testing** - How did you test it?
5. **Screenshots** (if applicable)

**Example:**
```markdown
## What
Adds the Bundle Size Assassin agent to detect and optimize large imports.

## Why
Bundle size is a critical issue for React Native apps. This agent catches:
- Full lodash imports (should use lodash-es)
- Large moment.js (suggest day.js alternative)
- Duplicate dependencies

## How
- Created agent file: ready-to-use/agents/tier-3-specialized/bundle-assassin.md
- Uses Bash tool to run `npx react-native-bundle-visualizer`
- Parses output and suggests optimizations

## Testing
- Tested on 3 Expo projects (SDK 50, 51, 52)
- Detected 4/4 known bundle size issues
- Suggestions were actionable and correct
```

---

## 📝 Coding Standards

### PowerShell Scripts

```powershell
# ✅ DO: Use clear variable names
$projectRoot = Get-Location

# ✅ DO: Add error handling
try {
    Copy-Item -Path $source -Destination $dest -Force
} catch {
    Write-Host "[ERROR] Failed to copy: $_" -ForegroundColor Red
    exit 1
}

# ✅ DO: Use consistent colors
Write-Host "[OK] Success" -ForegroundColor Green
Write-Host "[WARN] Warning" -ForegroundColor Yellow
Write-Host "[ERROR] Error" -ForegroundColor Red

# ❌ DON'T: Hardcode paths
$path = "C:\Users\Senai\..."  # BAD

# ❌ DON'T: Skip error handling
Copy-Item ...  # No try/catch - BAD
```

### Agent Files (Markdown + YAML)

```markdown
# ✅ DO: Be specific in description
---
description: Validates React Native components for missing accessibilityLabel, accessibilityRole, and touch target size (44x44) according to WCAG 2.2
---

# ❌ DON'T: Be vague
---
description: Checks accessibility
---

# ✅ DO: Only include needed tools
---
tools: Read, Grep
---

# ❌ DON'T: Include all tools
---
tools: Read, Write, Edit, Grep, Glob, Bash, Task, WebFetch  # Overkill
---
```

### Documentation

- Use **clear headings** with emoji (consistent with existing docs)
- Include **code examples** with syntax highlighting
- Add **real-world scenarios** when possible
- Keep **line length < 120 characters** for readability
- Use **markdown tables** for comparisons

---

## 🧪 Testing Guidelines

### Manual Testing Checklist

Before submitting a PR, test:

#### For Installation Script Changes:
- [ ] **Fresh install** - Delete `.claude/` and reinstall
- [ ] **Project-scoped install** - Run from Expo project root
- [ ] **Global install** - Install to `~/.claude/`
- [ ] **Interactive mode** - Test prompts and user input
- [ ] **Non-interactive mode** - Test `-Scope` parameter
- [ ] **Error handling** - Test with missing package.json, invalid paths
- [ ] **Permission errors** - Test without admin rights

#### For Agent Changes:
- [ ] **Auto-invocation** - Does it trigger automatically?
- [ ] **Manual invocation** - Does `@agent-name` work?
- [ ] **Correct output** - Are suggestions accurate?
- [ ] **Edge cases** - Test with unusual project structures
- [ ] **Performance** - Response time < 30 seconds?

#### For Documentation:
- [ ] **Links work** - All internal links navigate correctly
- [ ] **Code blocks** - All examples use correct syntax
- [ ] **Formatting** - Renders correctly in GitHub
- [ ] **Accuracy** - Information is up-to-date

### Test Reporting

In your PR, include:

```markdown
## Test Results

**Environment:**
- Windows 11 Pro
- Claude Code v2.0.5
- PowerShell 7.4.1
- Expo SDK 51

**Tests Performed:**
✅ Fresh install (project-scoped)
✅ Fresh install (global)
✅ Interactive mode selection
✅ Agent auto-invocation (5/5 tests)
✅ Manual invocation works
✅ Error handling (missing package.json)

**Issues Found:** None
```

---

## 📚 Documentation

### What to Document

When adding features, update:

1. **README.md** - If it affects installation or main features
2. **START-HERE.md** - If it changes quick start process
3. **COMPLETE-GUIDE.md** - For detailed feature documentation
4. **TROUBLESHOOTING-AND-FAQ.md** - For common issues
5. **AGENTS-REFERENCE.md** - For new agents
6. **CHANGELOG.md** - For all changes

### Documentation Style

- **User-focused** - Write for developers who will use it
- **Practical examples** - Show don't just tell
- **Clear structure** - Use headings, lists, tables
- **Concise** - Get to the point quickly
- **Accurate** - Test examples before documenting

---

## 🎯 Contribution Ideas

Not sure what to contribute? Here are ideas:

**High Impact:**
- Create agents from the 20-agent design (see AGENTS-REFERENCE.md)
- Add macOS/Linux installation support
- Improve agent descriptions for better auto-invocation
- Add real-world case studies to documentation

**Medium Impact:**
- Create custom slash commands for common workflows
- Add support for Expo SDK 53+
- Improve error messages in installation script
- Add screenshots/GIFs to documentation

**Low Hanging Fruit:**
- Fix typos and grammar
- Improve code comments
- Add troubleshooting solutions
- Translate documentation (if multilingual support added)

---

## ❓ Questions?

- **General questions:** Open a GitHub Discussion
- **Bug reports:** Open a GitHub Issue
- **Feature requests:** Open a GitHub Issue
- **Security issues:** Email [security@example.com] (private)

---

## 🙏 Recognition

Contributors will be recognized in:
- README.md acknowledgments section
- Release notes
- Project documentation

Significant contributions may result in co-author credit.

---

## 📜 License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers this project.

---

**Thank you for making mobile development better for everyone! 🚀**

---

*© 2025 SenaiVerse | Claude Code Agent System | Built for React Native Mobile Excellence*
