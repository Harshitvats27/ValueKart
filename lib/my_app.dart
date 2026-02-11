import 'package:e_commerce_application/bindings/bindings.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/checkout/checkout.dart';
import 'package:e_commerce_application/routes/app_routes.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      getPages: UAppRoutes.screens,
      initialBinding: UBindings(),
      themeMode: ThemeMode.system,
       home: Scaffold(
         backgroundColor: UColors.primary,
         body:Center(
           child: CircularProgressIndicator(color: Colors.white,),
         ),
       ),
    );
  }
}