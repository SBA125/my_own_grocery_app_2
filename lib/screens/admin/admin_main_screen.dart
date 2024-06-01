import 'package:flutter/material.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_category_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_order_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_product_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_rider_screen.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_user_screen.dart';
import '../../models/admin_card.dart';
import '../../widgets/admin_card.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

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
      AdminCard(
        title: 'Reviews',
        icon: Icons.rate_review,
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlaceholderScreen(title: 'Reviews')),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
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

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Placeholder for $title Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}