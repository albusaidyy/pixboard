import 'package:flutter/material.dart';
import 'package:pixboard/utils/_index.dart';

class TagsWrap extends StatefulWidget {
  const TagsWrap({super.key, required this.tags});
  final List<String> tags;

  @override
  State<TagsWrap> createState() => _TagsWrapState();
}

class _TagsWrapState extends State<TagsWrap> {
  bool _expanded = false;
  static const int _collapsedCount = 3;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bool hasMore = widget.tags.length > _collapsedCount;
        final List<String> visibleTags = _expanded
            ? widget.tags
            : widget.tags.take(_collapsedCount).toList();

        final tagsWrap = Wrap(
          spacing: 8,
          runSpacing: 8,
          children: visibleTags
              .map(
                (t) => Chip(
                  label: Text(t, style: Theme.of(context).textTheme.bodyMedium),
                  backgroundColor:
                      Theme.of(
                        context,
                      ).cardTheme.color?.addOpacity(
                        0.9,
                      ),
                  side: BorderSide.none,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
              .toList(),
        );

        if (_expanded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 160,
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.tags
                        .map(
                          (t) => Chip(
                            label: Text(
                              t,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            backgroundColor:
                                Theme.of(
                                  context,
                                ).cardTheme.color?.addOpacity(
                                  0.9,
                                ),
                            side: BorderSide.none,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              if (hasMore) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => setState(() => _expanded = false),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onPrimary,
                  ),
                  child: const Text('Show less'),
                ),
              ],
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tagsWrap,
            if (hasMore) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => setState(() => _expanded = true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.onPrimary,
                ),
                child: Text(
                  'Show more (+${widget.tags.length - _collapsedCount})',
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
