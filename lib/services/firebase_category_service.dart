import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class FirebaseCategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> fetchCategories() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Categories').doc('allCategories').get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('categoriesList')) {
          List<dynamic>? categoriesList = data['categoriesList'] as List<dynamic>?;
          if (categoriesList != null) {
            return categoriesList.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();
          } else {
            throw Exception('categoriesList is null');
          }
        } else {
          throw Exception('categoriesList field is missing');
        }
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
