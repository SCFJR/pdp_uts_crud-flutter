import 'package:flutter_test/flutter_test.dart';
import 'package:crud_project/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('Task creation with valid parameters', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        isDone: false,
        description: 'Test description',
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.isDone, false);
      expect(task.description, 'Test description');
      expect(task.createdAt, isA<DateTime>());
    });

    test('Task creation with minimal parameters', () {
      final task = Task(
        id: '2',
        title: 'Minimal Task',
      );

      expect(task.id, '2');
      expect(task.title, 'Minimal Task');
      expect(task.isDone, false); // Default value
      expect(task.description, null); // Default value
      expect(task.createdAt, isA<DateTime>());
    });

    test('Task toMap and fromMap round trip', () {
      final originalTask = Task(
        id: '6',
        title: 'Round Trip Task',
        isDone: true,
        description: 'Testing round trip',
      );

      final map = originalTask.toMap();
      final newTask = Task.fromMap(map);

      expect(newTask.id, originalTask.id);
      expect(newTask.title, originalTask.title);
      expect(newTask.isDone, originalTask.isDone);
      expect(newTask.description, originalTask.description);
      expect(newTask.createdAt.millisecondsSinceEpoch, originalTask.createdAt.millisecondsSinceEpoch);
    });

    test('Task fromMap with missing values uses defaults', () {
      final map = {
        'id': '7',
        'title': 'Incomplete Task',
        // Missing other fields to test defaults
      };

      final task = Task.fromMap(map);

      expect(task.id, '7');
      expect(task.title, 'Incomplete Task');
      expect(task.isDone, false); // Default
      expect(task.description, ''); // Default
    });

    test('Task fromMap with invalid values uses defaults', () {
      final map = {
        'id': null,
        'title': null,
        'isDone': null,
        'createdAt': null,
        'description': null,
      };

      final task = Task.fromMap(map);

      expect(task.id, '');
      expect(task.title, 'Tidak ada judul');
      expect(task.isDone, false);
      expect(task.description, '');
    });
  });
}