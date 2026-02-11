import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/product_cards/product_cards_vertical.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text('WishList',style: Theme.of(context).textTheme.headlineMedium),
        actions: [UCircularIcon(icon: Iconsax.add,onPressed: ()=> NavigationController.instance.selectedIndex.value=0)],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UGridLayout(
            itemCount: 10,
            itemBuilder: (context, index) {
              return UProductcardVertical(productModel: ProductModel.empty(),);
            },
          ),
        ),
      ),

    );
  }
}
