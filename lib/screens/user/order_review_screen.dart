import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_own_grocery_app_2/blocs/orders/order_event.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/home_screen.dart';
import 'package:my_own_grocery_app_2/services/firebase_review_service.dart';
import '../../blocs/orders/order_bloc.dart';
import '../../blocs/review/review_bloc.dart';
import '../../blocs/review/review_event.dart';
import '../../blocs/review/review_state.dart';
import '../../models/review.dart';
import '../../repositories/review_repository.dart';

class AddReviewScreen extends StatelessWidget {
  final String orderID;
  final OrderRepository orderRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const AddReviewScreen({
    super.key, required this.orderID, 
    required this.orderRepository, 
    required this.authenticationRepository, 
    required this.userRepository
  });

  @override
  Widget build(BuildContext context) {
    ReviewRepository reviewRepository = ReviewRepository(firebaseReviewService: FirebaseReviewService());
    return Scaffold(
      appBar: AppBar(title: const Text('Add Review')),
      body: MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (_) => ReviewBloc(reviewRepository: reviewRepository),
),
    BlocProvider(
      create: (context) => OrderBloc(orderRepository: orderRepository),
    ),
  ],
  child: AddReviewForm(orderID: orderID, authenticationRepository: authenticationRepository, userRepository: userRepository, orderRepository: orderRepository,),
),
    );
  }
}

class AddReviewForm extends StatefulWidget {
  final String orderID;
  final OrderRepository orderRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const AddReviewForm({super.key, required this.orderID, required this.authenticationRepository, required this.userRepository, required this.orderRepository});

  @override
  _AddReviewFormState createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  late String _rating;
  String? _additionalNotes;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewLoading) {
          // Show loading indicator
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Submitting review...')));
        } else if (state is ReviewSuccess) {
          // Show success message and navigate back
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Review submitted successfully')));
          context.read<OrderBloc>().add(ChangeOrderStatus(widget.orderID, 'closed'));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(authenticationRepository: widget.authenticationRepository , userRepository: widget.userRepository, orderRepository: widget.orderRepository,),
            ),
          );
        } else if (state is ReviewError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating (out of 5)'),
                onSaved: (value) {
                  _rating = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Additional Notes'),
                onSaved: (value) {
                  _additionalNotes = value;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final review = Review(
                      reviewID: UniqueKey().toString(),
                      orderID: widget.orderID,
                      createdAt: DateTime.now(),
                      rating: _rating,
                      additionalNotes: _additionalNotes,
                    );
                    context.read<ReviewBloc>().add(AddReview(review));
                  }
                },
                child: const Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
