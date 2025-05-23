import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otokhi/pages/splach_screen.dart';
import 'package:otokhi/widgets/translations.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/product_controller.dart';


void main() async {
  await GetStorage.init();
  Get.put(CartController());
  Get.put(AuthController());
  Get.put(OrderController());
  Get.put(ProductController());
  Get.put(FavoriteController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Splash_Screen(),
    );
  }
}


