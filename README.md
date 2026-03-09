# 🎬 Streamly

Streamly is a modern, high-performance Flutter application designed for seamless video streaming and an exceptional user experience. Built with a scalable, production-ready architecture, it integrates robust video playback capabilities, state-of-the-art navigation, and smooth push notifications.

## 🏗 Project Architecture

Streamly follows a **Feature-Driven Clean Architecture** to ensure modularity, scalability, and maintainability. The codebase is organized by distinct features, making it highly decoupled and easy to navigate

## Clean Architecture

lib
│   firebase_options.dart
│   main.dart
│
├── core
│   ├── constants
│   │       api_constants.dart
│   │
│   ├── error
│   │       exceptions.dart
│   │       failures.dart
│   │
│   ├── network
│   │       api_service.dart
│   │
│   ├── styles
│   │       colors.dart
│   │
│   └── utils
│           date_formatter.dart
│
├── features
│   ├── profile
│   │   └── presentation
│   │       └── pages
│   │               profile_page.dart
│   │
│   └── videos
│       ├── data
│       │   ├── datasource
│       │   │       video_remote_datasource.dart
│       │   ├── models
│       │   │       video_model.dart
│       │   └── repositories
│       │           video_repository_impl.dart
│       │
│       ├── domain
│       │   ├── entities
│       │   │       video.dart
│       │   ├── repositories
│       │   │       video_repository.dart
│       │   └── usecases
│       │           get_videos.dart
│       │
│       └── presentation
│           ├── bloc
│           │       video_bloc.dart
│           │       video_event.dart
│           │       video_state.dart
│           ├── pages
│           │       home_page.dart
│           └── widgets
│                   video_player_card.dart
│
├── navigation
│       app_router.dart
│       main_screen.dart
│       page_notfound.dart
│       route_config.dart
│
└── notifications
        notification_service.dart

This layer-by-layer separation of concerns allows the project to scale easily while keeping the UI, business logic, and data layers decoupled.

## ✨ Key Features

- **🚀 Advanced Video Controllers:** Enjoy smooth streaming with a highly customized video player. Features include play/pause, 10-second forward/backward skip, and a seamless toggle for full-screen mode.
- **⚡ Efficient Video Rendering:** Videos feed is rendered optimally using `ListView.builder`, ensuring smooth scrolling performance without memory bloat or lag, even with continuous video feeds.
- **🌐 Robust API Integration:** Fast and reliable network data fetching from custom APIs using the powerful **Dio** HTTP client.
- **🧠 Reactive State Management:** Harnessing the power of the **BLoC** (Business Logic Component) pattern to gracefully bind fetched data to the UI, ensuring predictable state transitions and scalable business logic.
- **🔔 Smart Push Notifications:** Integrated **Firebase Cloud Messaging (FCM)** keeps users engaged, reliably triggering and handling notifications in both **Foreground** and **Background** states.
- **🧭 Persistent Navigation:** Smooth, deep-linkable, and persistent routing throughout the app managed via **go_router**, allowing nested navigations and preserved UI states.
- **🎨 Modern Aesthetic UI:** A sleek, premium, and highly interactive user interface crafted using modern design principles and smooth micro-animations.

## 🚀 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone <repo url>
   ```
2. **Navigate into the project directory:**
   ```bash
   cd streamly
   ```
3. **Clean and fetch dependencies:**
   ```bash
   flutter clean
   flutter pub get
   ```
4. **Run the application:**
   ```bash
   flutter run
   ```

## Developer
Developed by **Prasad Musini**.