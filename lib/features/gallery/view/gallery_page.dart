import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/_shared/view/hover_image_card.dart';
import 'package:pixboard/_shared/view/image_details_dialog.dart';
import 'package:pixboard/features/dashboard/view/dashboard_page.dart';
import 'package:pixboard/features/gallery/cubit/gallery_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch() {
    FocusScope.of(context).unfocus();
    context.read<GalleryCubit>().search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return GalleryView(
      controller: _controller,
      focusNode: _focusNode,
      onSearch: _onSearch,
    );
  }
}

class GalleryView extends StatelessWidget {
  const GalleryView({
    required this.controller,
    required this.focusNode,
    required this.onSearch,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: BlocBuilder<GalleryCubit, GalleryState>(
            builder: (context, state) {
              final screenWidth = MediaQuery.of(context).size.width;
              final hasResults = state is GallerySuccess;
              final isWide =
                  Device.screenType == ScreenType.desktop ||
                  Device.screenType == ScreenType.tablet;

              final searchBar = Row(
                mainAxisSize: isWide ? MainAxisSize.min : MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      onSubmitted: (_) => onSearch(),
                      decoration: InputDecoration(
                        hintText: 'Search images (e.g., cats, cars)',
                        prefixIcon: hasResults
                            ? null
                            : const Icon(Icons.search),
                        suffixIcon: hasResults
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                tooltip: 'Clear',
                                onPressed: () {
                                  controller.clear();
                                  context.read<GalleryCubit>().reset();
                                  focusNode.requestFocus();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: onSearch,
                    icon: const Icon(Icons.search),
                    label: const Text('Search'),
                  ),
                ],
              );

              if (isWide) {
                final centeredBar = Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: screenWidth * 0.35,
                      maxWidth: screenWidth * 0.5,
                    ),
                    child: searchBar,
                  ),
                );

                final isInitial = state is GalleryInitial;
                if (isInitial) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(child: centeredBar),
                  );
                }
                return centeredBar;
              }
              return searchBar;
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<GalleryCubit, GalleryState>(
            builder: (context, state) {
              return state.map(
                initial: (_) {
                  final isWide = MediaQuery.of(context).size.width > 600;
                  if (isWide) {
                    return const SizedBox.shrink();
                  }
                  return Center(
                    child: Text(
                      'Search for images by keyword',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                },
                loading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                success: (data) {
                  final images = data.images;
                  if (images.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }
                  if (Device.screenType == ScreenType.desktop ||
                      Device.screenType == ScreenType.tablet) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3 / 4,
                            ),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          final item = images[index];
                          final tags = item.tags
                              .split(', ')
                              .where((e) => e.isNotEmpty)
                              .toList();
                          if (kIsWeb) {
                            return HoverImageCard(
                              imageUrl: item.webformatURL,
                              photographer: item.user,
                              tags: tags,
                            );
                          }
                          return ImageCard(
                            imageUrl: item.webformatURL,
                            photographer: item.user,
                            tags: tags,
                          );
                        },
                      ),
                    );
                  } else {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: images.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = images[index];
                        final tags = item.tags
                            .split(', ')
                            .where((e) => e.isNotEmpty)
                            .toList();
                        return InkWell(
                          onTap: () =>
                              openImageDetailsDialog(context, item, tags),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.previewURL,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(item.user),
                            subtitle: Text(
                              item.tags,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () =>
                                  openImageDetailsDialog(context, item, tags),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                error: (e) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<GalleryCubit>().search(controller.text);
                        },
                        child: Text(
                          'Retry',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void openImageDetailsDialog(
    BuildContext context,
    PixImage item,
    List<String> tags,
  ) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (ctx) {
        return ImageDetailDialog(
          item: item,
          tags: tags,
          ctx: ctx,
        );
      },
    );
  }
}
