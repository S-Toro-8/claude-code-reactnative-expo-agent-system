# Agent Reference & Expansion Guide

> **🌟 Created by SenaiVerse**
> *Claude Code Agent System for Expo/React Native Development*

This file lists all 20 agents in the complete system. The core essential agents are included; you can create additional specialized agents as needed.

---

## ✅ Included Agents (Ready to Use)

### Tier S: Meta Orchestration
- ✅ **grand-architect** - Meta-orchestrator for complex features

### Tier 1: Daily Workflow
- ✅ **design-token-guardian** - Design system enforcement
- ✅ **a11y-enforcer** - Accessibility compliance
- ✅ **test-generator** - Smart test generation
- ✅ **performance-enforcer** - Performance budget tracking

### Tier 2: Power Agents
- ✅ **performance-prophet** - Predictive performance analysis
- ✅ **security-specialist** - Security penetration testing

---

## 📝 Additional Agents (Create as Needed)

You can create these agents following the same pattern as the included ones:

### Tier 1: Daily Workflow
- **version-shield** - Package compatibility checking
  - **What it does:** Validates package.json changes against React Native compatibility matrix
  - **Tools:** Read, Bash, WebFetch
  - **Model:** Sonnet

### Tier 2: Power Agents
- **journey-cartographer** - User flow mapping and edge case detection
  - **What it does:** Maps complete user journeys, identifies edge cases
  - **Tools:** Read, Grep, Glob
  - **Model:** Opus

- **refactor-surgeon** - Zero-breaking refactoring
  - **What it does:** Large-scale refactoring with rollback strategies
  - **Tools:** Read, Edit, Grep, Bash
  - **Model:** Opus

- **cross-platform-enforcer** - iOS/Android consistency
  - **What it does:** Ensures UX parity across platforms
  - **Tools:** Read, Bash, Grep
  - **Model:** Sonnet

### Tier 3: Specialized
- **api-guardian** - Type-safe API integration
- **memory-detective** - Memory leak detection
- **design-enforcer** - Design system validation
- **debt-quantifier** - Technical debt measurement
- **test-architect** - Test strategy planning
- **bundle-assassin** - Bundle size optimization
- **migration-strategist** - Safe version upgrades
- **state-auditor** - State management analysis
- **impact-analyzer** - Feature impact prediction

---

## 🛠️ How to Create Additional Agents

### Step 1: Choose Agent Type
Decide which agent you need based on your current pain points.

### Step 2: Create File
```bash
# Example: Creating version-shield agent
touch ~/.claude/agents/tier-1-daily/version-shield.md
```

### Step 3: Add YAML Frontmatter
```yaml
---
name: version-shield
description: Validates React Native package compatibility to prevent version conflicts
tools: Read, Bash, WebFetch
model: sonnet
---
```

### Step 4: Write System Prompt

Reference the COMPLETE-GUIDE.md for detailed descriptions of each agent's:
- Purpose
- Capabilities
- Output format
- Examples

Or use the enhanced prompt system from newprompt.md to generate the system prompt.

### Step 5: Test
```bash
claude
> @version-shield check my package.json
```

---

## 💡 Quick Templates

### Simple Agent Template
```yaml
---
name: my-agent
description: Brief description of when to invoke this agent
tools: Read, Grep
model: sonnet
---

# My Agent

You are an expert in [domain].

## Your Mission
[What you do]

## What You Check
[Specific checks]

## Output Format
[How you report findings]
```

### Complex Agent Template (with thinking)
```yaml
---
name: my-complex-agent
description: Complex analysis requiring deep reasoning
tools: Read, Grep, Glob, WebFetch
model: opus
---

# My Complex Agent

You perform [complex task] using chain-of-thought reasoning.

## Workflow

Use `<thinking>` and `<answer>` tags:

<thinking>
1. Analysis
2. Evidence gathering
3. Alternatives
4. Recommendation
</thinking>

<answer>
[Actionable output]
</answer>

## [Rest of agent definition]
```

---

## 🎯 Priority for Creation

If you're deciding which agents to create next, prioritize based on your needs:

**High Priority (Common Pain Points):**
1. version-shield - Prevents upgrade nightmares
2. bundle-assassin - Critical for app size
3. state-auditor - Common re-render issues

**Medium Priority (Quality Improvements):**
4. memory-detective - Important for long-lived apps
5. cross-platform-enforcer - If you target both iOS/Android
6. impact-analyzer - For architectural decisions

**Low Priority (Nice to Have):**
7. debt-quantifier - Long-term health tracking
8. test-architect - If test strategy unclear
9. migration-strategist - During upgrades

---

## 📚 Resources for Agent Creation

1. **COMPLETE-GUIDE.md** - Full agent descriptions
2. **newprompt.md** - Prompt enhancement system
3. **Official Anthropic Docs** - https://docs.claude.com/en/docs/claude-code/sub-agents
4. **Community Agents** - https://github.com/hesreallyhim/awesome-claude-code-agents

---

## 🔄 Sharing Custom Agents

If you create great agents, consider:
1. Adding to your team's repo (`.claude/agents/`)
2. Documenting in team's CLAUDE.md
3. Sharing with community

---

**The included 7 core agents cover 80% of daily needs. Create additional agents as specific needs arise.**

**Happy agent building! 🤖**

---

*© 2025 SenaiVerse | Claude Code Agent System v1.0 | Built for Expo/React Native Excellence*
