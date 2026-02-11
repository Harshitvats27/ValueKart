import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banners_models.dart';
import '../../../utils/constants/key.dart';
import '../../../utils/exception/firebase_exception.dart';
import '../../../utils/exception/format_exception.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<void>uploadBanners(List<BannerModel> banners)async {
    try{


      // upload cloudinary ka bhaang bhosdaa tha yhan

      for (final banner in banners) {
      await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());}
    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    }on UFormatException catch (_) {
      throw UFormatException();
    }on PlatformException catch (_) {
      throw UFormatException();
    } catch (e) {
      throw 'Failed to load categories';
    }
  }
  Future<List<BannerModel>> fetchBanners() async {
    try{

      final query =await _db.collection(UKeys.bannerCollection).where('active',isEqualTo: true).get();
      if (query.docs.isNotEmpty) {
         List<BannerModel> banners = query.docs.map((document)=>BannerModel.fromDocument(document)).toList();
        return banners;
      }else{
        return [];

      }

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    }on UFormatException catch (_) {
      throw UFormatException();
    }on PlatformException catch (_) {
      throw UFormatException();
    } catch (e) {
      throw 'Failed to load categories';
    }
  }
}