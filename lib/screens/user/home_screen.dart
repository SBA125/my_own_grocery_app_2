import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/product_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/cart_screen.dart';
import 'package:my_own_grocery_app_2/widgets/side_drawer.dart';
import 'package:my_own_grocery_app_2/widgets/text_form_field.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication_state.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/products/product_bloc.dart';
import '../../main.dart';
import '../../services/firebase_product_service.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;

  const HomeScreen({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    ProductRepository productRepository = ProductRepository(firebaseProductService: FirebaseProductService());
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu)),
        ),
        centerTitle: true,
        title: const Text('Grocery App'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int itemCount = 0;
              if (state is CartLoaded) {
                itemCount = state.cartItems.length;
              }
              return IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  CartScreen(
                      authenticationRepository: authenticationRepository,
                      userRepository: userRepository,
                      orderRepository: orderRepository,
                    )
                    ),
                  );
                },
                icon: Badge(
                  isLabelVisible: itemCount > 0,
                  label: Text(itemCount.toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
              );
            },
          ),
        ],
        // bottom: const PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child: SearchTextFormField(),
        // ),
      ),
      drawer: SideDrawer(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(authenticationRepository, userRepository),
          ),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(LoadCart()),
          ),
          BlocProvider<ProductBloc>(
              create: (_) => ProductBloc(productRepository: productRepository),
          )
        ],
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pictures/96.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationUnauthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(authenticationRepository: authenticationRepository, userRepository: userRepository)),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: CategoryList(),
            ),
          ),
        ),
      ),
    );
  }
}






