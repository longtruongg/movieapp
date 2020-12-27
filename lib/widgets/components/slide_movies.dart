import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/movie.dart';

//
// class MovieSlide extends StatefulWidget {
//   final List<Movie> movieList;
//
//   MovieSlide({this.movieList});
//
//   @override
//   _MovieSlideState createState() => _MovieSlideState();
// }
//
// class _MovieSlideState extends State<MovieSlide> {
//   @override
//   Widget build(BuildContext context) {
//     var sizeConfig = MediaQuery.of(context).size;
//     return Scaffold(
//       body: _buildSliderImage(context),
//     );
//   }
//
//   Widget _buildSliderImage(BuildContext context) {
//     String pathPoster = AppString.POSTER_URL;
//     return CustomScrollView(
//       slivers: <Widget>[
//         SliverAppBar(
//           expandedHeight: MediaQuery.of(context).size.height * 0.3,
//           floating: false,
//           pinned: true,
//           flexibleSpace: FlexibleSpaceBar(
//             background: Swiper(
//               itemCount: widget.movieList.length,
//               itemBuilder: (context, int index) => Image.network(
//                 pathPoster + widget.movieList[index].posterPath,
//                 fit: BoxFit.cover,
//               ),
//               autoplay: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
class SliderMovie extends SliverPersistentHeader {
  final List<Movie> movieList;

  const SliderMovie({this.movieList});

  @override
  Widget build(BuildContext context) {
    String posterPath = AppString.POSTER_URL;
    return Swiper(
      itemCount: movieList.length,
      itemBuilder: (context, int index) => Image.network(
        posterPath + movieList[index].posterPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
