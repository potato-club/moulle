import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.img});

  final String id;
  final String img;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('detail'),
      onDismissed: (direction) => Navigator.pop(context),
      direction: DismissDirection.down,
      child: Hero(
          transitionOnUserGestures: true,
          tag: widget.id,
          child: Image.network(widget.img)),
    );
  }
}
