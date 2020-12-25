import 'package:yuve/models/movie.dart';

class MovieHub {
  int page;
  List<Movie> movieList;
  int totalPages;
  int totalResults;

  MovieHub({this.page, this.movieList, this.totalPages, this.totalResults});

  factory MovieHub.fromJson(Map<String, dynamic> json) => MovieHub(
        page: json["page"],
        movieList: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_movieList"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "movieList": List<dynamic>.from(movieList.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_movieList": totalResults,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
