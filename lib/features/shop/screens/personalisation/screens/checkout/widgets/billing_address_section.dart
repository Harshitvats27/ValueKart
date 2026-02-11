import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          USectionHeading(title: 'Billing Address',buttonTitle: 'Change',onPressed: (){},),
        Text('Unknown Pro',style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: USizes.spaceBtwItems/2,),
        Row(
          children: [
            Icon(Icons.phone,size: USizes.iconSm,color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),
            Text('+91 9518437050')
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems/2,),
        Row(
          children: [
            Icon(Icons.local_activity,size: USizes.iconSm,color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),
            Expanded(
                child: Text('HJno 680 VPO Harsana Kalan,Sonipat,131001',softWrap: true,))
          ],
        ),
      ],
    );
  }
}
