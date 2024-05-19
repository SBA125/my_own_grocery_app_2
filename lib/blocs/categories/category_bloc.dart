import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<LoadCategories>((event, emit) async {
      try {
        final categories = await categoryRepository.getCategories();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
