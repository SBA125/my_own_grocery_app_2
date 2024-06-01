import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_own_grocery_app_2/models/category.dart';
import 'package:my_own_grocery_app_2/models/product.dart';

import '../models/review.dart';
import '../models/rider.dart';
import '../models/user.dart';
import '../models/order.dart' as userOrder;

class FirebaseAdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> getAllUsers() async {
    final doc = await _firestore.collection('Users').doc('allUsers').get();
    if (doc.exists) {
      List<dynamic> usersList = doc.data()?['usersList'] ?? [];
      return usersList.map((data) => User.fromMap(data)).toList();
    }
    return [];
  }

  Future<void> deleteUser(String userID) async {
    final doc = await _firestore.collection('Users').doc('allUsers').get();
    if (doc.exists) {
      List<dynamic> usersList = doc.data()?['usersList'] ?? [];
      usersList.removeWhere((user) => user['id'] == userID);
      await _firestore.collection('Users').doc('allUsers').update({'usersList': usersList});
    }
  }

  Future<void> addProduct(Product product) async {
    final doc = await _firestore.collection('Products ').doc('allProducts').get();
    if (doc.exists) {
      List<dynamic> productsList = doc.data()?['productsList'] ?? [];
      productsList.add(product.toMap());
      await _firestore.collection('Products').doc('allProducts').update({'productsList': productsList});
    } else {
      await _firestore.collection('Products').doc('allProducts').set({
        'productsList': [product.toMap()],
      });
    }
  }

  Future<void> updateProductDetails(String productID, Product updatedProduct) async {
    final doc = await _firestore.collection('Products ').doc('allProducts').get();
    if (doc.exists) {
      List<dynamic> productsList = doc.data()?['productsList'] ?? [];
      int index = productsList.indexWhere((product) => product['id'] == productID);
      if (index != -1) {
        productsList[index] = updatedProduct.toMap();
        await _firestore.collection('Products').doc('allProducts').update({'productsList': productsList});
      }
    }
  }

  Future<void> deleteProduct(String productID) async {
    final doc = await _firestore.collection('Products ').doc('allProducts').get();
    if (doc.exists) {
      List<dynamic> productsList = doc.data()?['productsList'] ?? [];
      productsList.removeWhere((product) => product['id'] == productID);
      await _firestore.collection('Products').doc('allProducts').update({'productsList': productsList});
    }
  }

  Future<List<Product>> getAllProducts() async {
    final doc = await _firestore.collection('Products ').doc('allProducts').get();
    if (doc.exists) {
      List<dynamic> productsList = doc.data()?['productsList'] ?? [];
      return productsList.map((data) => Product.fromMap(data)).toList();
    }
    return [];
  }

  Future<Product> getProduct(String productID) async {
    final doc = await _firestore.collection('Products ').doc('allProducts').get();
    if (doc.exists) {
      List<dynamic> productsList = doc.data()?['productsList'] ?? [];
      var productMap = productsList.firstWhere((product) => product['id'] == productID, orElse: () => null);
      if (productMap != null) {
        return Product.fromMap(productMap);
      }
    }
    throw Exception('Product not found');
  }

  Future<void> addCategory(Category category) async {
    final doc = await _firestore.collection('Categories').doc('allCategories').get();
    if (doc.exists) {
      List<dynamic> categoriesList = doc.data()?['categoriesList'] ?? [];
      categoriesList.add(category.toMap());
      await _firestore.collection('Categories').doc('allCategories').update({'categoriesList': categoriesList});
    } else {
      await _firestore.collection('Categories').doc('allCategories').set({
        'categoriesList': [category.toMap()],
      });
    }
  }

  Future<void> updateCategoryDetails(String categoryID, Category updatedCategory) async {
    final doc = await _firestore.collection('Categories').doc('allCategories').get();
    if (doc.exists) {
      List<dynamic> categoriesList = doc.data()?['categoriesList'] ?? [];
      int index = categoriesList.indexWhere((category) => category['id'] == categoryID);
      if (index != -1) {
        categoriesList[index] = updatedCategory.toMap();
        await _firestore.collection('Categories').doc('allCategories').update({'categoriesList': categoriesList});
      }
    }
  }

  Future<void> deleteCategory(String categoryID) async {
    final doc = await _firestore.collection('Categories').doc('allCategories').get();
    if (doc.exists) {
      List<dynamic> categoriesList = doc.data()?['categoriesList'] ?? [];
      categoriesList.removeWhere((category) => category['id'] == categoryID);
      await _firestore.collection('Categories').doc('allCategories').update({'categoriesList': categoriesList});
    }
  }

  Future<List<Category>> getAllCategories() async {
    final doc = await _firestore.collection('Categories').doc('allCategories').get();
    if (doc.exists) {
      List<dynamic> categoriesList = doc.data()?['categoriesList'] ?? [];
      return categoriesList.map((data) => Category.fromMap(data)).toList();
    }
    return [];
  }

  Future<Category> getCategory(String categoryID) async {
    final doc = await _firestore.collection('Categories').doc('allCategories').get();
    if (doc.exists) {
      List<dynamic> categoriesList = doc.data()?['categoriesList'] ?? [];
      var categoryMap = categoriesList.firstWhere((category) => category['id'] == categoryID, orElse: () => null);
      if (categoryMap != null) {
        return Category.fromMap(categoryMap);
      }
    }
    throw Exception('Category not found');
  }

  Future<List<userOrder.Order>> getAllOrders() async {
    final snapshot = await _firestore.collection('Orders').get();
    return snapshot.docs.map((doc) => userOrder.Order.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<Rider>> getAllRiders() async {
    final doc = await _firestore.collection('Riders').doc('allRiders').get();
    if (doc.exists) {
      List<dynamic> ridersList = doc.data()?['ridersList'] ?? [];
      return ridersList.map((data) => Rider.fromMap(data)).toList();
    }
    return [];
  }

  Future<List<Review>> getAllReviews() async {
    final doc = await _firestore.collection('Reviews').doc('allReviews').get();
    if (doc.exists) {
      List<dynamic> reviewsList = doc.data()?['reviewsList'] ?? [];
      return reviewsList.map((data) => Review.fromMap(data)).toList();
    }
    return [];
  }
}