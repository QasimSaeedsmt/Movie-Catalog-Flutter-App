import 'package:nextion/data/models/movie_model.dart';

/// Interface for the Movie Repository.
abstract class MovieRepository {
  Future<List<Movie>> getMovies();
}
