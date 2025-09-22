import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/presentation/controllers/signin_controller.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_container.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';

class SigninPage extends GetView<SigninController> {
  const SigninPage({super.key});

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
        appBar: const GlassAppBar(
          title: 'Sign in',
        ),
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Center(
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Welcome + Sign-in block (match width with policy block)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'เข้าสู่ระบบเพื่อเริ่มใช้งาน',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (controller.errorMessage != null) ...[
                            Text(
                              controller.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 16),
                          ],
                          SizedBox(
                            width: 280,
                            height: 48,
                            child: ElevatedButton.icon(
                              icon: Image.network(
                                'https://developers.google.com/identity/images/g-logo.png',
                                width: 20,
                                height: 20,
                              ),
                              label: Text(controller.isSigningIn ? 'กำลังเข้าสู่ระบบ...' : 'Sign in with Google'),
                              onPressed: (controller.isSigningIn || !controller.hasAcceptedPdpa)
                                  ? null
                                  : () => controller.signInWithGoogle(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.black.withOpacity(0.08)),
                                ),
                                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // PDPA Consent block (separate)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(14),
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        height: 280,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            child: Builder(
                              builder: (context) {
                                const appName = 'IT Shop';
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'PDPA Consent',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                    ),
                                    const Text(
                                      'TH:',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'เพื่อปฏิบัติตามพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล (PDPA) แอป IT Shop ขอเก็บ รวบรวม และใช้ข้อมูลส่วนบุคคลของคุณ เช่น ชื่อ-นามสกุล อีเมล เบอร์โทรศัพท์ และข้อมูลการใช้งาน เพื่อ:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text('• การสร้างและจัดการบัญชีผู้ใช้', style: TextStyle(fontSize: 12)),
                                    const Text('• การให้บริการและปรับปรุงประสบการณ์การใช้งาน', style: TextStyle(fontSize: 12)),
                                    const Text('• การติดต่อสื่อสารและส่งข้อมูลสำคัญเกี่ยวกับบริการ', style: TextStyle(fontSize: 12)),
                                    const Text('• การปฏิบัติตามข้อกฎหมาย', style: TextStyle(fontSize: 12)),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'คุณมีสิทธิ์ในการเข้าถึง แก้ไข ลบข้อมูล หรือถอนความยินยอมได้ตลอดเวลา ตามที่ระบุใน นโยบายความเป็นส่วนตัว',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // TODO: นำทางไปหน้าหรือลิงก์นโยบายความเป็นส่วนตัว
                                          },
                                          child: const Text('เปิด'),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'EN:',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'In compliance with the Personal Data Protection Act (PDPA), IT Shop requests your consent to collect, process, and use your personal data, such as full name, email, phone number, and usage information, for the following purposes:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text('• Creating and managing your user account', style: TextStyle(fontSize: 12)),
                                    const Text('• Providing and improving the service experience', style: TextStyle(fontSize: 12)),
                                    const Text('• Communicating and sending important service-related information', style: TextStyle(fontSize: 12)),
                                    const Text('• Complying with applicable legal requirements', style: TextStyle(fontSize: 12)),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'You have the right to access, correct, delete, or withdraw your consent at any time as specified in the Privacy Policy.',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // TODO: Navigate to Privacy Policy
                                          },
                                          child: const Text('Open'),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(() => CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          controlAffinity: ListTileControlAffinity.leading,
                                          value: controller.hasAcceptedPdpa,
                                          onChanged: (v) => controller.setPdpaAccepted(v ?? false),
                                          title: const Text(
                                            'ฉันได้อ่านและยินยอมให้แอป IT Shop เก็บและใช้ข้อมูลส่วนบุคคลตามวัตถุประสงค์ที่ระบุ',
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _showPDPADialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('ยินยอมการประมวลผลข้อมูลส่วนบุคคล (PDPA)'),
          content: const SingleChildScrollView(
            child: Text(
              'เมื่อกดตกลง ถือว่าคุณได้อ่านและยินยอมตามนโยบายความเป็นส่วนตัวและข้อกำหนดการให้บริการ ข้อมูลของคุณจะถูกใช้เพื่อปรับปรุงประสบการณ์ใช้งานและให้บริการที่เหมาะสม โดยเราจะเก็บรักษาความปลอดภัยของข้อมูลตามมาตรฐานที่เหมาะสม',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            GetX<SigninController>(
              builder: (c) {
                return ElevatedButton(
                  onPressed: c.isSigningIn ? null : () async {
                    Navigator.of(ctx).pop();
                    await c.signInWithGoogle();
                  },
                  child: Text(c.isSigningIn ? 'กำลังเข้าสู่ระบบ...' : 'ตกลง'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}


