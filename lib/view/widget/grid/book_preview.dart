import 'package:faker/faker.dart' show Faker;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:moulle/model/thing.dart';
import 'package:moulle/view/widget/appbar/basic_app_bar.dart';
import 'package:moulle/view/widget/button/small_icon_button.dart';
import 'package:moulle/view/widget/header/basic_header.dart';
import 'package:moulle/view/widget/menubar/scroll_menubar.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:camera/camera.dart';

class BookPreview extends StatefulWidget {
  final List<Thing> list;
  final bool isActive;
  const BookPreview({
    super.key,
    required this.list,
    required this.isActive,
  });

  @override
  State<BookPreview> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {
  Widget gridItem(
    String img,
    String label,
    String writer,
  ) {
    return GestureDetector(
      onTap: () => print(label),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: img.isEmpty ? const Placeholder() : Image.network(img),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            writer,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    // Cache the system UI insets outside of the scaffold for later use.
    // This is because the scaffold adds the height of the navigation bar
    // to the padding.bottom of the inherited MediaQuery and re-exposes it
    // to the descendant widgets. Therefore, the descendant widgets cannot get
    // the net system UI insets.
    final systemUiInsets = MediaQuery.of(context).padding;

    final result = Scaffold(
      // Enable this flag since the navigation bar
      // will be hidden when the sheet is dragged down.
      extendBody: true,
      // Enable this flag since we want the sheet handle to be drawn
      // behind the tab bar when the sheet is fully expanded.
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const _AppBar(),
      body: Stack(
        children: [
          const _Map(),
          _ContentSheet(systemUiInsets: systemUiInsets),
        ],
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
      floatingActionButton: const _MapButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    return DefaultTabController(
      length: _AppBar.tabs.length,
      // Provides a SheetController to the descendant widgets
      // to perform some sheet position driven animations.
      // The sheet will look up and use this controller unless
      // another one is manually specified in the constructor.
      // The descendant widgets can also get this controller by
      // calling 'DefaultSheetController.of(context)'.
      child: DefaultSheetController(
        child: result,
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton();

  @override
  Widget build(BuildContext context) {
    final sheetController = DefaultSheetController.of(context);

    void onPressed() {
      if (sheetController.metrics case final it?) {
        // Collapse the sheet to reveal the map behind.
        sheetController.animateTo(
          SheetOffset.absolute(it.minOffset),
          curve: Curves.fastOutSlowIn,
        );
      }
    }

    final result = FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Colors.black,
      label: const Text('Map'),
      icon: const Icon(Icons.map),
    );

    // It is easy to create sheet position driven animations
    // by using 'PositionDrivenAnimation', a special kind of
    // 'Animation<double>' whose value changes from 0 to 1 as
    // the sheet position changes from 'startPosition' to 'endPosition'.
    final animation = SheetOffsetDrivenAnimation(
      controller: DefaultSheetController.of(context),
      // The initial value of the animation is required
      // since the sheet position is not available at the first build.
      initialValue: 1,
      // If null, the minimum position will be used. (Default)
      startOffset: null,
      // If null, the maximum position will be used. (Default)
      endOffset: null,
    ).drive(CurveTween(curve: Curves.easeInExpo));

    // Hide the button when the sheet is dragged down.
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: result,
      ),
    );
  }
}

class _Map extends StatefulWidget {
  const _Map();

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.medium,
      );
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox.expand(
        child: _controller == null || !_controller!.value.isInitialized
            ? const Center(child: CircularProgressIndicator())
            : AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
      ),
    );
  }
}

class _ContentSheet extends StatelessWidget {
  const _ContentSheet({
    required this.systemUiInsets,
  });

  final EdgeInsets systemUiInsets;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHeight = constraints.maxHeight;
        final appbarHeight = MediaQuery.of(context).padding.top;
        final handleHeight = const _ContentSheetHandle().preferredSize.height;
        final sheetHeight = parentHeight - appbarHeight + handleHeight;
        final minSheetOffset =
            SheetOffset.absolute(handleHeight + systemUiInsets.bottom);

