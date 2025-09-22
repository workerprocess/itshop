import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/auth_controller.dart';

class SigninController extends GetxController {
  final RxBool _isSigningIn = false.obs;
  final RxBool _hasAcceptedPdpa = false.obs;
  String? _errorMessage;

  bool get isSigningIn => _isSigningIn.value;
  bool get hasAcceptedPdpa => _hasAcceptedPdpa.value;
  String? get errorMessage => _errorMessage;

  void setPdpaAccepted(bool accepted) {
    _hasAcceptedPdpa.value = accepted;
  }

  Future<void> signInWithGoogle() async {
    try {
      if (!hasAcceptedPdpa) {
        _errorMessage = 'กรุณายอมรับเงื่อนไขการคุ้มครองข้อมูลส่วนบุคคล (PDPA) ก่อนเข้าสู่ระบบ';
        Get.snackbar('ต้องยอมรับ PDPA', _errorMessage!);
        return;
      }
      _isSigningIn.value = true;
      _errorMessage = null;
      // TODO: Integrate actual Google Sign-In SDK / Firebase Auth here
      await Future.delayed(const Duration(seconds: 1));
      // On success, navigate or update state as needed
      final auth = Get.find<AuthController>();
      await auth.setSignedIn(name: 'IT Shop User', email: 'user@itshop.com');
      Get.back();
      Get.snackbar('สำเร็จ', 'เข้าสู่ระบบด้วย Google สำเร็จ');
    } catch (e) {
      _errorMessage = 'เกิดข้อผิดพลาด: $e';
      Get.snackbar('ล้มเหลว', _errorMessage!);
    } finally {
      _isSigningIn.value = false;
    }
  }
}


