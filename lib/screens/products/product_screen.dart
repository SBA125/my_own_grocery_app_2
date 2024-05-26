import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/products/product_bloc.dart';
import '../../blocs/products/product_state.dart';
import '../../blocs/products/product_event.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../../services/firebase_product_service.dart';


class ProductScreen extends StatelessWidget {
  final Category category;

  const ProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    ProductRepository productRepository = ProductRepository(firebaseProductService: FirebaseProductService());
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pictures/96.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child: BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            productRepository: productRepository,
          )..add(LoadProductsByCategory(category.productIDs)),
          child: const ProductList(),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          final products = state.products;
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product? product;

  const ProductCard({super.key, required this.product});

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
                product!.imageUrl,
                fit: BoxFit.contain,
                // width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: Column(
              children: [
                Text(
                  product!.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Rs.${product?.price}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: (){},
                    child: const Text('Add to cart')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
