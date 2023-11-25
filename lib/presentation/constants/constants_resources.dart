// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A utility class containing constants used throughout the application.
class ConstantsResources {
  /// Base URL for making requests to the movie database API.
  static const String BASE_URL = 'https://api.themoviedb.org/3/movie/';

  /// Endpoint for retrieving randomly i-e popular,upcoming,now_playing and top_rated etc form API  API.
  static const List<String> END_POINTS = [
    'top_rated?',
    "now_playing?",
    "popular?",
    "upcoming?"
  ];

  /// Exception message displayed when loading movies fails.
  static const String FAILED_EXCEPTION = 'Failed to load movies';

  /// Name of the Hive box used for storing movie data locally.
  static const String BOX_NAME = "Movie Box";

  /// File name of the environment configuration file.
  static const String ENV = ".env";

  /// HTTP status code indicating a successful response.
  static const int SUCCESSFUL_STATUS_CODE = 200;

  /// Number of cross-axis items in a grid view.
  static const int GRID_CROSS_ACCESS_COUNT = 2;

  /// An empty list constant.
  static const List EMPTY_LIST = [];

  /// Delay time for displaying a snackbar in seconds.
  static const int SNACKBAR_DELAY = 2;

  /// Maximum number of lines to display for movie overviews.
  static const int OVERVIEW_MAX_LINES = 2;
}
