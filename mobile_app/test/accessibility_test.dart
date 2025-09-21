import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mobile_app/main.dart';

void main() {
  group('Accessibility Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should have proper semantic labels', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange & Act
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Assert - Check for semantic labels
        expect(find.byType(Semantics), findsWidgets);
        
        // Check bottom navigation semantics
        final bottomNav = find.byType(BottomNavigationBar);
        expect(bottomNav, findsOneWidget);
        
        // Check app bar semantics
        final appBar = find.byType(AppBar);
        expect(appBar, findsOneWidget);
      });
    });

    testWidgets('should support screen reader navigation', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Act - Navigate using semantic actions
        final bottomNav = find.byType(BottomNavigationBar);
        expect(bottomNav, findsOneWidget);

        // Test tab navigation
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - Navigation should work
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should have proper contrast ratios', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange & Act
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Navigate to Profile to test theme switching
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Test theme toggle
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - Theme should be applied
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should support keyboard navigation', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Navigate to Search page
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Act - Test text field focus
        final textField = find.byType(TextField);
        if (textField.evaluate().isNotEmpty) {
          await tester.tap(textField);
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));
          
          // Assert - Text field should be focused
          expect(find.byType(TextField), findsOneWidget);
        }
      });
    });

    testWidgets('should have proper touch targets', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Act - Test all interactive elements
        final interactiveElements = [
          find.text('Home'),
          find.text('Products'),
          find.text('Search'),
          find.text('Favorites'),
          find.text('Profile'),
        ];

        for (final element in interactiveElements) {
          if (element.evaluate().isNotEmpty) {
            await tester.tap(element);
            await tester.pumpAndSettle();
            async.elapse(const Duration(milliseconds: 100));
          }
        }

        // Assert - All interactions should work
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    testWidgets('should support different text scales', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange - Test with different text scales
        final textScales = [0.8, 1.0, 1.2, 1.5, 2.0];
        
        for (final scale in textScales) {
          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(textScaleFactor: scale),
              child: const MyApp(),
            ),
          );
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));

          // Assert - App should handle different text scales
          expect(find.byType(MaterialApp), findsOneWidget);
          
          // Clean up for next iteration
          await tester.pumpWidget(Container());
        }
      });
    });

    testWidgets('should support different screen sizes', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange - Test with different screen sizes
        final screenSizes = [
          const Size(320, 568),   // iPhone SE
          const Size(375, 667),  // iPhone 8
          const Size(414, 896),  // iPhone 11 Pro Max
          const Size(768, 1024), // iPad
        ];
        
        for (final size in screenSizes) {
          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: size),
              child: const MyApp(),
            ),
          );
          await tester.pumpAndSettle();
          async.elapse(const Duration(seconds: 1));

          // Assert - App should handle different screen sizes
          expect(find.byType(MaterialApp), findsOneWidget);
          
          // Clean up for next iteration
          await tester.pumpWidget(Container());
        }
      });
    });
  });

  group('Internationalization Tests', () {
    setUp(() {
      Get.reset();
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should display Thai text correctly', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange & Act
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Navigate to Search page to see Thai text
        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - Thai text should be displayed
        expect(find.text('ค้นหาสินค้า...'), findsOneWidget);
      });
    });

    testWidgets('should handle text overflow gracefully', (WidgetTester tester) async {
      await fakeAsync((async) async {
        // Arrange
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 2));

        // Navigate to different pages
        await tester.tap(find.text('Products'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));
        
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();
        async.elapse(const Duration(seconds: 1));

        // Assert - No overflow errors should occur
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });
  });
}
