import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalisation/controllers/user_controller.dart';
import '../../../../personalisation/controllers/address_controller.dart';

// 🔥 ADDED: Apni Neon background wali file yahan zaroor import kar lena!
// import 'path_to_your_file/neon_animated_background.dart';

class UHomeAppbar extends StatelessWidget {
  const UHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Dono controllers yahan initialize kar diye
    final userController = Get.put(UserController());
    final addressController = Get.put(AddressController());

    // 🔥 JADOO YAHAN HAI: Poore UAppBar ko NeonAnimatedBackground ke andar daal diya!
    return  UAppBar(
        title: GestureDetector(
          onTap: () => addressController.selectNewAddressBottomSheet(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                'Deliver to',
                style: Theme.of(context).textTheme.labelMedium!.apply(color: UColors.grey),
              ),
              const SizedBox(height: USizes.spaceBtwItems / 3),

              // subtitle (Address Field)
              Obx(() {
                if (userController.profileLoading.value) {
                  return const UShimmerEffect(width: 80, height: 15);
                }

                final address = addressController.selectedAddress.value;

                return Row(
                  children: [
                    const Icon(Iconsax.location, color: UColors.white, size: 16),
                    const SizedBox(width: 4),

                    Flexible(
                      child: Text(
                        address.id.isEmpty
                            ? 'Select Address'
                            : '${address.name}, ${address.street}, ${address.city}',
                        style: Theme.of(context).textTheme.headlineSmall!.apply(color: UColors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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