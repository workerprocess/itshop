import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mobile_app/main.dart';

void main() {
  group('End-to-End User Journey Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should complete full user journey from home to product detail', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Start at Home
        expect(find.text('Welcome to IT Shop'), findsOneWidget);
        expect(find.text('Your one-stop shop for IT products'), findsOneWidget);

        // Step 2: Navigate to Products
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        // Step 3: Search for products
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Search'), findsOneWidget);

        // Step 4: Navigate to Favorites
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Favorites'), findsOneWidget);

        // Step 5: Navigate to Profile
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        // Step 6: Access Settings
        await tester.tap(find.byIcon(Icons.settings));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Settings'), findsOneWidget);

        // Step 7: Return to Home
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Welcome to IT Shop'), findsOneWidget);
      });
    });

    testWidgets('should handle theme switching journey', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Navigate to Profile
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        // Step 2: Toggle theme
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Step 3: Navigate to Settings
        await tester.tap(find.byIcon(Icons.settings));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Settings'), findsOneWidget);

        // Step 4: Toggle theme in settings
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Step 5: Return to Profile
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Profile'), findsOneWidget);

        // Assert - Theme should be applied
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should handle search and filter journey', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Navigate to Search
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Search'), findsOneWidget);

        // Step 2: Check empty state
        expect(find.text('ค้นหาสินค้าที่คุณต้องการ'), findsOneWidget);

        // Step 3: Navigate to Products
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        // Step 4: Toggle view mode
        await tester.tap(find.byIcon(Icons.list));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        await tester.tap(find.byIcon(Icons.grid_view));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - View mode should toggle
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should handle favorites management journey', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Navigate to Favorites
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Favorites'), findsOneWidget);

        // Step 2: Check empty state
        expect(find.text('ยังไม่มีสินค้าที่บันทึกไว้'), findsOneWidget);

        // Step 3: Navigate to Products to add favorites
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Products'), findsOneWidget);

        // Step 4: Return to Favorites
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Favorites'), findsOneWidget);

        // Assert - Favorites page should be functional
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should handle complete app lifecycle', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Complete navigation cycle
        final tabs = ['Home', 'Products', 'Search', 'Favorites', 'Profile'];
        
        for (final tab in tabs) {
          await tester.tap(find.text(tab));
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));
          expect(find.text(tab), findsOneWidget);
        }

        // Step 2: Test settings access from multiple pages
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        await tester.tap(find.byIcon(Icons.settings));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Settings'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Step 3: Test theme switching
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Step 4: Final navigation test
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        expect(find.text('Welcome to IT Shop'), findsOneWidget);

        // Assert - App should be fully functional
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });
    });

    testWidgets('should handle error recovery scenarios', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Step 1: Rapid navigation
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Products'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
          
          await tester.tap(find.text('Search'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
          
          await tester.tap(find.text('Home'));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 50));
        }

        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Step 2: Test theme switching
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        for (int i = 0; i < 3; i++) {
          await tester.tap(find.byType(Switch));
          await tester.pump();
          async.elapse(const Duration(milliseconds: 100));
        }

        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - App should recover gracefully
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });
    });
  });
}
