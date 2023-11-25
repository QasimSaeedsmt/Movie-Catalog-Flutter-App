// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:nextion/data/repositories/movie_service.dart';
import 'package:nextion/presentation/extensions/string_extension.dart';

/// A utility class containing constants for string resources used throughout the application.
class StringResources {
  /// Title for the list screen.
  static String LIST_SCREEN_TITLE =
      MovieService().getRandomEndPoint().capitalize().removeQuestionMark();

  /// Error message when loading data fails.
  static const String ERROR_LOADING_DATA = "Error loading data";

  /// Text prefix for displaying the release date.
  static const String RELEASE_DATE_TEXT = "Release Date:";

  /// Title for the favorite screen.
  static const String FAVOURITE_SCREEN_TITLE = 'Favourite Screen';

  /// Action button label for adding to favorites.
  static const String ADD_TO_FAVOURITES = 'Add to Favourites';

  /// Message displayed when an item is saved in favorites.
  static const String SAVED_IN_FAVOURITES = 'Saved in Favourites';

  /// Action button label for removing from favorites.
  static const String REMOVE_FROM_FAVOURITES = "Remove from Favourite";

  /// Message displayed when there are no favorite items available.
  static const String NO_FAVOURITE_ITEMS = "No Favourite Items available";

  /// Action button label for navigating to the favorites screen.
  static const String GO_TO_FAVOURITES = "Go to Favourites";

  /// Snackbar message for indicating a successful addition to favorites.
  static const String SNACK_BAR_SAVED_TO_FAVOURITE_TEXT = "Added to Favourites";

  /// Snackbar message for indicating a successful removal from favorites.
  static const String SNACK_BAR_REMOVED_FROM_FAVOURITE_TEXT =
      "Removed from Favourites";
}
