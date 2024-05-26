import 'package:my_own_grocery_app_2/services/firebase_product_service.dart';

import '../models/product.dart';

class ProductRepository{

  final FirebaseProductService firebaseProductService;

  ProductRepository({required this.firebaseProductService});

  Future<List<Product>> getProducts() async {
    return await firebaseProductService.fetchProducts();
  }

  Future<List<Product>> getProductsByCategory(List<String> productIDs) async{
    return await firebaseProductService.getProductsByCategory(productIDs);
  }

}