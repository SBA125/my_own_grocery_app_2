import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/models/cart.dart';


void main() {
  group('CartItem', () {
    test('Properties should be set correctly', () {
      const String id = '1';
      const String productId = '123';
      const String name = 'Product';
      const int price = 100;
      const int quantity = 2;
      const String imageUrl = 'https://example.com/image.jpg';

      final cartItem = CartItem(
        id: id,
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
        imageUrl: imageUrl,
      );

      expect(cartItem.id, id);
      expect(cartItem.productId, productId);
      expect(cartItem.name, name);
      expect(cartItem.price, price);
      expect(cartItem.quantity, quantity);
      expect(cartItem.imageUrl, imageUrl);
    });

    test('copyWith should create a new instance with updated values', () {
      final cartItem = CartItem(
        id: '1',
        productId: '123',
        name: 'Product',
        price: 100,
        quantity: 2,
        imageUrl: 'https://example.com/image.jpg',
      );

      final updatedCartItem = cartItem.copyWith(quantity: 3);

      expect(updatedCartItem.quantity, 3);
      expect(updatedCartItem.id, cartItem.id);
      expect(updatedCartItem.productId, cartItem.productId);
      expect(updatedCartItem.name, cartItem.name);
      expect(updatedCartItem.price, cartItem.price);
      expect(updatedCartItem.imageUrl, cartItem.imageUrl);
    });

    test('toMap should return a map representation of the object', () {
      final cartItem = CartItem(
        id: '1',
        productId: '123',
        name: 'Product',
        price: 100,
        quantity: 2,
        imageUrl: 'https://example.com/image.jpg',
      );

      final map = cartItem.toMap();

      expect(map['id'], cartItem.id);
      expect(map['productId'], cartItem.productId);
      expect(map['name'], cartItem.name);
      expect(map['price'], cartItem.price);
      expect(map['quantity'], cartItem.quantity);
      expect(map['imageUrl'], cartItem.imageUrl);
    });
  });
}
