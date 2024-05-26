import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_state.dart';
import 'package:my_own_grocery_app_2/main.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user_profile/user_profile_screen.dart';

class SideDrawer extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const SideDrawer({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.account_circle, size: 80),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfileScreen(userRepository: userRepository, authenticationRepository: authenticationRepository)),
                    );
                  },
                  child: const Text('View Profile', style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing...')),
                );
              } else if (state is AuthenticationUnauthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(authenticationRepository: authenticationRepository)),
                );
              } else if (state is AuthenticationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: ${state.message}')),
                );
              }
            },
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        authenticationRepository.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen(authenticationRepository: authenticationRepository)),
                        );
                      },
                      icon: const Icon(Icons.logout_rounded, color: Colors.black,),
                      label: const Text('Logout', style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

