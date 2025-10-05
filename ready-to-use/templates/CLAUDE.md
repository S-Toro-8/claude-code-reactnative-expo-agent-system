# Project Context for Claude Code

**This file provides project-specific context for Claude Code and its agents.**

---

## Agent System

**Scope:** Project-scoped agents (in `.claude/agents/`)

**Available Agents:** 7 production-ready agents for Expo/React Native
- **Grand Architect** - Meta-orchestrator for complex features
- **Design Token Guardian** - Enforces design system consistency
- **A11y Enforcer** - WCAG 2.2 compliance validation
- **Test Generator** - Auto-generates tests with ROI prioritization
- **Performance Enforcer** - Tracks performance budgets
- **Performance Prophet** - Predictive performance analysis
- **Security Specialist** - Security audits & penetration testing

**Updating Agents:**
```bash
# From this project root
/path/to/claude-code-expo-system/scripts/install-agents.ps1 -Scope project
```

**Team Sync:** Agents are version controlled in `.claude/` - team members get them automatically via git.

---

## Project Overview

**Project Name:** [Your App Name]
**Description:** [Brief description]
**Target Platforms:** iOS, Android (React Native/Expo)

---

## Tech Stack

### Core
- **Expo SDK:** [Version - e.g., 53.0.0]
- **React Native:** [Version - e.g., 0.76.0]
- **TypeScript:** [Version - e.g., 5.3.3]
- **Node:** [Version - e.g., 20.x]

### State Management
- [Redux Toolkit / Zustand / Context API / Jotai]

### Navigation
- [Expo Router / React Navigation]

### Styling
- [Styled Components / NativeWind / StyleSheet / Tamagui]

### Key Libraries
- [List important dependencies: react-query, react-hook-form, etc.]

---

## Architecture

### Folder Structure
```
src/
├── screens/          # Screen components
├── components/       # Reusable components
│   ├── ui/          # Design system components
│   └── features/    # Feature-specific components
├── navigation/       # Navigation configuration
├── services/         # API, storage, external services
├── hooks/           # Custom React hooks
├── utils/           # Utility functions
├── state/           # Redux/Zustand store
├── theme/           # Design tokens
└── types/           # TypeScript types
```

### Design Pattern
- [Feature-based / Atomic Design / Domain-driven / etc.]

---

## Coding Conventions

### React Components
```typescript
// ✅ Functional components only
export default function ComponentName() {}

// ✅ Hooks at the top
const [state, setState] = useState();
const navigation = useNavigation();

// ❌ No class components
```

### TypeScript
```typescript
// ✅ Explicit types for props
interface Props {
  userId: string;
  onPress: () => void;
}

// ✅ No 'any' type (use 'unknown' if needed)
```

### Naming Conventions
- **Components:** PascalCase (`UserProfile.tsx`)
- **Hooks:** camelCase with 'use' prefix (`useAuth.ts`)
- **Utilities:** camelCase (`formatDate.ts`)
- **Constants:** UPPER_SNAKE_CASE (`API_BASE_URL`)

---

## Design System

### Theme Location
**Primary theme file:** `src/theme/index.ts`

### Token Usage
```typescript
// ✅ Always use theme tokens
import { theme } from '@/theme';

<View style={{
  backgroundColor: theme.colors.background,
  padding: theme.spacing.md,
  borderRadius: theme.borderRadius.md
}} />

// ❌ Never hardcode values
<View style={{ backgroundColor: '#FFF', padding: 16 }} />
```

### Color Tokens
- **Primary:** `theme.colors.primary`
- **Background:** `theme.colors.background`
- **Text:** `theme.colors.text.primary`, `theme.colors.text.secondary`
- **Error:** `theme.colors.error`
- **Success:** `theme.colors.success`

### Spacing Scale
- **xs:** 4px
- **sm:** 8px
- **md:** 16px
- **lg:** 24px
- **xl:** 32px
- **2xl:** 48px

---

## Testing Requirements

### Coverage Targets
- **Critical paths** (auth, payments): 90%+
- **Core features:** 80%+
- **UI components:** 60%+

