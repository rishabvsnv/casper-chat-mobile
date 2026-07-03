# 👻 Casper Chat

A modern, scalable, and feature-rich messaging platform built with **Flutter**, designed using **Clean Architecture**, **Riverpod**, **GoRouter**, and **Material 3**.

Casper Chat focuses on performance, reliability, privacy, and a beautiful user experience while maintaining a clean and maintainable codebase.

---

## 📱 Overview

Casper Chat is a next-generation messaging application built from the ground up using Flutter.

The project is designed with a modular architecture that supports real-time messaging, media sharing, groups, channels, voice and video communication, and future platform expansion.

The goal of Casper Chat is to provide a fast, intuitive, and modern communication platform with a professional user experience across Android, iOS, Desktop, and Web.

---

## ✨ Features

### 🔐 Authentication

- Phone number authentication
- OTP verification
- Session management
- Logout support
- Account recovery
- Secure login flow

---

### 💬 Messaging

- One-to-one messaging
- Real-time message delivery
- Message status indicators
- Message reactions
- Reply messages
- Forward messages
- Pinned messages
- Draft messages
- Scheduled messages
- Message search
- Message editing
- Message deletion

---

### 📸 Media Sharing

- Image sharing
- Video sharing
- Audio sharing
- Voice notes
- File sharing
- GIF support
- Sticker support
- Media preview
- Media downloads
- Media uploads

---

### 👥 Groups

- Create groups
- Manage members
- Assign administrators
- Group permissions
- Member restrictions
- Mute users
- Ban users
- Group invite links

---

### 📢 Channels

- Create channels
- Public channels
- Private channels
- Channel management
- Subscriber management
- Channel media sharing

---

### 📞 Calls

- Voice calls
- Video calls
- Call history
- Incoming calls
- Outgoing calls
- Missed calls

---

### 🌐 Stories

- Create stories
- Story viewers
- Story reactions
- Story privacy controls
- Expiring content

---

### 👤 User Profiles

- Profile photo management
- Username support
- Bio support
- Online status
- Last seen visibility
- Profile customization

---

### 📇 Contacts

- Contact synchronization
- Contact search
- Contact invitations
- Favorite contacts

---

### 🔔 Notifications

- Push notifications
- Message notifications
- Group notifications
- Channel notifications
- Call notifications
- Custom notification settings

---

### ⚙️ Settings

- Appearance settings
- Privacy settings
- Notification settings
- Language settings
- Storage management
- Data usage settings
- Security settings

---

## 🏗 Architecture

Casper Chat follows **Clean Architecture** principles for scalability, maintainability, and testability.

```text
lib/
├── app/
│   ├── router/
│   ├── theme/
│   ├── providers/
│   └── services/
│
├── core/
│   ├── constants/
│   ├── exceptions/
│   ├── extensions/
│   ├── models/
│   ├── network/
│   ├── services/
│   ├── storage/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── chats/
│   ├── contacts/
│   ├── calls/
│   ├── groups/
│   ├── channels/
│   ├── stories/
│   ├── profile/
│   ├── settings/
│   ├── search/
│   └── folders/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   ├── providers/
│   └── extensions/
│
└── main.dart
```

---

### Feature Structure

Each feature follows:

```text
feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── screens/
    ├── widgets/
    └── providers/
```

---

## 🛠 Tech Stack

### Framework

- Flutter

### Language

- Dart

### State Management

- Riverpod

### Navigation

- GoRouter

### Local Storage

- Hive
- SharedPreferences

### Code Generation

- Freezed
- Json Serializable

### Dependency Injection

- Riverpod Providers

### Media

- Image Picker
- Cached Network Image

### UI

- Material 3
- Custom Design System

---

## 📦 Dependencies

```yaml
flutter_riverpod
go_router

freezed
freezed_annotation
json_annotation

hive
hive_flutter

shared_preferences

equatable

intl

cached_network_image

flutter_svg

permission_handler

image_picker

path_provider
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Dart SDK
- Android Studio / VS Code
- Android SDK
- Xcode (For iOS)

---

## Clone Repository

```bash
git clone https://github.com/yourusername/casper-chat.git

cd casper-chat
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Generate Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Run Application

```bash
flutter run
```

---

## 📂 Environment Setup

### Android

Add required permissions:

```xml
<uses-permission android:name="android.permission.INTERNET"/>

<uses-permission android:name="android.permission.CAMERA"/>

<uses-permission android:name="android.permission.RECORD_AUDIO"/>

<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>

<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>

<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

---

### iOS

Add permissions to:

```text
ios/Runner/Info.plist
```

Examples:

```xml
NSCameraUsageDescription
NSMicrophoneUsageDescription
NSPhotoLibraryUsageDescription
NSPhotoLibraryAddUsageDescription
```

---

## 🔒 Security

- Secure authentication
- Session management
- Encrypted local storage
- Secure media handling
- Privacy-first architecture
- Permission-based access control

---

## 🧪 Testing

Run all tests:

```bash
flutter test
```

Run integration tests:

```bash
flutter test integration_test
```

---

## 📈 Roadmap

### Current Development

- [x] Authentication
- [x] User Profiles
- [x] Chat List
- [x] Private Messaging
- [x] Media Messaging
- [x] Search
- [x] Settings
- [x] Folder Management

### Upcoming Features

- [ ] Voice Calls
- [ ] Video Calls
- [ ] Stories
- [ ] Channels
- [ ] Bots
- [ ] Mini Apps
- [ ] Live Streaming
- [ ] Communities
- [ ] Multi-Account Support
- [ ] End-to-End Encryption
- [ ] Desktop Support
- [ ] Web Support

---

## 🤝 Contributing

Contributions are welcome.

### Create a Feature Branch

```bash
git checkout -b feature/new-feature
```

### Commit Changes

```bash
git commit -m "Add new feature"
```

### Push Changes

```bash
git push origin feature/new-feature
```

### Open Pull Request

Submit a Pull Request describing your changes.

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

### Rishabh

Flutter Developer

Built with ❤️ using Flutter.

---

## ⭐ Support

If you find Casper Chat useful, consider giving the repository a star.

It helps support development and makes the project more visible to the Flutter community.

---

# Casper Chat

### Fast. Secure. Beautiful Messaging.
