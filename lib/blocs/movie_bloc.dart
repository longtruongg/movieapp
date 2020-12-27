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

  MovieBloc({this.movieRepository}) : super(MovieInitial());

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
    } else {
      yield* movieLoadingWithError();
    }
  }

  Stream<MovieState> getAllMovie() async* {
    await Future.delayed(Duration(microseconds: 700));
    final movies = await movieRepository.getAllMovie(AppString.API);
    List<Movie> movielist = <Movie>[];
    movielist.addAll(movies.movieList);
    print("length of Movies :${movielist.length}");
    yield MovieLoaded(movieList: movielist);
  }

  Stream<MovieState> getTopRated() async* {
    await Future.delayed(Duration(milliseconds: 700));
    final movieHub = await movieRepository.getTopRated(AppString.API);
    List<Movie> movieList = <Movie>[];
    movieList.addAll(movieHub.movieList);
    yield MovieLoaded(movieList: movieList);
  }

  Stream<MovieState> getMovieUpComing() async* {
    await Future.delayed(Duration(milliseconds: 700));
    final movies = await movieRepository.getMovieUpComing(AppString.API);
    final List<Movie> movieList = <Movie>[];
    movieList.addAll(movies.movieList);
    yield MovieUpCome(movieList: movieList);
  }

  Stream<MovieState> movieLoadingWithError() async* {
    final String mess = "Fetch error check again !";
    yield MovieLoadError(message: mess);
  }
}
