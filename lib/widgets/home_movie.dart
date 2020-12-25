import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuve/blocs/movie_bloc.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/movie.dart';

final dio = Dio();

class HomeMovie extends StatefulWidget {
  @override
  _HomeMovieState createState() => _HomeMovieState();
}

class _HomeMovieState extends State<HomeMovie> {
  List<Movie> movieList;
  MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    // movieBloc = MovieBloc(movieRepository: MovieRepository(dio, baseUrl: AppString.URL));
    // movieBloc.fethMovie();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(GetAllMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Movie Home ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieLoadError) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Errors : ${state.message}")));
            } else if (state is MovieLoaded) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Errors : ${state.movieList.elementAt(1).title}")));
            }
          },
          // ignore: missing_return
          builder: (context, state) {
            if (state is MovieInitial) {
              debugPrint("Value :${state.props}");
              return buildCenterProgressbar(context);
            } else if (state is MovieLoading) {
              return buildCenterProgressbar(context);
            } else if (state is MovieLoaded) {
              debugPrint("Value :${state.movieList.length}");
              return buildMovieItem(context, state.movieList);
            } else
              return buildCenterProgressbar(context);
          },
        ));
  }

  Center buildCenterProgressbar(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildMovieItem(BuildContext context, List<Movie> movieList) {
    var sizeConf = MediaQuery.of(context).size;
    String _posterPath = AppString.POSTER_URL;
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: movieList
            .map((element) => InkWell(
                  child: Container(
                    width: sizeConf.height * 0.3,
                    height: sizeConf.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(_posterPath + element.posterPath))),
                  ),
                ))
            .toList());
  }

  @override
  void dispose() {
    movieBloc.close();
    super.dispose();
  }
}
