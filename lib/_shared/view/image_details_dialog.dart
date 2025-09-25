import 'package:flutter/material.dart';
import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/_shared/view/tags_wrap.dart';

class ImageDetailDialog extends StatelessWidget {
  const ImageDetailDialog({
    super.key,
    required this.item,
    required this.tags,
    required this.ctx,
  });
  final PixImage item;
  final List<String> tags;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(ctx).pop(),
                  child: const SizedBox.shrink(),
                ),
              ),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  heightFactor: 0.75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            item.webformatURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            ignoring: true,
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
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.user,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              TagsWrap(tags: tags),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black45,
                            ),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
