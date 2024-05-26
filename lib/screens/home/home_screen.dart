import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_event.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/widgets/side_drawer.dart';
import 'package:my_own_grocery_app_2/widgets/text_form_field.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication_state.dart';
import '../../blocs/categories/category_bloc.dart';
import '../../blocs/categories/category_state.dart';
import '../../main.dart';
import '../../models/category.dart';
import '../category_screen/category_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const HomeScreen({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(onPressed: ()=> Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu))
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Pickup',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Location 1',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Badge(
                  isLabelVisible: true,
                  label: Text(''),
                  child: Icon(Icons.shopping_cart)))
        ],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: SearchTextFormField(),
        ),
      ),
      drawer: SideDrawer(authenticationRepository: authenticationRepository, userRepository: userRepository),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(authenticationRepository, userRepository),
          ),
        ],
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pictures/96.jpg'),
              fit: BoxFit.cover
            ),
          ),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationUnauthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(authenticationRepository: authenticationRepository)),
                );
              }
            },
            child: const Padding(
              padding:  EdgeInsets.all(16.0),
              child: CategoryList(),
            ),
          ),
        ),
      ),
    );
  }
}





