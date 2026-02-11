
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../personalisation/controllers/banners/banner_controller.dart';
import '../../../controllers/home/home_controller.dart';

class BannersDotNavigation extends StatelessWidget {
  const BannersDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final bannerController=Get.put(BannerController());

    return Obx(
      ()=> SmoothPageIndicator(
        count: bannerController.banners.length,
        effect: ExpandingDotsEffect(
          dotHeight: 6.0,
          dotWidth: 6.0,
          activeDotColor: Colors.black,
        ),controller: PageController(initialPage: bannerController.currentIndex.value),
      ),
    );
  }
}
