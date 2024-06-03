import 'package:my_own_grocery_app_2/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/cart/cart_state.dart';


void main() {
  group('CartState tests', () {
    test('CartLoading state has no props', () {
      final cartLoadingState = CartLoading();
      expect(cartLoadingState, isA<CartLoading>());
    });

    test('CartLoaded state contains cartItems', () {
      final cartItems = [
        CartItem(
          id: '1',
          productId: 'prod1',
          name: 'Product 1',
          price: 10,
          quantity: 1,
          imageUrl: 'image-url',
        ),
      ];
      final cartLoadedState = CartLoaded(cartItems: cartItems);
      expect(cartLoadedState, isA<CartLoaded>());
      expect(cartLoadedState.cartItems, equals(cartItems));
    });

    test('CartError state contains message', () {
      const errorMessage = 'An error occurred';
      final cartErrorState = CartError(message: errorMessage);
      expect(cartErrorState, isA<CartError>());
      expect(cartErrorState.message, equals(errorMessage));
    });
  });
}

