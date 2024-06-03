import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_state.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/order_review_screen.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/orders/order_bloc.dart';
import '../../blocs/orders/order_event.dart';
import '../../blocs/orders/order_state.dart';
import 'home_screen.dart';

class OrderHistory extends StatelessWidget {
  final OrderRepository orderRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const OrderHistory({
    super.key,
    required this.orderRepository,
    required this.authenticationRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  userRepository: userRepository,
                  authenticationRepository: authenticationRepository,
                  orderRepository: orderRepository,
                ),
              ),
            );
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderBloc(orderRepository: orderRepository)
          ..add(FetchOrderHistory((context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).user.uid)),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('No orders found'));
              }
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  if(order.status == 'delivery complete'){
                    return Card(
                      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                      child: ListTile(
                        title: Text('Order ${index+1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: Rs.${order.total.toStringAsFixed(2)}'),
                            Text('Status: ${order.status}'),
                            Text('Date: ${order.createdAt.toLocal().toString()}'),
                            const Text('Cart Items:'),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: order.items.length,
                              itemBuilder: (context, itemIndex) {
                                final cartItem = order.items[itemIndex];
                                return ListTile(
                                  title: Text(cartItem.name),
                                  subtitle: Text('Quantity: ${cartItem.quantity}, Unit Price: Rs.${cartItem.price.toStringAsFixed(2)}'),
                                );
                              },
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddReviewScreen(
                                        orderID: order.id,
                                        orderRepository: orderRepository,
                                        authenticationRepository: authenticationRepository,
                                        userRepository: userRepository,
                                      )
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                ),
                                child: const Text('Review')
                            ),
                          ],
                        ),
                      ),
                    );
                  } else{
                    return Card(
                      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                      child: ListTile(
                        title: Text('Order ${index+1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: Rs.${order.total.toStringAsFixed(2)}'),
                            Text('Status: ${order.status}'),
                            Text('Date: ${order.createdAt.toLocal().toString()}'),
                            const Text('Cart Items:'),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: order.items.length,
                              itemBuilder: (context, itemIndex) {
                                final cartItem = order.items[itemIndex];
                                return ListTile(
                                  title: Text(cartItem.name),
                                  subtitle: Text('Quantity: ${cartItem.quantity}, Unit Price: Rs.${cartItem.price.toStringAsFixed(2)}'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            } else if (state is OrderHistoryError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No orders found'));
            }
          },
        ),
      ),
    );
  }
}

