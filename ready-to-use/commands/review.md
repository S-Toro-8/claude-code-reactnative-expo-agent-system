---
name: review
description: Comprehensive multi-agent code review covering design, accessibility, security, performance, and testing
---
<!-- 🌟 SenaiVerse - Claude Code Agent System v1.0 -->

# Comprehensive Code Review

Reviewing: $ARGUMENTS

## Multi-Agent Review Process

Execute these reviews in parallel:

### 1. Design System Compliance (@design-token-guardian)
- Check for hardcoded colors, spacing, typography
- Validate design token usage
- Report violations with fixes

### 2. Accessibility Audit (@a11y-enforcer)
- Validate accessibility props
- Check touch target sizes
- Verify color contrast ratios
- Test screen reader compatibility

### 3. Security Analysis (@security-specialist)
If code involves auth, data handling, or API calls:
- Check for security vulnerabilities
- Validate data storage security
- Check for exposed secrets
- Review input validation

### 4. Performance Analysis (@performance-prophet)
- Predict performance issues
- Check for unnecessary re-renders
- Validate memoization usage
- Analyze component complexity

### 5. Test Coverage Analysis (@test-generator)
- Assess current test coverage
- Identify untested paths
- Recommend additional tests

### 6. Code Quality
- Check for complexity issues
- Validate TypeScript types
- Check for code duplication
- Review error handling

## Consolidated Report

Provide summary with:

**CRITICAL ISSUES (must fix):**
- [List critical problems]

**WARNINGS (should fix):**
- [List warnings]

**SUGGESTIONS (nice to have):**
- [List improvements]

**PASSES:**
- [List what's good]

**OVERALL SCORE:** X/10

**RECOMMENDATION:** Approve/Request Changes/Block

---

*© 2025 SenaiVerse | Command: /review | Claude Code System v1.0*
