import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/admin/admin_bloc.dart';
import '../../blocs/admin/admin_event.dart';
import '../../blocs/admin/admin_state.dart';
class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdminBloc>(context).add(LoadAllOrders());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pictures/96.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoadedOrders) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Card(
                      elevation: 0.0,
                      margin: EdgeInsets.zero,
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
                              'Total: ${order.total}',
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
                            Text(
                              'Date: ${order.createdAt}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  const Center(child: Text('Cart Items:', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),)),
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
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is AdminFailure) {
              return Center(child: Text('Failed to load orders: ${state.error}'));
            } else {
              return const Center(child: Text('No orders found'));
            }
          },
        ),
      ),
    );
  }
}