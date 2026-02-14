import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_cards.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/sortable_products.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand/brand_controller.dart';
import '../../models/product_model.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});
final String title;
final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UBrandCard(brand: brand),
              SizedBox(height: USizes.spaceBtwSections),

             FutureBuilder(
                 future: controller.getBrandProducts(brand.id),
                 builder: (context,snapshot){



                   // Handle Loading ,Error and Empty States
                   const loader =UVerticalProductShimmer();
                  Widget ? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if(widget!=null) return widget;
                  List<ProductModel> products = snapshot.data!;
                   return USortableProducts(product:products);
                 },

               ),
            ],
          ),
        ),
      ),
    );
  }
}
