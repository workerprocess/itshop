# Technical Implementation Guidelines: Flutter Mobile Application

## Project Architecture Overview
Building a Flutter mobile application following Clean Architecture principles with GetX state management, focusing on technical implementation patterns and project structure.

## Core Technical Stack

### Primary Technologies
- **Flutter**: 3.16+ with Material 3 design system
- **Dart**: 3.0+ with null safety
- **GetX**: State management, navigation, dependency injection
- **Dio**: HTTP client with interceptors for API communication
- **SharedPreferences**: Local data persistence

### Development Tools
- **json_serializable**: Model serialization with code generation
- **build_runner**: Code generation workflow
- **mockito**: Testing with mock objects
- **flutter_test**: Unit and widget testing

## Project Structure Standards

### Directory Organization (repository-specific)
```
mobile_app/
├── lib/
│   ├── core/                    # Core utilities and shared components
│   │   ├── constants/           # App constants and enums
│   │   ├── errors/              # Error handling classes
│   │   ├── network/             # API client and network utilities
│   │   ├── themes/              # Theme configuration (incl. glass theme)
│   │   └── utils/               # Utility functions and helpers
│   ├── data/                    # Data layer (Clean Architecture)
│   │   ├── datasources/         # Data source implementations
│   │   │   ├── local/           # Local data sources (SharedPreferences)
│   │   │   └── remote/          # Remote data sources (API calls)
│   │   ├── models/              # Data models with JSON serialization
│   │   └── repositories/        # Repository implementations
│   ├── domain/                  # Domain layer (Clean Architecture)
│   │   ├── entities/            # Business entities
│   │   ├── repositories/        # Repository interfaces
│   │   └── usecases/            # Business logic use cases
│   ├── presentation/            # Presentation layer (Clean Architecture)
│   │   ├── bindings/            # GetX dependency injection bindings
│   │   ├── controllers/         # GetX controllers for state management
│   │   ├── pages/               # Screen widgets
│   │   └── widgets/             # Reusable UI components
│   └── routes/                  # GetX routing configuration
├── assets/
│   ├── images/                  # Image assets
│   ├── json/                    # Mock data files (products.json, categories.json)
│   └── fonts/                   # Custom fonts
└── test/
    ├── unit/                    # Unit tests
    ├── integration/             # Integration tests
    └── contract/                # API contract tests
```

### Project-specific Conventions
- Use `AppRoutes` and `AppPages` under `mobile_app/lib/routes/` for all navigation. Do not hardcode route strings.
- Persist theme and favorites via repositories; controllers should not access SharedPreferences directly.
- Do not perform HTTP/Dio calls in widgets or controllers; use domain use cases and data repositories.
- Primary UI language is Thai; keep copy consistent and friendly. Code identifiers remain in English.
- Empty state strings (Thai):
  - หมวดว่าง: "ยังไม่มีข้อมูลที่เกี่ยวข้อง"
  - ค้นหาไม่พบ: "ไม่พบสินค้าที่ตรงกับการค้นหาของคุณ"
  - รายการโปรดว่าง: "ยังไม่มีสินค้าที่บันทึกไว้"

## Code Organization Patterns

### File Naming Conventions
- **Files**: snake_case (user_controller.dart, api_client.dart)
- **Classes**: PascalCase (UserController, ApiClient)
- **Variables**: camelCase (userName, isLoading)
- **Constants**: SCREAMING_SNAKE_CASE (API_BASE_URL, MAX_RETRY_COUNT)
- **Private members**: underscore prefix (_privateMethod, _privateVariable)

### Class Structure Standards
- **One class per file**: Strictly enforced
- **File naming**: Match class name in snake_case
- **Import organization**: External packages → Internal packages → Relative imports
- **Export organization**: Public classes → Private classes → Utilities

## Clean Architecture Implementation

### Domain Layer (Business Logic)
```dart
// Entity example
class User {
  final String id;
  final String name;
  final String email;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
  });
}

// Repository interface
abstract class UserRepository {
  Future<User> getUserById(String id);
  Future<List<User>> getAllUsers();
  Future<void> saveUser(User user);
}

// Use case example
class GetUserByIdUseCase {
  final UserRepository _repository;
  
  GetUserByIdUseCase(this._repository);
  
  Future<User> call(String id) async {
    return await _repository.getUserById(id);
  }
}
```

