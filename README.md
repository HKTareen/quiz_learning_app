# Quiz Learning App

## Note: **Architecture and Logics are totally written by hand below features are written via AI Help**
Profile Section, 
Randing Page UI tile
 some repeative tasks like Models and readme files 

Rest of the Work is Totally developed by me.
Thanks

## Project Structure

This project follows **Clean Architecture with Feature-Driven Development** pattern:

```
lib/src/
├── core/
│   ├── features/
│   │   ├── auth/          # Authentication feature
│   │   ├── user/          # User management feature
│   │   ├── quiz/          # Quiz feature
│   │   └── ranking/       # Ranking feature
│   └── local_data/        # Local storage (SharedPreferences)
├── presentation/
│   ├── auth/              # Login screen
│   ├── main/              # Main tab bar
│   ├── profile/           # Profile tab
│   ├── home/              # Home tab with categories
│   ├── quiz/              # Quiz screen
│   └── ranking/           # Ranking tab
├── base/                  # Base components (theme, l10n, modals)
├── router/                # Navigation (GoRouter)
├── widget/                # Reusable widgets
├── extensions/            # Dart extensions
├── mixins/                # Reusable mixins
└── utils/                 # Utility functions
```

## Features Implemented

### 1. Login Screen
- Responsive design for web and mobile
- Email and password validation
- Error handling with specific error messages
- Session persistence using SharedPreferences

**Credentials:**
- Email: `test@gmail.com`
- Password: `Test@123`

### 2. Main Tab Bar
Three tabs implemented:
- **Profile (Tab 0)**: User profile display and logout
- **Home (Tab 1)**: Quiz categories list
- **Ranking (Tab 2)**: Leaderboard

### 3. Profile Tab
- Displays user image, name, email, rank, and score
- Logout button that clears session and navigates to login

### 4. Home Tab
- Header with user image, name, rank, and score
- List of 10 quiz categories with progress indicators
- Tap on category to start quiz

### 5. Quiz Flow
- 3-second countdown animation (3..2..1) before quiz starts
- Fetches 10 questions from Open Trivia DB API
- Each question has 1-minute timer
- Progress indicator showing current question (e.g., 3/10 -> 30%)
- Immediate feedback on answer selection
- Visual feedback: green border for correct, red for incorrect
- "Correct" or "Incorrect" label on selected answer
- 1-second delay between questions
- Results screen after quiz completion
- Updates user score and category progress

### 6. Ranking Tab
- Displays top 10 users from mock API
- Highlights currently logged-in user
- Shows user image, name, rank, and score

## How to Run

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.11.0)

### Setup
1. Install dependencies:
```bash
flutter pub get
```

2. Generate code (freezed, riverpod):
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run on Web
```bash
flutter run -d chrome
```

### Run on Mobile
```bash
flutter run
```

## Architecture Details

### State Management
- **Riverpod** for state management with code generation
- Providers in `domain/provider/` for each feature

### Data Flow
```
Presentation → Provider → Service → API → DTO → Model
```

### Dependency Injection
- Custom `Binding` pattern for initialization
- Riverpod providers for dependency injection

### Code Generation
- `freezed` for immutable models/DTOs
- `riverpod_annotation` for providers
- Generated files (`.g.dart`, `.freezed.dart`) should be created after running build_runner

## API Integration

### Open Trivia DB
- Base URL: `https://opentdb.com/api.php`
- Example: `https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple`
- Categories used:
  - 9: General Knowledge
  - 19: Math
  - 10: English
  - 17: Science & Nature
  - 18: Computers
  - 21: Sports
  - 22: Geography
  - 23: History
  - 25: Art
  - 27: Animals

### Ranking API
- Mock API with 10 dummy users
- Simulates network delay

## Design Decisions

1. **Simple UI**: Following the login page design pattern - clean and minimal
2. **Responsive**: Adapts to mobile, tablet, and web screen sizes
3. **Error Handling**: Graceful error handling with user-friendly messages
4. **Loading States**: Loading indicators during API calls
5. **Session Management**: In-memory session for app lifecycle, persisted in SharedPreferences

## Notes

- Tab bar is automatically hidden when navigating to quiz screen (separate route)
- User score updates after each correct answer
- Category progress updates after quiz completion
- HTML entities in quiz questions are automatically decoded

## Testing

To run tests:
```bash
flutter test
```

## Dependencies

Key dependencies:
- `flutter_riverpod`: State management
- `go_router`: Navigation
- `dio`: HTTP client
- `freezed`: Immutable models
- `shared_preferences`: Local storage

See `pubspec.yaml` for complete list.
