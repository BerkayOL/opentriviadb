# Quizora — Open Trivia DB Quiz App

Quizora is a Flutter quiz application powered by the Open Trivia DB API.

The app allows users to configure a quiz, answer timed questions, receive instant feedback, track their score, view quiz history, and switch between light, dark, and system themes.

This project was developed as an internship graduation project with a focus on clean architecture, Cubit-based state management, API integration, local persistence, error handling, reusable UI components, and a polished mobile-first interface.

---

## Features

- Dynamic category loading from Open Trivia DB
- Quiz setup with category, difficulty, question count, and question type
- Multiple choice and true/false question support
- Timed quiz flow with a countdown timer for each question
- Timeout handling that marks unanswered questions as wrong
- Randomized answer options
- Correct/wrong answer feedback
- A/B/C/D answer option badges
- Animated question transitions
- Progress header and progress bar
- Final result screen with score-based feedback
- Local quiz history with date and score
- Highest score calculation from local history
- Persistent theme preference
- Light, dark, and system theme support
- Loading, error, retry, and empty states
- HTML entity decoding for API question/answer text
- Centralized strings, assets, API keys, route paths, storage keys, dimensions, and theme tokens

---

## Tech Stack

- `flutter_bloc` — Cubit-based state management
- `dio` — API communication
- `go_router` — declarative routing and ShellRoute navigation
- `hive_ce` / `hive_ce_flutter` — local persistence
- `get_it` — dependency injection
- `equatable` — value-based state and entity comparison
- `intl` — date formatting for quiz history

---

## API

The app uses the free Open Trivia DB API.

Base website:

```txt
https://opentdb.com
```

Category endpoint:

```txt
https://opentdb.com/api_category.php
```

Question endpoint:

```txt
https://opentdb.com/api.php
```

Example question request:

```txt
https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple
```

Supported query parameters:

- `amount` — number of questions
- `category` — selected category id
- `difficulty` — easy, medium, hard
- `type` — multiple or boolean

Open Trivia DB returns some text as HTML entities. The app uses a centralized decoder to clean values such as `&quot;`, `&#039;`, `&amp;`, and `&shy;` before rendering them in the UI.

API endpoints, query keys, response codes, and JSON field keys are centralized under the quiz data constants layer instead of being hard-coded inside models or widgets.

---

## Architecture

The project uses a feature-first layered architecture.

```txt
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── bootstrap/
│   │   └── app_bootstrap.dart
│   ├── dependency_injection/
│   │   ├── app_di.dart
│   │   ├── history_di.dart
│   │   ├── quiz_di.dart
│   │   └── settings_di.dart
│   └── router/
│       ├── app_router.dart
│       └── app_routes.dart
├── core/
│   ├── constants/
│   │   ├── app_assets.dart
│   │   ├── app_date_formats.dart
│   │   ├── app_strings.dart
│   │   └── network_constants.dart
│   ├── error/
│   │   ├── app_exception.dart
│   │   └── failure.dart
│   ├── network/
│   │   └── dio_client.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_feedback_dimensions.dart
│   │   ├── app_motion.dart
│   │   ├── app_radius.dart
│   │   ├── app_spacing.dart
│   │   ├── app_theme.dart
│   │   └── app_typography.dart
│   ├── utils/
│   │   └── html_text_decoder.dart
│   └── widgets/
│       ├── app_button.dart
│       ├── app_card.dart
│       ├── empty_view.dart
│       ├── error_view.dart
│       └── loading_view.dart
├── features/
│   ├── app_shell/
│   │   └── presentation/
│   │       ├── constants/
│   │       │   └── app_shell_dimensions.dart
│   │       ├── cubits/
│   │       │   └── nav_item_press_cubit.dart
│   │       ├── pages/
│   │       │   └── app_shell_page.dart
│   │       ├── theme/
│   │       │   └── app_shell_palette.dart
│   │       └── widgets/
│   │           ├── floating_nav_bar.dart
│   │           ├── floating_nav_icon_bubble.dart
│   │           ├── floating_nav_indicator.dart
│   │           ├── floating_nav_item.dart
│   │           └── floating_nav_item_body.dart
│   ├── history/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── quiz/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── settings/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── splash/
│       └── presentation/
└── test/
    ├── widget_test.dart
    └── features/
        └── quiz/
            ├── data/
            ├── domain/
            └── presentation/
```

### Layer Responsibilities

#### `app`

Contains application-level setup:

- app bootstrap
- dependency injection setup
- route definitions
- app-level composition

#### `core`

Contains app-wide reusable infrastructure:

- generic network client
- shared error/failure types
- theme tokens
- spacing, radius, motion, typography constants
- shared UI widgets
- app strings and assets
- HTML text decoder

The `core` layer does not contain Open Trivia DB-specific API details.

#### `features`

Each feature owns its own data, domain, and presentation responsibilities.

Main features:

- `quiz` — quiz setup, question flow, scoring, timer, result
- `history` — local quiz history and highest score
- `settings` — theme mode persistence
- `app_shell` — shared shell layout and floating navigation
- `splash` — app launch screen

---

## Clean Architecture Flow

The main data flow follows this direction:

```txt
UI Widget
  ↓
Cubit
  ↓
UseCase
  ↓
Repository Contract
  ↓
Repository Implementation
  ↓
DataSource
  ↓
Dio / Hive CE
```

