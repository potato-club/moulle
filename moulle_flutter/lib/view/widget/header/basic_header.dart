import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../button/small_icon_button.dart';

class BasicHeader extends StatefulWidget {
  final String title;
  final Color bgColor;
  final bool isActive;
  final String transTitle;
  const BasicHeader({
    super.key,
    required this.title,
    required this.bgColor,
    this.isActive = false,
    required this.transTitle,
  });

  @override
  State<BasicHeader> createState() => _BasicHeaderState();
}

class _BasicHeaderState extends State<BasicHeader> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.paddingOf(context).top + 60,
      padding:
          EdgeInsets.fromLTRB(16, MediaQuery.paddingOf(context).top, 16, 0),
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      decoration: BoxDecoration(
        color: widget.isActive ? const Color(0xFF54A3FF) : widget.bgColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                opacity: widget.isActive ? 0 : 1,
                child: SizedBox(
                  width: 90,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(-90, 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  transform: widget.isActive
                      ? Matrix4.translationValues(0, 0, 0)
                      : Matrix4.translationValues(0, 42, 0),
                  child: Text(
                    widget.transTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmallIconButton(
                  child: Icon(
                Symbols.search,
                size: 24,
                color: widget.isActive ? Colors.white : Colors.black,
              )),
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
                      'https://yt3.ggpht.com/yti/ADpuP3NXuzVnH8kkxn2xCsN_Lij7bjDP8BAKdpMtJXHi=s108-c-k-c0x00ffffff-no-rj'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
