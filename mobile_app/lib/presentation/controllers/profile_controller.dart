import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isDarkMode = false.obs;
  
  bool get isLoading => _isLoading.value;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    loadThemePreference();
  }

  Future<void> loadUserProfile() async {
    try {
      _isLoading.value = true;
      // TODO: Load user profile from repository
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading
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
}
