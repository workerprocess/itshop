import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/core/themes/glass_theme.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_app_bar.dart';
import 'package:mobile_app/presentation/widgets/glass/glass_container.dart';

class TermAndUsePage extends StatelessWidget {
  const TermAndUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: glass.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: 'Terms & Privacy',
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ข้อกำหนดการใช้งาน (Terms of Use)', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      const Text(
                        'ยินดีต้อนรับสู่ IT Shop การใช้งานแอปนี้ถือว่าคุณยอมรับข้อกำหนดและเงื่อนไขต่อไปนี้ รวมถึงนโยบายความเป็นส่วนตัวของเรา ข้อกำหนดอาจมีการปรับปรุงเป็นครั้งคราว โปรดตรวจสอบเป็นระยะ',
                      ),
                      const SizedBox(height: 12),
                      const _Bullet(text: 'ใช้บริการตามกฎหมายที่เกี่ยวข้องและวัตถุประสงค์ของแอป'),
                      const _Bullet(text: 'ห้ามทำการละเมิดสิทธิ์หรือสร้างความเสียหายต่อผู้ใช้งานคนอื่น'),
                      const _Bullet(text: 'เนื้อหาและทรัพย์สินทางปัญญาเป็นของผู้พัฒนา/เจ้าของแอป'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('นโยบายความเป็นส่วนตัว (Privacy Policy)', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      const Text(
                        'เราเคารพความเป็นส่วนตัวของคุณและประมวลผลข้อมูลส่วนบุคคลตามกฎหมาย PDPA โดยมีวัตถุประสงค์เพื่อให้บริการ ปรับปรุงประสบการณ์ และปฏิบัติตามข้อกฎหมาย คุณสามารถขอเข้าถึง แก้ไข ลบ หรือถอนความยินยอมได้',
                      ),
                      const SizedBox(height: 12),
                      const _Bullet(text: 'ข้อมูลที่เก็บ: ชื่อ อีเมล โทรศัพท์ และข้อมูลการใช้งาน'),
                      const _Bullet(text: 'ระยะเวลาเก็บรักษา: ตามความจำเป็นต่อวัตถุประสงค์'),
                      const _Bullet(text: 'การแบ่งปันข้อมูล: เฉพาะเมื่อจำเป็นและมีมาตรการความปลอดภัย'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}


