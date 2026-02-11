
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../common/widgets/custom_shape/rounded_container.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/helpers/helper_function.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({
    super.key, required this.isSelected,
  });
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    return URoundedContainer(
      showBorder: true,
      backgroundColor: isSelected ? UColors.primary.withValues(alpha: 0.5) : Colors.transparent,
      borderColor: isSelected?Colors.transparent:dark?UColors.darkerGrey:UColors.grey,
      padding: EdgeInsets.all(USizes.md),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unknown Pro',style: Theme.of(context).textTheme.titleLarge,maxLines: 1,overflow: TextOverflow.ellipsis,),
              SizedBox(height: USizes.spaceBtwItems/2),
              Text('+91 95198437050',maxLines: 1,overflow: TextOverflow.ellipsis,),
              SizedBox(height: USizes.spaceBtwItems/2),
              Text('Harsana Kalan , Sonipat , Haryana ',maxLines: 1,overflow: TextOverflow.ellipsis,)
            ],
          ),
          if(isSelected)Positioned(
              top: 0,
              bottom: 0,
              right: 6,
              child: Icon(Iconsax.tick_circle))
        ],
      )
    );
  }
}
