import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final Widget child;
  const SmallIconButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: child,
      ),
    );
  }
}
