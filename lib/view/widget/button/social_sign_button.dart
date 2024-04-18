import 'package:flutter/material.dart';

enum SocialType {
  google,
  apple,
}

class SocialSignButton extends StatelessWidget {
  const SocialSignButton({super.key, this.onPressed, required this.type});

  const SocialSignButton.google({super.key, this.onPressed})
      : type = SocialType.google;

  const SocialSignButton.apple({super.key, this.onPressed})
      : type = SocialType.apple;

  final VoidCallback? onPressed;

  final SocialType type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: 225,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(
              switch (type) {
                (SocialType.google) => 'assets/images/socials/google.png',
                (SocialType.apple) => 'assets/images/socials/apple.png',
              },
            ),
            Expanded(
              child: Text(
                switch (type) {
                  (SocialType.google) => 'Google로 로그인하기',
                  (SocialType.apple) => 'Apple로 로그인하기',
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
