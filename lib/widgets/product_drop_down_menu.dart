import 'package:flutter/material.dart';

import '../models/product.dart';

class SearchResultDropdown extends StatelessWidget {
  final List<Product> searchResults;
  final Function(Product) onSelect;

  const SearchResultDropdown({
    super.key,
    required this.searchResults,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final product = searchResults[index];
          return ListTile(
            title: Text(product.name),
            onTap: () => onSelect(product),
          );
        },
      ),
    );
  }
}
