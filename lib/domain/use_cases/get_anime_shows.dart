import 'package:eitherx/eitherx.dart';
import 'package:revision/core/errors/failures.dart';
import 'package:revision/data/models/paginated_result_model.dart';
import 'package:revision/domain/params/get_anime_shows_params.dart';
import 'package:revision/domain/repos/anime_repo.dart';

class GetAnimeShows {
  final AnimeRepo animeRepo;

  GetAnimeShows(this.animeRepo);

  Future<Either<Failure, PaginatedResultModel>> call(
    GetAnimeShowsParams params,
  ) async {
    return await animeRepo.getAnimeList(
      params.page,
      params.pageSize,
      params.title ?? "",
    );
  }
}
