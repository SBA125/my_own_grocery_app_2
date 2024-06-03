import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/categories/category_state.dart';
import 'package:my_own_grocery_app_2/models/category.dart';

void main() {
  group('CategoryLoading', () {
    test('props are correct', () {
      final categoryLoading = CategoryLoading();

      // Verify that props getter returns an empty list
      expect(categoryLoading.props, []);
    });
  });

  group('CategoriesLoaded', () {
    test('props are correct', () {
      final categories = [Category(categoryID: '1', name: 'Category 1', imageUrl: 'image.png', productIDs: [])];
      final categoriesLoaded = CategoriesLoaded(categories);

      // Verify that props getter returns a list containing the categories
      expect(categoriesLoaded.props, [categories]);
    });
  });

  group('CategoryError', () {
    test('props are correct', () {
      const errorMessage = 'Error loading categories';
      const categoryError = CategoryError(errorMessage);

      // Verify that props getter returns a list containing the error message
      expect(categoryError.props, [errorMessage]);
    });
  });
}