import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuve/models/movie.dart';

class MovieSearch extends SearchDelegate<Movie> {
  // final UnmodifiableListView<Movie> movieList;

  // MovieSearch({this.movieList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
