import 'package:equatable/equatable.dart';

import '../../models/category.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../../models/review.dart';
import '../../models/rider.dart';
import '../../models/user.dart';


abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoadedUsers extends AdminState {
  final List<User> users;

  const AdminLoadedUsers(this.users);

  @override
  List<Object> get props => [users];
}

class AdminLoadedProducts extends AdminState {
  final List<Product> products;

  const AdminLoadedProducts(this.products);

  @override
  List<Object> get props => [products];
}

class AdminLoadedCategories extends AdminState {
  final List<Category> categories;

  const AdminLoadedCategories(this.categories);

  @override
  List<Object> get props => [categories];
}

class AdminLoadedOrders extends AdminState {
  final List<Order> orders;

  const AdminLoadedOrders(this.orders);

  @override
  List<Object> get props => [orders];
}

class AdminLoadedRiders extends AdminState {
  final List<User> riders;

  const AdminLoadedRiders(this.riders);

  @override
  List<Object> get props => [riders];
}

class AdminLoadedReviews extends AdminState {
  final List<Review> reviews;

  const AdminLoadedReviews(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class AdminSuccess extends AdminState {}

class AdminFailure extends AdminState {
  final String error;

  const AdminFailure(this.error);

  @override
  List<Object> get props => [error];
}
