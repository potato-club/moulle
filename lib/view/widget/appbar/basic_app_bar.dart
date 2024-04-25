import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const appBarHeight = 71.0;

    return Container(
      height: appBarHeight,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.15),
            //   blurRadius: 6.0,
            //   spreadRadius: 2.0,
            //   offset: const Offset(0, 2),
            // )
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarButton(
              icon: Symbols.star,
              label: "랭킹",
              onTap: () {},
            ),
            AppBarButton(
              icon: Symbols.home,
              label: "홈",
              onTap: () {},
            ),
            AppBarButton(
              icon: Symbols.trophy,
              label: "업적",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;

  final String label;

  final bool isActive;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 42,
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 24,
              color: const Color(0XFF1C1B1F),
              fill: isActive ? 1.0 : 0.0,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
