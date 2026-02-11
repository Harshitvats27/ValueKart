import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/personalisation/controllers/user_controller.dart';
import '../../../utils/constants/images.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(() {
      final isProfileAvailable =
          controller.user.value.profilePicture.isNotEmpty;

      return UCircularImage(
        image: isProfileAvailable
            ? controller.user.value.profilePicture
            : UImages.profileLogo,
        isNetworkImage: isProfileAvailable,
        height: 120,
        width: 120,
        borderWidth: 5.0,
        padding: 0,
      );
    });
  }
}
