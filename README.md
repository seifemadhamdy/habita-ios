# 🌱 Habita

A modern iOS habit tracking application that helps users build and maintain daily habits using Firebase Authentication and Firebase Realtime Database.

<table style="width: 100%; text-align: center; table-layout: fixed;">
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/885837fe-cfba-47eb-b2bd-e05f3b9d0c8b" alt="Authentication Screen Light"><br>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/143a687a-0024-40a6-8484-cff47ae62b66" alt="Home Screen Light"><br>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/390fbff4-8ce3-4e4e-adc8-b7a4b999070d" alt="Add Habit Dialog Light"><br>
    </td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/90468ec5-d835-46f6-bb87-693fc25b3c0a" alt="Authentication Screen Dark"><br>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/60285fa5-fd7d-4ea6-92c1-b5af6668d167" alt="Home Screen Dark"><br>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/6025ed39-6e1f-41d3-a97b-5b06e87792fb" alt="Add Habit Dialog Dark"><br>
    </td>
  </tr>
</table>

## ✨ Features

- User authentication with email and password
- Real-time habit tracking using Combine
- Add daily habits
- Mark habits as completed for the day
- Secure user data with Firebase authentication
- Responsive and intuitive SwiftUI design

## 🏗️ Technical Architecture

### Architecture Overview

The application follows Clean Architecture principles with MVVM pattern, ensuring:

- Clear separation of concerns
- High testability
- Scalable and maintainable codebase
- Unidirectional data flow with Combine

### Key Technical Decisions

#### UI Layer

- **SwiftUI**: Modern declarative UI framework
- **Navigation Stack**: Type-safe iOS navigation
- **Combine Framework**: Reactive programming
- **MVVM Pattern**: Separation of UI logic and data
- **@Published and @State**: Reactive state management

#### Domain Layer

- **Use Cases**: Encapsulated business logic
- **Protocols**: Modular and testable code design

## 🔄 Trade-offs & Decisions

1. **Authentication Strategy**
   - Chose email/password authentication for simplicity
   - Implemented robust validation and error handling using Combine

2. **Data Persistence**
   - Leveraged Firebase Realtime Database for instant updates
   - Implemented strict security rules for user data privacy

3. **UI Implementation**
   - Used SwiftUI for declarative and reactive UI components
   - Implemented responsive design for various iOS device sizes

## 🔜 Future Improvements

1. **Technical**
   - Implement more authentication methods (Apple Sign-In, Google)
   - Add comprehensive unit and integration tests
   - Implement habit streaks and progress tracking with Core Data

2. **User Experience**
   - Implement habit reminders using UserNotifications
   - Add detailed habit analytics
   - Create custom habit categories

## 🛠️ Setup & Installation

1. Clone the repository
2. Set up Firebase project
   - Create Firebase project
   - Add GoogleService-Info.plist to the project
3. Configure Firebase Realtime Database security rules
4. Build and run the project

### Firebase Realtime Database Rules

```json
{
  "rules": {
    "habits": {
      "$uid": {
        ".read": "auth !== null && auth.uid === $uid",
        ".write": "auth !== null && auth.uid === $uid"
      }
    }
  }
}
```

## 👨‍💻 Author

Seif Abu El-Ela
