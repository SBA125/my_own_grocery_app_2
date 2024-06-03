import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/admin/admin_main_screen.dart';
import 'package:my_own_grocery_app_2/screens/rider/rider_screen.dart';
import 'package:my_own_grocery_app_2/screens/user/home_screen.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication_event.dart';
import '../../blocs/authentication/authentication_state.dart';
import '../../repositories/authentication_repository.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  const LoginScreen({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pictures/96.jpg'),
            fit: BoxFit.cover,
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
            child: LoginForm(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  const LoginForm({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in...')),
            );
          } else if (state is AuthenticationAuthenticated) {
            if(state.role == 'user'){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(
                  authenticationRepository: widget.authenticationRepository,
                  userRepository: widget.userRepository,
                  orderRepository: widget.orderRepository,
                )
                ),
              );
            } else if(state.role =='admin'){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminMainScreen(authenticationRepository: widget.authenticationRepository, userRepository: widget.userRepository,)
                ),
              );
            } else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  RiderScreen(authenticationRepository: widget.authenticationRepository, userRepository: widget.userRepository,)
                  ),
              );
            }

          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 300,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationSignInRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 25),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
