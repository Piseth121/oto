import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;
  var newProducts = <Product>[].obs;
  var topSolds = <Product>[].obs;
  var recommendeds = <Product>[].obs;
  var feature = Rxn<Product>();
  var productsByCategory = <int, List<Product>>{}.obs;
  var categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchHomeProducts();
    super.onInit();
  }

  void fetchHomeProducts() async {
    try {
      isLoading.value = true;

      final data = await ApiService.fetchHomeProducts();

      products.value = (data['products'] as List).map((e) => Product.fromJson(e)).toList();
      newProducts.value = (data['newProducts'] as List).map((e) => Product.fromJson(e)).toList();
      topSolds.value = (data['topSolds'] as List).map((e) => Product.fromJson(e)).toList();
      recommendeds.value = (data['recommendeds'] as List).map((e) => Product.fromJson(e)).toList();
      feature.value = data['feature'] != null ? Product.fromJson(data['feature']) : null;

      final productList = (data['products'] as List).map((e) => Product.fromJson(e)).toList();
      products.value = productList;

      final Map<int, List<Product>> grouped = {};
      final Set<String> seenNames = {};

      for (var item in productList) {
        grouped.putIfAbsent(item.categoryId, () => []).add(item);
        if (!seenNames.contains(item.category)) {
          categories.add({"id": item.categoryId, "name": item.category});
          seenNames.add(item.category);
        }
      }

      productsByCategory.value = grouped;
    } catch (e) {
      print(" Error loading products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
