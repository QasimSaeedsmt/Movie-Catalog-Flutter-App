import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final int _id;

  @HiveField(1)
  final String _title;

  @HiveField(2)
  final DateTime _releaseDate;

  @HiveField(3)
  final String _overview;

  @HiveField(4)
  final String _posterUrl;

  // Public getters for encapsulation
  int get id => _id;

  String get title => _title;

  DateTime get releaseDate => _releaseDate;

  String get overview => _overview;

  String get posterUrl => _posterUrl;

  /// Constructor for creating a Movie instance.
  ///
  /// The [id], [title], [releaseDate], [overview], and [posterUrl] are required parameters.
  Movie({
    required int id,
    required String title,
    required DateTime releaseDate,
    required String overview,
    required String posterUrl,
  })  : _id = id,
        _title = title,
        _releaseDate = releaseDate,
        _overview = overview,
        _posterUrl = posterUrl;

  /// Factory method to create a Movie instance from JSON data.
  ///
  /// The [json] parameter should contain the necessary data fields for a Movie.
  /// Throws an [Exception] if parsing fails.
  factory Movie.fromJson(Map<String, dynamic> json) {
    try {
      // Attempt to parse the data and create a Movie instance
      return Movie(
        id: json['id'],
        title: json['title'],
        releaseDate: DateTime.parse(json['release_date']),
        overview: json['overview'],
        posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      );
    } catch (e) {
      // Handle the error and provide feedback to the user
      throw Exception('Failed to parse Movie data');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
