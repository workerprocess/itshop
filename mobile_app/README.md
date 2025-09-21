# IT Shop Mobile Application

A Flutter mobile application for IT product sales built with Clean Architecture, GetX state management, and Dio HTTP client.

## 🚀 Features

- **Clean Architecture**: Separation of concerns with Presentation, Domain, and Data layers
- **GetX State Management**: Reactive programming with dependency injection
- **Dio HTTP Client**: Robust API communication with interceptors
- **Material 3 Design**: Modern UI with Light/Dark theme support
- **5-Tab Navigation**: Home, Products, Search, Favorites, Profile
- **Responsive Design**: Optimized for various mobile screen sizes

## 📱 Screenshots

*Coming soon...*

## 🛠️ Tech Stack

- **Flutter**: 3.16+ with Material 3
- **Dart**: 3.0+ with null safety
- **GetX**: State management, navigation, dependency injection
- **Dio**: HTTP client with interceptors
- **SharedPreferences**: Local data persistence
- **json_serializable**: Model serialization

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities and shared components
│   ├── constants/          # App constants and enums
│   ├── errors/             # Error handling classes
│   ├── network/            # API client and network utilities
│   ├── themes/             # Theme configuration
│   └── utils/              # Utility functions and helpers
├── data/                   # Data layer (Clean Architecture)
│   ├── datasources/        # Data source implementations
│   │   ├── local/          # Local data sources
│   │   └── remote/         # Remote data sources
│   ├── models/             # Data models with JSON serialization
│   └── repositories/       # Repository implementations
├── domain/                 # Domain layer (Clean Architecture)
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business logic use cases
├── presentation/           # Presentation layer (Clean Architecture)
│   ├── bindings/           # GetX dependency injection bindings
│   ├── controllers/        # GetX controllers for state management
│   ├── pages/              # Screen widgets
│   └── widgets/            # Reusable UI components
└── routes/                 # GetX routing configuration

assets/
├── images/                 # Image assets
├── json/                   # Mock data files
└── fonts/                  # Custom fonts

test/
├── unit/                   # Unit tests
├── integration/            # Integration tests
└── contract/               # API contract tests
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.16+
- Dart SDK 3.0+
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd mobile_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

### Unit Tests
```bash
flutter test test/unit/
```

### Integration Tests
```bash
flutter test test/integration/
```

### Contract Tests
```bash
flutter test test/contract/
```

## 📦 Build

### Debug Build
```bash
flutter run --debug
```

### Release Build
```bash
flutter build apk --release
flutter build ios --release
```

## 🎨 Theme Management

The app supports Light and Dark themes with automatic system theme detection:

```dart
// Toggle theme programmatically
Get.find<ProfileController>().toggleTheme();
```

## 🔧 Configuration

### API Configuration
Update the base URL in `lib/core/network/api_client.dart`:

```dart
static const String baseUrl = 'https://your-api.com/v1';
```

### Mock Data
Mock data is available in `assets/json/`:
- `products.json` - Sample product data
- `categories.json` - Product categories

## 📱 Navigation

The app uses GetX routing with the following structure:

- **Home**: `/home` - Featured products and recommendations
- **Products**: `/products` - Product listing and categories
- **Search**: `/search` - Product search functionality
- **Favorites**: `/favorites` - User's favorite products
- **Profile**: `/profile` - User profile and settings
- **Settings**: `/settings` - App settings and preferences

## 🏗️ Architecture

### Clean Architecture Layers

1. **Presentation Layer**: UI components, controllers, and bindings
2. **Domain Layer**: Business logic, entities, and use cases
3. **Data Layer**: Data sources, models, and repositories

### GetX Integration

- **Controllers**: State management and business logic
- **Bindings**: Dependency injection and lifecycle management
- **Routes**: Navigation and page management

## 🔍 Code Quality

The project uses strict linting rules defined in `analysis_options.yaml`:

- Flutter lint rules
- Custom code style guidelines
- Documentation requirements
- Type safety enforcement

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

For support, email support@itshop.com or create an issue in the repository.

---

**Built with ❤️ using Flutter and Clean Architecture**