### Data Layer (Data Management)
```dart
// Model with JSON serialization
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
  User toEntity() => User(
    id: id,
    name: name,
    email: email,
  );
}

// Repository implementation
class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  
  UserRepositoryImpl(this._dataSource);
  
  @override
  Future<User> getUserById(String id) async {
    final model = await _dataSource.getUserById(id);
    return model.toEntity();
  }
}
```

### Presentation Layer (UI & State)
```dart
// GetX Controller
class UserController extends GetxController {
  final GetUserByIdUseCase _getUserByIdUseCase = Get.find();
  
  final _user = Rxn<User>();
  User? get user => _user.value;
  
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  
  @override
  void onInit() {
    super.onInit();
    loadUser();
  }
  
  Future<void> loadUser() async {
    try {
      _isLoading.value = true;
      final user = await _getUserByIdUseCase.call('user_id');
      _user.value = user;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
    }
  }
}

// GetX Binding
class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDataSource>(() => UserDataSourceImpl());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetUserByIdUseCase(Get.find()));
    Get.lazyPut(() => UserController());
  }
}
```

## API Client Architecture

### Dio Configuration
```dart
class ApiClient {
  late Dio _dio;
  
  ApiClient() {
    _dio = Dio();
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    // Request interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add authentication headers
        options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Log successful responses
        print('Response: ${response.statusCode}');
        handler.next(response);
      },
      onError: (error, handler) {
        // Handle errors globally
        _handleError(error);
        handler.next(error);
      },
    ));
  }
  
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }
  
  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return _dio.post<T>(path, data: data);
  }
}
```

## State Management Patterns

### GetX Reactive State Management

#### Controller with Observable Variables
```dart
class ProductSearchController extends GetxController {
  final TextEditingController textSearchController = TextEditingController();
  
  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxList<Product> _searchResults = <Product>[].obs;
  final RxList<Category> _categories = <Category>[].obs;
  final RxString _selectedCategory = ''.obs;
  final RxBool _isGridView = true.obs;
  
  // Getters for reactive access
  bool get isLoading => _isLoading.value;
  List<Product> get searchResults => _searchResults;
  List<Category> get categories => _categories;
  String get selectedCategory => _selectedCategory.value;
  bool get isGridView => _isGridView.value;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  @override
  void onClose() {
    textSearchController.dispose();
    super.onClose();
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _searchResults.clear();
      return;
    }

    try {
      _isLoading.value = true;
      
      final searchProductsUseCase = Get.find<SearchProductsUseCase>();
      final results = await searchProductsUseCase.call(query);
      _searchResults.value = results;
      
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleViewMode() {
    _isGridView.value = !_isGridView.value;
  }
}
```

#### Reactive UI with Obx()
```dart
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductSearchController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          // Reactive view mode toggle
          Obx(() => IconButton(
            icon: Icon(
              controller.isGridView ? Icons.list : Icons.grid_view,
            ),
            onPressed: () => controller.toggleViewMode(),
          )),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          TextField(
            controller: controller.textSearchController,
            onChanged: (value) => controller.searchProducts(value),
          ),
          
          // Reactive category filter
          Obx(() {
            if (controller.categories.isNotEmpty) {
              return Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    final isSelected = controller.selectedCategory == category.id;
                    
                    return FilterChip(
                      label: Text(category.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          controller.filterByCategory(category.id);
                        } else {
                          controller.clearCategoryFilter();
                        }
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          
          // Reactive search results
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.searchResults.isEmpty) {
                return const Center(child: Text('No results found'));
              }
              
              return controller.isGridView
                  ? ProductGridView(products: controller.searchResults)
                  : ProductListView(products: controller.searchResults);
            }),
          ),
        ],
      ),
    );
  }
}
```

#### Reactive State Management Best Practices
- **Use Obx() for Reactive UI**: Wrap UI components that need to react to observable changes
- **Observable Variables**: Use `.obs` for reactive variables (RxBool, RxList, RxString)
- **Getter Methods**: Expose observable values through getter methods
- **Controller Lifecycle**: Properly dispose controllers and TextEditingController in onClose()
- **Error Handling**: Implement try-catch blocks in async methods
- **Loading States**: Use observable loading states for better UX

