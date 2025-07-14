import 'package:flutter/material.dart';

enum SocialType {
  google,
  apple,
}

class SocialSignButton extends StatefulWidget {
  const SocialSignButton({super.key, this.onPressed, required this.type});

  const SocialSignButton.google({super.key, this.onPressed})
      : type = SocialType.google;

  const SocialSignButton.apple({super.key, this.onPressed})
      : type = SocialType.apple;

  final VoidCallback? onPressed;

  final SocialType type;

  @override
  _SocialSignButtonState createState() => _SocialSignButtonState();
}

class _SocialSignButtonState extends State<SocialSignButton> {
  bool _isTouched = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) => setState(() => _isTouched = true),
      onTapUp: (_) => setState(() => _isTouched = false),
      onTapCancel: () => setState(() => _isTouched = false),
      onTap: widget.onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: 225,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.1)),
            left: BorderSide(color: Colors.black.withOpacity(0.1)),
            right: BorderSide(color: Colors.black.withOpacity(0.1)),
            bottom: BorderSide(
                width: _isTouched ? 1.0 : 4.0,
                color: Colors.black.withOpacity(0.1)),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(
              switch (widget.type) {
                (SocialType.google) => 'assets/images/socials/google.png',
                (SocialType.apple) => 'assets/images/socials/apple.png',
              },
            ),
            Expanded(
              child: Text(
                switch (widget.type) {
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
