# TestTaskApp

**TestTaskApp** is a SwiftUI-based iOS application for registering users and displaying a list of registered users. It follows clean architecture principles using MVVM. 
---

## Features

- User list with pagination
  - Displays user name, position, email, phone, and avatar
  - Supports infinite scrolling and incremental loading
- User registration form
  - Includes fields: name, email, phone, position selection, and photo upload
  - Validates each field and provides inline error messages
  - Supports photo upload via the camera or photo library
- Network and error handling
  - Displays a error screen when no internet connection is available
  - Shows success or error screens after form submission

---

## Architecture

This project uses a modular clean MVVM pattern

---

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

---

## Setup

1. Clone the repository
```
git clone https://github.com/yanpepik/Testtask.git
cd TestTaskApp
```

2. Open the project in Xcode
```
open TestTaskApp.xcodeproj
```

3. Build and run on a simulator or real device

Note: Camera access is only available on real devices.

---

## Permissions

Make sure the following keys are included in your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires camera access to upload profile photos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires access to the photo library to select profile images.</string>

