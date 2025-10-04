import 'package:flutter/material.dart';

class BookItemBox extends StatefulWidget {
  const BookItemBox({super.key});

  @override
  State<BookItemBox> createState() => _BookItemBoxState();
}

class _BookItemBoxState extends State<BookItemBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
    );
  }
}
