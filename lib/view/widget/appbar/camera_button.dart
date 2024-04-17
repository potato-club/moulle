import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            )
          ]),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(Symbols.location_searching,
                size: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
