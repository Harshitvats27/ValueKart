import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/colors.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});


  @override
  Widget build(BuildContext context) {
    final dark =UHelperfunctions.isDarkTheme(context);
    return Column(
      children: [
        USectionHeading(title: 'Payment Method',buttonTitle: 'Change',onPressed: (){},),
        SizedBox(height: USizes.spaceBtwItems/2,),
        Row(
          children: [
            URoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark? UColors.light:UColors.white,
              padding: EdgeInsets.all(USizes.sm),
              child: Image(
                image: AssetImage(UImages.googlePay,),fit: BoxFit.contain,
              ),
            ),
            SizedBox(width:USizes.spaceBtwItems/2 ,),
            
            Text('Google Pay',style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}
