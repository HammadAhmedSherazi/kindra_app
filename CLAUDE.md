# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter run              # Run the app
flutter build apk        # Build Android APK
flutter build ios        # Build iOS
flutter test             # Run all tests
flutter test test/path/to/test.dart  # Run a single test
flutter analyze          # Static analysis
```

## Architecture

**State management**: Flutter Riverpod 2.x with `NotifierProvider` (auth) and `StateNotifierProvider` (navigation). `ProviderScope` wraps the entire app in `main.dart`.

**Navigation**: Imperative routing via `AppRouter` utility class (`lib/utils/router.dart`). No named routes — all navigation uses direct widget instances. Key methods: `push`, `pushReplacement`, `pushAndRemoveUntil`, `pushWithAnimation`, `back`, `backToHome`.

**User roles**: The app has 5 distinct user types — Householder, Communities, Businesses, Coastal Groups, and Driver — each routing to a separate dashboard after login.

**Folder layout under `lib/`**:
- `data/network/` — HTTP client, API endpoints, response/exception models
- `models/` — Data models
- `providers/` — Riverpod providers and notifiers
- `services/` — Business logic (API base class, SharedPreferences wrapper, SecureStorage)
- `utils/` — Router, theme, colors, localization, asset paths, constants, enums, extensions
- `views/` — Feature screens organized by role/domain (auth, home, driver_dashboard, community_dashboard, business_dashboard, coastal_group, reward, redeem, scan_waste, trainer, profile, notification, onboarding)
- `widget/` — Reusable UI components
- `export_all.dart` — Central barrel file; import this instead of individual files

**API layer**: `BaseApiServices` abstract class → `HttpClient` implementation. Base URL is a placeholder in `lib/services/base_api_services.dart`. Endpoints live in `lib/data/network/api_endpoints.dart`. All responses wrapped in `ApiResponse<T>`.

**Storage**: `SharedPreferenceManager` (language, onboarding state) and `SecureStorage` (auth tokens, user data) are singleton services initialized before `runApp`.

**Localization**: English + Spanish via custom `LocalizationService` reading JSON from `assets/l10n/`. Locale switching via `localeProvider` (Riverpod).

**Theming**: Material 3, Roboto Flex font, custom `AppColors`, text scaling locked to 1.0 in `main.dart`.
