import '../../models/cart.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddItemToCart extends CartEvent {
  final CartItem item;

  AddItemToCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final String itemId;

  RemoveItemFromCart(this.itemId);
}

class UpdateItemQuantity extends CartEvent {
  final String itemId;
  final int quantity;

  UpdateItemQuantity(this.itemId, this.quantity);
}

class ClearCart extends CartEvent {}