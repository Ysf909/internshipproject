# Praktix – Mobile App (Flutter)

> Professional skills & mentorship platform. Built with Flutter, Clean Architecture, and strict MVVM.

---

## 📐 Architecture: Clean Architecture + MVVM

```
lib/
├── core/
│   ├── constants/        # AppColors, AppTextStyles
│   ├── theme/            # AppTheme (light + dark ThemeData)
│   └── utils/            # AppRouter (go_router), Validators
│
├── data/                          ← MODEL layer
│   ├── models/           # Program, Expert (immutable value objects)
│   ├── mock/             # MockData (6 programs, 6 experts)
│   └── repositories/     # ProgramRepository, ExpertRepository
│                                    (abstracts data source from UI)
│
└── presentation/                  ← VIEW + VIEWMODEL layers
    ├── viewmodels/        ← VIEWMODEL — one per screen
    │   ├── home_view_model.dart
    │   ├── programs_view_model.dart
    │   ├── program_detail_view_model.dart
    │   ├── expert_profile_view_model.dart
    │   └── apply_view_model.dart
    │
    ├── providers/
    │   └── theme_provider.dart    # Dark/light toggle (SharedPreferences)
    │
    ├── screens/                   ← VIEW — screens consume ViewModel only
    │   ├── home/
    │   ├── programs/
    │   ├── experts/
    │   └── apply/
    │
    └── widgets/                   ← VIEW — reusable, stateless components
        ├── program_card.dart
        ├── expert_card.dart
        ├── custom_button.dart
        ├── custom_text_field.dart
        └── section_header.dart
```

---

## 🧩 MVVM Breakdown

| Layer | Class | Responsibility |
|---|---|---|
| **Model** | `Program`, `Expert` | Pure data — no Flutter deps |
| **Model** | `ProgramRepository`, `ExpertRepository` | Data fetching / transformation |
| **ViewModel** | `HomeViewModel` | Loads featured programs + experts, exposes `HomeState`, handles `refresh()` |
| **ViewModel** | `ProgramsViewModel` | Owns search query, category filter, filtered list — `onSearchChanged()`, `onCategorySelected()`, `resetFilters()` |
| **ViewModel** | `ProgramDetailViewModel` | Loads program + linked expert by ID |
| **ViewModel** | `ExpertProfileViewModel` | Loads expert + their programs by ID |
| **ViewModel** | `ApplyViewModel` | Form submission state machine: idle → loading → success/error, persists to SharedPreferences |
| **View** | `HomeScreen`, `ProgramsScreen`, etc. | Calls `ref.watch(viewModelProvider)` only — zero business logic |

> Each screen calls `ref.watch(itsOwnViewModel)` and `ref.read(itsOwnViewModel.notifier)`. 
> Screens never touch repositories directly.

---

## ✨ Features

- 🌙 Dark / Light mode — persisted across sessions
- 🔍 Reactive search + category filter (all logic in ViewModel)
- 🎞 Staggered animations with flutter_animate
- 📦 Application data stored locally via SharedPreferences
- ♻️ Fully reusable widget library
- 🔄 Pull-to-refresh on Home screen

---

## 🚀 How to Run

```bash
# 1. Extract the zip and navigate into the project
cd internshipproject

# 2. Install dependencies
flutter pub get

# 3. Run on device or emulator
flutter run

# 4. Build release APK (optional)
flutter build apk --release
```

**Requirements:** Flutter SDK ≥ 3.2.0, Dart ≥ 3.2.0

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `flutter_riverpod` | State management (StateNotifier per ViewModel) |
| `go_router` | Navigation — shell + full-screen routes |
| `google_fonts` | Poppins (headings) + Inter (body) |
| `flutter_animate` | Declarative stagger animations |
| `shared_preferences` | Theme persistence + application storage |

---

## 🎨 Design System

- **Primary**: Indigo `#4F46E5` · **Secondary**: Emerald `#10B981`
- **Fonts**: Poppins (display/headings) + Inter (body/labels)
- **Corners**: 12–24px · **Shadows**: subtle, elevation-free cards
- Fully adaptive to dark and light mode

