import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
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
          success: (fetchedImages) => Padding(
            padding: const EdgeInsets.all(16),
            child: fetchedImages.images.isNotEmpty
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600
                          ? 3
                          : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: fetchedImages.images.length,
                    itemBuilder: (context, index) {
                      final item = fetchedImages.images[index];
                      return ImageCard(
                        imageUrl: item.webformatURL,
                        photographer: item.user,
                        tags: item.tags.split(', '),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No images found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
          ),
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
                  photographer,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tags.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
