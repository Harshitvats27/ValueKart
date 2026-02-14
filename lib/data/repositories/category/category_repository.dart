import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/utils/constants/key.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exception/firebase_exception.dart';
import '../../../utils/exception/format_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // /// Fetch all categories
  // Future<List<CategoryModel>> fetchCategories() async {
  //   try {
  //     final snapshot =
  //     await _db.collection(UKeys.categoryCollection).get();
  //
  //     return snapshot.docs
  //         .map((doc) => CategoryModel.fromSnapshot(doc))
  //         .toList();
  //   } on FirebaseException catch (e) {
  //     throw UFirebaseException(e.code).message;
  //   } catch (e) {
  //     throw 'Failed to load categories';
  //   }
  // }

  Future<List<CategoryModel>> fetchCategories() async {
    try {

      final query =await _db.collection(UKeys.categoryCollection).get();
      if (query.docs.isNotEmpty) {
        final List<CategoryModel> categories = query.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();;
return categories;
      }
return[];



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

  /// Upload categories (Admin use)
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        await _db
            .collection(UKeys.categoryCollection)
            .doc(category.id)
            .set(category.toJson());
      }
    } catch (e) {
      throw 'Category upload failed';
    }
  }


}
