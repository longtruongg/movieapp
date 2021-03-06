import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuve/blocs/movie_bloc.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/movie.dart';
import 'package:yuve/widgets/movies/detail_movie.dart';

class DiscoverMovie extends StatefulWidget {
  @override
  _DiscoverMovieState createState() => _DiscoverMovieState();
}

class _DiscoverMovieState extends State<DiscoverMovie> {
  MovieBloc movieBloc;
  List<Movie> movieListSlider = <Movie>[];
  List<Movie> movieHub;

  @override
  void initState() {
    super.initState();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(MovieUpComing());
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
        body: BlocConsumer<MovieBloc, MovieState>(listener: (context, state) {
      if (state is MovieUpCome) {
        movieHub = state.movieList;
      } else if (state is MovieLoadError) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(state.message.toString().toLowerCase())));
      }
    }, builder: (context, state) {
      if (state is MovieInitial)
        return _buildCenterProgress(context);
      else if (state is MovieLoading)
        return _buildLinearProgress(context);
      else if (state is MovieUpCome) {
        return _buildGridViewMovie(context, state);
      }
      return _buildCenterProgress(context);
    }));
  }
}

Widget _buildCenterProgress(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      value: 10,
      backgroundColor: Colors.lightGreen,
    ),
  );
}

Widget _buildLinearProgress(BuildContext context) {
  return LinearProgressIndicator(
    value: 10,
    backgroundColor: Colors.deepOrangeAccent,
  );
}

Widget _buildGridViewMovie(BuildContext context, MovieUpCome state) {
  var sizeConf = MediaQuery.of(context).size;
  String _posterPath = AppString.POSTER_URL;
  return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: state.movieList
          .map((element) => InkWell(
                onTap: () => _buildDetailMovie(context, element),
                child: Container(
                  width: sizeConf.height * 0.7,
                  height: sizeConf.height * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_posterPath + element.posterPath))),
                ),
              ))
          .toList());
}

void _buildDetailMovie(BuildContext context, Movie element) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => DetailMovie(
                movie: element,
              )));
}