### Dependency Injection with GetX Bindings

#### AppBindings (Core Dependencies)
```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core dependencies - Initialize once at app startup
    Get.put<ApiClient>(ApiClient());
    
    // Data sources
    Get.put<ProductDataSource>(ProductDataSource(Get.find()));
    
    // Repositories
    Get.put<ProductRepository>(ProductRepositoryImpl(Get.find(), useMockData: true));
    Get.put<CategoryRepository>(CategoryRepositoryImpl(Get.find(), useMockData: true));
    
    // Use cases
    Get.put(GetProductsUseCase(Get.find()));
    Get.put(GetProductByIdUseCase(Get.find()));
    Get.put(GetProductsByCategoryUseCase(Get.find()));
    Get.put(GetRecommendedProductsUseCase(Get.find()));
    Get.put(GetBestSellerProductsUseCase(Get.find()));
    Get.put(SearchProductsUseCase(Get.find()));
    Get.put(GetCategoriesUseCase(Get.find()));
    Get.put(GetCategoryByIdUseCase(Get.find()));
  }
}
```

#### RootBinding (Main App Entry Point)
```dart
class RootBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize app dependencies ONCE
    AppBindings().dependencies();
    
    // Initialize root controller
    Get.put<RootController>(RootController());
    
    // Initialize all page controllers for tab navigation
    Get.put<HomeController>(HomeController());
    Get.put<ProductsController>(ProductsController());
    Get.put<ProductSearchController>(ProductSearchController());
    Get.put<FavoritesController>(FavoritesController());
    Get.put<ProfileController>(ProfileController());
  }
}
```

#### Individual Page Bindings (Performance Optimized)
```dart
// HomeBinding - Only initializes HomeController
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // App dependencies are already initialized in RootBinding
    Get.put<HomeController>(HomeController());
  }
}

// SearchBinding - Only initializes ProductSearchController
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // App dependencies are already initialized in RootBinding
    Get.put<ProductSearchController>(ProductSearchController());
  }
}

// ProductsBinding - Only initializes ProductsController
class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    // App dependencies are already initialized in RootBinding
    Get.put<ProductsController>(ProductsController());
  }
}
```

#### Binding Performance Optimization
- **Single AppBindings Call**: AppBindings().dependencies() is called only once in RootBinding
- **No Duplicate Initialization**: Individual bindings only initialize their specific controllers
- **Memory Efficiency**: Prevents creating multiple instances of core dependencies
- **Faster Navigation**: Page transitions are faster without redundant dependency initialization

## Navigation Patterns

### GetX Navigation Architecture

#### Root Page with Tab Navigation
```dart
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex,
        children: const [
          HomePage(),
          ProductsPage(),
          SearchPage(),
          FavoritesPage(),
          ProfilePage(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentIndex,
        onTap: (index) => controller.changeTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}

class RootController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  
  int get currentIndex => _currentIndex.value;
  
  void changeTab(int index) {
    _currentIndex.value = index;
  }
}
```

#### App Routes Configuration
```dart
class AppRoutes {
  static const String root = '/';
  static const String home = '/home';
  static const String products = '/products';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String productDetail = '/product-detail';
}

class AppPages {
  static final routes = [
    // Root Page - Main entry point with bottom navigation
    GetPage(
      name: AppRoutes.root,
      page: () => const RootPage(),
      binding: RootBinding(),
    ),
    
    // Individual page routes - Direct navigation to specific pages
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesPage(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    
    // Modal/Overlay pages
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailPage(product: Get.arguments),
      binding: ProductDetailBinding(),
    ),
  ];
}
```

#### Navigation Patterns
- **Root Page**: Central hub with IndexedStack for tab navigation
- **State Preservation**: IndexedStack maintains state across tab switches
- **Direct Navigation**: Individual routes for direct page access
- **Modal Pages**: Settings and detail pages as overlays
- **Reactive Navigation**: Obx() for reactive tab switching

## Theme Management

### Theme Configuration
```dart
class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  );
  
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
}

class ThemeController extends GetxController {
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
```

