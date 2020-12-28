import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuve/blocs/movie_bloc.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/repo/movie/movierepository.dart';
import 'package:yuve/widgets/home_movie.dart';

class MyApp extends StatelessWidget {
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MovieBloc(
          movieRepository: MovieRepository(dio, baseUrl: AppString.URL),
        ),
        child: HomeMovie(),
      ),
    );
  }
}
