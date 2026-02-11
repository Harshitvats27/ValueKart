import 'package:e_commerce_application/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/helper_function.dart';

class UBottomAddtoCart extends StatelessWidget {
  const UBottomAddtoCart({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperfunctions.isDarkTheme(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace,vertical: USizes.defaultSpace/2),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Row(
        children: [
          // decrement button
          UCircularIcon(icon: Iconsax.minus,backgroundColor: UColors.darkGrey,width: 40,height: 40,color: UColors.white,),
          SizedBox(width: USizes.spaceBtwItems),

          Text('2',style: Theme.of(context).textTheme.titleSmall,),
          SizedBox(width: USizes.spaceBtwItems),

          // increment button
          UCircularIcon(icon: Iconsax.add,backgroundColor: UColors.darkGrey,width: 40,height: 40,color: UColors.white,),
         Spacer(),
         ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
              backgroundColor: UColors.black,
           padding: EdgeInsets.all(USizes.md),
           side: BorderSide(color: UColors.black)
         ), child: Row(
           children: [
             Icon(Iconsax.shopping_bag,color: UColors.white,),
             SizedBox(width: USizes.spaceBtwItems/2),
             Text('Add to Cart'),
           ],
         ))
        ],
      ),

    );
  }
}
