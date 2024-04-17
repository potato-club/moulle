import 'package:flutter/material.dart';
import 'package:moulle/view/screen/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await supabase.auth.signInWithOAuth(
              OAuthProvider.google,
              redirectTo: 'com.ciart.moulle://login-callback',
            );

            if (response) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
