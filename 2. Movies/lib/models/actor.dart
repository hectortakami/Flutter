class Actors {
  List<Actor> actorList = [];

  Actors();

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final actor = new Actor.fromJson2Map(item);
      actorList.add(actor);
    }
  }
}

class Actor {
  late int id;
  late String name;
  late String profilePath;
  late int castId;
  late String character;
  late String creditId;

  Actor(
    int id,
    String name,
    String profilePath,
    int castId,
    String character,
    String creditId,
  ) {
    this.id = id;
    this.name = name;
    this.profilePath = profilePath;
    this.castId = castId;
    this.character = character;
    this.creditId = creditId;
  }

  Actor.fromJson2Map(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
  }

  String getPoster() {
    // ignore: unnecessary_null_comparison
    if (this.profilePath == null || this.profilePath.length <= 0) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
    }
    return 'https://image.tmdb.org/t/p/w500' + this.profilePath;
  }
}
