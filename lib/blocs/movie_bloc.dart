import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/movie.dart';
import 'package:yuve/models/moviehub.dart';
import 'package:yuve/repo/movie/movierepository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({this.movieRepository})
      : assert(movieRepository != null),
        super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieInit) {
      yield MovieInitial();
    } else if (event is MovieLoadingg) {
      yield MovieLoading(mess: "Will coming...");
    } else if (event is GetAllMovie) {
      yield* getAllMovie();
    } else if (event is MovieTopRated) {
      yield* getTopRated();
    } else if (event is MovieUpComing) {
      yield* getMovieUpComing();
    } else if (event is FindMovie) {
      yield* getSimilarMovies();
    } else {
      yield* movieLoadingWithError();
    }
  }

  Stream<MovieState> getAllMovie() async* {
    await Future.delayed(Duration(microseconds: 700));
    List<Movie> movielist = (await movieRepository.getAllMovie(AppString.API)).movieList;
    print("length of Movies :${movielist.length}");
    yield MovieLoaded(movieList: movielist);
  }

  Stream<MovieState> getTopRated() async* {
    await Future.delayed(Duration(milliseconds: 700));

    List<Movie> movieList = (await movieRepository.getTopRated(AppString.API)).movieList;
    yield MovieLoaded(movieList: movieList);
  }

  Stream<MovieState> getMovieUpComing() async* {
    await Future.delayed(Duration(milliseconds: 700));

    List<Movie> movieList = (await movieRepository.getMovieUpComing(AppString.API)).movieList;
    yield MovieUpCome(movieList: movieList);
  }

  Stream<MovieState> movieLoadingWithError() async* {
    final String mess = "Fetch error check again !";
    yield MovieLoadError(message: mess);
  }

  Stream<MovieState> getSimilarMovies() async* {}
}
