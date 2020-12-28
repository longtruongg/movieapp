import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/movie.dart';

class DetailMovie extends StatefulWidget {
  final Movie movie;

  DetailMovie({this.movie});

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  final String headerPath = AppString.HEADER_URL;

  @override
  Widget build(BuildContext context) {
    var sizeConf = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            expandedHeight: sizeConf,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                headerPath + widget.movie.backdropPath,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              title: Text(
                widget.movie.originalTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              titlePadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Flex(direction: Axis.vertical, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterChip(
                    avatar: Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    label: Text(
                      widget.movie.voteAverage.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  FilterChip(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text(
                      widget.movie.voteCount.toString(),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    avatar: Icon(Icons.favorite_outlined),
                  ),
                  CustomFilterChip(
                    icon: Icons.movie,
                    content: widget.movie.popularity.toString(),
                  )
                ],
              ),
            ]),
            Flex(
              direction: Axis.vertical,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Release Date: ${widget.movie.releaseDate}"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    widget.movie.overview,
                    style: TextStyle(fontSize: 15),
                    maxLines: 5,
                  ),
                )
              ],
            )
          ]))
        ],
      ),
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  final String content;
  final IconData icon;

  const CustomFilterChip({
    this.content,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        avatar: Icon(
          icon,
          color: Colors.red,
        ),
        label: Text(
          content,
          style: TextStyle(fontSize: 15),
        ),
        onSelected: null);
  }
}
