
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/features/personalisation/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../../common/widgets/images/user_profile_logo.dart';
class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Center(
      child: Obx(() {
        return Stack(
          alignment: Alignment.center,
          children: [
            UserProfileLogo(),

            // Loader
            if (controller.imageUploading.value)
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),

            // Edit icon
            if (!controller.imageUploading.value)
              Positioned(
                bottom: 0,
                right: 0,
                child: UCircularIcon(
                  onPressed: controller.updateUserProfilePicture,
                  icon: Iconsax.edit,
                ),
              ),
          ],
        );
      }),
    );
  }
}
