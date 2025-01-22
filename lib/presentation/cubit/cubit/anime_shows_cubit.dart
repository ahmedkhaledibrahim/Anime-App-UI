import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revision/data/models/paginated_result_model.dart';
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

  void sortByRate({String sortOrder = "Ascending"}) {
    if (state is AnimeShowsLoaded) {
      final currentState = state as AnimeShowsLoaded;
      final sortedAnimeShows = List<AnimeShow>.from(currentState.shows.items);

      sortedAnimeShows.sort((a, b) {
        final comparison = a.rate.compareTo(b.rate);
        return sortOrder == "Ascending" ? comparison : -comparison;
      });

      emit(
        AnimeShowsLoaded(
          PaginatedResultModel(
            items: sortedAnimeShows,
            totalCount: currentState.shows.totalCount,
            pageNumber: currentState.shows.pageNumber,
            pageSize: currentState.shows.pageSize,
          ),
        ),
      );
    }
  }

  void toggleSortOrder() {
    if (state is AnimeShowsLoaded) {
      final currentState = state as AnimeShowsLoaded;
      final newOrder =
          currentState.sortOrder == "Ascending" ? "Descending" : "Ascending";

      sortByRate(sortOrder: newOrder);
    }
  }
}
