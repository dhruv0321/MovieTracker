class MovieInfo {
  final int? id;
  final String movieName;
  final String dirName;
  final String photoName;

  const MovieInfo({
    this.id,
    required this.movieName,
    required this.dirName,
    required this.photoName,
  });

  MovieInfo copy({
    int? id,
    String? movieName,
    String? dirName,
    String? photoName,
  }) =>
      MovieInfo(
          id: id ?? this.id,
          movieName: movieName ?? this.movieName,
          dirName: dirName ?? this.dirName,
          photoName: photoName ?? this.photoName);

  Map<String, Object?> toMap() => {
        'id': id,
        'movieName': movieName,
        'dirName': dirName,
        'photoName': photoName,
      };

  static MovieInfo fromMap(Map<String, Object?> json) => MovieInfo(
        id: json['id'] as int?,
        movieName: json['movieName'] as String,
        dirName: json['dirName'] as String,
        photoName: json['photoName'] as String,
      );
}
