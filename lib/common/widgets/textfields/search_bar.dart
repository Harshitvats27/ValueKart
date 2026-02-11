
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../style/shadow.dart';

class USearchBar extends StatelessWidget {
  const USearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperfunctions.isDarkTheme(context);
    return Positioned(
      bottom: 0,
      right: USizes.spaceBtwSections,
      left: USizes.spaceBtwSections,
      child: Container(
        height: USizes.searchBarHeight,
        padding: EdgeInsets.symmetric(horizontal: USizes.md),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(USizes.borderRadiusLg),
            color: dark ? UColors.dark : UColors.light,
            boxShadow:UShadow.searchBarShadow

        ),
        child: Row(
          children: [
            Icon(Iconsax.search_normal,color: UColors.darkerGrey,),
            SizedBox(width: USizes.spaceBtwItems,),
            Text(UTexts.searchBarTitle,style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
