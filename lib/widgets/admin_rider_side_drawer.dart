import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/authentication/authentication_state.dart';
import '../main.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/user_repository.dart';

class AdminRiderSideDrawer extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;


  const AdminRiderSideDrawer({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.account_circle, size: 80),
                // Text(
                //   '${userRepository.displayUserDetails()}'
                // ),
                Row(
                  children: [
                    Icon(Icons.email),
                  ],
                )
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
                          MaterialPageRoute(builder: (context) => MainScreen(authenticationRepository: authenticationRepository, userRepository: userRepository,)),
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