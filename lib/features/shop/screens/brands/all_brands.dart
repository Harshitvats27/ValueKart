import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_cards.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/brand/brand_controller.dart';
import '../../models/brand_model.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              USectionHeading(title: 'Brands', showActionButtton: false),
              SizedBox(height: USizes.spaceBtwItems),

              // List OF Brands
              Obx(
                (){
                  if(controller.isLoading.value){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(controller.allBrands.isEmpty){
                    return Center(child: Text('No Brands Found'));
                  }
                  return UGridLayout(
                    itemCount: controller.allBrands.length,
                    itemBuilder: (context, index) {
                      BrandModel brand = controller.allBrands[index];
                      return UBrandCard(
                        onTap: () => Get.to(() => BrandProductsScreen(
                          title: brand.name,
                          brand: brand,
                        )),
                        brand: brand,
                      );
                    },
                    mainAxisExtent: 80,);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
