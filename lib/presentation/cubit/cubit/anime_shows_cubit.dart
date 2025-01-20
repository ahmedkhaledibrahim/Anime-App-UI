import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revision/domain/entities/anime_show.dart';
import 'package:revision/domain/params/get_anime_shows_params.dart';
import 'package:revision/domain/use_cases/get_anime_shows.dart';

part 'anime_shows_state.dart';

class AnimeShowsCubit extends Cubit<AnimeShowsState> {
  final GetAnimeShows getAnimeShows;
  AnimeShowsCubit(this.getAnimeShows) : super(AnimeShowsInitial());

  Future<void> loadAnimeShows({
    int page = 1,
    String? title,
    int? categoryId,
    double? minimumRate,
  }) async {
    emit(AnimeShowsLoading());

    final result = await getAnimeShows(
      GetAnimeShowsParams(
        page: page,
        title: title,
        categoryId: categoryId,
        minimumRate: minimumRate,
      ),
    );

    result.fold(
      (failure) => emit(AnimeShowsError(failure.message)),
      (paginatedResult) => emit(AnimeShowsLoaded(paginatedResult)),
    );
  }
}
