import 'package:flutter/material.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';

import '../../repositories/admin_repository.dart';

class AdminScreen extends StatelessWidget{
  final AuthenticationRepository authenticationRepository;
  final AdminRepository adminRepository;

  const AdminScreen({super.key, required this.authenticationRepository, required this.adminRepository});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: ,
      ),
    );
  }
}