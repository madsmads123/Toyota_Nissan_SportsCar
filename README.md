# Toyota Nissan SportsCar Classification App

A Flutter-based mobile application for classifying Toyota and Nissan sports cars using machine learning models trained with Teachable Machine. The app integrates with Firebase Firestore for cloud-based data logging and provides real-time ML inference via device camera.

## Features

- **Sports Car Display**: View all Toyota and Nissan sports car models with photos, names, and specifications on the home screen
- **Real-time Classification**: Instantly identify sports cars using camera with TensorFlow Lite AI
- **Cloud Database**: Firebase Firestore integration for storing car models and classification results
- **Responsive Design**: Optimized for multiple screen sizes (phones and tablets)
- **Classification Analytics**: Automatic logging of identification results to Firestore for insights
- **Optimized Image Loading**: Efficient image caching for car photos and model specifications

## Project Structure

```
lib/
├── main.dart                          # Application entry point
├── firebase_options.dart              # Firebase configuration
├── screens/
│   ├── home_screen.dart              # Homepage with class grid display
│   ├── camera_screen.dart            # Camera and ML inference
│   └── class_detail_screen.dart      # Class detail view
├── models/
│   └── class_data.dart               # ClassData model
├── services/
│   └── firestore_service.dart        # Firestore database operations
├── providers/
│   └── class_provider.dart           # State management with Provider
└── widgets/
    └── class_card.dart               # Reusable class card component
test/
├── widgets/
│   └── class_card_test.dart          # ClassCard widget tests
└── providers/
    └── class_provider_test.dart      # ClassProvider tests
```

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK (included with Flutter)
- Android Studio / Xcode for mobile development
- Firebase project with Firestore database
- Teachable Machine exported TensorFlow Lite model

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure Firebase

#### For Android:
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/`

#### For iOS:
1. Download `GoogleService-Info.plist` from Firebase Console
2. Add it to Xcode project

### 3. Update Firebase Options

Edit `lib/firebase_options.dart` with your Firebase project credentials:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_STORAGE_BUCKET',
);
```

### 4. Run the Application

```bash
flutter run
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS App
```bash
flutter build ios --release
```

## Firestore Database Setup

### Collections Structure

**classes** - Store sports car models
```json
{
  "id": "supra_a90",
  "name": "Toyota Supra A90",
  "description": "5th generation high-performance sports car with twin-turbo engine",
  "photoUrl": "gs://bucket/class_photos/supra_a90.jpg",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

**classifications** - Log car identification results
```json
{
  "classId": "supra_a90",
  "className": "Toyota Supra A90",
  "confidence": 0.95,
  "userId": "user_123",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

**metrics** - Aggregated identification data for Looker Studio
```json
{
  "classId": "supra_a90",
  "totalClassifications": 150,
  "averageConfidence": 0.92,
  "lastUpdated": "2024-01-15T10:30:00Z"
}
```

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/widgets/class_card_test.dart
```

### Generate Coverage Report
```bash
flutter test --coverage
```

## Key Components

### ClassCard Widget
Displays individual class information in a card format with:
- Class photo (with placeholder support)
- Class name
- Class description
- Tap handling for navigation

### ClassProvider
State management using Provider pattern:
- Fetches classes from Firestore
- Manages loading and error states
- Logs classifications
- Listens to real-time Firestore updates

### HomeScreen
Homepage implementation featuring:
- GridView of ClassCard widgets
- Pull-to-refresh functionality
- Loading and error states
- Navigation to camera and detail screens

## Adding Classes to Firestore

### Option 1: Firebase Console
1. Go to Firestore Database
2. Create collection "classes"
3. Add documents with class information

### Option 2: Programmatically
```dart
ClassProvider classProvider = context.read<ClassProvider>();
final newCar = ClassData(
  id: 'nissan_z_z33',
  name: 'Nissan Z Z33',
  description: 'Legendary Japanese sports car with V6 engine and iconic design',
  photoUrl: 'gs://bucket/class_photos/nissan_z_z33.jpg',
  createdAt: DateTime.now(),
);
await classProvider.addClass(newCar);
```

## Troubleshooting

### Firebase Connection Issues
- Verify internet connectivity
- Check Firebase credentials in `firebase_options.dart`
- Ensure Firestore rules allow read/write access

### Image Loading Issues
- Verify photoUrl paths are accessible
- Check Firebase Storage permissions
- Use relative paths for local assets

### ML Model Issues
- Ensure TensorFlow Lite model is in `assets/models/`
- Verify model input/output specifications
- Check camera permissions on device

## Future Enhancements

- [ ] Complete TensorFlow Lite integration for camera classification
- [ ] User authentication and profiles
- [ ] Classification history view
- [ ] Advanced filtering and sorting
- [ ] Offline mode with local database
- [ ] Push notifications for alerts
- [ ] Integration with Looker Studio dashboards

## License

This project is part of the Flutter Mobile App Development course.

## Support

For issues or questions, please contact the course instructor or check the project documentation.
