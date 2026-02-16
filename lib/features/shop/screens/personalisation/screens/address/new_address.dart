import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../personalisation/controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Add New Address',style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // name
                TextFormField(
                  validator: (value)=>UValidator.validateEmptyText('Name',value),
                  controller: controller.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name'
                  ),
                ),
                SizedBox(height:USizes.spaceBtwInputFields,),
                // street
                TextFormField(
                  validator: (value)=>UValidator.validateEmptyText('Phone Number',value),

                  controller: controller.phoneNumber,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone Number'
                  ),
                ),
                SizedBox(height:USizes.spaceBtwInputFields,),
            
                Row(
                  children: [
                    // street
                    Expanded(
                      child: TextFormField(
                        validator: (value)=>UValidator.validateEmptyText('Street',value),
                        controller: controller.street,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street'
                        ),
                      ),
                    ),
                    SizedBox(width:USizes.spaceBtwInputFields,),
                    // postal code
                    Expanded(
                      child: TextFormField(
                        validator: (value)=>UValidator.validateEmptyText('Postal Code',value),
                        controller: controller.postalCode,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Postal Code'
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:USizes.spaceBtwInputFields,),
                Row(
                  children: [
                    // city
                    Expanded(
                      child: TextFormField(
                        validator: (value)=>UValidator.validateEmptyText('City',value),
                        controller: controller.city,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'
                        ),
                      ),
                    ),
                    SizedBox(width:USizes.spaceBtwInputFields,),
                    // postal code
                    Expanded(
                      child: TextFormField(
                        validator: (value)=>UValidator.validateEmptyText('State',value),
                        controller: controller.state,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State'
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:USizes.spaceBtwInputFields,),
                // country
                TextFormField(
                  validator: (value)=>UValidator.validateEmptyText('Country',value),
                  controller: controller.country,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.global),
                      labelText: 'Country'
                  ),
                ),
                SizedBox(height:USizes.spaceBtwSections,),
                // Save Button
                UElevatedButton(onPressed: controller.addNewAddress, child:Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
