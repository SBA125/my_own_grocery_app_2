import 'package:my_own_grocery_app_2/models/category.dart';
import 'package:my_own_grocery_app_2/models/product.dart';

import '../models/order.dart';
import '../models/review.dart';
import '../models/rider.dart';
import '../models/user.dart';
import '../services/firebase_admin_service.dart';

class AdminRepository{
  final FirebaseAdminService firebaseAdminService;

  AdminRepository({required this.firebaseAdminService});

  Future<List<User>> getAllUsers() async{
   return await firebaseAdminService.getAllUsers();
  }

  Future<void> deleteUser(String userID) async{
    await firebaseAdminService.deleteUser(userID);
  }

  Future<void> addProduct(Product product) async{
    await firebaseAdminService.addProduct(product);
  }

  Future<void> updateProductDetails(String productID, Product product) async{
    await firebaseAdminService.updateProductDetails(productID, product);
  }

  Future<void> deleteProduct(String productID) async{
    await firebaseAdminService.deleteProduct(productID);
  }

  Future<List<Product>> getAllProducts() async{
    return await firebaseAdminService.getAllProducts();
  }

  Future<Product> getProduct(String productID) async{
    return await firebaseAdminService.getProduct(productID);
  }

  Future<void> addCategory(Category category) async{
    await firebaseAdminService.addCategory(category);
  }

  Future<void> updateCategoryDetails(String categoryID, Category category) async{
    await firebaseAdminService.updateCategoryDetails(categoryID, category);
  }

  Future<void> deleteCategory(String categoryID) async{
    await firebaseAdminService.deleteCategory(categoryID);
  }

  Future<List<Category>> getAllCategories() async{
    return await firebaseAdminService.getAllCategories();
  }

  Future<Category> getCategory(String categoryID) async{
    return await firebaseAdminService.getCategory(categoryID);
  }

  Future<List<Order>> getAllOrders() async{
    return await firebaseAdminService.getAllOrders();
  }

  Future<List<Rider>> getAllRiders() async{
    return await firebaseAdminService.getAllRiders();
  }

  Future<List<Review>> getAllReviews() async{
    return await firebaseAdminService.getAllReviews();
  }

}