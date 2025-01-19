class AnimeShowModel {
  final int id;
  final String name;
  final String description;
  final double rate;
  final String imageUrl;
  final int categoryId;

  AnimeShowModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.imageUrl,
    required this.categoryId,
  });

  factory AnimeShowModel.fromJson(Map<String, dynamic> json) {
    return AnimeShowModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description for this anime',
      rate: json['rate'],
      imageUrl: json['imageUrl'] ?? 'https://placehold.co/600x400',
      categoryId: json['categoryId'],
    );
  }
}
