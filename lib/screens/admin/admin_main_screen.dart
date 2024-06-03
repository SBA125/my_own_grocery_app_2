import 'package:flutter/material.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_category_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_order_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_product_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_rider_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_user_screen.dart';
import 'package:my_own_grocery_app_2/screens/user/order_review_screen.dart';
import 'package:my_own_grocery_app_2/widgets/admin_rider_side_drawer.dart';
import '../../models/admin_card.dart';
import '../../widgets/admin_card.dart';

class AdminMainScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  const AdminMainScreen({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    final List<AdminCard> cards = [
      AdminCard(
        title: 'Users',
        icon: Icons.people,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminUserScreen()),
        ),
      ),
      AdminCard(
        title: 'Riders',
        icon: Icons.motorcycle,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminRiderScreen()),
        ),
      ),
      AdminCard(
        title: 'Orders',
        icon: Icons.shopping_cart,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminOrderScreen()),
        ),
      ),
      AdminCard(
        title: 'Products',
        icon: Icons.store,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminProductScreen()),
        ),
      ),
      AdminCard(
        title: 'Categories',
        icon: Icons.category,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminCategoryScreen()),
        ),
      ),
      // AdminCard(
      //   title: 'Reviews',
      //   icon: Icons.rate_review,
      //   onTap: (context) => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const AddReviewScreen(orderID: orderID, orderRepository: orderRepository, authenticationRepository: authenticationRepository, userRepository: userRepository) ),
      //   ),
      // ),
    ];

    return Scaffold(
      drawer: AdminRiderSideDrawer(authenticationRepository: authenticationRepository, userRepository: userRepository),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pictures/96.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return AdminCardWidget(card: cards[index]);
            },
          ),
        ),
      ),
    );
  }
}

