import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_state.dart';
import 'package:my_own_grocery_app_2/models/product.dart';
import 'package:my_own_grocery_app_2/repositories/product_repository.dart';
import 'package:my_own_grocery_app_2/widgets/text_form_field.dart';

void main() {
  testWidgets('SearchTextFormField widget test', (WidgetTester tester) async {
    late ProductRepository productRepository = MockProductRepository();

    final products = [
      Product(productID: '1', name: 'Apple', description: '', price: 10, imageUrl: 'url', quantity: 100, inStock: true),
      Product(productID: '2', name: 'Banana', description: '', price: 10, imageUrl: 'url', quantity: 100, inStock: true),
      Product(productID: '3', name: 'Orange', description: '', price: 10, imageUrl: 'url', quantity: 100, inStock: true),
    ];

    final productBloc = ProductBloc(productRepository: productRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<ProductBloc>.value(
            value: productBloc,
            child: const SearchTextFormField(),
          ),
        ),
      ),
    );


    expect(find.byType(TextFormField), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'App');
    expect(productBloc.state, emits(ProductsLoaded(products)));
    await tester.pumpAndSettle();

    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Banana'), findsOneWidget);
    expect(find.text('Orange'), findsOneWidget);

    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();

    expect(find.text('Apple'), findsOneWidget);


    await tester.tap(find.byType(Overlay));
    await tester.pumpAndSettle();

    expect(find.byType(Overlay), findsNothing);
  });
}

class MockProductRepository extends Mock implements ProductRepository{
}
