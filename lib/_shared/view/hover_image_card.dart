import 'package:flutter/material.dart';
import 'package:pixboard/_shared/view/tags_wrap.dart';

class HoverImageCard extends StatefulWidget {
  const HoverImageCard({
    required this.imageUrl,
    required this.photographer,
    required this.tags,
    super.key,
  });

  final String imageUrl;
  final String photographer;
  final List<String> tags;

  @override
  State<HoverImageCard> createState() => _HoverImageCardState();
}

class _HoverImageCardState extends State<HoverImageCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              opacity: _hovering ? 1 : 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        widget.photographer,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 8),
                      TagsWrap(tags: widget.tags),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
