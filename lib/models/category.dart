class Category {
  final String categoryID;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> productIDs; // List of product IDs associated with this category

  Category({
    required this.categoryID,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.productIDs,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      categoryID: data['categoryID'],
      name: data['name'],
      description: data['description'],
      imageUrl:data['imageUrl'],
      productIDs: List<String>.from(data['productIDs']) ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'productIDs': productIDs,
    };
  }
}

