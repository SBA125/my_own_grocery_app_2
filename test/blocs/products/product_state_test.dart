import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_state.dart';
import 'package:my_own_grocery_app_2/models/product.dart';

void main() {
  group('ProductLoading', () {
    test('props are correct', () {
      final productLoading = ProductLoading();

      // Verify that props getter returns an empty list
      expect(productLoading.props, []);
    });
  });

  group('ProductsLoaded', () {
    test('props are correct', () {
      final products = [
        Product(
          productID: '1',
          name: 'Product 1',
          description: 'Description 1',
          price: 10,
          imageUrl: 'image1.jpg',
          quantity: 5,
          inStock: true,
        ),
        Product(
          productID: '2',
          name: 'Product 2',
          description: 'Description 2',
          price: 20,
          imageUrl: 'image2.jpg',
          quantity: 10,
          inStock: false,
        ),
      ];
      final productsLoaded = ProductsLoaded(products);

      // Verify that props getter returns a list containing products
      expect(productsLoaded.props, [products]);
    });
  });

  group('ProductError', () {
    test('props are correct', () {
      const errorMessage = 'Failed to load products';
      const productError = ProductError(errorMessage);

      // Verify that props getter returns a list containing the error message
      expect(productError.props, [errorMessage]);
    });
  });
}
