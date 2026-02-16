
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../common/widgets/custom_shape/rounded_container.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/helpers/helper_function.dart';
import '../../../../../../personalisation/controllers/address_controller.dart';
import '../../../../../../personalisation/models/address_model.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({
    super.key,  required this.addresses, required this.onTap,
  });

final AddressModel addresses;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller =AddressController.instance;
    final dark = UHelperfunctions.isDarkTheme(context);
    return Obx((){
      String selectedAddressId = controller.selectedAddress.value.id;
      bool isSelected = selectedAddressId == addresses.id;
      return InkWell(
        onTap: onTap,
        child: URoundedContainer(
            showBorder: true,
            backgroundColor: isSelected ? UColors.primary.withValues(alpha: 0.5) : Colors.transparent,
            borderColor: isSelected?Colors.transparent:dark?UColors.darkerGrey:UColors.grey,
            padding: EdgeInsets.all(USizes.md),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(addresses.name,style: Theme.of(context).textTheme.titleLarge,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: USizes.spaceBtwItems/2),
                    Text(addresses.phoneNumber,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: USizes.spaceBtwItems/2),
                    Text(addresses.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ],
                ),
                if(isSelected)Positioned(
                    top: 0,
                    bottom: 0,
                    right: 6,
                    child: Icon(Iconsax.tick_circle))
              ],
            )
        ),
      );
    });
  }
}
