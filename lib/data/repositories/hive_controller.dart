import 'package:hive/hive.dart';
import 'package:nextion/data/models/movie_model.dart';

import '../../core/boxes.dart';

/// Controller class for managing Hive database operations related to Movie data.
class HiveController {
  /// Hive box for storing Movie data.
  Box<Movie> box = Boxes.getData();

  /// Create a new Movie record in the database.
  ///
  /// The [title], [id], [posterUrl], [overview], [releaseDate], and [isFavourite] are required parameters.
  static void createDataBase(String title, int id, String posterUrl,
      String overview, DateTime releaseDate, bool isFavourite) {
    var box = Boxes.getData();
    var data = Movie(
      id: id,
      title: title,
      releaseDate: releaseDate,
      overview: overview,
      posterUrl: posterUrl,
    );
    box.add(data);
    data.save();
  }

  /// Remove a Movie from the favorites list in the database.
  ///
  /// The [index] parameter indicates the index of the Movie to be removed.
  static removeFromFavourite(int index) {
    var box = Boxes.getData();
    List<Movie> data = box.values.toList().cast<Movie>();
    data[index].delete();
  }
}
