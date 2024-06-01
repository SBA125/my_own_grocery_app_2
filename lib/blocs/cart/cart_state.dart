import '../../models/cart.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded({required this.cartItems});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}