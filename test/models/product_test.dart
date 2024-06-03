import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_own_grocery_app_2/models/product.dart';

void main() {
  group('Product', () {
    test('Properties should be set correctly', () {
      const String productID = '1';
      const String name = 'Product Name';
      const String description = 'Product Description';
      const int price = 50;
      const String imageUrl = 'image_url.jpg';
      const int quantity = 10;
      const bool inStock = true;

      final product = Product(
        productID: productID,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        quantity: quantity,
        inStock: inStock,
      );

      expect(product.productID, productID);
      expect(product.name, name);
      expect(product.description, description);
      expect(product.price, price);
      expect(product.imageUrl, imageUrl);
      expect(product.quantity, quantity);
      expect(product.inStock, inStock);
    });

    test('copyWith should create a new instance with updated values', () {
      final product = Product(
        productID: '1',
        name: 'Product Name',
        description: 'Product Description',
        price: 50,
        imageUrl: 'image_url.jpg',
        quantity: 10,
        inStock: true,
      );

      final updatedProduct = product.copyWith(
        name: 'Updated Product Name',
        price: 60,
        quantity: 15, productID: '', description: '', imageUrl: '', inStock: null,
      );

      expect(updatedProduct.productID, product.productID);
      expect(updatedProduct.name, 'Updated Product Name');
      expect(updatedProduct.description, product.description);
      expect(updatedProduct.price, 60);
      expect(updatedProduct.imageUrl, product.imageUrl);
      expect(updatedProduct.quantity, 15);
      expect(updatedProduct.inStock, product.inStock);
    });

    test('toMap should return a map representation of the object', () {
      final product = Product(
        productID: '1',
        name: 'Product Name',
        description: 'Product Description',
        price: 50,
        imageUrl: 'image_url.jpg',
        quantity: 10,
        inStock: true,
      );

      final map = product.toMap();

      expect(map['productID'], product.productID);
      expect(map['name'], product.name);
      expect(map['description'], product.description);
      expect(map['price'], product.price);
      expect(map['imageUrl'], product.imageUrl);
      expect(map['quantity'], product.quantity);
      expect(map['inStock'], product.inStock);
    });

    // test('fromSnapshot should create an instance from a document snapshot', () {
    //   final data = {
    //     'name': 'Product Name',
    //     'description': 'Product Description',
    //     'price': 50,
    //     'imageUrl': 'image_url.jpg',
    //     'quantity': 10,
    //     'inStock': true,
    //   };
    //   final snapshot = DocumentSnapshot(
    //     data: data,
    //     id: '1',
    //     reference: FirebaseFirestore.instance.doc('products/1'),
    //   );
    //
    //   final product = Product.fromSnapshot(snapshot);
    //
    //   expect(product.productID, '1');
    //   expect(product.name, 'Product Name');
    //   expect(product.description, 'Product Description');
    //   expect(product.price, 50);
    //   expect(product.imageUrl, 'image_url.jpg');
    //   expect(product.quantity, 10);
    //   expect(product.inStock, true);
    // });

    test('fromMap should create an instance from a map', () {
      final data = {
        'productID': '1',
        'name': 'Product Name',
        'description': 'Product Description',
        'price': 50,
        'imageUrl': 'image_url.jpg',
        'quantity': 10,
        'inStock': true,
      };

      final product = Product.fromMap(data);

      expect(product.productID, '1');
      expect(product.name, 'Product Name');
      expect(product.description, 'Product Description');
      expect(product.price, 50);
      expect(product.imageUrl, 'image_url.jpg');
      expect(product.quantity, 10);
      expect(product.inStock, true);
    });
  });
}
