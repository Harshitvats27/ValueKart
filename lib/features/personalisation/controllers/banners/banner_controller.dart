import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/features/shop/models/banners_models.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banner_repository.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _repository=Get.put(BannerRepository());
  RxList<BannerModel>banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;
  final CarouselSliderController carouselController =
  CarouselSliderController();
  RxInt currentIndex = 0.obs;




  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }
  void onPageChanged(int index) {
    currentIndex.value = index;
  }



  Future<void>fetchBanners()async{
    
    try{
      isLoading.value = true;
      List<BannerModel>activeBanners = await _repository.fetchBanners();
      banners.assignAll(activeBanners);

    }catch(e){
      USnackBarHelpers.errorSnackBar(title: 'Failed',message: e.toString());
    }finally{
      isLoading.value = false;

    }
    
  }


}