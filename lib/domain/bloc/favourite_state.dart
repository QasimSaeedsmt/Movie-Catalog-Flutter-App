import '../../../data/models/movie_model.dart';

/// Abstract base class for states related to managing favorite movies.
abstract class FavouriteState {}

/// Initial state for the FavouriteBloc.
class FavouriteInitial extends FavouriteState {}

/// State representing the addition of a movie to the favorites list.
class AddToFavouriteState extends FavouriteState {
  final List<Movie> data;
  final List<bool>? isFavouriteList;

  /// Constructor for creating an AddToFavouriteState.
  ///
  /// The [data] parameter is required, representing the updated list of favorite movies.
  /// The [isFavouriteList] parameter is optional and represents the updated list of boolean values indicating whether each movie is a favorite.
  AddToFavouriteState({required this.data, required this.isFavouriteList});
}

/// State representing the removal of a movie from the favorites list.
class RemoveFromFavouriteState extends FavouriteState {
  final List<Movie> data;

  /// Constructor for creating a RemoveFromFavouriteState.
  ///
  /// The [data] parameter is required, representing the updated list of favorite movies after removal.
  RemoveFromFavouriteState({required this.data});
}
