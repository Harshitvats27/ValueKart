import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/shop/models/product_model.dart';

import '../repository/product_upload_repository.dart';

class ProductUploadController extends GetxController {
  static ProductUploadController get instance => Get.find();

  final ProductUploadRepository _repository = ProductUploadRepository();

  RxBool isUploading = false.obs;
  RxDouble progress = 0.0.obs;

  /// Upload product with images
  Future<void> uploadProductWithImages(ProductModel product, List<File> images) async {
    try {
      isUploading(true);
      progress(0.0);

      await _repository.uploadProduct(product, images);

      progress(1.0);
      Get.snackbar('Success', 'Product uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading(false);
    }
  }
}
