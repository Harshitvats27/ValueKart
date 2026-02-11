import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brand/brand_repository.dart';
import '../../models/brand_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;



  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void>getBrands()async{
  try{
    isLoading(true);

    List<BrandModel> allBrands= await _repository.fetchBrands();
    this.allBrands.assignAll(allBrands);
    this.featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured?? false).toList());



  }catch(e){
    USnackBarHelpers.errorSnackBar(title: 'Failed',message: e.toString());
  }
finally{
    isLoading(false);

  }
}
}