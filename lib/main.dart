import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories/category/category_repository.dart';
import 'features/shop/controllers/categories/category_controller.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationReposiotory());
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  /// 🔥 Dependency Injection (GLOBAL)
  Get.put(CategoryRepository());
  Get.put(CategoryController());
  runApp(const MyApp());
}
