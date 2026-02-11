import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/primary_header_container.dart';
import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/shop/screens/order/order.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/profile/widgets/profile_primary_header.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/profile/widgets/setting_menu_tile.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/profile/widgets/user_profile_details.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../address/address.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProfilePrimaryHeader(),
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  // user profile detaisl
                  UserProfileTile(),
                  SizedBox(height: USizes.spaceBtwItems),

                  //Account Section Heading
                  USectionHeading(
                    title: 'Account Settings',
                    showActionButtton: false,
                  ),

                  // Setting Menu
                  SettingMenuTile(ontap: ()=>Get.to(()=>AddressScreen()),
                    icon: Iconsax.safe_home,
                    title: 'MY Addresses',
                    subtitle: 'Set Shopping delivery address',
                  ),
                  SettingMenuTile(ontap: (){},
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add,remove products and move to checkout',
                  ),
                  SettingMenuTile(
                    ontap: ()=>Get.to(()=>OrderScreen()),
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                  ),

                  SizedBox(height: USizes.spaceBtwSections),

                  // logout
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: AuthenticationReposiotory.instance.logout,
                      child: Text('Logout'),
                    ),
                  ),

                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
