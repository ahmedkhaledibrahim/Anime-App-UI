import 'package:eitherx/src/either.dart';
import 'package:revision/core/errors/exceptions.dart';
import 'package:revision/core/errors/failures.dart';
import 'package:revision/data/data_sources/anime_remote_data_source.dart';
import 'package:revision/data/mappers/anime_show_mapper.dart';
import 'package:revision/domain/entities/anime_show.dart';
import 'package:revision/domain/repos/anime_repo.dart';

class AnimeRepoImpl extends AnimeRepo {
  final AnimeRemoteDataSource remoteDataSource;

  AnimeRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AnimeShow>>> getAnimeList(
    int pageNumber,
    int pageSize,
    String name,
  ) async {
    try {
      final animeShowModels = await remoteDataSource.getAnimeShows(
        pageNumber: pageNumber,
        pageSize: pageSize,
        name: name,
      );
      final animeShowsList =
          animeShowModels.map((anime) => anime.toDomain()).toList();
      return Right(animeShowsList);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
