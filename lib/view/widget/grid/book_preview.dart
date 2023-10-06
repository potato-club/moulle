import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookPreview extends StatefulWidget {
  final List<dynamic> list;
  final bool isActive;
  final ScrollController scrollController;
  const BookPreview({
    super.key,
    required this.list,
    required this.isActive,
    required this.scrollController,
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
            child: Image.network(img),
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
    return MasonryGridView.count(
      controller: widget.scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: widget.list.length,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 106),
      physics: widget.isActive
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return gridItem(widget.list[index]['img'], widget.list[index]['label'],
            widget.list[index]['writer']);
      },
    );
  }
}