### Test Location
- Unit tests: `ComponentName.test.tsx` (same folder as component)
- E2E tests: `e2e/` folder

### Running Tests
```bash
npm test                  # Unit & integration tests
npm run test:e2e         # Detox E2E tests
npm run test:coverage    # Coverage report
```

---

## Code Quality Standards

### Before Committing
1. ✅ Run linter: `npm run lint`
2. ✅ Run tests: `npm test`
3. ✅ Check types: `npm run type-check`
4. ✅ Run `/review` command for changed files

### Pre-commit Hooks
- ESLint auto-fix
- Prettier formatting
- Type checking

---

## API Integration

### Base URL
- **Development:** [URL]
- **Staging:** [URL]
- **Production:** [URL]

### Authentication
- **Method:** [JWT / OAuth / etc.]
- **Storage:** [Expo SecureStore / EncryptedStorage]
- **Token refresh:** [Describe strategy]

### API Client
**Location:** `src/services/api.ts`

```typescript
// Example usage
import { apiClient } from '@/services/api';
const data = await apiClient.get('/users/me');
```

---

## Platform-Specific Notes

### iOS
- Minimum version: iOS 13+
- Uses [specific libraries or features]

### Android
- Minimum SDK: 23 (Android 6.0)
- Uses [specific libraries or features]

---

## Environment Variables

**Location:** `.env`, `.env.local`

**Required:**
- `EXPO_PUBLIC_API_URL`
- `EXPO_PUBLIC_API_KEY`
- [Add your env vars]

**Never commit:** Secrets, API keys, tokens

---

## Deployment

### Build Process
```bash
# Development build
eas build --profile development --platform all

# Production build
eas build --profile production --platform all
```

### App Store Info
- **iOS Bundle ID:** [com.company.app]
- **Android Package:** [com.company.app]

---

## Common Patterns

### Navigation
```typescript
// ✅ Type-safe navigation
import { useNavigation } from '@/navigation';
const navigation = useNavigation();
navigation.navigate('Profile', { userId: '123' });
```

### State Management
```typescript
// ✅ [Your state pattern - Redux/Zustand/Context]
// [Add example]
```

### Error Handling
```typescript
// ✅ Use try-catch with proper error types
try {
  await api.call();
} catch (error) {
  if (error instanceof ApiError) {
    // Handle API error
  }
}
```

---

## Anti-Patterns to Avoid

❌ **No inline styles in components** → Use StyleSheet or design tokens
❌ **No direct AsyncStorage for sensitive data** → Use SecureStore
❌ **No console.log in production** → Use proper logging service
❌ **No hardcoded strings** → Use i18n
❌ **No missing accessibility props** → Always add accessibilityLabel
❌ **No prop drilling >3 levels** → Use Context or state management

---

## Performance Guidelines

- ✅ Use `React.memo` for list items
- ✅ Use `useCallback` for callbacks passed to children
- ✅ Use `useMemo` for expensive calculations
- ✅ Lazy load heavy screens
- ✅ Optimize images (WebP, proper sizes)
- ✅ Use `getItemLayout` for FlatLists
- ❌ Don't import entire lodash library

---

## Security Guidelines

- ✅ Encrypt sensitive data at rest
- ✅ Use HTTPS for all API calls
- ✅ Validate user input
- ✅ Use SecureStore for tokens
- ❌ Never log sensitive data
- ❌ Never commit secrets to git

---

## Accessibility Requirements

- ✅ All `TouchableOpacity` must have `accessibilityLabel` and `accessibilityRole`
- ✅ Minimum touch target: 44x44 points
- ✅ Color contrast ratio: 4.5:1 (WCAG AA)
- ✅ Support screen readers
- ✅ Keyboard navigation (where applicable)

---

## Known Issues / Workarounds

[Document any platform-specific issues, library quirks, or temporary workarounds]

---

## Team Conventions

[Add any team-specific conventions, code review checklist, or workflow requirements]

---

**Last Updated:** [Date]
**Maintained By:** [Team/Person]

---

*© 2025 SenaiVerse | Claude Code Agent System v1.0 | Project Context Template*
