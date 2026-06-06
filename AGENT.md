# Project Instructions (AGENT.md)

Welcome! This document outlines the technology stack, project guidelines, directory structure, and commands for the **fin_state_analytical** Flutter project.

---

## 🛠️ Technology Stack & Environment
*   **Flutter SDK:** Managed via FVM (`3.44.1`)
    *   *Note: Always prefix flutter/dart commands with `fvm` (e.g., `fvm flutter run`)*
*   **State Management:** BLoC (`flutter_bloc`)
*   **Local Storage:** Hive (`hive_flutter`)
*   **AI Integration:** Gemini API (via `google_generative_ai`)
*   **Dependency Injection:** Service Locator via `get_it`
*   **Architecture Pattern:** Clean Architecture (Presentation/UI, Domain, Data)

---

## 📂 Project Structure
Files are organized under `lib/` as follows:
```text
lib/
├── data/          # Data Sources, APIs, Hive DB implementations, and Repositories (Data Layer)
│   ├── datasources/   # Local (Hive) & Remote (Gemini API) sources
│   ├── models/        # JSON Models & Data Transfer Objects (DTOs)
│   └── repositories/  # Repository implementations
├── domain/        # Entities, Use Cases, and Repository Interfaces (Domain Layer)
│   ├── entities/      # Core business objects
│   ├── repositories/  # Abstract repository definitions
│   └── usecases/      # Business logic (e.g., CalculateRatiosUseCase)
├── ui/            # UI Pages, Widgets, and BLoC State Management (UI Layer)
│   ├── blocs/         # BLoC state logic (Events, States, Blocs)
│   ├── pages/         # Screens & Views
│   └── widgets/       # Shared UI components
├── injection_container.dart # Dependency Injection setup (GetIt)
└── main.dart      # Application entrypoint
```

---

## 📐 Core Architectural Rules

1.  **AI Data Extraction vs. Calculation (CRITICAL)**
    *   **Rule:** **DO NOT** ask the Gemini API to perform mathematical calculations for financial ratios. LLMs are prone to arithmetic errors.
    *   **Process:**
        1.  Gemini API must only **extract raw values** (e.g., Current Assets, Current Liabilities, Inventory, Net Income) from the PDF and return them in a strict JSON format.
        2.  The **Domain Layer (Use Cases)** in Dart will perform all mathematical calculations deterministically (e.g., `currentRatio = currentAssets / currentLiabilities`).
2.  **State Management Guidelines**
    *   Separate UI from business logic using `flutter_bloc`.
    *   UI Widgets must only emit events and listen to state changes.
3.  **Data Caching**
    *   Successfully parsed and calculated financial reports should be cached locally in **Hive** for offline viewing and analysis history.
4.  **AI Collaboration Rule (CRITICAL)**
    *   **Rule:** For all logic implementations (e.g., API integration, BLoC, DB caching, math logic), the AI Assistant must focus on explaining the architectural guidelines, flow, and providing code templates or pseudo-code first. The developer will write and compile all code files themselves to facilitate "Learning by Doing".
5.  **Architecture Consistency & Best Practices**
    *   **Rule:** Strictly follow the Feature-First Clean Architecture guidelines defined in the [implementation_plan.md](file:///C:/Users/nutna/.gemini/antigravity-ide/brain/dcb0bdd4-1ee2-4d28-a566-655329cbc482/implementation_plan.md). Core packages must resolve, code must follow lint rules, and features must remain decoupled.

---

## 🚀 Key Commands

*   **Run the App:**
    ```bash
    fvm flutter run
    ```
*   **Install Dependencies:**
    ```bash
    fvm flutter pub get
    ```
*   **Generate Code (Hive/Build Runner):**
    ```bash
    fvm flutter pub run build_runner build --delete-conflicting-outputs
    ```
*   **Run Unit Tests:**
    ```bash
    fvm flutter test
    ```
