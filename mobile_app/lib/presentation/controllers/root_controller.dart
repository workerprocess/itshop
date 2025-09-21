import 'package:get/get.dart';

class RootController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  
  int get currentIndex => _currentIndex.value;
  
  void changeTab(int index) {
    _currentIndex.value = index;
  }
}
