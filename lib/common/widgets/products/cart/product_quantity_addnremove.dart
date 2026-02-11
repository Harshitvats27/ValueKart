
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../icons/circular_icon.dart';

class UProductQuantityandRemove extends StatelessWidget {
  const UProductQuantityandRemove({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    return Row(
      children: [
        SizedBox(width:70.0),
        Row(
          children: [
            UCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: USizes.iconSm,
              color: dark ? UColors.white : UColors.black,

              backgroundColor: dark
                  ? UColors.darkerGrey
                  : UColors.light,
            ),
            SizedBox(width: USizes.spaceBtwItems),
            Text('2', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(width: USizes.spaceBtwItems),
            UCircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: USizes.iconSm,
              color: UColors.white,

              backgroundColor: UColors.primary,
            ),
          ],
        )
      ],
    );
  }
}
