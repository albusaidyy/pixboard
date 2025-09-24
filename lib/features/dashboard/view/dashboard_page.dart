import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    final sampleImages = [
      {
        'url': 'https://picsum.photos/400/300?random=1',
        'photographer': 'Alice Johnson',
        'tags': ['Nature', 'Forest'],
      },
      {
        'url': 'https://picsum.photos/400/300?random=2',
        'photographer': 'John Doe',
        'tags': ['City', 'Night'],
      },
      {
        'url': 'https://picsum.photos/400/300?random=3',
        'photographer': 'Maria Lopez',
        'tags': ['Beach', 'Sunset'],
      },
      {
        'url': 'https://picsum.photos/400/300?random=4',
        'photographer': 'David Kim',
        'tags': ['Mountains', 'Snow'],
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemCount: sampleImages.length,
        itemBuilder: (context, index) {
          final item = sampleImages[index];
          return ImageCard(
            imageUrl: item['url'].toString(),
            photographer: item['photographer'].toString(),
            tags: (item['tags'] as List?)?.cast<String>() ?? const <String>[],
          );
        },
      ),
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
          // Thumbnail
          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Photographer + Tags
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
                  tags.join(', '), // Combine tags into a single string
                  maxLines: 1, // Keep it to one line
                  overflow: TextOverflow.ellipsis, // Show ...
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
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
