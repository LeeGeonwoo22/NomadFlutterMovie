// ignore: empty_constructor_bodies
class PlayingModel {
  final bool adult, video;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final int id, voteCount;
  final double popularity, voteAverage;
  final List<int> genreIds;

  // 클래스 필드 초기화
  PlayingModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        video = json['video'],
        backdropPath =
            'https://image.tmdb.org/t/p/w500/${json['backdrop_path']}',
        originalLanguage = json['original_language'],
        overview = json['overview'],
        posterPath = 'https://image.tmdb.org/t/p/w500/${json['poster_path']}',
        title = json['title'],
        id = json['id'],
        popularity = json['popularity'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'],
        originalTitle = json['original_title'],
        releaseDate = json['release_date'],
        genreIds = List<int>.from(json['genre_ids']);

  // PlayingsModel.fromJson(Map<String,dynamic> json, this.adult, this.video, this.backdropPath, this.originalLanguage, this.originalTitle, this.overview, this.posterPath, this.releaseDate, this.title, this.id, this.popularity, this.voteAverage, this.voteCount, this.genreIds)
}
