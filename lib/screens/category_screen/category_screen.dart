import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/screens/products/product_screen.dart';
import '../../blocs/categories/category_bloc.dart';
import '../../blocs/categories/category_state.dart';
import '../../models/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesLoaded) {
          final categories = state.categories;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductScreen(category: category))),
                  child: CategoryCard(category: category),
              );
            },
          );
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
                // width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
