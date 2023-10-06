import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    Widget generateMenu(IconData icon, String label, bool isActive) {
      return SizedBox(
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
          ));
    }

    const appbarHeight = 71.0;
    return Container(
      height: appbarHeight,
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
            generateMenu(Symbols.star, "랭킹", false),
            generateMenu(Symbols.home, "홈", false),
            generateMenu(Symbols.trophy, "업적", true),
          ],
        ),
      ),
    );
  }
}
