part of 'anime_shows_cubit.dart';

sealed class AnimeShowsState extends Equatable {
  const AnimeShowsState();

  @override
  List<Object> get props => [];
}

final class AnimeShowsInitial extends AnimeShowsState {}

final class AnimeShowsLoading extends AnimeShowsState {}

final class AnimeShowsLoaded extends AnimeShowsState {
  final List<AnimeShow> shows;

  const AnimeShowsLoaded(this.shows);

  @override
  List<Object> get props => [shows];
}

final class AnimeShowsError extends AnimeShowsState {
  final String message;

  const AnimeShowsError(this.message);

  @override
  List<Object> get props => [message];
}
