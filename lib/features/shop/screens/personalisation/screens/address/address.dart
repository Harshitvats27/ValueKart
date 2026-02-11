import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/address/new_address.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/address/widgets/single_address.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text('Addresses',style: Theme.of(context).textTheme.headlineMedium,),
        showBackArrow: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              USingleAddress(isSelected: true,),
              SizedBox(height: USizes.spaceBtwItems),
              USingleAddress(isSelected: false,),

            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.to(()=>AddNewAddressScreen()),
        backgroundColor: UColors.primary,
        child: Icon(Iconsax.add),
      ),
    );
  }
}
