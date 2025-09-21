# Data Model: Mobile Application สำหรับการขายสินค้า IT

**Feature**: 001-mobile-application-it  
**Date**: 2024-12-19  
**Status**: Complete

## Entity Definitions

### Product Entity
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final String brand;
  final Map<String, dynamic> specifications;
  final bool isRecommended;
  final bool isBestSeller;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

**Validation Rules**:
- ID must be non-empty string
- Name must be 3-100 characters
- Price must be positive number
- Category must match IT classification standards
- Images must be valid URLs
- Rating must be 0.0-5.0

### Category Entity
```dart
class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String parentId;
  final List<String> subcategories;
  final int productCount;
  final bool isActive;
}
```

**Validation Rules**:
- ID must be non-empty string
- Name must be 2-50 characters
- Must follow international IT classification standards
- Icon must be valid asset path

### ThemeSettings Entity
```dart
class ThemeSettings {
  final bool isDarkMode;
  final String primaryColor;
  final String secondaryColor;
  final double fontSize;
  final String fontFamily;
  final DateTime lastUpdated;
}
```

**Validation Rules**:
- Colors must be valid hex codes
- Font size must be 12-24
- Font family must be supported

### UserPreferences Entity
```dart
class UserPreferences {
  final String userId;
  final List<String> favoriteProductIds;
  final Map<String, dynamic> searchHistory;
  final String preferredLanguage;
  final bool notificationsEnabled;
  final DateTime lastLogin;
}
```

**Validation Rules**:
- User ID must be valid format
- Language must be supported (th, en)
- Search history must be limited to 50 items

### NavigationState Entity
```dart
class NavigationState {
  final int currentIndex;
  final String currentRoute;
  final Map<String, dynamic> routeParams;
  final List<String> navigationHistory;
  final bool isBottomNavVisible;
}
```

**Validation Rules**:
- Current index must be 0-4 (5 tabs)
- Route must be valid app route
- Navigation history limited to 20 items

## Data Models (JSON Serialization)

### Product Model
```dart
class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String category,
    required List<String> images,
    required String brand,
    required Map<String, dynamic> specifications,
    required bool isRecommended,
    required bool isBestSeller,
    required double rating,
    required int reviewCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(/* ... */);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      images: List<String>.from(json['images']),
      brand: json['brand'] as String,
      specifications: Map<String, dynamic>.from(json['specifications']),
      isRecommended: json['isRecommended'] as bool,
      isBestSeller: json['isBestSeller'] as bool,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'brand': brand,
      'specifications': specifications,
      'isRecommended': isRecommended,
      'isBestSeller': isBestSeller,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
```

### Category Model
```dart
class CategoryModel extends Category {
  CategoryModel({
    required String id,
    required String name,
    required String description,
    required String icon,
    required String parentId,
    required List<String> subcategories,
    required int productCount,
    required bool isActive,
  }) : super(/* ... */);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      parentId: json['parentId'] as String,
      subcategories: List<String>.from(json['subcategories']),
      productCount: json['productCount'] as int,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'parentId': parentId,
      'subcategories': subcategories,
      'productCount': productCount,
      'isActive': isActive,
    };
  }
}
```

## State Transitions

### Product Loading States
```
Initial → Loading → Loaded → Error
   ↓         ↓        ↓       ↓
 Empty   Loading   Success  Retry
```

### Theme Switching States
```
Light → Switching → Dark
  ↓        ↓         ↓
Save   Transition  Save
```

### Navigation States
```
Tab0 → Tab1 → Tab2 → Tab3 → Tab4
 ↓     ↓      ↓      ↓      ↓
Home Products Search Favorites Profile
```

## Data Validation

### Product Validation
- Name: Required, 3-100 characters
- Price: Required, positive number
- Category: Required, valid IT category
- Images: Required, at least 1 image
- Rating: Optional, 0.0-5.0 range

### Category Validation
- Name: Required, 2-50 characters
- Icon: Required, valid asset path
- Product Count: Non-negative integer

### Theme Validation
- Colors: Valid hex format (#RRGGBB)
- Font Size: 12-24 range
- Font Family: Supported font

## Error Handling

### Data Loading Errors
- NetworkError: API connection issues
- ParseError: JSON parsing failures
- ValidationError: Data validation failures
- NotFoundError: Empty results

### State Management Errors
- NavigationError: Invalid route transitions
- ThemeError: Theme switching failures
- PreferenceError: Settings persistence failures

## Mock Data Structure

### Sample Product JSON
```json
{
  "id": "prod_001",
  "name": "MacBook Pro 16-inch",
  "description": "Powerful laptop for professionals",
  "price": 89990.00,
  "category": "computers",
  "images": ["https://example.com/macbook1.jpg"],
  "brand": "Apple",
  "specifications": {
    "processor": "M2 Pro",
    "memory": "16GB",
    "storage": "512GB SSD"
  },
  "isRecommended": true,
  "isBestSeller": true,
  "rating": 4.8,
  "reviewCount": 1250,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-12-19T00:00:00Z"
}
```

### Sample Category JSON
```json
{
  "id": "cat_001",
  "name": "Computers",
  "description": "Laptops, desktops, and workstations",
  "icon": "assets/icons/computer.svg",
  "parentId": "",
  "subcategories": ["laptops", "desktops", "workstations"],
  "productCount": 45,
  "isActive": true
}
```

## Database Schema (if needed)

### Products Table
```sql
CREATE TABLE products (
  id VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  category VARCHAR(50) NOT NULL,
  images JSON,
  brand VARCHAR(50),
  specifications JSON,
  is_recommended BOOLEAN DEFAULT FALSE,
  is_best_seller BOOLEAN DEFAULT FALSE,
  rating DECIMAL(2,1) DEFAULT 0.0,
  review_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Categories Table
```sql
CREATE TABLE categories (
  id VARCHAR(50) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  icon VARCHAR(100),
  parent_id VARCHAR(50),
  subcategories JSON,
  product_count INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE
);
```

## API Response Formats

### Product List Response
```json
{
  "success": true,
  "data": {
    "products": [...],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 100,
      "hasNext": true
    }
  },
  "message": "Products retrieved successfully"
}
```

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "PRODUCT_NOT_FOUND",
    "message": "Product not found",
    "details": "Product with ID 'prod_001' does not exist"
  }
}
```
