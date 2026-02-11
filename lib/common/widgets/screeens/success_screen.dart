import 'package:e_commerce_application/common/style/padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../button/elevated_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.title, required this.subTitle, required this.image, required this.onTap});

  final String title , subTitle, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // Image
              Image.asset(
               image,
                height: UDeviceHelper.getScreenWidth(context) * 0.9,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              // Title
              Text(
               title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              //sub title
              Text(
              subTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              // Continue
              UElevatedButton(onPressed: onTap, child: Text(UTexts.uContinue)),

            ],
          ),
        ),
      ),

    );
  }
}
