class PaginatedResultModel<T> {
  final List<T> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  PaginatedResultModel({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });

  factory PaginatedResultModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResultModel(
      items:
          (json['items'] as List)
              .map((item) => fromJsonT(item as Map<String, dynamic>))
              .toList(),
      totalCount: json['totalCount'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
    );
  }
}
