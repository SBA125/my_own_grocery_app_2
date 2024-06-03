import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/blocs/categories/category_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/categories/category_event.dart';
import 'package:my_own_grocery_app_2/blocs/categories/category_state.dart';
import 'package:my_own_grocery_app_2/repositories/category_repository.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  group('CategoryBloc', () {
    late CategoryRepository categoryRepository;
    late CategoryBloc categoryBloc;

    setUp(() {
      categoryRepository = MockCategoryRepository();
      categoryBloc = CategoryBloc(categoryRepository: categoryRepository);
    });

    tearDown(() {
      categoryBloc.close();
    });

    test('initial state is CategoryLoading', () {
      expect(categoryBloc.state, CategoryLoading());
    });

    // blocTest<CategoryBloc, CategoryState>(
    //   'emits CategoriesLoaded when LoadCategories event is added',
    //   build: () {
    //     when(() => categoryRepository.getCategories()).thenAnswer((_) async => [Category(id: '1', name: 'Category 1')]);
    //     return categoryBloc;
    //   },
    //   act: (bloc) => bloc.add(LoadCategories()),
    //   expect: () => [CategoriesLoaded([Category(id: '1', name: 'Category 1')])],
    // );

    blocTest<CategoryBloc, CategoryState>(
      'emits CategoryError when LoadCategories event is added and repository throws an error',
      build: () {
        when(() => categoryRepository.getCategories()).thenThrow(Exception('Error fetching categories'));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(LoadCategories()),
      expect: () => [const CategoryError('Exception: Error fetching categories')],
    );

  });
}
