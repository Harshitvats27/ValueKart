
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../personalisation/controllers/user_controller.dart';
import '../../edit_profile/edit_profile.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Obx(()=> Text(controller.user.value.fullName,style: Theme.of(context).textTheme.bodySmall)),
      subtitle: Obx(()=>Text(controller.user.value.email,style: Theme.of(context).textTheme.bodyMedium)),
      trailing: IconButton(onPressed:()=> Get.to(()=>EditProfileScree()),icon: Icon(Iconsax.edit),),


    );
  }
}
