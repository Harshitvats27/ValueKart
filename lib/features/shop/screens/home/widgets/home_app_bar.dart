import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text.dart';
import '../../../../personalisation/controllers/user_controller.dart';

class UHomeAppbar extends StatelessWidget {
  const UHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return UAppBar(
      title: Column(
        children: [
          // title
          Text(
            UHelperfunctions.getGreetingMessage(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: UColors.grey),
          ),
SizedBox(height: USizes.spaceBtwItems/3,),
          // subtitle
          Obx(() {
            if(controller.profileLoading.value){
              return UShimmerEffect(width: 80,height: 50,);
            }
            return Text(
              controller.user.value.username,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: UColors.white),
            );
          }),
        ],
      ),

      actions: [UCartCounterIcon()],
    );
  }
}
