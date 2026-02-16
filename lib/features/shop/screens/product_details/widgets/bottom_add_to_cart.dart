import 'package:e_commerce_application/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/helper_function.dart';
import '../../../controllers/cart/cart_controller.dart';

class UBottomAddtoCart extends StatelessWidget {
  const UBottomAddtoCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    bool dark = UHelperfunctions.isDarkTheme(context);
    controller.updateAlreadyAddedProduct(product);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        ()=> Row(
          children: [
            // decrement button
            UCircularIcon(
              icon: Iconsax.minus,
              backgroundColor: UColors.darkGrey,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.productQuantityInCart.value -= 1,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            Text(
              controller.productQuantityInCart.value.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            // increment button
            UCircularIcon(
              icon: Iconsax.add,
              backgroundColor: UColors.darkGrey,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: () => controller.productQuantityInCart.value += 1,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: UColors.black,
                padding: EdgeInsets.all(USizes.md),
                side: BorderSide(color: UColors.black),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.shopping_bag, color: UColors.white),
                  SizedBox(width: USizes.spaceBtwItems / 2),
                  Text('Add to Cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
