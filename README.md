# Quizora — Open Trivia DB Quiz App

Quizora is a Flutter quiz application powered by the Open Trivia DB API.

The app allows users to configure a quiz, answer timed questions, receive instant feedback, track their score, view quiz history, and switch between light/dark themes.

This project was developed as an internship graduation project with a focus on clean architecture, state management, API integration, local persistence, error handling, and a polished mobile UI.

---

## Features

- Dynamic category loading from Open Trivia DB
- Quiz setup with category, difficulty, question count, and question type
- Multiple choice and true/false question support
- Timed quiz flow with a countdown timer for each question
- Randomized answer options
- Correct/wrong answer feedback
- A/B/C/D answer option badges
- Animated question transitions
- Progress indicator for quiz completion
- Final result screen with score-based feedback
- Local quiz history with date and score
- Persistent theme preference
- Light, dark, and system theme support
- Loading, error, and empty states
- HTML entity decoding for API question/answer text

---

## Tech Stack

- `flutter_bloc` — Cubit-based state management
- `dio` — API communication
- `go_router` — declarative routing
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

---

## Architecture

The project uses a feature-first layered architecture.

```txt
lib/
  app/
    bootstrap/
    dependency_injection/
    router/

  core/
    constants/
    error/
    network/
    theme/
    utils/
    widgets/

  features/
    quiz/
      data/
      domain/
      presentation/

    history/
      data/
      domain/
      presentation/

    settings/
      data/
      domain/
      presentation/
```

### Layer Responsibilities

#### `data`

Handles API communication, local storage access, models, and data source implementations.

#### `domain`

Contains entities, repository contracts, and use cases.

#### `presentation`

Contains Cubits, states, pages, widgets, and UI-specific helpers.

This separation keeps API logic, business rules, and UI code independent from each other. Widgets do not call the API directly.

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
- changing theme mode

For this project scope, Cubit keeps the state layer readable and avoids unnecessary event boilerplate.

---

## Local Persistence

The app uses Hive CE for local storage.

Stored local data includes:

- quiz history
- completed quiz scores
- theme preference

This allows quiz history and theme selection to remain available after the app is closed and reopened.

---

## Error and Empty States

The app handles:

- loading states while fetching data
- network or API failures
- empty question results
- local storage read/write failures where applicable

When an error occurs, the user is shown a message and a retry option instead of a blank screen.

---

## UI / UX

The interface was designed with a modern mobile-first approach.

UI details include:

- consistent spacing and reusable UI components
- dark and light theme support
- gradient backgrounds
- card-based question and result screens
- custom answer option cards
- A/B/C/D option badges
- visual correct/wrong feedback
- progress bar
- timer badge
- animated question transitions
- adaptive result feedback based on the final score

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
- modern UI polish

Remaining recommended improvements are mostly related to additional automated test coverage and small accessibility refinements.