import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuve/blocs/movie_bloc.dart';
import 'package:yuve/config/app_string.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(GetAllMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is MovieLoadError) return _buildCenterProgress(context);
      },
      builder: (context, state) {
        if (state is MovieInitial) {
          return _buildCenterProgress(context);
        } else if (state is MovieLoading) {
          return _buildLoadingMovie(context);
        } else if (state is MovieLoaded) {
          return _buildMovieEachItem(context, state);
        }
        return _buildCenterProgress(context);
      },
    ));
  }

  Widget _buildMovieEachItem(BuildContext context, MovieLoaded state) {
    var sizeConf = MediaQuery.of(context).size;
    String _posterPath = AppString.POSTER_URL;
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: state.movieList
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

  Widget _buildCenterProgress(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
        value: 30,
      ),
    );
  }

  Widget _buildLoadingMovie(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            backgroundColor: Colors.lightGreen,
            value: 10,
          ),
          Text("Movie's coming....")
        ],
      ),
    );
  }
}
