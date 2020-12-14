class Films {
  List<Film> films = new List();

  Films();

  Films.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final film = new Film.fromJson(item);
      films.add(film);
    }
  }
}

class Film {
  String uniqueId;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Film({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Film.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    genreIds = json["genre_ids"].cast<int>();
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"] / 1;
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"] / 1;
    voteCount = json["vote_count"];
  }

  getPosterImage() {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    } else if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    } else {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png';
    }
  }

  getBackdropPathImage() {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    } else if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    } else {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png';
    }
  }
}
