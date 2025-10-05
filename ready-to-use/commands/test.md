---
name: test
description: Generates comprehensive test suite with ROI-based prioritization
---
<!-- 🌟 SenaiVerse - Claude Code Agent System v1.0 -->

# Generate Test Suite

Generating tests for: $ARGUMENTS

## Test Generation Workflow

### Step 1: Analyze Target

1. Read the file/component
2. Assess complexity (lines, cyclomatic complexity, dependencies)
3. Determine business criticality
4. Calculate test priority: Complexity × Criticality

### Step 2: Determine Test Strategy (@test-architect)

**CRITICAL Priority:**
- E2E tests (full user journey)
- Integration tests (API, state)
- Unit tests (logic)
- Edge case coverage

**HIGH Priority:**
- Integration tests
- Unit tests
- Basic edge cases

**MEDIUM Priority:**
- Unit tests
- Snapshot tests

**LOW Priority:**
- Snapshot tests only (or skip)

### Step 3: Generate Tests (@test-generator)

Create test files with:
- Proper setup/teardown
- Mocking (API, navigation, etc.)
- Async handling
- Edge cases
- Accessibility checks
- Clear test descriptions

### Step 4: Run Tests

```bash
npm test -- [test-file]
```

Report:
- ✅ Tests passing
- ❌ Tests failing (with fixes)
- Coverage percentage

### Step 5: Validation

Ensure:
- Tests are meaningful (not just coverage boosting)
- Edge cases covered
- Error paths tested
- Async operations handled correctly

## Output

**Tests Generated:** X
**Coverage:** Before X% → After Y%
**Test Types:**
- Unit: X tests
- Integration: X tests
- E2E: X tests

**Files Created:**
- [List test files]

**To Run:**
```bash
npm test
```

---

*© 2025 SenaiVerse | Command: /test | Claude Code System v1.0*
