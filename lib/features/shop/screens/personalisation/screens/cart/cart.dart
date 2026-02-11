import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce_application/common/widgets/images/rounded_image.dart';
import 'package:e_commerce_application/common/widgets/text/brand_title_with_verify_icon.dart';
import 'package:e_commerce_application/common/widgets/text/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/text/product_title_text.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../../common/widgets/products/cart/product_quantity_addnremove.dart';
import '../../../../../../utils/helpers/helper_function.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
      ),

      body: Padding(
        padding: UPadding.screenPadding,
        child: UCartItems(),
      ),
      bottomNavigationBar: UElevatedButton(onPressed: ()=> Get.to(()=>CheckoutScreen()), child: Text('Checkout \$ 134435')),
    );
  }
}
