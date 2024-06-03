import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/rider/rider_bloc.dart';
import '../../blocs/rider/rider_event.dart';
import '../../models/order.dart';

class RiderOrderScreen extends StatelessWidget {
  final Order order;

  const RiderOrderScreen({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 16.0)),
            Text('Name: ${order.userName}', style: const TextStyle(fontSize: 16.0)),
            Text('Phone No: ${order.contactNo}', style: const TextStyle(fontSize: 16.0)),
            Text('Address: ${order.address}', style: const TextStyle(fontSize: 16.0)),
            Text('Total: ${order.total}', style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final cartItem = order.items[index];
                final totalItemPrice = cartItem.price * cartItem.quantity;
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 2,
                  child: ListTile(
                    leading: Image.network(cartItem.imageUrl),
                    title: Text(cartItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${cartItem.quantity} x Rs.${cartItem.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('Rs.${totalItemPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<RiderBloc>().add(CompleteOrder(order));
                },
                child: const Text('Order Complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
