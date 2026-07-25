import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalisation/controllers/user_controller.dart';
// 🔥 ADDED: Apna naya AddressController import kiya
import '../../../../personalisation/controllers/address_controller.dart';

class UHomeAppbar extends StatelessWidget {
  const UHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Dono controllers yahan initialize kar diye
    final userController = Get.put(UserController());
    final addressController = Get.put(AddressController());

    return UAppBar(
      // 🔥 ADDED: GestureDetector taaki click hone par bottom sheet khule
      title: GestureDetector(
        onTap: () => addressController.selectNewAddressBottomSheet(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Isko start kar diya taaki left align rahe
          children: [
            // title
            Text(
              'Deliver to', // Greeting ki jagah 'Deliver to' zyada professional lagta hai e-commerce mein
              style: Theme.of(context).textTheme.labelMedium!.apply(color: UColors.grey),
            ),
            const SizedBox(height: USizes.spaceBtwItems / 3),

            // subtitle (Address Field)
            Obx(() {
              // Agar profile load ho rahi hai toh tera pehle wala shimmer dikhega
              if (userController.profileLoading.value) {
                return const UShimmerEffect(width: 80, height: 15);
              }

              // Address load karna
              final address = addressController.selectedAddress.value;

              return Row(
                children: [
                  const Icon(Iconsax.location, color: UColors.white, size: 16),
                  const SizedBox(width: 4),

                  // Flexible/Expanded zaroori hai taaki lamba address screen ke bahar na nikle
                  Flexible(
                    child: Text(
                      address.id.isEmpty
                          ? 'Select Address'
                          : '${address.name}, ${address.street}, ${address.city}', // Custom format jo dikhana ho
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: UColors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Bada text ... mein badal jayega
                    ),
                  ),

                  const SizedBox(width: 4),
                  const Icon(Iconsax.arrow_down_1, color: UColors.white, size: 16),
                ],
              );
            }),
          ],
        ),
      ),
      actions: const [UCartCounterIcon()],
    );
  }
}