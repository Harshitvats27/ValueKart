import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/banners_dot_navigation.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/primary_header_container.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/promoslider.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:e_commerce_application/utils/helpers/u_empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common/layout/grid_layout.dart';
import '../../../../common/style/shadow.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shape/circular_contaner.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../common/widgets/textfields/search_bar.dart';
import '../../../../pan_india_catalog.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../personalisation/controllers/address_controller.dart';
import '../../controllers/controller/product_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final productController = Get.put(ProductController());
    bool dark = UHelperfunctions.isDarkTheme(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // upper part
            Stack(
              children: [
                SizedBox(height: USizes.homePrimaryHeaderHeight + 10),
                PrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UHomeAppbar(),
                      const SizedBox(height: USizes.spaceBtwSections),
                      // row Categories
                      const UHomeCategories(),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: USizes.defaultSpace,
                  right: USizes.defaultSpace,
                  child: const USearchBar(),
                ),
              ],
            ),
            const SizedBox(height: USizes.defaultSpace),

            // lower part
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  // 🔥 Banners Hamesha Dikhenge
                  const UPromoSlider(),
                  const SizedBox(height: USizes.spaceBtwSections),

                  // 🔥 Sirf Products wale hisse par Address ki condition lagayenge
                  Obx(() {
                    // Obx ke andar address get kiya taaki address change hote hi UI badal jaye
                    final address = Get.put(AddressController()).selectedAddress.value;

                    // 1. Agar koi address select nahi kiya hai
                    if (address.id.isEmpty || address.latitude == 0.0) {
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          const Icon(Iconsax.location_cross, size: 50, color: Colors.grey),
                          const SizedBox(height: 15),
                          Text(
                            'Please select an address to see products in your area 📍',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      );
                    }

                    // 2. Agar products load ho rahe hain
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // 3. Agar address ke aas-paas koi store (products) nahi hai
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // 3. Agar address ke aas-paas koi store (products) nahi hai
                    if (productController.featuredProducts.isEmpty) {
                      return UEmptyStateWidget(
                        icon: Iconsax.box_remove,
                        title: 'Not Serviceable in your area yet! 🚀',
                        subTitle: 'We are expanding fast! Explore items from across India below.',
                        showAction: true,
                        actionTitle: 'Explore Pan-India Catalog 🌍',
                        onActionPressed: () {
                          // TODO: Yahan apni PanIndiaCatalogScreen ka route daal dena
                          Get.to(() => const PanIndiaCatalogScreen());
                        },
                      );
                    }

                    // 4. Agar address bhi hai aur products bhi hain (Sab theek hai)
                    return Column(
                      children: [
                        // Section Heading
                        USectionHeading(
                          title: 'Popular Products',
                          onPressed: () => Get.to(() => AllProductsScreen(
                            title: 'Popular Products',
                            futureMethod: productController.getAllFeaturedProducts(),
                          )),
                        ),
                        const SizedBox(height: USizes.spaceBtwSections),

                        // Vertical product cards
                        UGridLayout(
                          itemBuilder: (context, index) {
                            ProductModel product = productController.featuredProducts[index];
                            return UProductcardVertical(productModel: product);
                          },
                          itemCount: productController.featuredProducts.length,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}