import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductsImages(ProductModel product) {
    Set<String> images = {};

    // load Thumbnail image
    images.add(product.thumbnail);

    // Assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    // Load all images of the product
    if (product.images != null && product.images!.isEmpty) {
      images.addAll(product.images!);
    }

    // load all images of the product variations
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {

      List<String>variationImages=product.productVariations!.map((variation) => variation.image).toList();
      images.addAll(variationImages);

    }
    return images.toList();
  }

  void showEnlargedImage(String image){
    Get.to(
      fullscreenDialog: true,
        ()=>Dialog.fullscreen(
          child: Column(
            children: [
              // Image
              Padding(padding: EdgeInsets.symmetric(vertical: USizes.defaultSpace*2,horizontal: USizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image,),
              ),
              SizedBox(height: USizes.defaultSpace,),

              // close Button
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: ()=> Get.back(), child: Text('Close')),
                ),
              )
            ],
          ),
        )
    );
  }


}