### Glass Theme
- The project includes a glassmorphism-inspired theme in `mobile_app/lib/core/themes/glass_theme.dart`. New widgets should respect translucency, blur, and vibrant color accents defined there, and work in both Light and Dark modes.

## Testing Strategy

### Unit Testing
```dart
// Controller testing
void main() {
  group('UserController', () {
    late UserController controller;
    late MockGetUserByIdUseCase mockUseCase;
    
    setUp(() {
      mockUseCase = MockGetUserByIdUseCase();
      controller = UserController();
    });
    
    test('should load user successfully', () async {
      // Arrange
      when(mockUseCase.call(any)).thenAnswer((_) async => User(id: '1', name: 'Test'));
      
      // Act
      await controller.loadUser();
      
      // Assert
      expect(controller.user?.name, 'Test');
      expect(controller.isLoading, false);
    });
  });
}
```

### Integration Testing
```dart
// Widget testing
void main() {
  group('HomePage Integration', () {
    testWidgets('should display user data', (tester) async {
      // Arrange
      Get.put<GetUserByIdUseCase>(MockGetUserByIdUseCase());
      
      // Act
      await tester.pumpWidget(GetMaterialApp(home: HomePage()));
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Test User'), findsOneWidget);
    });
  });
}
```

## Performance Targets
- App startup ≤ 2 seconds on mid-tier devices.
- Smooth 60fps scrolling on product lists and home carousels.
- Responsive layouts for common phone sizes (e.g., 360x640, 375x667, 414x896, 428x926).

## Documentation & Tooling References
- Business PRD: `spec/PRD-business.md`
- Technical Design: `spec/TECH-design.md`
- Copilot instructions: `copilot-instruction.github`

## Error Handling

### Error Classes
```dart
abstract class AppError {
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class ValidationError extends AppError {
  const ValidationError(super.message);
}

class NotFoundError extends AppError {
  const NotFoundError(super.message);
}
```

### Error Handling in Controllers
```dart
class DataController extends GetxController {
  final _error = Rxn<AppError>();
  AppError? get error => _error.value;
  
  Future<void> loadData() async {
    try {
      // API call
    } on DioException catch (e) {
      _error.value = NetworkError('Network error: ${e.message}');
    } on ValidationException catch (e) {
      _error.value = ValidationError('Validation error: ${e.message}');
    } catch (e) {
      _error.value = AppError('Unexpected error: $e');
    }
  }
}
```

## Performance Optimization

### GetX Binding Performance
- **Single AppBindings Call**: Initialize core dependencies only once in RootBinding
- **Lazy Loading**: Use `Get.lazyPut()` for non-critical dependencies
- **Memory Management**: Properly dispose controllers and resources
- **State Preservation**: Use IndexedStack for tab navigation to maintain state

### Reactive UI Optimization
- **Obx() Usage**: Wrap only UI components that need reactive updates
- **Observable Variables**: Use `.obs` for reactive state management
- **Getter Methods**: Expose observable values through getter methods
- **Controller Lifecycle**: Implement proper onInit() and onClose() methods

### Memory Management
- **Controller Disposal**: Always dispose TextEditingController in onClose()
- **Resource Cleanup**: Remove listeners and subscriptions properly
- **Singleton Pattern**: Use GetX singleton pattern for shared resources
- **Error Handling**: Implement proper error handling to prevent memory leaks

### Code Generation
```bash
# Generate JSON serialization code
flutter packages pub run build_runner build

# Watch for changes during development
flutter packages pub run build_runner watch

# Clean generated files
flutter packages pub run build_runner clean
```

## Development Commands

### Project Setup
```bash
# Create new Flutter project
flutter create --org com.example app_name

# Install dependencies
flutter pub get

# Run code generation
flutter packages pub run build_runner build

# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

### Build Commands
```bash
# Debug build
flutter run

# Release build
flutter build apk --release
flutter build ios --release

# Profile build
flutter run --profile
```

## Code Quality Standards

### Linting Configuration
```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - avoid_print
    - prefer_single_quotes
    - sort_constructors_first
```

### Git Workflow
- Feature branches for new development
- Pull request reviews required
- Automated testing on CI/CD
- Code coverage requirements (minimum 80%)

---

*This technical guideline focuses on implementation patterns and project structure without business-specific requirements.*
