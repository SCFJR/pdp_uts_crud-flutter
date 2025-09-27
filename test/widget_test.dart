  // This is a basic Flutter widget test.
  //
  // To perform an interaction with a widget in your test, use the WidgetTester
  // utility in the flutter_test package. For example, you can send tap and scroll
  // gestures. You can also use WidgetTester to find child widgets in the widget
  // tree, read text, and verify that the values of widget properties are correct.

  import 'package:flutter/material.dart';
  import 'package:flutter_test/flutter_test.dart';

  import 'package:crud_project/main.dart';

  void main() {
    testWidgets('Todo App loads correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Verify that the app title is displayed.
      expect(find.text('To-Do List'), findsOneWidget);

      // Verify that the initial message is displayed when no tasks exist.
      expect(find.text('Belum ada tugas'), findsOneWidget);

      // Verify that the floating action button exists.
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  }
