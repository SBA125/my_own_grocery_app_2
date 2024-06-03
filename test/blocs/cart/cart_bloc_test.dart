import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/blocs/cart/cart_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/cart/cart_event.dart';
import 'package:my_own_grocery_app_2/blocs/cart/cart_state.dart';
import 'package:my_own_grocery_app_2/models/cart.dart';

class MockCartItem extends Mock implements CartItem {}

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is CartLoading', () {
      expect(cartBloc.state, CartLoading());
    });

    blocTest<CartBloc, CartState>(
      'emits CartLoaded when LoadCart event is added',
      build: () => cartBloc,
      act: (bloc) => bloc.add(LoadCart()),
      expect: () => [CartLoaded(cartItems: [])],
    );

    blocTest<CartBloc, CartState>(
      'emits CartLoaded with added item when AddItemToCart event is added and state is CartLoaded',
      build: () => cartBloc,
      act: (bloc) => bloc.add(AddItemToCart(MockCartItem())),
      seed: () => CartLoaded(cartItems: []),
      expect: () => [CartLoaded(cartItems: [MockCartItem()])],
    );

    // Add more tests for other scenarios...

  });
}
