# Banking App — Notifications Module

A Flutter module that handles **push and in-app notifications** for a banking app. It receives Firebase Cloud
Messaging pushes, shows them as local notifications while the app is in the foreground, and lists them in a
notifications screen backed by a REST API.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Push-FCM-FFCA28?logo=firebase&logoColor=black)

## What's built

- FCM setup for foreground, background and terminated states
- Local notifications with `flutter_local_notifications`
- Notifications screen with Cubit state and Dio-based API calls
- Arabic and English with `easy_localization`

## Architecture

Clean Architecture for the `notification` feature (data / domain / presentation), `get_it` for DI,
`dartz` `Either` for errors.

## Tech stack

Flutter · flutter_bloc · get_it · Dio · dartz · Firebase Messaging · flutter_local_notifications · easy_localization

## Getting started

```bash
flutter pub get
flutter run
```

Requires a Firebase project configured with `flutterfire configure`.

## Author

**Ammar Zeineh**, Flutter Developer · [LinkedIn](https://linkedin.com/in/ammar-zeineh) · [GitHub](https://github.com/AmmarZeineh)
