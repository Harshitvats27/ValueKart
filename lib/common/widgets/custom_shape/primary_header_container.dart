
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

import 'circular_contaner.dart';
import 'clipper/custom_rounded_clipper.dart';
import 'rounded_edges_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/device_helpers.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child, required this.height,
  });
final Widget child;
final double height;

  @override
  Widget build(BuildContext context) {
   return URoundedEdges(
      child: Container(
        height:height,
        color: UColors.primary,
        child: Stack(
          children: [
            // Circular Container
            Positioned(
              top: -100,
              right: -150,
              left: 220,
              child: UCircularContaimer.UCircularContainer(
                // height: UDeviceHelper.getScreenHeight(context) * 0.4,
                // width: UDeviceHelper.getScreenWidth(context)*0.4,
                height: height,
                width:  USizes.homePrimaryHeaderHeight,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
      
            // Circular Container
            Positioned(
              right: -380,
              left: 240,
              top: 50,
              bottom: -120,
              child: UCircularContaimer.UCircularContainer(
                // height: UDeviceHelper.getScreenHeight(context) * 0.4,
                // width: UDeviceHelper.getScreenWidth(context)*0.4,
                height: USizes.homePrimaryHeaderHeight,
                width:  USizes.homePrimaryHeaderHeight,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
      
            child
          ],
        ),
      ),
    );
  }
}
