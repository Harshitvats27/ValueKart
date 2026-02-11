import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/button/elevated_button.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../../controllers/onboarding/onboarding_controller.dart';


class OnboardingScreen  extends StatelessWidget {
  const OnboardingScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
        child: Stack(
          children: [

            // Scrollable page
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(animation: UImages.onboarding1Animation,title: UTexts.onBoardingTitle1,subtitle: UTexts.onBoardingSubTitle1,),
                OnBoardingPage(animation: UImages.onboarding2Animation,title: UTexts.onBoardingTitle2,subtitle: UTexts.onBoardingSubTitle2,),
                OnBoardingPage(animation: UImages.onboarding3Animation,title: UTexts.onBoardingTitle3,subtitle: UTexts.onBoardingSubTitle3,),

              ],



        ),
            //  Indicator
            OnBoardingDotNavigation(),

            // Bottom Button
            OnBoardingNextButton(),

            // Skip Button

            OnBoardingSkipButton(),
          ],
        ),
      ),
   );
  }
}

