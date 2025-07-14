import 'package:flutter/material.dart';
import 'package:moulle/model/thing.dart';
import 'package:moulle/view/widget/grid/book_preview.dart';
import 'package:moulle/view/widget/header/basic_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Thing> things = [
    Thing(
      id: '1',
      ownerId: '1',
      name: 'asd',
    ),
    Thing(
      id: '1',
      ownerId: '1',
      name: 'asd',
    ),
    Thing(
      id: '1',
      ownerId: '1',
      name: 'asd',
    ),
    Thing(
      id: '1',
      ownerId: '1',
      name: 'asd',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Home();

    return Scaffold(
        backgroundColor: const Color(0XFF202123),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: const BasicHeader(
            title: '책장',
            bgColor: Colors.black,
            transTitle: '책장',
            isActive: true,
          ),
        ),
        body: BookPreview(
          isActive: true,
          list: things,
        ));
  }
}
