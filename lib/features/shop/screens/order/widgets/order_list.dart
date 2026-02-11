import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/device_helpers.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class UOrderListItems extends StatelessWidget {
  const UOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=UHelperfunctions.isDarkTheme(context);
    return ListView.separated(
      separatorBuilder: (context,index)=>SizedBox(height: USizes.spaceBtwItems,),
        itemCount:10,
        itemBuilder: (context,index){
      return URoundedContainer(
        showBorder: true,
        backgroundColor: dark? UColors.dark:UColors.light,
        padding: EdgeInsets.all(USizes.sm),
        child: Padding(
          padding: const EdgeInsets.all(USizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Iconsax.ship),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Processing',style: Theme.of(context).textTheme.bodyLarge!.apply(color: UColors.primary,fontWeightDelta:1 ),),
                        Text('01 January 2026',style: Theme.of(context).textTheme.headlineSmall,)
                      ],
                    ),
                  ),

                  IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34,size: USizes.iconSm,))
                ],
              ),
              SizedBox(height: USizes.spaceBtwItems,),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.tag),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order',style: Theme.of(context).textTheme.labelMedium,),
                              Text('6516515',style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.calendar),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shipping Date',style: Theme.of(context).textTheme.labelMedium,),
                              Text('06 January 2026',style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )

            ],
          ),
        ),


      );
    });
  }
}
