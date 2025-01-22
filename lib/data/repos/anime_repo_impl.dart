import 'package:eitherx/src/either.dart';
import 'package:revision/core/errors/exceptions.dart';
import 'package:revision/core/errors/failures.dart';
import 'package:revision/data/data_sources/anime_remote_data_source.dart';
import 'package:revision/data/mappers/anime_show_mapper.dart';
import 'package:revision/data/models/paginated_result_model.dart';
import 'package:revision/domain/entities/anime_show.dart';
import 'package:revision/domain/repos/anime_repo.dart';

class AnimeRepoImpl extends AnimeRepo {
  final AnimeRemoteDataSource remoteDataSource;

  AnimeRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResultModel<AnimeShow>>> getAnimeList(
    int pageNumber,
    int pageSize,
    String name,
  ) async {
    try {
      final paginatedResult = await remoteDataSource.getAnimeShows(
        pageNumber: pageNumber,
        pageSize: pageSize,
        name: name,
      );

      List<AnimeShow> animeShowsList =
          paginatedResult.items.map((element) => element.toDomain()).toList();

      PaginatedResultModel<AnimeShow> result = PaginatedResultModel(
        items: animeShowsList,
        totalCount: paginatedResult.totalCount,
        pageNumber: paginatedResult.pageNumber,
        pageSize: paginatedResult.pageSize,
      );

      // final animeShowsList =
      //     animeShowModels.items.map((anime) => anime.toDomain()).toList();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
