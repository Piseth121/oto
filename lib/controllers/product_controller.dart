import 'package:get/get.dart';
import '../models/new_product.dart';
import '../models/top_sold.dart';
import '../services/api_service.dart';


class ProductController extends GetxController {
  var isLoading = true.obs;
  var newProducts = <NewProduct>[].obs;
  var topSelling = <TopSelling>[].obs;
  var recommendeds = <NewProduct>[].obs; // use NewProduct for recommendeds too

  @override
  void onInit() {

    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var data = await ApiService.fetchHomeProducts();

      if (data['newProducts'] != null) {
        newProducts.value = List<NewProduct>.from(
          data['newProducts'].map((x) => NewProduct.fromJson(x)),
        );
      }

      if (data['topSolds'] != null) {
        topSelling.value = List<TopSelling>.from(
          data['topSolds'].map((x) => TopSelling.fromJson(x)),
        );
      }

      if (data['recommendeds'] != null) {
        recommendeds.value = List<NewProduct>.from(
          data['recommendeds'].map((x) => NewProduct.fromJson(x)),
        );
      }
    } finally {
      isLoading(false);
    }
  }

}
