part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieInit extends MovieEvent {}

class MovieLoadingg extends MovieEvent {}

class GetAllMovie extends MovieEvent {
  const GetAllMovie();
}

class MovieTopRated extends MovieEvent {
  const MovieTopRated();
}

class MovieUpComing extends MovieEvent {}

class FindMovie extends MovieEvent {
  final String movieName;

  const FindMovie({this.movieName});

  @override
  List<Object> get props => [movieName];
}

class SimilarMovie extends MovieEvent {
  const SimilarMovie();
}
