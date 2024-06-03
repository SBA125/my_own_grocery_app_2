import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Products ').doc('allProducts').get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('productsList')) {
          List<dynamic>? productsList = data['productsList'] as List<dynamic>?;
          if (productsList != null) {
            return productsList.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
          } else {
            throw Exception('productsList is null');
          }
        } else {
          throw Exception('productsList field is missing');
        }
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(List<String> productIDs) async {
    try {
      final docRef = _firestore.collection('Products ').doc('allProducts');
      final docSnapshot = await docRef.get();

      final data = docSnapshot.data() as Map<String, dynamic>;
      final productsList = List<Map<String, dynamic>>.from(data['productsList']);
      final filteredProducts = productsList.where((productData) {
        return productIDs.contains(productData['productID']);
      }).toList();

      return filteredProducts.map((productData) => Product.fromMap(productData)).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }

  }
}