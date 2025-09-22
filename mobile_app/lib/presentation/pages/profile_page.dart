import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_card.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';
import 'package:mobile_app/presentation/controllers/auth_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // เรียกใช้ controller.onInit() เมื่อ widget ถูกสร้าง
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.initialized) {
        controller.onInit();
      }
    });
    final glass = Theme.of(context).extension<GlassTheme>()!;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'กำลังโหลดข้อมูลโปรไฟล์',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // เฉพาะส่วนที่เกี่ยวกับผู้ใช้ ให้แสดงเมื่อเข้าสู่ระบบแล้วเท่านั้น
              GetX<AuthController>(
                builder: (auth) {
                  if (!auth.isInitialized || !auth.isSignedIn) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      // Profile Header
                      _buildProfileHeader(context),
                      const SizedBox(height: 24),
                      // Profile Menu Items (ที่เกี่ยวกับผู้ใช้)
                      _buildMenuItems(context),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
              
              // Theme Toggle - ใช้ Obx สำหรับ theme changes
              Obx(() => _buildThemeToggle(context, controller)),
              
              const SizedBox(height: 24),
              
              // App Info
              _buildAppInfo(context),
            ],
          ),
        ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue[100],
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.blue[600],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // User Name
          Text(
            controller.userName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // User Email
          Text(
            controller.userEmail,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(context, 'รายการโปรด', controller.favoriteCount.toString()),
              _buildStatItem(context, 'คำสั่งซื้อ', controller.orderCount.toString()),
              _buildStatItem(context, 'รีวิว', controller.reviewCount.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context: context,
          icon: Icons.shopping_bag,
          title: 'คำสั่งซื้อของฉัน',
          subtitle: 'ดูประวัติการสั่งซื้อ',
          onTap: () {
            Get.snackbar('คำสั่งซื้อ', 'กำลังโหลดประวัติการสั่งซื้อ');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.favorite,
          title: 'รายการโปรด',
          subtitle: 'สินค้าที่คุณชอบ',
          onTap: () => Get.toNamed('/favorites'),
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.star,
          title: 'รีวิวของฉัน',
          subtitle: 'รีวิวที่คุณเขียน',
          onTap: () {
            Get.snackbar('รีวิว', 'กำลังโหลดรีวิวของคุณ');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.notifications,
          title: 'การแจ้งเตือน',
          subtitle: 'จัดการการแจ้งเตือน',
          onTap: () {
            Get.snackbar('การแจ้งเตือน', 'กำลังเปิดการตั้งค่าการแจ้งเตือน');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.help,
          title: 'ช่วยเหลือ',
          subtitle: 'คำถามที่พบบ่อย',
          onTap: () {
            Get.snackbar('ช่วยเหลือ', 'กำลังเปิดหน้าช่วยเหลือ');
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, ProfileController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      child: ListTile(
        leading: Icon(
          controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.orange,
        ),
        title: Text(
          'ธีม',
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
          ),
        ),
        subtitle: Text(
          controller.isDarkMode ? 'โหมดมืด' : 'โหมดสว่าง',
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: controller.isDarkMode,
          onChanged: (value) => controller.toggleTheme(),
        ),
      ),
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // App Name
          Text(
            controller.appName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // App Version
          Text(
            'เวอร์ชัน ${controller.appVersion}',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          // App Description
          Text(
            controller.appDescription,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white.withOpacity(0.6) : Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}