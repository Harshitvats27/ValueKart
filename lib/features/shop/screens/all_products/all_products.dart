import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/data/repositories/brand/brand_category_model.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/cart/sortable_products.dart';
import '../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/controller/all_products_controller.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    this.futureMethod,
    this.query,
    required this.title,
  });

  final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // count loader=UVerticalProductShimmer(itemCount: controller.,);
              final widget = UCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
              );
              if (widget != null) return widget;
              List<ProductModel> products = snapshot.data!;
              return USortableProducts(product: products);
            },
          ),
        ),
      ),
    );
  }
}
