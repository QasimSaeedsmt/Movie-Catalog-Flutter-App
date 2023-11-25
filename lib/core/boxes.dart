import 'package:hive/hive.dart';
import '../data/models/movie_model.dart';
import '../presentation/constants/constants_resources.dart';

/// A utility class for managing Hive boxes related to Movie data.
class Boxes {
  /// Returns the Hive box containing Movie data.
  ///
  /// This method provides access to the Hive box used for storing Movie objects.
  /// It uses the `BOX_NAME` constant from `ConstantsResources` to ensure consistency.
  ///
  /// Usage:
  /// ```dart
  /// Box<Movie> movieBox = Boxes.getData();
  /// ```
  static Box<Movie> getData() => Hive.box<Movie>(ConstantsResources.BOX_NAME);
}
