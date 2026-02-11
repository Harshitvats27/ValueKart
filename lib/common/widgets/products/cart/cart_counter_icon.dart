
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_function.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperfunctions.isDarkTheme(context);
    return Stack(
      children: [
        IconButton(
          onPressed: ()=>Get.to(()=>CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: UColors.light),
        ),

        Positioned(
          right:6.0,                  child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dark ? UColors.dark : UColors.light,
            ),
            child: Center(child: Text('2',style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeFactor: 0.7,color: dark ? UColors.light : UColors.dark),))
        ),
        ),
      ],
    );
  }
}
