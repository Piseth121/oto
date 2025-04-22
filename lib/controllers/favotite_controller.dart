import 'package:get/get.dart';
import '../constant_model/models.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <NewProduct>[].obs;

  void toggleFavorite(NewProduct product) {
    if (favoriteItems.contains(product)) {
      favoriteItems.remove(product);
    } else {
      favoriteItems.add(product);
    }
  }

  bool isFavorite(NewProduct product) {
    return favoriteItems.contains(product);
  }
}
