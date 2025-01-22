import 'package:flutter/material.dart';
import 'package:revision/domain/entities/anime_show.dart';

class AnimeShowCard extends StatelessWidget {
  final AnimeShow show;
  final VoidCallback? onTap;

  const AnimeShowCard({Key? key, required this.show, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anime Image - fixed height
            SizedBox(
              height: 140, // Reduced from 200 to give more space for content
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                child: Image.network(
                  show.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      show.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        // Changed to titleSmall
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Reduced to 1 line
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ), // Smaller icon
                        const SizedBox(width: 4),
                        Text(
                          show.rate.toStringAsFixed(1),
                          style:
                              Theme.of(
                                context,
                              ).textTheme.bodySmall, // Smaller text
                        ),
                      ],
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    // Description
                    Expanded(
                      child: Text(
                        show.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // Smaller text
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
