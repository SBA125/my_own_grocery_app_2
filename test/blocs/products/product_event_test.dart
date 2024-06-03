

import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_event.dart';

void main() {
  group('LoadProducts', () {
    test('props are correct', () {
      final loadProducts = LoadProducts();

      // Verify that props getter returns an empty list
      expect(loadProducts.props, []);
    });
  });

  group('LoadProductsByCategory', () {
    test('props are correct', () {
      final productIDs = ['1', '2', '3'];
      final loadProductsByCategory = LoadProductsByCategory(productIDs);

      // Verify that props getter returns a list containing productIDs
      expect(loadProductsByCategory.props, [productIDs]);
    });
  });

  group('SearchProducts', () {
    test('props are correct', () {
      const query = 'phone';
      const searchProducts = SearchProducts(query);

      // Verify that props getter returns a list containing the query
      expect(searchProducts.props, [query]);
    });
  });
}
