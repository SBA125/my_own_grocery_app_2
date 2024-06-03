import 'package:bloc/bloc.dart';
import '../../models/cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_loadCart);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartLoaded(cartItems: []));
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final cartItems = List<CartItem>.from((state as CartLoaded).cartItems);
      final index = cartItems.indexWhere((item) => item.productId == event.item.productId);
      if (index != -1) {
        final updatedItem = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + event.item.quantity,
        );
        cartItems[index] = updatedItem;
      } else {
        cartItems.add(event.item);
      }

      emit(CartLoaded(cartItems: cartItems));
    } else {
      emit(CartLoaded(cartItems: [event.item]));
    }
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final cartItems = (state as CartLoaded)
          .cartItems
          .where((item) => item.id != event.itemId)
          .toList();
      emit(CartLoaded(cartItems: cartItems));
    }
  }

  void _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final cartItems = (state as CartLoaded).cartItems.map((item) {
        if (item.id == event.itemId) {
          return CartItem(
            id: item.id,
            productId: item.productId,
            name: item.name,
            price: item.price,
            quantity: event.quantity,
            imageUrl: item.imageUrl,
          );
        }
        return item;
      }).toList();
      emit(CartLoaded(cartItems: cartItems));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartLoaded(cartItems: []));
  }
}