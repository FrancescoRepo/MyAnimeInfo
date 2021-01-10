import 'package:dio/dio.dart';
import 'package:myanime_info/models/mediapage.dart';
import 'package:myanime_info/models/category.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:5000/api/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/media/categories")
  Future<List<Category>> getCategories();

  @GET('/categories/{category}/{type}')
  Future<MediaPage> getMediaOfCategory(@Path("category") String category,
      @Path("type") String type, @Query("page") String page);

  @GET('/media/{title}/{type}')
  Future<MediaPage> searchMedia(@Path("title") String title,
      @Path("type") String type, @Query("page") String page);
}
