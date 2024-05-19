import '../models/category.dart';
import '../services/firebase_category_service.dart';

class CategoryRepository {
  final FirebaseCategoryService firebaseCategoryService;

  CategoryRepository({required this.firebaseCategoryService});

  Future<List<Category>> getCategories() async {
    return await firebaseCategoryService.fetchCategories();
  }
}
