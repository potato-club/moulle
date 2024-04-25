import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ShutterButton extends StatelessWidget {
  const ShutterButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFF3F3F3F),
            shape: BoxShape.circle,
            border: Border(
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
              bottom: BorderSide(width: 4, color: Colors.black),
            ),
          ),
          child: const Icon(
            Symbols.location_searching,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
