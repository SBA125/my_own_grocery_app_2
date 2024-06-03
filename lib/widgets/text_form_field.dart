import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/widgets/product_drop_down_menu.dart';

import '../blocs/products/product_bloc.dart';
import '../blocs/products/product_event.dart';
import '../blocs/products/product_state.dart';
import '../models/product.dart';

class SearchTextFormField extends StatefulWidget {
  const SearchTextFormField({super.key});

  @override
  _SearchTextFormFieldState createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends State<SearchTextFormField> {
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;
  List<Product> _searchResults = [];

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: SearchResultDropdown(
            searchResults: _searchResults,
            onSelect: (product) {
              _controller.text = product.name;
              _hideOverlay();
            },
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  final LayerLink _layerLink = LayerLink();

  void _updateSearchResults(List<Product> results) {
    setState(() {
      _searchResults = results;
    });
    if (_overlayEntry == null) {
      _showOverlay(context);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(32),
          child: SizedBox(
            width: 300,
            child: BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductsLoaded) {
                  _updateSearchResults(state.products);
                }
              },
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search by product name',
                  hintStyle: textTheme.bodyMedium!.copyWith(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (productName) {
                  context.read<ProductBloc>().add(SearchProducts(productName));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


