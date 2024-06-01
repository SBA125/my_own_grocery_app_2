import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/rider/rider_bloc.dart';
import '../../blocs/rider/rider_event.dart';
import '../../blocs/rider/rider_state.dart';
class RiderScreen extends StatelessWidget {
  const RiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RiderBloc>(context).add(RiderLoadAllOrders());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
      ),
      body: BlocBuilder<RiderBloc, RiderState>(
        builder: (context, state) {
          if (state is RiderOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RiderLoadedOrders) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Adjust the number of columns as needed
                childAspectRatio: 0.7, // Adjust the aspect ratio as needed
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: state.orders.length,
              itemBuilder: (context, index){
                final order = state.orders[index];
                if (order.status =='pending') {
                  return Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Order#${index+1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                          Text(
                            'Name: ${order.userName}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Phone No: ${order.contactNo}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Date: ${order.createdAt}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Status: ${order.status}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: order.items.length,
                              itemBuilder: (context, index){
                                final cartItem = order.items[index];
                                final totalItemPrice = cartItem.price * cartItem.quantity;
                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: Image.network(cartItem.imageUrl),
                                    title: Text(
                                      cartItem.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${cartItem.quantity} x Rs.${cartItem.price}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Text(
                                      'Rs.${totalItemPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                          ),
                          Text(
                            'Total: ${order.total}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                              onPressed:(){

                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.black, width: 1.0),
                                  ),
                                ),
                              ),
                              child: const Text('Accept Order')
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return null;
              },
            );
          } else if (state is RiderError) {
            return Center(child: Text('Failed to load orders: ${state.message}'));
          } else {
            return const Center(child: Text('No orders found'));
          }
        },
      ),
    );
  }
}