import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/personalisation/controllers/address_controller.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controllers/checkout/checkout_controller.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.getAllAddresses();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          USectionHeading(title: 'Billing Address',buttonTitle: 'Change',onPressed: ()=>controller.selectNewAddressBottomSheet(context),),
        Obx((){
          final address = controller.selectedAddress.value;
          if(address.id.isEmpty){return Text('Select Address');}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name,style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: USizes.spaceBtwItems/2,),
              Row(
                children: [
                  Icon(Icons.phone,size: USizes.iconSm,color: UColors.darkGrey,),
                  SizedBox(width: USizes.spaceBtwItems,),
                  Text( address.phoneNumber,softWrap: true,)
                ],
              ),
              SizedBox(height: USizes.spaceBtwItems/2,),
              Row(
                children: [
                  Icon(Icons.local_activity,size: USizes.iconSm,color: UColors.darkGrey,),
                  SizedBox(width: USizes.spaceBtwItems,),
                  Expanded(
                      child: Text(address.toString(),softWrap: true,))
                ],
              ),
            ],
          );

        })
      ],
    );
  }
}