Widgets do not call the API, Hive, repositories, or data sources directly.

For example, the quiz question flow works like this:

```txt
QuizPage / QuizQuestionView
  ↓
QuizCubit
  ↓
GetQuestionsUseCase
  ↓
QuizRepository
  ↓
QuizRepositoryImpl
  ↓
QuizRemoteDataSource
  ↓
Dio
  ↓
Open Trivia DB API
```

---

## Dependency Injection

Dependency registration is managed under:

```txt
lib/app/dependency_injection/
```

The dependency injection structure is split by feature:

```txt
app_di.dart       -> main composition root
quiz_di.dart      -> quiz dependencies
history_di.dart   -> history dependencies
settings_di.dart  -> settings dependencies
```

`app_di.dart` acts as the composition root and calls the feature-level DI modules.

Shared or mostly stateless dependencies such as repositories and use cases are registered as lazy singletons. State-holding Cubits are registered as factories so each route or screen can receive a fresh state instance when needed.

Example dependency chain:

```txt
Dio
  ↓
QuizRemoteDataSource
  ↓
QuizRepository
  ↓
GetQuestionsUseCase
  ↓
QuizCubit
```

This keeps object creation outside widgets and preserves the separation between UI, business flow, and data access.

---

## Routing

The app uses `go_router` for centralized route management.

Routes are defined under:

```txt
lib/app/router/
```

The main route structure includes:

- Splash route
- App shell route
- Quiz setup route
- History route
- Settings route
- Quiz route

`ShellRoute` is used to keep setup, history, and settings screens inside a shared `AppShellPage`. This allows the floating navigation shell to remain consistent while only the child page changes.

The quiz screen is placed outside the shell route because it is a focused quiz-taking flow. This prevents accidental navigation away from the active quiz flow through the shell navigation.

Quiz setup data is passed to the quiz screen as a `QuizRequest` through route extra data. The router checks the type before starting the quiz to avoid invalid route state.

---

## State Management

The project uses `flutter_bloc` with Cubit.

Cubit was chosen because the app state is clear and action-based:

- loading categories
- configuring quiz settings
- starting a quiz
- selecting an answer
- moving to the next question
- handling timer timeout
- loading quiz history
- clearing quiz history
- changing theme mode

For this project scope, Cubit keeps the state layer readable and avoids unnecessary event boilerplate.

---

## Local Persistence

The app uses Hive CE for local storage.

Stored local data includes:

- quiz history
- completed quiz scores
- theme preference

Quiz history is persisted locally, and the highest score is calculated from saved quiz history entries.

Theme preference is also persisted, so the selected theme mode remains available after the app is closed and reopened.

---

## Error and Empty States

The app handles:

- loading states while fetching data
- network or API failures
- empty question results
- invalid quiz request route state
- local storage read/write failures where applicable

When an error occurs, the user is shown a message and retry option instead of a blank screen.

History save failure after quiz completion is treated as a non-critical operation so the result screen is not blocked. In a larger production project, this could be extended with logging or a non-blocking snackbar.

---

## UI / UX

The interface was designed with a modern mobile-first approach.

UI details include:

- consistent spacing and reusable UI components
- centralized colors, typography, spacing, radius, motion, and dimensions
- dark and light theme support
- gradient backgrounds
- card-based question and result screens
- custom answer option cards
- true/false decision switch
- A/B/C/D option badges
- visual correct/wrong feedback
- progress bar and timer badge
- animated question transitions
- adaptive result feedback based on the final score
- reusable loading, error, and empty views

Presentation-specific visual values are kept in feature-level constants and palette files. App-wide design tokens are kept under `core/theme`.

---

## Testing

The project includes automated tests for key logic.

Current test structure:

```txt
test/
├── widget_test.dart
└── features/
    └── quiz/
        ├── data/
        │   └── models/
        │       └── quiz_question_model_test.dart
        ├── domain/
        │   └── usecases/
        │       └── get_questions_usecase_test.dart
        └── presentation/
            └── cubits/
                └── quiz_cubit_test.dart
```

Covered areas include:

- deterministic `QuizQuestionModel.fromJson` parsing
- answer shuffle behavior in `GetQuestionsUseCase`
- injected random behavior for testability
- QuizCubit answer, next question, completion, and retry flow
- widget smoke test

Run tests:

```bash
flutter test
```

---

## Run the Project

Make sure Flutter is installed and configured.

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

---

## Quality Checks

Before submission, the following checks should pass:

```bash
flutter analyze
flutter test
```

Recommended manual checks:

- start a quiz with multiple choice questions
- start a quiz with true/false questions
- test category loading
- test error state by disabling internet
- test timer timeout
- complete a quiz and verify result screen
- verify quiz history is saved
- verify highest score updates
- verify theme selection persists after restart
- test both light and dark mode
- test long questions and long answers on a small screen

---

## Project Status

The main project requirements are implemented:

- API integration
- dynamic category loading
- configurable quiz setup
- timed quiz flow
- scoring
- result screen
- local quiz history
- theme persistence
- error/loading/empty states
- layered architecture
- Cubit state management
- dependency injection
- route-based navigation
- modern UI polish
- basic automated test coverage

Remaining recommended improvements are not blocking and are mostly related to broader automated test coverage, such as additional persistence tests for history/settings and router guard tests.