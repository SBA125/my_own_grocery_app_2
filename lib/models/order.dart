import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime createdAt;
  final String paymentMethod;
  final String userId;
  final String userName;
  final String contactNo;
  final String address;
  final String status;
  final bool isReview;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.createdAt,
    required this.paymentMethod,
    required this.userId,
    required this.userName,
    required this.contactNo,
    required this.address,
    required this.status,
    required this.isReview,
  });

  Order copyWith({String? status, bool? isReview}) {
    return Order(
      id: id,
      items: items,
      total: total,
      createdAt: createdAt,
      paymentMethod: paymentMethod,
      userId: userId,
      userName: userName,
      contactNo: contactNo,
      address: address,
      status: status ?? this.status,
      isReview: isReview ?? this.isReview,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'createdAt': createdAt,
      'paymentMethod': paymentMethod,
      'userId': userId,
      'userName': userName,
      'contactNo': contactNo,
      'address': address,
      'status': status,
      'isReview': isReview,
    };
  }

  factory Order.fromMap(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      items: (data['items'] as List)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      total: data['total'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'],
      userId: data['userId'],
      userName: data['userName'],
      contactNo: data['contactNo'],
      address: data['address'],
      status: data['status'],
      isReview: data['isReview']
    );
  }
}