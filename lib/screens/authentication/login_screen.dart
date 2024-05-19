// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/screens/home/home_screen.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication_event.dart';
import '../../blocs/authentication/authentication_state.dart';
import '../../repositories/authentication_repository.dart';
import '../../services/firebase_auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const LoginScreen({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(authenticationRepository),
          ),
        ],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          // Handle authentication states here
          if (state is AuthenticationLoading) {
            // Show loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in...')),
            );
          } else if (state is AuthenticationAuthenticated) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(authenticationRepository:
            AuthenticationRepository(
                FirebaseAuthService()),)));
            // Navigate to home screen or perform other actions
            // Navigator.of(context).pushReplacementNamed('/register_screen');
          } else if (state is AuthenticationError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Add email validation logic here if needed
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // Add password validation logic here if needed
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Dispatch AuthenticationSignInRequested event
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationSignInRequested(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
