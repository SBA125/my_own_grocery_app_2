import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/admin/admin_bloc.dart';
import '../../blocs/admin/admin_event.dart';
import '../../blocs/admin/admin_state.dart';

class AdminRiderScreen extends StatelessWidget {
  const AdminRiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load users when the widget is built
    BlocProvider.of<AdminBloc>(context).add(LoadAllRiders());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Riders'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminLoadedRiders) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Adjust the number of columns as needed
                childAspectRatio: 5/2, // Adjust the aspect ratio as needed
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: state.riders.length,
              itemBuilder: (context, index) {
                final rider = state.riders[index];
                return Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'User#${index+1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        Text(
                          'Username: ${rider.userID}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Email: ${rider.riderID}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is AdminFailure) {
            return Center(child: Text('Failed to load riders: ${state.error}'));
          } else {
            return const Center(child: Text('No riders found'));
          }
        },
      ),
    );
  }
}
