import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce_application/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/controller/favourite_controller.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../utils/constants/images.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: FavouriteController.instance.getFavouriteProducts(),
              builder: (context, snapshot) {
                // Handle Emptyu Data
                final nothingFound = UAnimationLoader(
                  text: 'Wishlist is Empty',
                  animation: UImages.pencilAnimation,
                  showActionButton: true,
                  actionText: "Let's add same",
                  onActionPressed: () =>
                      NavigationController.instance.selectedIndex.value = 0,
                );
                const loader = UVerticalProductShimmer(itemCount: 6);
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: nothingFound,
                );
                if (widget != null) return widget;

                // products found
                final products = snapshot.data as List<ProductModel>;
                return UGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return UProductcardVertical(productModel: products[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
