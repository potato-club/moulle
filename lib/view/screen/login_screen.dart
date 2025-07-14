import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moulle/view/screen/home_screen.dart';
import 'package:moulle/view/widget/background/logo_background.dart';
import 'package:moulle/view/widget/button/social_sign_button.dart';
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
      body: Stack(
        children: [
          const Expanded(child: LogoBackground()),
          Column(
            children: [
              Expanded(
                child: Center(child: Image.asset('assets/images/logo.png')),
              ),
              Column(
                children: [
                  SocialSignButton.google(
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
                  ),
                  const SizedBox(height: 16),
                  SocialSignButton.apple(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 64),
            ],
          ),
        ],
      ),
    );
  }
}
