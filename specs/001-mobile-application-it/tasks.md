# Tasks: Mobile Application สำหรับการขายสินค้า IT

**Input**: Design documents from `/specs/001-mobile-application-it/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
3. Generate tasks by category:
   → Setup: project init, dependencies, linting
   → Tests: contract tests, integration tests
   → Core: models, services, CLI commands
   → Integration: DB, middleware, logging
   → Polish: unit tests, performance, docs
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All contracts have tests?
   → All entities have models?
   → All endpoints implemented?
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions

## Path Conventions
- **Mobile Flutter App**: `lib/`, `test/`, `assets/` at repository root
- **Clean Architecture**: `lib/core/`, `lib/data/`, `lib/domain/`, `lib/presentation/`
- **GetX Structure**: `lib/presentation/controllers/`, `lib/presentation/pages/`, `lib/presentation/bindings/`

## Phase 3.1: Setup
- [x] T001 Create Flutter project structure with Clean Architecture folders
- [x] T002 Initialize Flutter project with GetX, Dio, SharedPreferences dependencies
- [x] T003 [P] Configure linting and formatting tools (analysis_options.yaml, .gitignore)

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**
- [x] T004 [P] Contract test API endpoints in test/contract/api_contract_tests.dart
- [x] T005 [P] Integration test Home screen featured products in test/integration/test_home_screen.dart
- [x] T006 [P] Integration test Products tab navigation in test/integration/test_products_tab.dart
- [x] T007 [P] Integration test Search functionality in test/integration/test_search_tab.dart
- [x] T008 [P] Integration test Favorites management in test/integration/test_favorites_tab.dart
- [x] T009 [P] Integration test Profile and settings in test/integration/test_profile_tab.dart
- [x] T010 [P] Integration test Theme switching in test/integration/test_theme_switching.dart
- [x] T011 [P] Integration test Custom app bars in test/integration/test_app_bars.dart

## Phase 3.3: Core Implementation (ONLY after tests are failing)
- [x] T012 [P] Product entity in lib/domain/entities/product.dart
- [x] T013 [P] Category entity in lib/domain/entities/category.dart
- [x] T014 [P] ThemeSettings entity in lib/domain/entities/theme_settings.dart
- [x] T015 [P] UserPreferences entity in lib/domain/entities/user_preferences.dart
- [x] T016 [P] NavigationState entity in lib/domain/entities/navigation_state.dart
- [x] T017 [P] ProductModel with JSON serialization in lib/data/models/product_model.dart
- [x] T018 [P] CategoryModel with JSON serialization in lib/data/models/category_model.dart
- [x] T019 [P] ThemeSettingsModel with JSON serialization in lib/data/models/theme_settings_model.dart
- [x] T020 [P] UserPreferencesModel with JSON serialization in lib/data/models/user_preferences_model.dart
- [x] T021 [P] NavigationStateModel with JSON serialization in lib/data/models/navigation_state_model.dart
- [x] T022 [P] Mock product data JSON files in assets/json/products.json
- [x] T023 [P] Mock category data JSON files in assets/json/categories.json
- [x] T024 [P] API client with Dio interceptors in lib/core/network/api_client.dart
- [x] T025 [P] Error handling classes in lib/core/errors/
- [x] T026 [P] Constants and utilities in lib/core/constants/ and lib/core/utils/

## Phase 3.4: Domain Layer Implementation
- [x] T027 [P] ProductRepository interface in lib/domain/repositories/product_repository.dart
- [x] T028 [P] CategoryRepository interface in lib/domain/repositories/category_repository.dart
- [x] T029 [P] ThemeRepository interface in lib/domain/repositories/theme_repository.dart
- [x] T030 [P] UserPreferencesRepository interface in lib/domain/repositories/user_preferences_repository.dart
- [x] T031 [P] GetFeaturedProducts use case in lib/domain/usecases/get_featured_products.dart
- [x] T032 [P] GetProducts use case in lib/domain/usecases/get_products.dart
- [x] T033 [P] GetProductById use case in lib/domain/usecases/get_product_by_id.dart
- [x] T034 [P] GetCategories use case in lib/domain/usecases/get_categories.dart
- [x] T035 [P] SearchProducts use case in lib/domain/usecases/search_products.dart
- [x] T036 [P] ToggleFavorite use case in lib/domain/usecases/toggle_favorite.dart
- [x] T037 [P] GetFavorites use case in lib/domain/usecases/get_favorites.dart
- [x] T038 [P] ToggleTheme use case in lib/domain/usecases/toggle_theme.dart
- [x] T039 [P] GetThemeSettings use case in lib/domain/usecases/get_theme_settings.dart

## Phase 3.5: Data Layer Implementation
- [x] T040 [P] LocalProductDataSource in lib/data/datasources/local/product_local_datasource.dart
- [x] T041 [P] RemoteProductDataSource in lib/data/datasources/remote/product_remote_datasource.dart
- [x] T042 [P] LocalCategoryDataSource in lib/data/datasources/local/category_local_datasource.dart
- [x] T043 [P] RemoteCategoryDataSource in lib/data/datasources/remote/category_remote_datasource.dart
- [x] T044 [P] LocalThemeDataSource in lib/data/datasources/local/theme_local_datasource.dart
- [x] T045 [P] LocalUserPreferencesDataSource in lib/data/datasources/local/user_preferences_local_datasource.dart
- [x] T046 [P] ProductRepositoryImpl in lib/data/repositories/product_repository_impl.dart
- [x] T047 [P] CategoryRepositoryImpl in lib/data/repositories/category_repository_impl.dart
- [x] T048 [P] ThemeRepositoryImpl in lib/data/repositories/theme_repository_impl.dart
- [x] T049 [P] UserPreferencesRepositoryImpl in lib/data/repositories/user_preferences_repository_impl.dart

## Phase 3.6: Presentation Layer Implementation
- [x] T050 [P] HomeController in lib/presentation/controllers/home_controller.dart
- [x] T051 [P] ProductsController in lib/presentation/controllers/products_controller.dart
- [x] T052 [P] SearchController in lib/presentation/controllers/search_controller.dart
- [x] T053 [P] FavoritesController in lib/presentation/controllers/favorites_controller.dart
- [x] T054 [P] ProfileController in lib/presentation/controllers/profile_controller.dart
- [x] T055 [P] ThemeController in lib/presentation/controllers/theme_controller.dart
- [x] T056 [P] NavigationController in lib/presentation/controllers/navigation_controller.dart
- [x] T057 [P] HomeBinding in lib/presentation/bindings/home_binding.dart
- [x] T058 [P] ProductsBinding in lib/presentation/bindings/products_binding.dart
- [x] T059 [P] SearchBinding in lib/presentation/bindings/search_binding.dart
- [x] T060 [P] FavoritesBinding in lib/presentation/bindings/favorites_binding.dart
- [x] T061 [P] ProfileBinding in lib/presentation/bindings/profile_binding.dart
- [x] T062 [P] AppRoutes in lib/routes/app_routes.dart
- [x] T063 [P] AppPages in lib/routes/app_pages.dart

## Phase 3.7: UI Implementation
- [x] T064 [P] Light theme configuration in lib/themes/light_theme.dart
- [x] T065 [P] Dark theme configuration in lib/themes/dark_theme.dart
- [x] T066 [P] Theme manager in lib/themes/theme_manager.dart
- [x] T067 [P] Responsive widgets in lib/presentation/widgets/responsive/
- [x] T068 [P] Custom app bars in lib/presentation/widgets/app_bars/
- [x] T069 [P] Product widgets in lib/presentation/widgets/products/
- [x] T070 [P] Empty state widgets in lib/presentation/widgets/empty_states/
- [x] T071 [P] Home page in lib/presentation/pages/home_page.dart
- [x] T072 [P] Products page in lib/presentation/pages/products_page.dart
- [x] T073 [P] Search page in lib/presentation/pages/search_page.dart
- [x] T074 [P] Favorites page in lib/presentation/pages/favorites_page.dart
- [x] T075 [P] Profile page in lib/presentation/pages/profile_page.dart
- [x] T076 [P] Settings page in lib/presentation/pages/settings_page.dart
- [x] T077 [P] Product detail page in lib/presentation/pages/product_detail_page.dart
- [x] T078 [P] Main app with GetMaterialApp in lib/main.dart

## Phase 3.8: Integration
- [x] T079 Connect Dio API client to remote data sources
- [x] T080 Connect SharedPreferences to local data sources
- [x] T081 Implement factory pattern for repository switching
- [x] T082 Connect GetX controllers to use cases
- [x] T083 Connect GetX bindings to controllers
- [x] T084 Connect GetX routing to pages
- [x] T085 Implement responsive design calculations
- [x] T086 Implement theme persistence
- [x] T087 Implement empty state handling
- [x] T088 Implement error handling and logging

## Phase 3.9: Polish
- [x] T089 [P] Unit tests for controllers in test/unit/controllers/
- [x] T090 [P] Unit tests for use cases in test/unit/usecases/
- [x] T091 [P] Unit tests for repositories in test/unit/repositories/
- [x] T092 [P] Unit tests for data sources in test/unit/datasources/
- [x] T093 [P] Unit tests for models in test/unit/models/
- [x] T094 [P] Unit tests for widgets in test/unit/widgets/
- [x] T095 Performance tests (<2s startup, 60fps UI, <200ms API)
- [x] T096 [P] Update README.md with setup instructions
- [x] T097 [P] Update API documentation
- [x] T098 Remove code duplication and optimize
- [x] T099 Run quickstart.md validation steps
- [x] T100 Final integration testing and deployment preparation

## Dependencies
- Tests (T004-T011) before implementation (T012-T088)
- Entities (T012-T016) before models (T017-T021)
- Models (T017-T021) before data sources (T040-T045)
- Data sources (T040-T045) before repositories (T046-T049)
- Repositories (T046-T049) before use cases (T031-T039)
- Use cases (T031-T039) before controllers (T050-T056)
- Controllers (T050-T056) before bindings (T057-T061)
- Bindings (T057-T061) before pages (T071-T077)
- Themes (T064-T066) before UI implementation (T067-T077)
- All implementation before polish (T089-T100)

## Parallel Execution Examples

### Phase 3.2: Contract and Integration Tests (T004-T011)
```
# Launch all tests together:
Task: "Contract test API endpoints in test/contract/api_contract_tests.dart"
Task: "Integration test Home screen featured products in test/integration/test_home_screen.dart"
Task: "Integration test Products tab navigation in test/integration/test_products_tab.dart"
Task: "Integration test Search functionality in test/integration/test_search_tab.dart"
Task: "Integration test Favorites management in test/integration/test_favorites_tab.dart"
Task: "Integration test Profile and settings in test/integration/test_profile_tab.dart"
Task: "Integration test Theme switching in test/integration/test_theme_switching.dart"
Task: "Integration test Custom app bars in test/integration/test_app_bars.dart"
```

### Phase 3.3: Entities and Models (T012-T026)
```
# Launch entities and models together:
Task: "Product entity in lib/domain/entities/product.dart"
Task: "Category entity in lib/domain/entities/category.dart"
Task: "ThemeSettings entity in lib/domain/entities/theme_settings.dart"
Task: "UserPreferences entity in lib/domain/entities/user_preferences.dart"
Task: "NavigationState entity in lib/domain/entities/navigation_state.dart"
Task: "ProductModel with JSON serialization in lib/data/models/product_model.dart"
Task: "CategoryModel with JSON serialization in lib/data/models/category_model.dart"
Task: "ThemeSettingsModel with JSON serialization in lib/data/models/theme_settings_model.dart"
Task: "UserPreferencesModel with JSON serialization in lib/data/models/user_preferences_model.dart"
Task: "NavigationStateModel with JSON serialization in lib/data/models/navigation_state_model.dart"
Task: "Mock product data JSON files in assets/json/products.json"
Task: "Mock category data JSON files in assets/json/categories.json"
Task: "API client with Dio interceptors in lib/core/network/api_client.dart"
Task: "Error handling classes in lib/core/errors/"
Task: "Constants and utilities in lib/core/constants/ and lib/core/utils/"
```

### Phase 3.4: Domain Layer (T027-T039)
```
# Launch domain layer together:
Task: "ProductRepository interface in lib/domain/repositories/product_repository.dart"
Task: "CategoryRepository interface in lib/domain/repositories/category_repository.dart"
Task: "ThemeRepository interface in lib/domain/repositories/theme_repository.dart"
Task: "UserPreferencesRepository interface in lib/domain/repositories/user_preferences_repository.dart"
Task: "GetFeaturedProducts use case in lib/domain/usecases/get_featured_products.dart"
Task: "GetProducts use case in lib/domain/usecases/get_products.dart"
Task: "GetProductById use case in lib/domain/usecases/get_product_by_id.dart"
Task: "GetCategories use case in lib/domain/usecases/get_categories.dart"
Task: "SearchProducts use case in lib/domain/usecases/search_products.dart"
Task: "ToggleFavorite use case in lib/domain/usecases/toggle_favorite.dart"
Task: "GetFavorites use case in lib/domain/usecases/get_favorites.dart"
Task: "ToggleTheme use case in lib/domain/usecases/toggle_theme.dart"
Task: "GetThemeSettings use case in lib/domain/usecases/get_theme_settings.dart"
```

### Phase 3.5: Data Layer (T040-T049)
```
# Launch data layer together:
Task: "LocalProductDataSource in lib/data/datasources/local/product_local_datasource.dart"
Task: "RemoteProductDataSource in lib/data/datasources/remote/product_remote_datasource.dart"
Task: "LocalCategoryDataSource in lib/data/datasources/local/category_local_datasource.dart"
Task: "RemoteCategoryDataSource in lib/data/datasources/remote/category_remote_datasource.dart"
Task: "LocalThemeDataSource in lib/data/datasources/local/theme_local_datasource.dart"
Task: "LocalUserPreferencesDataSource in lib/data/datasources/local/user_preferences_local_datasource.dart"
Task: "ProductRepositoryImpl in lib/data/repositories/product_repository_impl.dart"
Task: "CategoryRepositoryImpl in lib/data/repositories/category_repository_impl.dart"
Task: "ThemeRepositoryImpl in lib/data/repositories/theme_repository_impl.dart"
Task: "UserPreferencesRepositoryImpl in lib/data/repositories/user_preferences_repository_impl.dart"
```

### Phase 3.6: Presentation Layer (T050-T063)
```
# Launch presentation layer together:
Task: "HomeController in lib/presentation/controllers/home_controller.dart"
Task: "ProductsController in lib/presentation/controllers/products_controller.dart"
Task: "SearchController in lib/presentation/controllers/search_controller.dart"
Task: "FavoritesController in lib/presentation/controllers/favorites_controller.dart"
Task: "ProfileController in lib/presentation/controllers/profile_controller.dart"
Task: "ThemeController in lib/presentation/controllers/theme_controller.dart"
Task: "NavigationController in lib/presentation/controllers/navigation_controller.dart"
Task: "HomeBinding in lib/presentation/bindings/home_binding.dart"
Task: "ProductsBinding in lib/presentation/bindings/products_binding.dart"
Task: "SearchBinding in lib/presentation/bindings/search_binding.dart"
Task: "FavoritesBinding in lib/presentation/bindings/favorites_binding.dart"
Task: "ProfileBinding in lib/presentation/bindings/profile_binding.dart"
Task: "AppRoutes in lib/routes/app_routes.dart"
Task: "AppPages in lib/routes/app_pages.dart"
```

### Phase 3.7: UI Implementation (T064-T078)
```
# Launch UI components together:
Task: "Light theme configuration in lib/themes/light_theme.dart"
Task: "Dark theme configuration in lib/themes/dark_theme.dart"
Task: "Theme manager in lib/themes/theme_manager.dart"
Task: "Responsive widgets in lib/presentation/widgets/responsive/"
Task: "Custom app bars in lib/presentation/widgets/app_bars/"
Task: "Product widgets in lib/presentation/widgets/products/"
Task: "Empty state widgets in lib/presentation/widgets/empty_states/"
Task: "Home page in lib/presentation/pages/home_page.dart"
Task: "Products page in lib/presentation/pages/products_page.dart"
Task: "Search page in lib/presentation/pages/search_page.dart"
Task: "Favorites page in lib/presentation/pages/favorites_page.dart"
Task: "Profile page in lib/presentation/pages/profile_page.dart"
Task: "Settings page in lib/presentation/pages/settings_page.dart"
Task: "Product detail page in lib/presentation/pages/product_detail_page.dart"
Task: "Main app with GetMaterialApp in lib/main.dart"
```

### Phase 3.9: Unit Tests (T089-T094)
```
# Launch unit tests together:
Task: "Unit tests for controllers in test/unit/controllers/"
Task: "Unit tests for use cases in test/unit/usecases/"
Task: "Unit tests for repositories in test/unit/repositories/"
Task: "Unit tests for data sources in test/unit/datasources/"
Task: "Unit tests for models in test/unit/models/"
Task: "Unit tests for widgets in test/unit/widgets/"
```

## Notes
- [P] tasks = different files, no dependencies
- Verify tests fail before implementing
- Commit after each task
- Avoid: vague tasks, same file conflicts
- Follow Clean Architecture principles
- Use GetX patterns consistently
- Implement responsive design for all screen sizes
- Use Dio for HTTP client with interceptors

## Task Generation Rules
*Applied during main() execution*

1. **From Contracts**:
   - API contract file → contract test task [P]
   - Each endpoint → implementation task
   
2. **From Data Model**:
   - Each entity → model creation task [P]
   - Relationships → service layer tasks
   
3. **From User Stories**:
   - Each story → integration test [P]
   - Quickstart scenarios → validation tasks

4. **Ordering**:
   - Setup → Tests → Models → Services → Endpoints → Polish
   - Dependencies block parallel execution

## Validation Checklist
*GATE: Checked by main() before returning*

- [x] All contracts have corresponding tests
- [x] All entities have model tasks
- [x] All tests come before implementation
- [x] Parallel tasks truly independent
- [x] Each task specifies exact file path
- [x] No task modifies same file as another [P] task
- [x] Clean Architecture layers properly ordered
- [x] GetX patterns consistently applied
- [x] Responsive design considerations included
- [x] Theme switching implementation covered
- [x] Empty state handling included
- [x] Performance targets addressed

## 🎉 PROJECT COMPLETION STATUS

**✅ ALL 100 TASKS COMPLETED SUCCESSFULLY!**

### 📊 Completion Summary:
- **Phase 3.1: Setup** - 3/3 tasks ✅ (100%)
- **Phase 3.2: Tests First (TDD)** - 8/8 tasks ✅ (100%)
- **Phase 3.3: Core Implementation** - 15/15 tasks ✅ (100%)
- **Phase 3.4: Domain Layer** - 13/13 tasks ✅ (100%)
- **Phase 3.5: Data Layer** - 10/10 tasks ✅ (100%)
- **Phase 3.6: Presentation Layer** - 14/14 tasks ✅ (100%)
- **Phase 3.7: UI Implementation** - 15/15 tasks ✅ (100%)
- **Phase 3.8: Integration** - 10/10 tasks ✅ (100%)
- **Phase 3.9: Polish** - 12/12 tasks ✅ (100%)

### 🏆 Total: 100/100 Tasks Completed (100%)

### 🚀 Mobile Application Features Delivered:
- ✅ **5-Tab Navigation System** (Home, Products, Search, Favorites, Profile)
- ✅ **Product Management** (Listing, Detail, Search, Favorites)
- ✅ **Search & Filtering** (Real-time search, category filters)
- ✅ **User Interface** (Profile, Settings, Theme switching)
- ✅ **Clean Architecture** (Presentation, Domain, Data layers)
- ✅ **State Management** (GetX controllers and reactive programming)
- ✅ **Data Persistence** (SharedPreferences for user preferences)
- ✅ **API Integration** (Dio HTTP client with interceptors)
- ✅ **Mock Data** (JSON files for development and testing)
- ✅ **Comprehensive Testing** (Unit, Widget, Integration, Performance, Accessibility, E2E tests)
- ✅ **Responsive Design** (Adaptive layouts for different screen sizes)
- ✅ **Theme System** (Light/Dark theme with persistence)
- ✅ **Test Automation** (Automated test runner script)

### 🎯 Ready for Production:
The IT Shop Mobile Application is now **100% complete** and ready for:
- **Development Testing**: `flutter run`
- **Automated Testing**: `./run_tests.sh`
- **Production Build**: `flutter build apk` / `flutter build ios`
- **App Store Deployment**

**Project Status: COMPLETED SUCCESSFULLY** 🎉✨
