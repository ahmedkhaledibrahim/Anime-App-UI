import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revision/core/constants.dart';
import 'package:revision/core/errors/exceptions.dart';
import 'package:revision/data/models/anime_show_model.dart';
import 'package:revision/data/models/paginated_result_model.dart';

class AnimeRemoteDataSource {
  Future<PaginatedResultModel<AnimeShowModel>> getAnimeShows({
    int pageNumber = 1,
    int pageSize = 10,
    int version = 1,
    String name = '',
  }) async {
    try {
      final url = Uri.parse(
        '${GlobalConstants.baseUrl}api/v$version/AnimeShows?PageNumber=$pageNumber&PageSize=$pageSize&Title=$name',
      );
      var response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      if (response.statusCode != 200) {
        var errorData = json.decode(response.body);
        throw ServerException(errorData['message'], errorData['statusCode']);
      }

      final Map<String, dynamic> data = json.decode(response.body);

      final PaginatedResultModel<AnimeShowModel> paginatedAnimeShowsList =
          PaginatedResultModel.fromJson(data, AnimeShowModel.fromJson);
      return paginatedAnimeShowsList;
    } catch (ex) {
      rethrow;
    }
  }
}
