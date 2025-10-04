import 'package:flutter/material.dart';

class ScrollMenuBar extends StatefulWidget {
  final String currentMenu;
  final Function setCurrentMenu;
  final List<Map<String, dynamic>> menuList;
  const ScrollMenuBar({
    super.key,
    required this.menuList,
    required this.currentMenu,
    required this.setCurrentMenu,
  });

  @override
  State<ScrollMenuBar> createState() => _ScrollMenuBarState();
}

class _ScrollMenuBarState extends State<ScrollMenuBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: MediaQuery.sizeOf(context).width,
      child: ListView(
        padding: const EdgeInsets.only(right: 4, left: 16),
        scrollDirection: Axis.horizontal,
        children: [
          ...widget.menuList.map((i) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () => widget.setCurrentMenu(i['label']),
                  child: Container(
                      height: 44,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.1), width: 1),
                      ),
                      decoration: BoxDecoration(
                        color: i['label'] == widget.currentMenu
                            ? const Color(0xFF54A3FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              if (i['icon'] != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    i['icon'],
                                    color: i['label'] == widget.currentMenu
                                        ? Colors.white
                                        : const Color(0xFF7F7F7F),
                                    size: 20,
                                  ),
                                ),
                              Text(
                                i['label'],
                                style: TextStyle(
                                  color: i['label'] == widget.currentMenu
                                      ? Colors.white
                                      : const Color(0xFF7F7F7F),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
