import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/device_helpers.dart';

class UCircularContaimer extends StatelessWidget {
  const UCircularContaimer.UCircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.backgroundColor = UColors.white,
    this.padding,
    this.margin,
     this.child,
  });

  final double height, width;

  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget?child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: child,
    );
  }
}
