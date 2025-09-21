import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/root_controller.dart';
import 'package:mobile_app/presentation/pages/home_page.dart';
import 'package:mobile_app/presentation/pages/products_page.dart';
import 'package:mobile_app/presentation/pages/search_page.dart';
import 'package:mobile_app/presentation/pages/favorites_page.dart';
import 'package:mobile_app/presentation/pages/profile_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: (controller) => Scaffold(
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
          onTap: controller.changeTab,
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
      ),
    );
  }
}
