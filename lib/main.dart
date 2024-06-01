import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_own_grocery_app_2/blocs/admin/admin_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_state.dart';
import 'package:my_own_grocery_app_2/blocs/cart/cart_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/orders/order_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/products/product_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/users/user_bloc.dart';
import 'package:my_own_grocery_app_2/repositories/admin_repository.dart';
import 'package:my_own_grocery_app_2/repositories/category_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/product_repository.dart';
import 'package:my_own_grocery_app_2/repositories/rider_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/services/firebase_admin_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_auth_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_category_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_order_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_product_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_rider_service.dart';
import 'package:my_own_grocery_app_2/services/firebase_user_service.dart';
import 'blocs/authentication/authentication_event.dart';
import 'blocs/categories/category_bloc.dart';
import 'blocs/categories/category_event.dart';
import 'firebase_options.dart';
import 'package:video_player/video_player.dart';
import 'repositories/authentication_repository.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/authentication/register_screen.dart';
import 'screens/user/home_screen.dart';
import 'blocs/authentication/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthenticationRepository authenticationRepository = AuthenticationRepository(FirebaseAuthService());
  final CategoryRepository categoryRepository = CategoryRepository(firebaseCategoryService: FirebaseCategoryService());
  final ProductRepository productRepository = ProductRepository(firebaseProductService: FirebaseProductService());
  final UserRepository userRepository = UserRepository(firebaseUserService: FirebaseUserService());
  final OrderRepository orderRepository = OrderRepository(orderService: OrderService());
  final AdminRepository adminRepository = AdminRepository(firebaseAdminService: FirebaseAdminService());
  final RiderRepository riderRepository = RiderRepository(firebaseRiderService: FirebaseRiderService());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(authenticationRepository, userRepository),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(categoryRepository: categoryRepository)..add(LoadCategories()),
        ),
        BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(productRepository: productRepository)
        ),
        BlocProvider(
            create: (_) => UserBloc(userRepository: userRepository)
        ),
        BlocProvider(
            create: (_) => CartBloc()
        ),
        BlocProvider(
            create: (_) => OrderBloc(orderRepository: orderRepository)
        ),
        BlocProvider(
            create: (_) => AdminBloc(adminRepository: adminRepository)
        ),
        BlocProvider(
            create: (_) => RiderBloc(riderRepository: riderRepository)
        )
      ],
      child: MyApp(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;

  const MyApp({super.key, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      home: MainScreen(authenticationRepository: authenticationRepository, userRepository: userRepository,),
      initialRoute: '/',
      routes: {
        '/register': (context) => RegisterScreen(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
        '/login': (context) => LoginScreen(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
        '/home': (context) => HomeScreen(authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  const MainScreen({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/intro.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging in...')),
          );
        } else if (state is AuthenticationAuthenticated) {
          Navigator.pushNamed(context, '/home');
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
  child: Scaffold(
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
              : Container(),
          const Center(
            child: Text(
              'Grocery App',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Login With Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () async {
                       BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationGmailLoginRequested());
                      },
                      child: const Text(
                        'Login With Gmail',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to register screen
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ),
);
  }
}
