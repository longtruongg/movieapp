part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  final String mess;

  const MovieLoading({this.mess});

  @override
  // TODO: implement props
  List<Object> get props => [mess];
}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;

  const MovieLoaded({this.movieList});

  @override
  List<Object> get props => [movieList];

  @override
  String toString() => "Value ${movieList.length}";
}

class MovieUpCome extends MovieState {
  final List<Movie> movieList;

  const MovieUpCome({this.movieList});

  @override
  // TODO: implement props
  List<Object> get props => [movieList];

  @override
  String toString() => "Length of array :${movieList.length}";
}

class MovieSimilar extends MovieState {
  final String movieId;
  final List<MovieHub> movieSimilar;

  const MovieSimilar({this.movieId, this.movieSimilar});

  @override
  // TODO: implement props
  List<Object> get props => [movieId, movieSimilar];
}

class MovieLoadError extends MovieState {
  final String message;

  const MovieLoadError({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
