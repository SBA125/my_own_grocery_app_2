import 'package:equatable/equatable.dart';

import '../../models/category.dart';
import '../../models/product.dart';


abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class LoadAllUsers extends AdminEvent {}

class DeleteUser extends AdminEvent {
  final String userID;
  const DeleteUser(this.userID);

  @override
  List<Object> get props => [userID];
}

class AddProduct extends AdminEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends AdminEvent {
  final String productId;
  final Product product;

  const UpdateProduct(this.productId, this.product);

  @override
  List<Object> get props => [productId, product];
}

class DeleteProduct extends AdminEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class LoadAllProducts extends AdminEvent {}

class AddCategory extends AdminEvent {
  final Category category;

  const AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends AdminEvent {
  final String categoryId;
  final Category category;

  const UpdateCategory(this.categoryId, this.category);

  @override
  List<Object> get props => [categoryId, category];
}

class DeleteCategory extends AdminEvent {
  final String categoryId;

  const DeleteCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class LoadAllCategories extends AdminEvent {}

class LoadAllOrders extends AdminEvent {}

class LoadAllRiders extends AdminEvent {}

class LoadAllReviews extends AdminEvent {}
