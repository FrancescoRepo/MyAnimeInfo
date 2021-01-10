import 'package:myanime_info/models/category.dart';
import 'package:myanime_info/network/rest_client.dart';

class CategoryRepository {
  final RestClient restClient;

  CategoryRepository({this.restClient});

  Future<List<Category>> get categories => restClient.getCategories();
}
