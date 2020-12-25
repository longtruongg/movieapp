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
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MovieInit) {
      yield MovieInitial();
    } else if (event is MovieLoadingg) {
      yield MovieLoading(mess: "Will coming...");
    } else if (event is GetAllMovie) {
      // yield* fethMovie();
      try {
        await Future.delayed(Duration(microseconds: 700));
        final movies = await movieRepository.getAllMovie(AppString.API);
        List<Movie> movielist = <Movie>[];
        movielist.addAll(movies.movieList);
        print("length of Movies :${movielist.length}");
       yield  MovieLoaded(movieList: movielist);
      } on MovieLoadError catch (e) {
        yield MovieLoadError(message: e.message.toString());
      }
    } else if (event is MovieTopRated) {
      try {
        await Future.delayed(Duration(seconds: 1));
        final movieHub = await movieRepository.getTopRated(AppString.API);
        yield MovieLoaded(movieList: movieHub.movieList);
      } on MovieLoadError catch (e) {
        yield MovieLoadError(message: e.message);
      }
    } else {
      yield MovieLoadError(message: "Check again ");
    }
  }

  fethMovie() async {
    try {
      await Future.delayed(Duration(microseconds: 700));
      final movies = await movieRepository.getAllMovie(AppString.API);
      MovieLoaded(movieList: movies.movieList);
    } on MovieLoadError catch (e) {
      MovieLoadError(message: e.message.toString());
    }
  }

  findMovie() async {
    try {
      await Future.delayed(Duration(milliseconds: 700));
      String query;
      final resuslt = await movieRepository.findMovieId(AppString.API);
      MovieUpCome(movieList: resuslt.movieList);
    } on MovieLoadError catch (e) {
      MovieLoadError(message: e.message.toString());
    }
  }

  movieSimilar() async {
    try {
      String movieId;
      final result = await movieRepository.similarMovie(movieId, AppString.API);
      MovieLoaded(movieList: result.movieList);
    } on MovieLoadError catch (e) {
      MovieLoadError(message: e.message.toString());
    }
  }
}
