import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_event.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_state.dart';

import '../../repositories/product_repository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductLoading()) {
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

    Future<void> _onLoadProductsByCategory(LoadProductsByCategory event, Emitter<ProductState> emit) async {
      try {
        final products = await productRepository.getProductsByCategory(event.productIDs);
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }

    Future<void> _onSearchProducts(SearchProducts event,Emitter<ProductState> emit) async{
      try {
        emit(ProductLoading());
        final allProducts = await productRepository.getProducts();
        final filteredProducts = allProducts.where((product) {
          return product.name.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
        emit(ProductsLoaded(filteredProducts));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }

  }
