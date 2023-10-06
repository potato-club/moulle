import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moulle/view/widget/appbar/appbar.dart';
import 'package:moulle/view/widget/appbar/camera_button.dart';
import 'package:moulle/view/widget/grid/book_preview.dart';
import 'package:moulle/view/widget/header/basic_header.dart';
import 'package:moulle/view/widget/menubar/scroll_menubar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isActive = false;
  bool showMenu = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListenerActive);
    _scrollController.addListener(_scrollListenerShowMenu);
  }

  void _scrollListenerActive() {
    if ((_scrollController.offset <=
            _scrollController.position.minScrollExtent) &&
        (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward)) {
      setState(() => isActive = false);
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
    const activeMargin = -30;
    const margin = 38;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).padding.top -
                (isActive ? activeMargin : margin),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 72),
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
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (!isActive) {
                        if (details.delta.dy < 0) {
                          setState(() => isActive = true);
                          setState(() => showMenu = false);
                        }
                      }
                    },
                    child: BookPreview(
                      scrollController: _scrollController,
                      isActive: isActive,
                      list: const [
                        {
                          'img':
                              'https://image.aladin.co.kr/product/31867/71/cover500/k132833528_2.jpg',
                          'label': '비가 오면 열리는 상점',
                          'writer': '유영광'
                        },
                        {
                          'img':
                              'https://image.aladin.co.kr/product/32463/98/cover500/8934940980_1.jpg',
                          'label': '나만 그런 게 아니었어',
                          'writer': '요시타케 신스케'
                        },
                        {
                          'img':
                              'https://image.aladin.co.kr/product/32470/2/cover500/k322935408_1.jpg',
                          'label': '편집 만세',
                          'writer': '리베카 리'
                        },
                        {
                          'img':
                              'https://image.aladin.co.kr/product/31867/71/cover500/k132833528_2.jpg',
                          'label': '비가 오면 열리는 상점',
                          'writer': '유영광'
                        },
                        {
                          'img':
                              'https://image.aladin.co.kr/product/32463/98/cover500/8934940980_1.jpg',
                          'label': '나만 그런 게 아니었어',
                          'writer': '요시타케 신스케'
                        },
                        {
                          'img':
                              'https://image.aladin.co.kr/product/32470/2/cover500/k322935408_1.jpg',
                          'label': '편집 만세',
                          'writer': '리베카 리'
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
            top: MediaQuery.paddingOf(context).top +
                36 +
                (isActive && !showMenu ? activeMargin : margin),
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
            isActive: isActive,
            transTitle: currentMenu,
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: HomeAppbar(),
        ),
        const Positioned(bottom: 16, left: 0, right: 0, child: CameraButton()),
      ],
    ));
  }
}
