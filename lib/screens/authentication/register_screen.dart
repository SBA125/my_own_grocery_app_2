
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_event.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/home_screen.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication_state.dart';
import '../../repositories/authentication_repository.dart';
class RegisterScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  const RegisterScreen({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pictures/96.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (_) => AuthenticationBloc(authenticationRepository, userRepository),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RegisterForm(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  const RegisterForm({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String password = '';
    return Form(
      key: _formKey,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Loading...')),
            );
          } else if (state is AuthenticationAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(
                  authenticationRepository: widget.authenticationRepository,
                  userRepository: widget.userRepository, 
                orderRepository: widget.orderRepository,
              )
              ),
            );
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration failed: ${state.message}')),
            );
          }
        },
  child: Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black, // Set border color
          width: 1.0, // Set border width
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: 420,
      padding: const EdgeInsets.all(16),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add email validation logic here if needed
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password',labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add password validation logic
                  return null;
                },
                onSaved: (value) => password = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirm Password', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  // Add password confirmation validation logic
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthenticationBloc>().add(AuthenticationSignUpRequested(
                      username: name,
                      email: email,
                      password: password,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful')),
                    );
                  }
                },
                child: const Text('Register',style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
    ),
  ),
      ),
    );
  }
}
