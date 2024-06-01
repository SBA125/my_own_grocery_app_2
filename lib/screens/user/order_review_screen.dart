import 'package:flutter/material.dart';

class OrderReviewScreen extends StatelessWidget{
  final OrderRepository orderRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  const OrderReviewScreen({super.key, required this.orderRepository, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreen(
                    orderRepository: orderRepository,
                    authenticationRepository: authenticationRepository,
                    userRepository: userRepository,
                  )
              ),
            );
          },
        ),
      ),
      body: BlocProvider<OrderBloc>(
        create: (_) => OrderBloc(orderRepository: orderRepository),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrderForm(
            orderRepository: orderRepository,
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          ),
        ),
      ),
    );
  }
}

class OrderForm extends StatefulWidget{
  final OrderRepository orderRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const OrderForm({super.key, required this.orderRepository, required this.authenticationRepository, required this.userRepository});

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Placing order...')),
            );
          } else if (state is OrderPlaced) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully')),
            );
            BlocProvider.of<CartBloc>(context).add(ClearCart());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  authenticationRepository: widget.authenticationRepository,
                  userRepository: widget.userRepository,
                  orderRepository: widget.orderRepository,
                ),
              ),
            );
          } else if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _contactNoController,
              decoration: const InputDecoration(
                labelText: 'Contact No',
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = state.cartItems[index];
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
                      },
                    );
                  } else {
                    return const Center(child: Text('No items in cart'));
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final authState = context.read<AuthenticationBloc>().state;
                  if (authState is AuthenticationAuthenticated) {
                    final user = authState.user;
                    final cartItems = (context.read<CartBloc>().state as CartLoaded).cartItems;
                    final totalAmount = cartItems.fold<double>(
                      0,
                          (previousValue, cartItem) => previousValue + (cartItem.price * cartItem.quantity),
                    );
                    final orderId = const Uuid().v4();
                    final order = Order(
                        id: orderId,
                        items: cartItems,
                        total: totalAmount,
                        createdAt: DateTime.now(),
                        paymentMethod: 'Cash on Delivery',
                        userId: user.uid,
                        userName: _nameController.value.text,
                        contactNo: _contactNoController.value.text,
                        address: _addressController.value.text,
                        status: 'pending',
                        isReview: false
                    );
                    context.read<OrderBloc>().add(PlaceOrder(order));
                  }
                }
              },
              child: const Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}