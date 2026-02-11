import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_cards.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Bata', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UBrandCard(brand: BrandModel.empty()),
              SizedBox(height: USizes.spaceBtwSections),
             USortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
