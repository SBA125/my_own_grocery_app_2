class Category {
  final String categoryID;
  final String name;
  final String imageUrl;
  final List<String> productIDs;

  Category({
    required this.categoryID,
    required this.name,
    required this.imageUrl,
    required this.productIDs,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      categoryID: data['categoryID'],
      name: data['name'],
      imageUrl:data['imageUrl'],
      productIDs: List<String>.from(data['productIDs']) ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'name': name,
      'imageUrl': imageUrl,
      'productIDs': productIDs,
    };
  }

  Category copyWith({
    required String categoryID,
    required String name,
    required String imageUrl,
    required List<String> productIDs,
  }) {
    return Category(
      categoryID: categoryID,
      name: name,
      imageUrl: imageUrl,
      productIDs: productIDs,
    );
  }
}
