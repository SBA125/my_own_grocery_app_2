import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/users/user_event.dart';
import 'package:my_own_grocery_app_2/models/user.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/home_screen.dart';

import '../../blocs/users/user_bloc.dart';
import '../../blocs/users/user_state.dart';
import '../../repositories/user_repository.dart';

class UserProfileScreen extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  final OrderRepository orderRepository;

  const UserProfileScreen({super.key, required this.userRepository, required this.authenticationRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userRepository: userRepository , authenticationRepository: authenticationRepository, orderRepository: orderRepository,)),
          );
        },
          icon: const Icon(Icons.arrow_back),

        ),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(userRepository: userRepository)..add(FetchUserDetails()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoaded) {
              final loadedUser = state.user;
              return _buildUserProfile(loadedUser);
            } else if (state is UserError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return const Center(
                child: Text('No user data available'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserProfile(User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.account_circle,
            size: 100,
          ),
          const SizedBox(height: 16),
          Text('Username: ${user.username}', style: const TextStyle(fontSize: 18)),
          Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
          // Add other user details here
        ],
      ),
    );
  }
}

