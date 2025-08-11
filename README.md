# A Simple Todo App


This Flutter todo app provides solid foundation of a todo app which include the add todo, active todo, complete todo and also contain basic CRUD operations
The UI design is consistent to ensuring a seamless user experience.


## Features
Todo Screen: Add todo, display todo, statistics and categories etc.
Edit and Update Screen: This page allows to edit and update todo

## Videos



Uploading WhatsApp Video 2025-08-11 at 4.00.22 PM.mp4…


## Prerequisites
- [FlutterSDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio](https://visualstudio.microsoft.com/) with Flutter and Dart plugins

## Dependencies
This Todo app uses the following dependencies to provide essential functionalities and ensure a smooth development experience:


### Core Dependencies

1.. Flutter_riverpod: ^2.6.1
An advanced state management library that is an improvement over the original Provider package, offering better performance and flexibility.

2. SharePreferences: ^2.2.2
A local storage to store and manage app data across the application. making it easy to access save data  from anywhere in the code.

## Getting Started
### 1. Clone the Repository
bash
```Copy code
git clone https://github.com/Phillip4reall/Todo.git
```

### 2. Install Dependencies
Run the following command to install the necessary packages:
bash
```Copy code
flutter pub get
```

### 4. Run the Application
To start the application on an emulator or a connected device, run:
bash
```Copy code
flutter run
```

### 5. Building for Release
For Android:
bash
```Copy code
flutter build apk --release
```

For iOS:
```bash

flutter build ios --release
```

## Project Structure

lib/
├── model/models.dart

├── provider/todo_provider.dart 

├── Screens ├── edit_todo.dart
                todo_screen.dart
                       
├── widgets ├── app_theme.dart
                statistics.dart
                todo_filter.dart
                todo_items.dart             
└── main.dart          







