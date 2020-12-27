import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yuve/config/app_string.dart';
import 'package:yuve/models/moviehub.dart';

part 'movierepository.g.dart';

@RestApi(baseUrl: AppString.URL)
abstract class MovieRepository {
  factory MovieRepository(Dio dio, {String baseUrl}) = _MovieRepository;

  @GET("/3/movie/popular")
  Future<MovieHub> getAllMovie(@Query("api_key") String apiKey);

  @GET("/3/movie/top_rated")
  Future<MovieHub> getTopRated(@Query("api_key") String apiKey);

  @GET("/3/movie/upcoming")
  Future<MovieHub>getMovieUpComing(@Query("api_key") String apiKey);

  @GET("/3/movie/{movie_id}/similar")
  Future<MovieHub> similarMovie(@Path("movie_id") String movieId, @Query("api_key") String apiKey);
}
