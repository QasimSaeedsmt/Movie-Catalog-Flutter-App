import 'package:bloc/bloc.dart';
import 'package:nextion/core/boxes.dart';
import 'package:nextion/data/repositories/hive_controller.dart';

import '../../../data/models/movie_model.dart';
import '../respository/movie_repository.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

/// BLoC (Business Logic Component) responsible for managing favorite movies.
class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final MovieRepository? movieRepository;

  /// Hive box for storing Movie data.
  var box = Boxes.getData();

  /// Constructor for initializing the FavouriteBloc.
  FavouriteBloc({this.movieRepository}) : super(FavouriteInitial()) {
    on<AddToFavouriteEvent>((event, emit) {
      // Add the movie to the favorites list in the database
      HiveController.createDataBase(
        event.title,
        event.id,
        event.posterUrl,
        event.overview,
        event.releaseDate,
        event.isFavourite,
      );

      List<Movie> data = box.values.toList().cast<Movie>();
      List<bool> isFavoriteList = <bool>[];

      if (isFavoriteList.isEmpty) {
        isFavoriteList =
            List.generate(event.data?.length ?? 0, (index) => false);
        emit(AddToFavouriteState(data: data, isFavouriteList: isFavoriteList));
      }
    });

    on<RemoveFromFavouriteEvent>((event, emit) {
      HiveController.removeFromFavourite(event.index);

      List<Movie> data = box.values.toList().cast<Movie>();

      emit(RemoveFromFavouriteState(data: data));
    });
  }
}
