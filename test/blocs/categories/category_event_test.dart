import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/categories/category_event.dart';

void main() {
  group('LoadCategories', () {
    test('props are correct', () {
      final loadCategories1 = LoadCategories();
      final loadCategories2 = LoadCategories();

      // Verify that both instances of LoadCategories are equal
      expect(loadCategories1, loadCategories2);

      // Verify that props getter returns an empty list
      expect(loadCategories1.props, []);
    });
  });
}