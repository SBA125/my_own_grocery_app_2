import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/admin/admin_event.dart';
import 'package:my_own_grocery_app_2/models/category.dart';
import 'package:my_own_grocery_app_2/models/product.dart';

void main() {
  group('AdminEvent tests', () {
    test('LoadAllUsers should have no props', () {
      final loadAllUsers = LoadAllUsers();
      expect(loadAllUsers.props, []);
    });

    test('DeleteUser should contain the userID', () {
      const userID = '1';
      final deleteUser = DeleteUser(userID);
      expect(deleteUser.props, [userID]);
    });

    test('AddProduct should contain the product', () {
      final product = Product(productID: '1', name: 'Product 1', description: 'Description 1', price: 10, imageUrl: 'image_url', quantity: 10, inStock: true);
      final addProduct = AddProduct(product);
      expect(addProduct.props, [product]);
    });

    test('UpdateProduct should contain the productId and product', () {
      const productId = '1';
      final product = Product(productID: '1', name: 'Product 1', description: 'Description 1', price: 10, imageUrl: 'image_url', quantity: 10, inStock: true);
      final updateProduct = UpdateProduct(productId, product);
      expect(updateProduct.props, [productId, product]);
    });

    // Add tests for other events similarly
  });
}
