import 'package:revision/data/models/anime_show_model.dart';
import 'package:revision/domain/entities/anime_show.dart';

extension AnimeShowMapper on AnimeShowModel {
  AnimeShow toDomain() {
    return AnimeShow(
      id: id,
      name: name,
      rate: rate,
      imageUrl: imageUrl,
      description: description,
      categoryId: categoryId,
    );
  }
}
