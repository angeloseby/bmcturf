import 'package:bmcturf/pages/home/homepage.dart';
import 'package:bmcturf/pages/register/registerpage.dart';
import 'package:bmcturf/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isAuthenticated) {
      return const HomePage(); // Show the Home Page if authenticated
    } else {
      return const RegisterPage(); // Show the Login Page if not authenticated
    }
  }
}
