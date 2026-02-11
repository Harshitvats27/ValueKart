
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/sizes.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('SubTotal',style: Theme.of(context).textTheme.bodyMedium,)),
                Text('\$343',style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),
            Row(
              children: [
                Expanded(child: Text('Shipping Fee',style: Theme.of(context).textTheme.bodyMedium,)),
                Text('\$34',style: Theme.of(context).textTheme.labelLarge,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),
            Row(
              children: [
                Expanded(child: Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,)),
                Text('\$34',style: Theme.of(context).textTheme.labelLarge,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),
            Row(
              children: [
                Expanded(child: Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,)),
                Text('\$3768',style: Theme.of(context).textTheme.titleMedium,),
              ],
            )
          ],
        )

      ],
    );
  }
}
