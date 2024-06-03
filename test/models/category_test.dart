import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/models/category.dart';

void main() {
  group('Category', () {
    test('Properties should be set correctly', () {
      final String categoryID = '1';
      final String name = 'Category';
      final String imageUrl = 'https://example.com/image.jpg';
      final List<String> productIDs = ['123', '456', '789'];

      final category = Category(
        categoryID: categoryID,
        name: name,
        imageUrl: imageUrl,
        productIDs: productIDs,
      );

      expect(category.categoryID, categoryID);
      expect(category.name, name);
      expect(category.imageUrl, imageUrl);
      expect(category.productIDs, productIDs);
    });

    test('copyWith should create a new instance with updated values', () {
      final category = Category(
        categoryID: '1',
        name: 'Category',
        imageUrl: 'https://example.com/image.jpg',
        productIDs: ['123', '456', '789'],
      );

      final updatedCategory = category.copyWith(name: 'New Category', categoryID: '', imageUrl: '', productIDs: []);

      expect(updatedCategory.name, 'New Category');
      expect(updatedCategory.categoryID, category.categoryID);
      expect(updatedCategory.imageUrl, category.imageUrl);
      expect(updatedCategory.productIDs, category.productIDs);
    });

    test('toMap should return a map representation of the object', () {
      final category = Category(
        categoryID: '1',
        name: 'Category',
        imageUrl: 'https://example.com/image.jpg',
        productIDs: ['123', '456', '789'],
      );

      final map = category.toMap();

      expect(map['categoryID'], category.categoryID);
      expect(map['name'], category.name);
      expect(map['imageUrl'], category.imageUrl);
      expect(map['productIDs'], category.productIDs);
    });
  });
}
