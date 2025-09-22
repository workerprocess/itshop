import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static const String _prefKeyIsSignedIn = 'isSignedIn';
  static const String _prefKeyUserName = 'userName';
  static const String _prefKeyUserEmail = 'userEmail';

  final RxBool _isSignedIn = false.obs;
  final RxString _userName = ''.obs;
  final RxString _userEmail = ''.obs;
  final RxBool _isInitialized = false.obs;

  bool get isSignedIn => _isSignedIn.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  bool get isInitialized => _isInitialized.value;

  @override
  void onInit() {
    super.onInit();
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isSignedIn.value = prefs.getBool(_prefKeyIsSignedIn) ?? false;
      _userName.value = prefs.getString(_prefKeyUserName) ?? '';
      _userEmail.value = prefs.getString(_prefKeyUserEmail) ?? '';
    } catch (e) {
      // ignore
    } finally {
      _isInitialized.value = true;
    }
  }

  Future<void> setSignedIn({required String name, required String email}) async {
    _isSignedIn.value = true;
    _userName.value = name;
    _userEmail.value = email;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyIsSignedIn, true);
    await prefs.setString(_prefKeyUserName, name);
    await prefs.setString(_prefKeyUserEmail, email);
  }

  Future<void> signOut() async {
    _isSignedIn.value = false;
    _userName.value = '';
    _userEmail.value = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyIsSignedIn, false);
    await prefs.remove(_prefKeyUserName);
    await prefs.remove(_prefKeyUserEmail);
  }
}


