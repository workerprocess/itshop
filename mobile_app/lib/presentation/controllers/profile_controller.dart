import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isDarkMode = false.obs;
  final RxString _userName = 'ผู้ใช้ IT Shop'.obs;
  final RxString _userEmail = 'user@itshop.com'.obs;
  final RxInt _favoriteCount = 12.obs;
  final RxInt _orderCount = 5.obs;
  final RxInt _reviewCount = 8.obs;
  final RxString _appName = 'IT Shop'.obs;
  final RxString _appVersion = '1.0.0'.obs;
  final RxString _appDescription = 'แอปพลิเคชันสำหรับการขายสินค้า IT'.obs;
  final RxBool _initialized = false.obs;
  
  bool get isLoading => _isLoading.value;
  bool get isDarkMode => _isDarkMode.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  int get favoriteCount => _favoriteCount.value;
  int get orderCount => _orderCount.value;
  int get reviewCount => _reviewCount.value;
  String get appName => _appName.value;
  String get appVersion => _appVersion.value;
  String get appDescription => _appDescription.value;
  bool get initialized => _initialized.value;

  @override
  void onInit() {
    super.onInit();
    _initialized.value = true;
    loadUserProfile();
    loadThemePreference();
  }

  Future<void> loadUserProfile() async {
    try {
      _isLoading.value = true;
      // TODO: Load user profile from repository
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading
      
      // Simulate loading user data
      _userName.value = 'ผู้ใช้ IT Shop';
      _userEmail.value = 'user@itshop.com';
      _favoriteCount.value = 12;
      _orderCount.value = 5;
      _reviewCount.value = 8;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
      
      // Apply theme
      Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    } catch (e) {
      print('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      _isDarkMode.value = !_isDarkMode.value;
      
      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode.value);
      
      // Apply theme
      Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      
      Get.snackbar(
        'เปลี่ยนธีม',
        _isDarkMode.value ? 'เปลี่ยนเป็นโหมดมืดแล้ว' : 'เปลี่ยนเป็นโหมดสว่างแล้ว',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error toggling theme: $e');
    }
  }

  // Methods for updating user info
  void updateUserName(String name) {
    _userName.value = name;
  }

  void updateUserEmail(String email) {
    _userEmail.value = email;
  }

  void updateFavoriteCount(int count) {
    _favoriteCount.value = count;
  }

  void updateOrderCount(int count) {
    _orderCount.value = count;
  }

  void updateReviewCount(int count) {
    _reviewCount.value = count;
  }

  // Methods for updating app info
  void updateAppName(String name) {
    _appName.value = name;
  }

  void updateAppVersion(String version) {
    _appVersion.value = version;
  }

  void updateAppDescription(String description) {
    _appDescription.value = description;
  }

  // Method to refresh all data
  Future<void> refreshData() async {
    await loadUserProfile();
    await loadThemePreference();
  }
}
