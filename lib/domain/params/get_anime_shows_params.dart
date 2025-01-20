import 'package:equatable/equatable.dart';

class GetAnimeShowsParams extends Equatable {
  final int page;
  final String? title;
  final int? categoryId;
  final double? minimumRate;
  final int pageSize;

  const GetAnimeShowsParams({
    required this.page,
    this.title,
    this.categoryId,
    this.minimumRate,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [page, title, categoryId, minimumRate, pageSize];
}
