import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/profile_controller.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_card.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class SettingsPage extends GetView<ProfileController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    return Container(
      decoration: BoxDecoration(
        gradient: glass.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: 'Settings',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theme Settings
              _buildSectionTitle('การแสดงผล'),
              _buildThemeSettings(controller, glass),
              
              const SizedBox(height: 24),
              
              // App Settings
              _buildSectionTitle('การตั้งค่าแอป'),
              _buildAppSettings(glass),
              
              const SizedBox(height: 24),
              
              // Account Settings
              _buildSectionTitle('บัญชีผู้ใช้'),
              _buildAccountSettings(glass),
              
              const SizedBox(height: 24),
              
              // About
              _buildSectionTitle('เกี่ยวกับ'),
              _buildAboutSection(glass),
            ],
        
          ),
        ),
        ),
      ),
    );
  }
  
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeSettings(ProfileController controller, GlassTheme glass) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
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
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.palette, color: Colors.purple),
            title: const Text('สีหลัก'),
            subtitle: const Text('สีน้ำเงิน'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('สีหลัก', 'ฟีเจอร์นี้จะมาในเวอร์ชันถัดไป');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings(GlassTheme glass) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.blue),
            title: const Text('การแจ้งเตือน'),
            subtitle: const Text('เปิดใช้งาน'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                Get.snackbar('การแจ้งเตือน', 'กำลังอัพเดทการตั้งค่า');
              },
            ),
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.green),
            title: const Text('ภาษา'),
            subtitle: const Text('ไทย'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ภาษา', 'ฟีเจอร์นี้จะมาในเวอร์ชันถัดไป');
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.storage, color: Colors.orange),
            title: const Text('การจัดเก็บข้อมูล'),
            subtitle: const Text('จัดการข้อมูลแคช'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('การจัดเก็บข้อมูล', 'กำลังเปิดหน้าจัดการข้อมูล');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings(GlassTheme glass) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('ข้อมูลส่วนตัว'),
            subtitle: const Text('แก้ไขข้อมูลโปรไฟล์'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ข้อมูลส่วนตัว', 'กำลังเปิดหน้าแก้ไขข้อมูล');
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.red),
            title: const Text('ความปลอดภัย'),
            subtitle: const Text('เปลี่ยนรหัสผ่าน'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ความปลอดภัย', 'กำลังเปิดหน้าการตั้งค่าความปลอดภัย');
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text('ความเป็นส่วนตัว'),
            subtitle: const Text('การตั้งค่าความเป็นส่วนตัว'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ความเป็นส่วนตัว', 'กำลังเปิดหน้าการตั้งค่าความเป็นส่วนตัว');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(GlassTheme glass) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('เกี่ยวกับแอป'),
            subtitle: const Text('IT Shop v1.0.0'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showAboutDialog();
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.green),
            title: const Text('ช่วยเหลือ'),
            subtitle: const Text('คำถามที่พบบ่อย'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ช่วยเหลือ', 'กำลังเปิดหน้าช่วยเหลือ');
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.feedback, color: Colors.orange),
            title: const Text('ส่งข้อเสนอแนะ'),
            subtitle: const Text('แจ้งปัญหาหรือข้อเสนอแนะ'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ส่งข้อเสนอแนะ', 'กำลังเปิดหน้าส่งข้อเสนอแนะ');
            },
          ),
          Divider(height: 1, color: glass.borderColor),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text('ให้คะแนนแอป'),
            subtitle: const Text('ให้คะแนนใน App Store'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar('ให้คะแนนแอป', 'กำลังเปิด App Store');
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เกี่ยวกับ IT Shop'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('เวอร์ชัน: 1.0.0'),
              SizedBox(height: 8),
              Text('แอปพลิเคชันสำหรับการขายสินค้า IT'),
              SizedBox(height: 8),
              Text('พัฒนาโดย: IT Shop Team'),
              SizedBox(height: 8),
              Text('© 2024 IT Shop. All rights reserved.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }
