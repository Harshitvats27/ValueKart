import 'package:e_commerce_application/features/shop/screens/store/store.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/device_helpers.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personalisation/controllers/address_controller.dart';
import 'features/personalisation/controllers/user_controller.dart';
import 'features/shop/controllers/cart/cart_controller.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/personalisation/screens/profile/profile.dart';
import 'features/shop/screens/wishlist/wishlist.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    Get.put(UserController());
    Get.put(AddressController());
    Get.put(CartController());
    bool dark = UHelperfunctions.isDarkTheme(context);

    // 🔥 1. Yahan puri App ko NeonAnimatedBackground se wrap kar diya!
    return  Scaffold(
        // 🔥 2. Scaffold ka background ekdum transparent, taaki neon peeche se dikhe!
        backgroundColor: Colors.transparent,

        body: Obx(() => controller.screens[controller.selectedIndex.value]),

        bottomNavigationBar: Obx(
              ()=> NavigationBar(
              elevation: 0,

              // 🔥 3. Navigation bar ko always black set kiya gaya h user ki request par
              backgroundColor: Colors.black,

              // Indicator ko thoda glowy light/dark diya taaki match kare
              indicatorColor: Colors.white.withOpacity(0.15),

              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index){
                controller.selectedIndex.value = index;
              },

              destinations: const [
                // Icons ko white kar diya taaki dark neon pe mast chamke
                NavigationDestination(icon: Icon(Iconsax.home, color: Colors.white), label: 'Home'),
                NavigationDestination(icon: Icon(Iconsax.shop, color: Colors.white), label: 'Store'),
                NavigationDestination(icon: Icon(Iconsax.heart, color: Colors.white), label: 'Wishlist'),
                NavigationDestination(icon: Icon(Iconsax.user, color: Colors.white), label: 'Profile'),
              ]),
        ),
      );

  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  List<Widget> screens = [HomeScreen(),StoreScreen(),WishListScreen(),ProfileScreen()];
}