import 'package:get/get.dart';
import '../constant_model/models.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <Product>[].obs;

  void toggleFavorite(Product product) {
    if (favoriteItems.contains(product)) {
      favoriteItems.remove(product);
    } else {
      favoriteItems.add(product);
    }
  }

  bool isFavorite(Product product) {
    return favoriteItems.contains(product);
  }
}
