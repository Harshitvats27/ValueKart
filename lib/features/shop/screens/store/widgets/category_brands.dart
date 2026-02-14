import 'package:e_commerce_application/common/widgets/brands/brand_showcase.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:flutter/cupertino.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return UBrandShowcase(images: [UImages.productImage15]);
  }
}
