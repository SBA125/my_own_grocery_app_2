import 'package:bloc/bloc.dart';
import '../../repositories/admin_repository.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc({required this.adminRepository}) : super(AdminInitial()) {
    on<LoadAllUsers>(_getAllUsers);
    on<DeleteUser>(_deleteUser);
    on<AddProduct>(_addProduct);
    on<UpdateProduct>(_updateProduct);
    on<DeleteProduct>(_deleteProduct);
    on<LoadAllProducts>(_loadAllProducts);
    on<AddCategory>(_addCategory);
    on<UpdateCategory>(_updateCategory);
    on<DeleteCategory>(_deleteCategory);
    on<LoadAllCategories>(_loadAllCategories);
    on<LoadAllOrders>(_loadAllOrders);
    on<LoadAllRiders>(_loadAllRiders);
    on<LoadAllReviews>(_loadAllReviews);
  }

  Future<void> _getAllUsers(LoadAllUsers event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final users = await adminRepository.getAllUsers();
      emit(AdminLoadedUsers(users));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _deleteUser(DeleteUser event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.deleteUser(event.userID);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _addProduct(AddProduct event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.addProduct(event.product);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _updateProduct(UpdateProduct event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.updateProductDetails(event.productId, event.product);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _deleteProduct(DeleteProduct event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.deleteProduct(event.productId);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _loadAllProducts(LoadAllProducts event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final products = await adminRepository.getAllProducts();
      emit(AdminLoadedProducts(products));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _addCategory(AddCategory event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.addCategory(event.category);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _updateCategory(UpdateCategory event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.updateCategoryDetails(event.categoryId, event.category);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _deleteCategory(DeleteCategory event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminRepository.deleteCategory(event.categoryId);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _loadAllCategories(LoadAllCategories event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final categories = await adminRepository.getAllCategories();
      emit(AdminLoadedCategories(categories));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _loadAllOrders(LoadAllOrders event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final orders = await adminRepository.getAllOrders();
      emit(AdminLoadedOrders(orders));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _loadAllRiders(LoadAllRiders event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final riders = await adminRepository.getAllRiders();
      emit(AdminLoadedRiders(riders));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }

  Future<void> _loadAllReviews(LoadAllReviews event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final reviews = await adminRepository.getAllReviews();
      emit(AdminLoadedReviews(reviews));
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }
}