        return SheetViewport(
          child: Sheet(
            scrollConfiguration: const SheetScrollConfiguration(),
            snapGrid: SheetSnapGrid(
              snaps: [minSheetOffset, const SheetOffset(1)],
            ),
            decoration: const MaterialSheetDecoration(
              size: SheetSize.fit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            child: SizedBox(
              height: sheetHeight,
              child: const Column(
                children: [
                  _ContentSheetHandle(),
                  Expanded(child: _HouseList()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContentSheetHandle extends StatelessWidget
    implements PreferredSizeWidget {
  const _ContentSheetHandle();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildIndicator(),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  '646 national park homes',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Container(
      height: 6,
      width: 40,
      decoration: const ShapeDecoration(
        color: Colors.black12,
        shape: StadiumBorder(),
      ),
    );
  }
}

class _HouseList extends StatelessWidget {
  const _HouseList();

  static List<Thing> list = [
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

  Widget buildGridItem(
    String img,
    String label,
    String writer,
  ) {
    return GestureDetector(
      onTap: () => print(label),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: img.isEmpty ? const Placeholder() : Image.network(img),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            writer,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = CustomScrollView(
      scrollBehavior:
          ScrollConfiguration.of(context).copyWith(scrollbars: false),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.red,
            height: 200,
          ),
        ),
        SliverFloatingHeader(
          child: ScrollMenuBar(
            currentMenu: '모두',
            setCurrentMenu: (value) {},
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
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childCount: list.length,
            itemBuilder: (context, index) {
              if (list[index].images.isEmpty) {
                return buildGridItem('', list[index].name, '익명');
              }

              return buildGridItem(
                list[index].images.first,
                list[index].name,
                '익명',
              );
            },
          ),
        ),
      ],
    );

    // Hide the list when the sheet is dragged down.
    return FadeTransition(
      opacity: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(
        CurveTween(curve: Curves.easeOutCubic),
      ),
      child: result,
    );
  }
}

class _House {
  const _House({
    required this.title,
    required this.rating,
    required this.distance,
    required this.charge,
    required this.image,
  });

  factory _House.random() {
    var faker = Faker();

    return _House(
      title: '${faker.address.city()}, ${faker.address.country()}',
      rating: faker.randomGenerator.decimal(scale: 1.5, min: 3.5),
      distance: faker.randomGenerator.integer(300, min: 50),
      charge: faker.randomGenerator.integer(2000, min: 500),
      image: faker.image.loremPicsum(width: 300, height: 300),
    );
  }

  final String title;
  final double rating;
  final int distance;
  final int charge;
  final String image;
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  static const tabs = [
    Tab(text: 'National parks', icon: Icon(Icons.forest_outlined)),
    Tab(text: 'Tiny homes', icon: Icon(Icons.cabin_outlined)),
    Tab(text: 'Ryokan', icon: Icon(Icons.hotel_outlined)),
    Tab(text: 'Play', icon: Icon(Icons.celebration_outlined)),
  ];

  static const topHeight = 56.0;

  @override
  Size get preferredSize => const Size.fromHeight(topHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      backgroundColor: const Color(0xFF54A3FF),
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: SizedBox(
        height: topHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '책장',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallIconButton(
                    child: Icon(Symbols.search, size: 24, color: Colors.white)),
                const SizedBox(width: 8),
                SmallIconButton(
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87,
                    ),
                    child: Image.network(
                        'https://yt3.ggpht.com/Bdu9TPjvhlxC3qYWtbbPx5fYBMU8eC6dkhwy-eiSFRU3Z1eS2vuvZrtDuzZ_fSyHAc5ukjGAl7k=s88-c-k-c0x00ffffff-no-rj'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final result = BottomNavigationBar(
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.pink,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Wishlists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.luggage_outlined),
          label: 'Trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox_outlined),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );

    // Hide the navigation bar when the sheet is dragged down.
    return SlideTransition(
      position: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(
        Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ),
      ),
      child: result,
    );
  }
}

class _HouseCard extends StatelessWidget {
  const _HouseCard(this.house);

  final _House house;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryTextStyle =
        textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final secondaryTextStyle = textTheme.titleMedium;
    final tertiaryTextStyle =
        textTheme.titleMedium?.copyWith(color: Colors.black54);

    final image = Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Image.network(
          house.image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );

    final rating = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: secondaryTextStyle?.color, size: 18),
        const SizedBox(width: 4),
        Text(house.rating.toStringAsFixed(1), style: secondaryTextStyle),
      ],
    );

    final heading = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            house.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: primaryTextStyle,
          ),
        ),
        const SizedBox(width: 8),
        rating,
      ],
    );

    final description = [
      Text('${house.distance} kilometers away', style: tertiaryTextStyle),
      const SizedBox(height: 4),
      Text('5 nights · Jan 14 - 19', style: tertiaryTextStyle),
      const SizedBox(height: 16),
      Text(
        '\$${house.charge} total before taxes',
        style: secondaryTextStyle?.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    ];

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            const SizedBox(height: 16),
            heading,
            const SizedBox(height: 8),
            ...description,
          ],
        ),
      ),
    );
  }
}

final _houses = List.generate(50, (_) => _House.random());
