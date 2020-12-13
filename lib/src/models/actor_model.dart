class Actor {
    bool adult;
    int castId;
    String character;
    String creditId;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    int order;
    String originalName;
    double popularity;
    String profilePath;

    Actor({this.adult, this.castId, this.character, this.creditId, this.gender, this.id, this.knownForDepartment, this.name, this.order, this.originalName, this.popularity, this.profilePath});

    factory Actor.fromJson(Map<String, dynamic> json) {
        return Actor(
            adult: json['adult'],
            castId: json['cast_id'],
            character: json['character'],
            creditId: json['credit_id'],
            gender: json['gender'],
            id: json['id'],
            knownForDepartment: json['known_for_department'],
            name: json['name'],
            order: json['order'],
            originalName: json['original_name'],
            popularity: json['popularity'],
            profilePath: json['profile_path'],
        );
    }
 
    getPosterImage() {
      if (profilePath != null) {
        return 'https://image.tmdb.org/t/p/w500/$profilePath';
      } else {
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png';
      }
    }
}

class Cast {
  List<Actor> casts = new List();

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = Actor.fromJson(element);
      casts.add(actor);
    });
  }
}