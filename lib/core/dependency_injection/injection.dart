import 'package:get_it/get_it.dart';
import 'package:revision/data/data_sources/anime_remote_data_source.dart';
import 'package:revision/data/repos/anime_repo_impl.dart';
import 'package:revision/domain/repos/anime_repo.dart';
import 'package:revision/domain/use_cases/get_anime_shows.dart';
import 'package:revision/presentation/cubit/cubit/anime_shows_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register RemoteDataSource
  sl.registerLazySingleton(() => AnimeRemoteDataSource());
  // Use case
  sl.registerLazySingleton(() => GetAnimeShows(sl()));

  // Cubit
  sl.registerFactory(() => AnimeShowsCubit(sl()));

  sl.registerLazySingleton<AnimeRepo>(
    () => AnimeRepoImpl(remoteDataSource: sl()),
  );
}
