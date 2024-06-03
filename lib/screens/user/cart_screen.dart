import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/home_screen.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../repositories/authentication_repository.dart';
import '../../repositories/user_repository.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  const CartScreen({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(userRepository: userRepository , authenticationRepository: authenticationRepository, orderRepository: orderRepository,)),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CartLoaded) {
                  return ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      final totalItemPrice = cartItem.price * cartItem.quantity;
                      return ListTile(
                        leading: Image.network(cartItem.imageUrl, width: 70,),
                        title: Text(
                          cartItem.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              splashRadius: 0.1,
                              onPressed: () {
                                if(cartItem.quantity ==1){
                                  BlocProvider.of<CartBloc>(context).add(RemoveItemFromCart(cartItem.id));
                                }
                                // Decrease quantity logic
                                BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(cartItem.id, cartItem.quantity - 1));
                              },
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                // Increase quantity logic
                                BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(cartItem.id, cartItem.quantity + 1));
                              },
                            ),
                            Text(
                              'Rs.${totalItemPrice.toStringAsFixed(1)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(RemoveItemFromCart(cartItem.id));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is CartError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No items in cart'));
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      final totalAmount = state.cartItems.fold<double>(
                        0,
                            (previousValue, cartItem) => previousValue + (cartItem.price * cartItem.quantity),
                      );
                      return Text(
                        'Total: Rs.$totalAmount',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else {
                      return const Text('Total: Rs.0');
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderScreen(
                            orderRepository: orderRepository,
                            authenticationRepository: authenticationRepository,
                            userRepository: userRepository,
                          )
                      ),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}