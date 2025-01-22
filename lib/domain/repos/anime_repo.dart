import 'package:eitherx/eitherx.dart';
import 'package:revision/core/errors/failures.dart';
import 'package:revision/data/models/paginated_result_model.dart';
import 'package:revision/domain/entities/anime_show.dart';

abstract class AnimeRepo {
  Future<Either<Failure, PaginatedResultModel<AnimeShow>>> getAnimeList(
    int pageNumber,
    int pageSize,
    String name,
  );
}
