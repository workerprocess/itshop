import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    
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
              // Profile Header
              _buildProfileHeader(),
              
              const SizedBox(height: 24),
              
              // Profile Menu Items
              _buildMenuItems(),
              
              const SizedBox(height: 24),
              
              // Theme Toggle
              _buildThemeToggle(controller),
              
              const SizedBox(height: 24),
              
              // App Info
              _buildAppInfo(),
            ],
          ),
        ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
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
          const Text(
            'ผู้ใช้ IT Shop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // User Email
          Text(
            'user@itshop.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('รายการโปรด', '12'),
              _buildStatItem('คำสั่งซื้อ', '5'),
              _buildStatItem('รีวิว', '8'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
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
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.shopping_bag,
          title: 'คำสั่งซื้อของฉัน',
          subtitle: 'ดูประวัติการสั่งซื้อ',
          onTap: () {
            Get.snackbar('คำสั่งซื้อ', 'กำลังโหลดประวัติการสั่งซื้อ');
          },
        ),
        _buildMenuItem(
          icon: Icons.favorite,
          title: 'รายการโปรด',
          subtitle: 'สินค้าที่คุณชอบ',
          onTap: () => Get.toNamed('/favorites'),
        ),
        _buildMenuItem(
          icon: Icons.star,
          title: 'รีวิวของฉัน',
          subtitle: 'รีวิวที่คุณเขียน',
          onTap: () {
            Get.snackbar('รีวิว', 'กำลังโหลดรีวิวของคุณ');
          },
        ),
        _buildMenuItem(
          icon: Icons.notifications,
          title: 'การแจ้งเตือน',
          subtitle: 'จัดการการแจ้งเตือน',
          onTap: () {
            Get.snackbar('การแจ้งเตือน', 'กำลังเปิดการตั้งค่าการแจ้งเตือน');
          },
        ),
        _buildMenuItem(
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
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildThemeToggle(ProfileController controller) {
    return Card(
      child: ListTile(
        leading: Icon(
          controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.orange,
        ),
        title: const Text('ธีม'),
        subtitle: Text(controller.isDarkMode ? 'โหมดมืด' : 'โหมดสว่าง'),
        trailing: Switch(
          value: controller.isDarkMode,
          onChanged: (value) => controller.toggleTheme(),
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'IT Shop',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'เวอร์ชัน 1.0.0',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'แอปพลิเคชันสำหรับการขายสินค้า IT',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}