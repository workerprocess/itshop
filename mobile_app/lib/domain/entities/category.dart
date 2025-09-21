class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String parentId;
  final List<String> subcategories;
  final int productCount;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.parentId,
    required this.subcategories,
    required this.productCount,
    required this.isActive,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, productCount: $productCount)';
  }
}
