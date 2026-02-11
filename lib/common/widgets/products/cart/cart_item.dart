
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../images/rounded_image.dart';
import '../../text/brand_title_with_verify_icon.dart';
import '../../text/product_title_text.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);

    return Row(
      children: [

        // product image
        URoundedImage(
          imageUrl: UImages.productImage15,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark?UColors.darkerGrey:UColors.light,
        ),
        SizedBox(width: USizes.spaceBtwItems,),
        // brand name variation
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UBrandTitleWithVerifyIcon(title: 'iPhone'),
            UProductTitleText(title:'iPhone 11 63 GB W',maxLines: 1,),
            RichText(text:TextSpan(
                children: [
                  TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.labelMedium
                  ),
                  TextSpan(
                      text: 'Green ',
                      style: Theme.of(context).textTheme.labelMedium
                  ),
                  TextSpan(
                      text: 'Storage ',
                      style: Theme.of(context).textTheme.labelMedium
                  ),
                  TextSpan(
                      text: '512GB ',
                      style: Theme.of(context).textTheme.labelMedium
                  )
                ]
            ) )
          ],
        ))
      ],
    );
  }
}
