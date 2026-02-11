import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product_repository.dart';
import '../../../../utils/pop_ups/snackbar_helpers.dart';
import '../../models/product_model.dart';

class AllProductsController extends GetxController{
  static AllProductsController get instance => Get.find();

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  final _repository=ProductRepository.instance;

  Future<List<ProductModel>> fetchProductsByQuery(Query?query) async {
    try{

      if(query == null)return[];

      List<ProductModel> products = await _repository.fetchProductsByQuery(query);
      return products;

    }catch(e){
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }

  }



}