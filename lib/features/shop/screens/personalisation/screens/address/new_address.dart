import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Add New Address',style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // name
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Name'
                ),
              ),
              SizedBox(height:USizes.spaceBtwInputFields,),


              // phone number
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name'
                ),
              ),
              SizedBox(height:USizes.spaceBtwInputFields,),
              // street
              TextFormField(
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
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Name'
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // city
                  Expanded(
                    child: TextFormField(
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
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country'
                ),
              ),
              SizedBox(height:USizes.spaceBtwSections,),
              // Save Button
              UElevatedButton(onPressed: (){}, child:Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
