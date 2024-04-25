import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moulle/model/thing.dart';
import 'package:moulle/view/widget/appbar/basic_app_bar.dart';
import 'package:moulle/view/widget/button/shutter_button.dart';
import 'package:moulle/view/widget/grid/book_preview.dart';
import 'package:moulle/view/widget/header/basic_header.dart';
import 'package:moulle/view/widget/menubar/scroll_menubar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum ActiveModeType {
  camera,
  menu,
  list,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  ActiveModeType activeMode = ActiveModeType.menu;
  bool showMenu = false;
  bool scrollStop = false;
  int duration = 350;
  List<Thing> things = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListenerActive);
    _scrollController.addListener(_scrollListenerShowMenu);

    // (() async {
    //   final data = await Supabase.instance.client.from('things').select();

    //   setState(() {
    //     things = data.map((e) => Thing.fromData(e)).toList();
    //   });
    // })();
  }

  void _scrollListenerActive() {
    if ((_scrollController.offset <=
            _scrollController.position.minScrollExtent) &&
        (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward)) {
      setState(() => activeMode = ActiveModeType.menu);
    }
  }

  void _scrollListenerShowMenu() {
    if (showMenu) {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() => showMenu = false);
      }
    } else {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() => showMenu = true);
      }
    }
  }

  String currentMenu = '모두';
  void setCurrentMenu(String value) => setState(() => currentMenu = value);

  @override
  Widget build(BuildContext context) {
    double contentHeight;
    double menuHeight;
    switch (activeMode) {
      case ActiveModeType.menu:
        contentHeight = MediaQuery.sizeOf(context).height -
            MediaQuery.of(context).padding.top -
            32;
        menuHeight = MediaQuery.sizeOf(context).height -
            MediaQuery.paddingOf(context).top -
            76 -
            42;
        break;
      case ActiveModeType.camera:
        contentHeight = 197;
        menuHeight = 117;
        break;
      case ActiveModeType.list:
        contentHeight = MediaQuery.sizeOf(context).height -
            MediaQuery.of(context).padding.top +
            28;
        menuHeight = MediaQuery.sizeOf(context).height -
            MediaQuery.paddingOf(context).top -
            76 -
            (!showMenu ? -30 : 40);
        break;
    }
    return Scaffold(
      backgroundColor: const Color(0XFF202123),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (activeMode == ActiveModeType.menu) {
                  if (details.delta.dy < -1) {
                    if (!scrollStop) {
                      setState(() => duration = 350);
                      setState(() => activeMode = ActiveModeType.list);
                      setState(() => showMenu = false);
                    }
                  } else if (details.delta.dy > 1) {
                    setState(() => duration = 500);
                    setState(() => activeMode = ActiveModeType.camera);
                  }
                } else if (activeMode == ActiveModeType.camera) {
                  if (details.delta.dy < -1) {
                    setState(() => scrollStop = true);
                    setState(() => activeMode = ActiveModeType.menu);
                  }
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: duration),
                curve: Curves.ease,
                onEnd: () => setState(() => scrollStop = false),
                width: MediaQuery.sizeOf(context).width,
                height: contentHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black.withOpacity(0.1), width: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 14, 0,
                          activeMode == ActiveModeType.camera ? 84 : 66),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BookPreview(
                        scrollController: _scrollController,
                        isActive: activeMode == ActiveModeType.list,
                        list: things,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: duration),
              curve: Curves.ease,
              bottom: menuHeight,
              child: ScrollMenuBar(
                currentMenu: currentMenu,
                setCurrentMenu: setCurrentMenu,
                menuList: const [
                  {'label': '모두'},
                  {
                    'label': '거실 책장',
                    'icon': Icons.shelves,
                  },
                  {
                    'label': '거실 책장2',
                    'icon': Icons.shelves,
                  },
                  {
                    'label': '거실 책장3',
                    'icon': Icons.shelves,
                  },
                  {
                    'label': '거실 책장4',
                    'icon': Icons.shelves,
                  },
                ],
              )),
          Positioned(
            top: -1,
            child: BasicHeader(
              title: 'Moulle',
              bgColor: Colors.white,
              isActive: activeMode == ActiveModeType.list,
              transTitle: currentMenu,
            ),
          ),
          // const Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: CustomAppBar(),
          // ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: ShutterButton(
              onTap: () => setState(
                () {
                  activeMode = ActiveModeType.camera;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
