import 'dart:ui';

import 'package:flutter/material.dart';

class LogoBackground extends StatelessWidget {
  const LogoBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: _LogoBackgroundPainter(),
      ),
    );
  }
}

class _LogoBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    canvas.drawOval(
      Rect.fromLTWH(centerX + 97, -70, 579, 379),
      Paint()
        ..color = const Color.fromARGB(52, 0, 58, 247)
        ..style = PaintingStyle.fill
        ..imageFilter = ImageFilter.blur(
          sigmaX: 64,
          sigmaY: 64,
          tileMode: TileMode.decal,
        ),
    );

    canvas.drawOval(
      Rect.fromLTWH(centerX - 366, -166, 579, 379),
      Paint()
        ..color = const Color.fromARGB(52, 2, 255, 166)
        ..style = PaintingStyle.fill
        ..imageFilter = ImageFilter.blur(
          sigmaX: 64,
          sigmaY: 64,
          tileMode: TileMode.decal,
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
