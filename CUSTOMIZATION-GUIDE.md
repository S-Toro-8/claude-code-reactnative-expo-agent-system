# 🎨 Customization & Editing Guide

> **🌟 Created by SenaiVerse**
> *Claude Code Agent System for Expo/React Native Development*

---

**Learn how to modify agents, create custom workflows, and tailor the system to your needs**

---

## 📋 Table of Contents

- [🔧 Editing Existing Agents](#-editing-existing-agents)
- [✨ Creating New Agents](#-creating-new-agents)
- [💬 Customizing Slash Commands](#-customizing-slash-commands)
- [⚙️ Configuring Hooks](#️-configuring-hooks)
- [📝 Modifying CLAUDE.md](#-modifying-claudemd)
- [🎯 Project-Specific Customization](#-project-specific-customization)
- [👥 Team Customization](#-team-customization)
- [🚀 Advanced Customization](#-advanced-customization)

---

## 🔧 Editing Existing Agents

### Why Edit an Agent?

- **Adjust behavior** for your team's conventions
- **Add project-specific rules**
- **Change tool access**
- **Modify output format**
- **Fine-tune for your tech stack**

---

### Step-by-Step: Edit an Agent

#### Step 1: Locate the Agent File

```bash
# Windows
cd C:\Users\Senai\.claude\agents

# Find the agent
ls tier-1-daily/
# Output: design-token-guardian.md, a11y-enforcer.md, etc.
```

**Agent locations:**
- `tier-s-meta/` - Grand Architect
- `tier-1-daily/` - Essential agents
- `tier-2-power/` - Power agents
- `tier-3-specialized/` - Specialized agents

---

#### Step 2: Open in Your Editor

```bash
# Option 1: Notepad (Windows)
notepad ~/.claude/agents/tier-1-daily/design-token-guardian.md

# Option 2: VS Code
code ~/.claude/agents/tier-1-daily/design-token-guardian.md

# Option 3: Cursor
cursor ~/.claude/agents/tier-1-daily/design-token-guardian.md
```

---

#### Step 3: Understand the Structure

```yaml
---
# YAML Frontmatter (Configuration)
name: design-token-guardian
description: Detects hardcoded colors, spacing, typography values
tools: Read, Grep, Glob, Edit
model: sonnet
---

# Markdown Content (System Prompt)
# Design Token Guardian

You are a design system expert who...

## Your Mission
[Instructions for the agent]

## Output Format
[How agent should respond]
```

**Two parts:**
1. **YAML Frontmatter** (between `---`) - Configuration
2. **Markdown Content** - The agent's instructions (system prompt)

---

#### Step 4: Modify Configuration (YAML)

**What you can change:**

| Field | Options | When to Change |
|-------|---------|----------------|
| `name` | Any string (lowercase-hyphenated) | ⚠️ Rarely - breaks invocation |
| `description` | Text explaining when to invoke | ✅ Often - improve auto-invocation |
| `tools` | Read, Write, Edit, Grep, Glob, Bash, Task, WebFetch | ✅ Often - restrict or expand |
| `model` | haiku, sonnet, opus | ✅ Often - balance speed/quality |

**Example: Make Agent Faster**

```yaml
# Before (slow but thorough)
---
name: design-token-guardian
tools: Read, Write, Edit, Grep, Glob, Bash
model: opus
---

# After (faster)
---
name: design-token-guardian
tools: Grep, Read, Edit  # Only essential tools
model: sonnet            # Faster model
---
```

**Example: Improve Auto-Invocation**

```yaml
# Before (too vague)
---
description: Checks design system
---

# After (specific keywords)
---
description: Detects hardcoded colors like #007AFF, spacing values like marginTop:16, and enforces design system tokens from theme.ts in React Native components
---
```

---

#### Step 5: Modify Instructions (Markdown)

**What you can customize:**

##### A. Add Project-Specific Rules

```markdown
## Design System

You enforce design tokens from:
- `src/theme/index.ts` (NativeBase config)
- `src/theme/custom.ts` (custom tokens)

### Project-Specific Rules for MyApp:
1. **Never use `theme.colors.blue`** - Use `theme.colors.brand.primary` instead
2. **Spacing must be multiples of 8** - xs(8), sm(16), md(24), lg(32)
3. **Custom shadow tokens** - Use `theme.shadows.card`, `theme.shadows.modal`

### Special Cases:
- Platform-specific colors allowed in `/platform/` directory
- Hardcoded values OK in Storybook files
```

##### B. Change Output Format

```markdown
## Output Format

<!-- Before (generic) -->
Report all violations found.

<!-- After (specific to your team) -->
**Output Format:**

1. **Critical Issues** (must fix before PR):
   - List with file:line references
   - Include fix suggestions

2. **Warnings** (fix in next iteration):
   - Grouped by type
   - Severity score (1-10)

3. **Auto-fix Available?**
   - Yes/No
   - If yes, show exact changes

4. **Summary Table:**
   | Category | Count | Severity |
   |----------|-------|----------|
   | Colors   | 12    | High     |
   | Spacing  | 8     | Medium   |

**Example Reference:**
Link to similar PR: #123
```

##### C. Adjust Strictness

```markdown
## Strictness Level

<!-- Make less strict -->
⚠️ **Warnings Only Mode:**
- Report violations but don't block
- Suggest fixes but allow hardcoded values in:
  - Prototype screens (/prototypes/)
  - Third-party integrations (/external/)
  - Legacy code (/legacy/)

<!-- Make more strict -->
🚫 **Strict Mode:**
- Block all hardcoded values
- No exceptions
- Zero tolerance for design system violations
```

##### D. Add Context from Your Tech Stack

```markdown
## Tech Stack Context

**This project uses:**
- **NativeBase 3.4** - Use `useToken()` hook
- **Custom theme:** Extended from NativeBase
- **Design Figma:** Link to Figma file

**NativeBase-Specific Patterns:**
```typescript
// ✅ Correct NativeBase pattern
import { useToken } from 'native-base';
const [primary] = useToken('colors', ['primary']);

// ❌ Don't suggest this
import { theme } from '@/theme';
const primary = theme.colors.primary; // NativeBase doesn't work this way
```

**Always verify fixes work with NativeBase API!**
```

---

#### Step 6: Test Your Changes

```bash
# 1. Save the file

# 2. Restart Claude Code (in your project)
cd /path/to/your/project
claude

# 3. Test the modified agent
> @design-token-guardian check src/screens/HomeScreen.tsx

# 4. Verify it works as expected
```

---

#### Step 7: Revert if Needed

```bash
# Option 1: Git (if you version control ~/.claude/)
cd ~/.claude
git checkout agents/tier-1-daily/design-token-guardian.md

# Option 2: Reinstall from system
cd ~/claude-code-expo-system/scripts
.\install-agents.ps1
# Choose "overwrite" when prompted
```

---

### Common Modifications

#### Make Agent Project-Specific

**Before (generic):**
```yaml
---
name: a11y-enforcer
description: Checks accessibility
---

You check for accessibility issues.
```

**After (project-specific):**
```yaml
---
name: a11y-enforcer
description: Validates WCAG 2.2 AA compliance for MyHealthApp, ensuring medical app accessibility standards and FDA compliance
---

# A11y Enforcer for MyHealthApp

You ensure WCAG 2.2 AA compliance **with extra requirements for medical apps**.

## MyHealthApp-Specific Rules

### FDA Requirements (21 CFR Part 11):
- All interactive elements must have accessibilityLabel
- Color cannot be the only differentiator for medical data
- Minimum touch target: 48x48 (higher than WCAG)

### Project Patterns:
```typescript
// Health data display
<Text accessibilityLabel={`Blood pressure ${value} mmHg`}>
  {value}
</Text>

// Critical actions
<Button
  accessibilityLabel="Submit vital signs data"
  accessibilityHint="Sends your measurements to your doctor"
/>
```

## Higher Standards
- Touch targets: 48x48 (not 44x44)
- Color contrast: 7:1 (AAA, not AA)
- All icons must have labels (no exceptions)
```

---

#### Change Tool Permissions

**Scenario:** Security agent should only READ, not WRITE

```yaml
# Before (can modify files)
---
name: security-specialist
tools: Read, Grep, Edit, Bash
---

# After (read-only)
---
name: security-specialist
tools: Read, Grep, Bash  # Removed Edit
---
```

**Result:** Agent can find issues but can't make changes (safer for security audits)

---

#### Adjust Model for Speed vs Quality

```yaml
# Fast but less thorough (good for simple checks)
model: haiku

# Balanced (default for most agents)
model: sonnet

# Smartest but slower (complex reasoning)
model: opus
```

**Recommendation:**
- Lint-style checks → `haiku`
- Most agents → `sonnet`
- Grand Architect, complex analysis → `opus`

---

## ✨ Creating New Agents

### When to Create a New Agent

✅ **Good reasons:**
- You have a recurring task not covered by existing agents
- Your team has specific conventions to enforce
- You want to integrate a custom tool or linter
- Project-specific validation needed

❌ **Bad reasons:**
- One-time task (just ask Claude directly)
- Already covered by existing agent
- Too generic (won't be useful)

---

### Creating Your First Custom Agent

#### Example: "API Naming Convention Enforcer"

**Step 1: Create the File**

```bash
# Decide tier
# tier-1-daily = use often
# tier-3-specialized = use occasionally

# Create file
touch ~/.claude/agents/tier-3-specialized/api-naming-enforcer.md
```

---

**Step 2: Write the YAML Frontmatter**

```yaml
---
name: api-naming-enforcer
description: Enforces team API naming conventions - camelCase for params, PascalCase for types, validates endpoint patterns in services/api.ts
tools: Read, Grep, Edit
model: sonnet
---
```

**Tips for good descriptions:**
- Include **specific keywords** your team uses
- Mention **file patterns** (e.g., `services/api.ts`)
- Add **tech terms** (camelCase, PascalCase)
- Be **specific** (not just "checks API")

---

**Step 3: Write the System Prompt**

```markdown
# API Naming Convention Enforcer

You enforce the team's API naming conventions for consistency.

## Team Conventions

### 1. Endpoint Naming
```typescript
// ✅ Correct
const fetchUserProfile = async (userId: string) => {
  return api.get(`/users/${userId}/profile`);
};

// ❌ Wrong
const GetUserProfile = async (user_id: string) => { // Should be camelCase
  return api.get(`/user/${user_id}/profile`); // Should be plural /users/
};
```

### 2. Request/Response Types
```typescript
// ✅ Correct - PascalCase
interface UserProfileResponse {
  userId: string;      // camelCase fields
  displayName: string;
}

interface UpdateUserRequest {
  displayName?: string;
}

// ❌ Wrong
interface user_profile_response { // Should be PascalCase
  user_id: string;               // Should be camelCase
}
```

### 3. API Method Naming
- GET: `fetch*` or `get*`
- POST: `create*`
- PUT/PATCH: `update*`
- DELETE: `delete*` or `remove*`

**Examples:**
- ✅ `fetchUsers()`, `createUser()`, `updateUser()`, `deleteUser()`
- ❌ `getUsers()`, `addUser()`, `editUser()`, `removeUser()`

### 4. Error Handling
```typescript
// ✅ Correct
try {
  const data = await fetchUserProfile(id);
} catch (error) {
  if (error instanceof ApiError) {
    // Handle API error
  }
}

// ❌ Wrong
const data = await fetchUserProfile(id); // No error handling
```

## What You Check

Scan `src/services/api/` for:
1. Function names match conventions
2. Type names are PascalCase
3. Field names are camelCase
4. Endpoints use correct HTTP methods
5. Error handling present

## Output Format

```
API Naming Convention Violations:

CRITICAL (X):
1. src/services/api/user.ts:12
   Function: GetUserProfile
   Issue: Should be fetchUserProfile (camelCase + fetch* prefix)
   Fix: Rename to fetchUserProfile

2. src/services/api/user.ts:45
   Type: user_response
   Issue: Should be UserResponse (PascalCase)
   Fix: Rename type

HIGH (X):
[...]

SUGGESTIONS (X):
[...]

Auto-fix available: Yes/No
```

## Special Cases

**Allowed exceptions:**
- Third-party API wrappers (can match their naming)
- GraphQL operations (follow GraphQL conventions)
- Legacy endpoints (marked with // LEGACY comment)
```

---

**Step 4: Test Your Agent**

```bash
# Start Claude Code
claude

# Test the agent
> @api-naming-enforcer check our API services

# Or auto-invoke
> Are our API naming conventions consistent?
```

---

**Step 5: Iterate and Improve**

Based on usage:
- Add more examples
- Clarify edge cases
- Adjust strictness
- Add auto-fix capability

---

### Agent Template Library

#### Simple Linter Agent

```yaml
---
name: my-linter
description: Checks for [specific pattern] in [file type]
tools: Grep, Read
model: haiku  # Fast for simple checks
---

# My Linter

You check for [pattern].

## What to Find
- [Pattern 1]
- [Pattern 2]

## Output
List violations with file:line and fix suggestions.
```

---

#### Complex Analyzer Agent

```yaml
---
name: my-analyzer
description: Deep analysis of [domain] with chain-of-thought reasoning
tools: Read, Grep, Glob, WebFetch
model: opus  # Needs complex reasoning
---

# My Analyzer

You perform deep analysis using chain-of-thought.

## Workflow

Use `<thinking>` and `<answer>` tags:

<thinking>
1. Analyze [aspect 1]
2. Consider [aspect 2]
3. Evaluate tradeoffs
4. Recommend approach
</thinking>

<answer>
[Actionable output]
</answer>

## [Rest of instructions]
```

---

#### Integration Agent (External Tools)

```yaml
---
name: my-integration
description: Integrates with [external tool] for [purpose]
tools: Bash, Read
model: sonnet
---

# My Integration

You run [external tool] and interpret results.

## How to Run

```bash
# Run the tool
npx [tool-name] [args]

# Parse output
# Interpret results
```

## Output
Translate tool output to actionable feedback.
```

---

## 💬 Customizing Slash Commands

### Editing Existing Commands

**Location:** `~/.claude/commands/`

**Example: Customize `/review` command**

```bash
# Open the file
notepad ~/.claude/commands/review.md
```

**Before:**
```markdown
---
name: review
description: Comprehensive code review
---

# Comprehensive Code Review

Reviewing: $ARGUMENTS

Execute these reviews in parallel:
1. @design-token-guardian
2. @a11y-enforcer
3. @security-specialist
```

**After (customized for your team):**
```markdown
---
name: review
description: MyTeam code review with custom checklist
---

# MyTeam Code Review

Reviewing: $ARGUMENTS

## Phase 1: Automated Checks (parallel)
1. @design-token-guardian - Design system compliance
2. @a11y-enforcer - Accessibility (WCAG 2.2 AA)
3. @security-specialist - Security audit
4. @test-generator - Test coverage check
5. @performance-enforcer - Performance budget

## Phase 2: Team-Specific Checks

### Code Style
- Check for console.log (should use logger)
- Verify no TODO comments without JIRA ticket
- Confirm all async functions have error handling

### Business Logic
- Validate against product requirements
- Check edge cases documented
- Verify user feedback handled

### Documentation
- TypeScript types documented
- Complex logic has comments
- README updated if needed

## Phase 3: Report

**BLOCKER** (must fix):
- [Critical issues]

**REQUIRED** (fix before merge):
- [High priority issues]

**OPTIONAL** (nice to have):
- [Suggestions]

**APPROVED IF:**
- Zero blockers
- < 3 required issues
- Test coverage > 80%
```

---

### Creating Custom Slash Commands

**Example: `/ship` - Deployment Workflow**

**Step 1: Create File**

```bash
touch ~/.claude/commands/ship.md
```

**Step 2: Write Command**

```markdown
---
name: ship
description: Full deployment workflow to production with safety checks
---

# Ship to Production

Deploying: $ARGUMENTS

## ⚠️ Pre-Flight Checks

1. **Git Status**
   ```bash
   git status
   ```
   - Ensure no uncommitted changes
   - On main branch
   - Pulled latest

2. **Environment Check**
   ```bash
   echo $NODE_ENV
   ```
   - Should be "production"

## 🧪 Phase 1: Testing

```bash
# Unit tests
npm test

# E2E tests
npm run test:e2e

# Type check
npm run type-check
```

**STOP if any tests fail!**

## 🔒 Phase 2: Security

Invoke @security-specialist for full audit:
- No secrets in code
- Dependencies up to date
- No critical vulnerabilities

**STOP if CRITICAL issues found!**

## ⚡ Phase 3: Performance

Invoke @performance-enforcer:
- Bundle size < 25MB
- No performance budget violations
- Startup time < 2s

**STOP if budgets exceeded!**

## ♿ Phase 4: Accessibility

Invoke @a11y-enforcer for full app audit:
- WCAG 2.2 AA compliance
- No missing accessibility labels
- Touch targets adequate

**STOP if accessibility failures!**

## 🏗️ Phase 5: Build

```bash
# iOS
eas build --platform ios --profile production --non-interactive

# Android
eas build --platform android --profile production --non-interactive
```

Monitor build progress...

## 📤 Phase 6: Submit

```bash
# iOS
eas submit --platform ios --latest

# Android
eas submit --platform android --latest
```

## 📊 Phase 7: Post-Deploy Monitoring

1. **Check Sentry** for crashes (first 2 hours)
2. **Monitor Analytics** for anomalies
3. **Check App Store** submission status
4. **Notify Team** via Slack

## 🎉 Success Checklist

- [ ] Tests passed
- [ ] Security audit clean
- [ ] Performance budgets met
- [ ] Accessibility compliant
- [ ] Builds successful
- [ ] Submitted to stores
- [ ] Monitoring active

---

**Build Numbers:**
- iOS: [Auto-filled from EAS]
- Android: [Auto-filled from EAS]

**Estimated Review Time:**
- iOS: 24-48 hours
- Android: 2-4 hours

**Next Steps:**
Monitor Sentry and analytics. Prepare hotfix branch if needed.
```

---

**Step 3: Use It**

```bash
claude
> /ship v2.1.0
```

---

## ⚙️ Configuring Hooks

### What Are Hooks?

Hooks run shell commands automatically at specific events:
- **PreToolUse** - Before agent uses a tool
- **PostToolUse** - After tool completes
- **UserPromptSubmit** - When you submit a prompt
- **Stop** - When agent finishes

---

### Editing Hook Configuration

**File:** `~/.claude/settings.json`

```bash
notepad ~/.claude/settings.json
```

**Example Configuration:**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "comment": "Block writes with accessibility violations",
        "matcher": "Write",
        "filter": "*.tsx",
        "hooks": [
          {
            "type": "command",
            "command": "node ~/.claude/hooks/validate-a11y.js"
          }
        ]
      },
      {
        "comment": "Prevent committing secrets",
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "node ~/.claude/hooks/check-secrets.js"
          }
        ]
      }
    ],

    "PostToolUse": [
      {
        "comment": "Check bundle size after file changes",
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "node ~/.claude/hooks/check-bundle-size.js"
          }
        ]
      }
    ],

    "UserPromptSubmit": [
      {
        "comment": "Track agent usage metrics",
        "hooks": [
          {
            "type": "command",
            "command": "node ~/.claude/hooks/track-usage.js"
          }
        ]
      }
    ]
  }
}
```

---

### Creating Hook Scripts

**Example: Accessibility Validation Hook**

**File:** `~/.claude/hooks/validate-a11y.js`

```javascript
#!/usr/bin/env node

// This hook blocks writes that violate accessibility

const fs = require('fs');

// Read hook input from stdin
const input = JSON.parse(fs.readFileSync(0, 'utf-8'));

// Only check React Native component files
if (input.tool !== 'Write' || !input.file.endsWith('.tsx')) {
  // Allow non-TSX files
  console.log(JSON.stringify({ block: false }));
  process.exit(0);
}

const content = input.content || '';
const issues = [];

// Check for TouchableOpacity without accessibilityLabel
if (content.includes('TouchableOpacity') && !content.includes('accessibilityLabel')) {
  issues.push('TouchableOpacity missing accessibilityLabel');
}

// Check for Pressable without accessibilityRole
if (content.includes('Pressable') && !content.includes('accessibilityRole')) {
  issues.push('Pressable missing accessibilityRole');
}

// Check for Image without alt/accessibilityLabel
if (content.includes('<Image') && !content.includes('accessibilityLabel')) {
  issues.push('Image missing accessibilityLabel');
}

if (issues.length > 0) {
  // Block the write
  console.error(JSON.stringify({
    block: true,
    message: `❌ Accessibility violations found:\n${issues.map(i => `  - ${i}`).join('\n')}\n\nFix these issues before writing the file.`
  }));
  process.exit(1);
}

// Allow the write
console.log(JSON.stringify({ block: false }));
process.exit(0);
```

**Make executable:**
```bash
chmod +x ~/.claude/hooks/validate-a11y.js
```

---

**Example: Bundle Size Check Hook**

**File:** `~/.claude/hooks/check-bundle-size.js`

```javascript
#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');

// Read previous bundle size
const sizeFile = '.claude-bundle-size.json';
let previousSize = 0;

if (fs.existsSync(sizeFile)) {
  previousSize = JSON.parse(fs.readFileSync(sizeFile, 'utf-8')).size;
}

// Check current bundle size (example for Metro bundler)
try {
  const output = execSync('npx react-native bundle --dev false --entry-file index.js --bundle-output /tmp/bundle.js', { encoding: 'utf-8' });
  const stats = fs.statSync('/tmp/bundle.js');
  const currentSize = stats.size;

  // Save current size
  fs.writeFileSync(sizeFile, JSON.stringify({ size: currentSize }));

  // Calculate increase
  const increase = currentSize - previousSize;
  const increasePercent = previousSize > 0 ? (increase / previousSize * 100).toFixed(1) : 0;

  if (increase > 1024 * 1024 * 2) { // 2MB increase
    console.error(JSON.stringify({
      block: true,
      message: `⚠️ Bundle size increased by ${(increase / 1024 / 1024).toFixed(2)}MB (${increasePercent}%)\nCurrent: ${(currentSize / 1024 / 1024).toFixed(2)}MB\nPrevious: ${(previousSize / 1024 / 1024).toFixed(2)}MB\n\nConsider optimizing before proceeding.`
    }));
    process.exit(1);
  }

  console.log(JSON.stringify({ block: false }));
} catch (error) {
  // Don't block on errors, just warn
  console.warn('Bundle size check failed:', error.message);
  console.log(JSON.stringify({ block: false }));
}
```

---

### Disabling Hooks Temporarily

```bash
# Set environment variable
CLAUDE_BYPASS_HOOKS=true claude

# Or edit ~/.claude/settings.json
{
  "hooks": {
    "PreToolUse": [
      {
        "hooks": [{
          "command": "...",
          "disabled": true  // Add this
        }]
      }
    ]
  }
}
```

---

## 📝 Modifying CLAUDE.md

### What is CLAUDE.md?

Project-specific context file that Claude automatically loads:
- Tech stack details
- Coding conventions
- Design system rules
- Architecture patterns
- Team preferences

---

### Location

```
your-expo-project/
├── CLAUDE.md  ← Here (project root)
├── src/
├── package.json
└── app.json
```

---

### Customization Examples

#### Adding New Conventions

```markdown
## Coding Conventions

### React Components
✅ Functional components only
✅ Hooks at the top
❌ No class components

### NEW: Error Handling Convention
All async functions must use our error wrapper:

```typescript
import { withErrorHandling } from '@/utils/errors';

// ✅ Correct
export const fetchData = withErrorHandling(async () => {
  const data = await api.get('/data');
  return data;
});

// ❌ Wrong
export const fetchData = async () => {
  try {
    return await api.get('/data');
  } catch (error) {
    console.error(error); // Use wrapper instead
  }
};
```

**Agents should enforce this pattern!**
```

---

#### Project-Specific Rules

```markdown
## MyApp-Specific Rules

### Health Data Display
All health metrics must include units:

```typescript
// ✅ Correct
<Text accessibilityLabel={`Blood pressure ${value} mmHg`}>
  {value} mmHg
</Text>

// ❌ Wrong - missing unit
<Text>{value}</Text>
```

### HIPAA Compliance
- Never log personal health information
- Encrypt all health data at rest
- Use SecureStore for authentication tokens
- Audit trail required for data changes

### FDA Requirements
- Touch targets: minimum 48x48 (not 44x44)
- Color contrast: 7:1 (AAA, not AA 4.5:1)
- All critical actions need confirmation dialog
```

---

#### Tool Integration

```markdown
## Development Tools

### Testing
```bash
npm test              # Unit tests (Jest)
npm run test:e2e      # E2E tests (Detox)
npm run test:a11y     # Accessibility tests
```

### Linting
```bash
npm run lint          # ESLint + Prettier
npm run type-check    # TypeScript
npm run analyze       # Bundle analyzer
```

### Pre-commit Checklist
Before every commit, run:
1. `npm run lint`
2. `npm test`
3. `npm run type-check`
4. `/review` on changed files

**Agents should remind developers of this!**
```

---

## 🎯 Project-Specific Customization

### Example: E-Commerce App

**Custom Agents Needed:**
1. **payment-validator** - Validates PCI-DSS compliance
2. **inventory-checker** - Ensures stock checks
3. **price-formatter** - Enforces currency formatting

**Custom Commands:**
1. **/checkout-review** - Full checkout flow audit
2. **/deploy-store** - Deploy with inventory sync

**CLAUDE.md additions:**
```markdown
## E-Commerce Specific

### Price Display
Always use our price formatter:
```typescript
import { formatPrice } from '@/utils/currency';
<Text>{formatPrice(amount, currency)}</Text>
```

### Inventory
Check stock before checkout:
```typescript
const inStock = await checkInventory(productId);
if (!inStock) throw new OutOfStockError();
```
```

---

### Example: Healthcare App

**Custom Agents:**
1. **hipaa-auditor** - HIPAA compliance
2. **medical-terminology** - Validates medical terms
3. **fda-compliance** - FDA requirements

**CLAUDE.md additions:**
```markdown
## Healthcare Regulations

### HIPAA Compliance
- PHI must be encrypted (use EncryptedStorage)
- Audit logging required for all PHI access
- Session timeout: 15 minutes
- No PHI in logs, analytics, crash reports

### Medical Accuracy
- All medical terms validated against ICD-10
- Dosage calculations double-checked
- Critical actions require confirmation
```

---

## 👥 Team Customization

### Sharing Configuration Across Team

#### Option 1: Git Repository (Recommended)

```bash
your-project/
├── .claude/
│   ├── agents/       # Team agents
│   │   └── team-specific-agent.md
│   └── commands/     # Team commands
│       └── team-review.md
├── CLAUDE.md         # Project context
└── .gitignore        # Don't ignore .claude/!
```

**Team Setup:**
```bash
# Each team member
git clone your-project
cd your-project

# Copy team agents to user directory
cp -r .claude/agents/* ~/.claude/agents/
cp -r .claude/commands/* ~/.claude/commands/
```

---

#### Option 2: Project-Level Only

```bash
# Agents load from project first, then user directory
your-project/.claude/agents/  # Project-specific
~/.claude/agents/             # Personal preferences
```

---

### Team Conventions Document

**File:** `CLAUDE.md`

```markdown
## Team Workflow

### Code Review Process
1. Developer runs `/review` before creating PR
2. All agents must pass (no blockers)
3. PR template includes agent check results
4. Reviewer verifies agent suggestions addressed

### Agent Usage Guidelines
- @grand-architect: Required for new features >3 days
- @security-specialist: Required for auth/payment changes
- @a11y-enforcer: Run on every component change
- @performance-enforcer: Check before every release

### Customized Agents
Our team has customized:
- design-token-guardian: Uses our NativeBase theme
- a11y-enforcer: Higher standards (AAA not AA)
- security-specialist: Includes HIPAA checks
```

---

## 🚀 Advanced Customization

### Chaining Agents

Create slash command that orchestrates multiple agents:

```markdown
---
name: full-audit
description: Complete app audit with all quality agents
---

# Full Quality Audit

## Phase 1: Code Quality (Parallel)
- @design-token-guardian
- @a11y-enforcer
- @security-specialist
- @performance-prophet

## Phase 2: Architecture (Sequential)
1. @debt-quantifier - Measure tech debt
2. @impact-analyzer - Assess refactoring impact
3. @grand-architect - Plan improvements

## Phase 3: Testing
- @test-generator - Ensure coverage
- @test-architect - Validate strategy

## Phase 4: Report
Consolidate all findings into:
- Executive summary
- Critical issues (must fix)
- Recommended improvements
- Estimated effort to address all issues
```

---

### Context-Aware Agents

Agents that adapt based on file path:

```markdown
# Design Token Guardian

## Context-Aware Rules

If file is in `/screens/`:
- Strict mode: No hardcoded values allowed

If file is in `/components/ui/`:
- Very strict: Must use design system exclusively

If file is in `/external/`:
- Relaxed: Hardcoded values allowed (third-party integration)

If file is in `/prototypes/`:
- Warning only: Report but don't block
```

---

### Dynamic Agent Loading

Load different agents for different environments:

```json
// ~/.claude/settings.json
{
  "agents": {
    "development": ["design-token-guardian", "a11y-enforcer"],
    "staging": ["security-specialist", "performance-enforcer"],
    "production": ["all"]
  }
}
```

---

## 📚 Best Practices

### ✅ DO

- **Version control** your customizations (git)
- **Document changes** you make to agents
- **Test after modifying** agents
- **Share with team** useful customizations
- **Keep backups** of working configurations
- **Start small** - modify one agent at a time
- **Use comments** in YAML and code

### ❌ DON'T

- Don't break YAML frontmatter syntax
- Don't change agent `name` without updating invocations
- Don't make agents too complex (split into multiple)
- Don't hardcode secrets in agent prompts
- Don't modify all agents at once
- Don't skip testing after changes

---

## 🔄 Migration Guide

### Updating to New Agent Versions

When the system updates:

```bash
# 1. Backup your customizations
cp -r ~/.claude/agents ~/.claude/agents.backup

# 2. Install new versions
cd claude-code-expo-system/scripts
.\install-agents.ps1

# 3. Merge your customizations
# Compare backup with new files
# Reapply your changes
```

---

## 🎓 Learning Path

1. **Week 1:** Edit CLAUDE.md with project details
2. **Week 2:** Modify one agent (description for better auto-invoke)
3. **Week 3:** Create your first custom slash command
4. **Week 4:** Create your first custom agent
5. **Week 5:** Set up hooks for automation
6. **Week 6:** Share with team and get feedback

---

## 📞 Need Help?

If you're stuck customizing:

1. Check examples in this guide
2. Review agent templates in `ready-to-use/agents/`
3. Read COMPLETE-GUIDE.md for detailed patterns
4. Test in isolation before deploying to team

---

**Remember:** Customization is iterative. Start simple, add complexity as needed! 🎯

**Version:** 1.2.0
**Last Updated:** 2025-10-05
**For:** Claude Code v2.0.5 + Windows + Expo/React Native

---

*© 2025 SenaiVerse | Claude Code Agent System v1.2.0 | Built for React Native Mobile Excellence*
