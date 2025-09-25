import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixboard/_shared/view/hover_image_card.dart';
import 'package:pixboard/_shared/view/image_details_dialog.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetImagesCubit, GetImagesState>(
      builder: (context, state) {
        return state.map(
          initial: (initial) => const SizedBox.shrink(),
          loading: (loading) =>
              const Center(child: CircularProgressIndicator()),
          success: (fetchedImages) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: fetchedImages.images.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Device.screenType == ScreenType.mobile
                            ? 2
                            : Device.screenType == ScreenType.tablet
                            ? 3
                            : 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: fetchedImages.images.length,
                      itemBuilder: (context, index) {
                        final item = fetchedImages.images[index];
                        final tags = item.tags
                            .split(', ')
                            .where((e) => e.isNotEmpty)
                            .toList();
                        if (Device.screenType == ScreenType.desktop) {
                          return HoverImageCard(
                            imageUrl: item.webformatURL,
                            photographer: item.user,
                            tags: tags,
                          );
                        }
                        return InkWell(
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (ctx) {
                                return ImageDetailDialog(
                                  item: item,
                                  tags: tags,
                                  ctx: ctx,
                                );
                              },
                            );
                          },
                          child: ImageCard(
                            imageUrl: item.webformatURL,
                            photographer: item.user,
                            tags: item.tags.split(', '),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No images found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
            );
          },
          error: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.flatColored,
                title: Text(error.message),
                description: const Text('Opps!'),
                alignment: Alignment.topCenter,
                autoCloseDuration: const Duration(seconds: 4),
              );
            });
            return Center(
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
                      context.read<GetImagesCubit>().getDashboardImages(
                        'popular',
                      );
                    },
                    child: Text(
                      'Retry',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.imageUrl,
    required this.photographer,
    required this.tags,
    super.key,
  });

  final String imageUrl;
  final String photographer;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tags.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'by ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: photographer,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
