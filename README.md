# 📱 Flutter User & Posts App

A Flutter application that lists users and their posts, fetching data from a REST API and storing it locally for offline access.

## 🚀 Features
- **List users** and fetch their posts.
- **Local caching** of users to reduce API calls.
- **Search users in real-time** using a search bar.
- **Display user details** including name, email, and phone number.
- **Show user posts**, fetched dynamically when selecting a user.
- **State management using Bloc** to manage UI states.
- **Error handling** for failed API requests.
- **Theming support** with a centralized theme file.
- **Unit & Widget Tests** covering more than **80%** of the code.

## 📂 Project Structure
```
lib/
│── core/                # Core configurations and utilities
│   ├── theme/           # Centralized theme management
│   │   ├── app_theme.dart
│   ├── navigation/      # App navigation routes
│   │   ├── app_routes.dart
│
├── data/                # Data handling (models & repositories)
│   ├── models/          # Data models
│   │   ├── post_model.dart
│   │   ├── user_model.dart
│   ├── repositories/    # Data repository layer
│   │   ├── user_repository.dart
│
├── presentation/        # UI and state management
│   ├── user_list_screen/
│   │   ├── bloc/        # User Bloc for state management
│   │   │   ├── user_bloc.dart
│   │   │   ├── user_event.dart
│   │   │   ├── user_state.dart
│   │   ├── screens/
│   │   │   ├── user_list_screen.dart
│
│   ├── user_post_screen/
│   │   ├── bloc/        # Post Bloc for state management
│   │   │   ├── post_bloc.dart
│   │   │   ├── post_event.dart
│   │   │   ├── post_state.dart
│   │   ├── screens/
│   │   │   ├── user_posts_screen.dart
│
│   ├── widgets/         # Reusable UI components
│   │   ├── post_card.dart
│   │   ├── user_card.dart
│
└── main.dart            # App entry point
```

## 🛠️ Dependencies
- **State Management:** `flutter_bloc`
- **Networking:** `dio`
- **Local Storage:** `shared_preferences`
- **Testing:** `flutter_test`, `mocktail`, `bloc_test`

## ✅ Running the Tests
To check test coverage, run:
```sh
flutter test --coverage
```
This project **achieves over 80% test coverage**, ensuring robustness and maintainability.

## 📌 Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Start the app with `flutter run`.
4. Run `flutter test` to validate functionality.

Enjoy coding! 🚀

