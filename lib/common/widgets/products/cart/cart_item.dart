
import 'package:e_commerce_application/features/shop/models/cart_item_model.dart';
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
    super.key, required this.cartItem,
  });
final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);

    return Row(
      children: [

        // product image
        URoundedImage(
          imageUrl: cartItem.image??'',
          isNetworkImage: true,
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
            UBrandTitleWithVerifyIcon(title: cartItem.brandName??''),
            UProductTitleText(title:cartItem.title,maxLines: 1,),
            RichText(text:TextSpan(
                children: (cartItem.selectedVariation??{}).entries.map((e)=>TextSpan(
                  children: [
                    TextSpan(
                        text: '${e.key}',
                        style: Theme.of(context).textTheme.labelMedium
                    ),
                    TextSpan(
                        text: '${e.value}',
                        style: Theme.of(context).textTheme.labelMedium
                    ),
                  ]
                )).toList()
            ) )
          ],
        ))
      ],
    );
  }
}
