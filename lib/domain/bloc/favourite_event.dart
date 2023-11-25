import 'package:nextion/data/models/movie_model.dart';

/// Abstract base class for events related to managing favorite movies.
abstract class FavouriteEvent {}

/// Event triggered when a movie is added to the favorites list.
class AddToFavouriteEvent extends FavouriteEvent {
  final int id;
  final List<Movie>? data;
  final String title;
  final DateTime releaseDate;
  final String overview;
  final String posterUrl;
  final bool isFavourite;

  /// Constructor for creating an AddToFavouriteEvent.
  ///
  /// The [id], [data], [title], [releaseDate], [overview], [posterUrl], and [isFavourite] are required parameters.
  AddToFavouriteEvent({
    required this.id,
    required this.data,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterUrl,
    required this.isFavourite,
  });
}

/// Event triggered when a movie is removed from the favorites list.
class RemoveFromFavouriteEvent extends FavouriteEvent {
  final int index;

  /// Constructor for creating a RemoveFromFavouriteEvent.
  ///
  /// The [index] parameter is required, indicating the index of the movie to be removed.
  RemoveFromFavouriteEvent({required this.index, required int id});
}
