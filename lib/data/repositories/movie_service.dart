import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/respository/movie_repository.dart';
import '../../presentation/constants/constants_resources.dart';
import '../models/movie_model.dart';

/// Service class for fetching movie data from a remote API.
class MovieService implements MovieRepository {
  /// API key for authentication.
  static final apiKey = dotenv.env['API_KEY'];

  /// Base URL for the movie API.
  static const String baseUrl = ConstantsResources.BASE_URL;

  /// Access token for authorization.
  static final accessToken = dotenv.env['ACCESS_TOKEN'];

  /// Dio instance for making HTTP requests.
  final Dio _dio = Dio();

  /// Fetch a list of movies from the remote API.
  ///
  /// Returns a Future containing a list of [Movie] objects.
  /// Throws an exception if the request fails.
  @override
  Future<List<Movie>> getMovies() async {
    final headers = {
      "authorization": accessToken,
    };

    try {
      final String endpoint = getRandomEndPoint();

      final response = await _dio.get(
        '$baseUrl$endpoint',
        options: Options(headers: headers, contentType: "application/json"),
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(ConstantsResources.FAILED_EXCEPTION);
      }
    } catch (e) {
      throw Exception('${ConstantsResources.FAILED_EXCEPTION}: $e');
    }
  }

  String getRandomEndPoint() {
    int randomIndex = Random().nextInt(ConstantsResources.END_POINTS.length);
    return ConstantsResources.END_POINTS[randomIndex];
  }
}
