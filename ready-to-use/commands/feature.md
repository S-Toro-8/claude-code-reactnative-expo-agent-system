---
name: feature
description: Implements new features using multi-agent orchestration workflow
---
<!-- 🌟 SenaiVerse - Claude Code Agent System v1.0 -->

# Feature Implementation Workflow

Implements: $ARGUMENTS

## Execution Plan

Execute the following multi-agent workflow:

### Phase 1: Planning & Analysis

1. **Grand Architect Analysis**
   - Invoke @grand-architect to break down the feature
   - Analyze architectural impact
   - Identify affected files and components
   - Assess complexity and risks

2. **Feature Impact Assessment**
   - Estimate implementation time
   - Identify dependencies
   - Determine if breaking changes are involved

### Phase 2: Security & Architecture Review

1. **Security Audit** (if feature involves):
   - User data, authentication, payments, or sensitive operations
   - Invoke @security-specialist for OWASP Mobile Top 10 check

2. **State Management Planning**
   - Determine state architecture needed
   - Plan Redux/Context integration
   - Design data flow

### Phase 3: Implementation

1. **Create Feature Structure**
   - Generate necessary files (components, hooks, services)
   - Follow project conventions from CLAUDE.md

2. **Write Core Logic**
   - Implement business logic
   - Add proper TypeScript types
   - Follow design system tokens

3. **Cross-Platform Validation**
   - Ensure iOS and Android compatibility
   - Handle platform-specific cases if needed

### Phase 4: Quality Assurance

1. **Generate Tests** (@test-generator)
   - Unit tests for business logic
   - Component tests for UI
   - E2E tests if critical flow

2. **Accessibility Check** (@a11y-enforcer)
   - Validate all interactive elements
   - Check color contrast
   - Verify touch targets

3. **Performance Check** (@performance-prophet)
   - Predict performance impact
   - Check for potential bottlenecks
   - Validate bundle size increase

### Phase 5: Final Review

1. **Code Review** (/@review)
   - Run comprehensive review
   - Fix any issues found

2. **Documentation**
   - Add inline comments for complex logic
   - Update CLAUDE.md if needed

## Success Criteria

✅ Feature implemented and working
✅ Tests generated and passing
✅ Accessibility compliant
✅ No security vulnerabilities
✅ Performance budget maintained
✅ Cross-platform validated

## Report

Provide summary:
- Files created/modified
- Tests added
- Any considerations for deployment
- Follow-up tasks if any

---

*© 2025 SenaiVerse | Command: /feature | Claude Code System v1.0*
