import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'StoreModel.dart'; // Apne StoreModel ka path daalna

class StoreRepository extends GetxController {
  static StoreRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // 🔥 Fetch ALL active stores (Hum locally distance calculate karenge)
  Future<List<StoreModel>> fetchAllActiveStores() async {
    try {
      final snapshot = await _db.collection('Stores').where('isActive', isEqualTo: true).get();
      return snapshot.docs.map((doc) => StoreModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching stores';
    }
  }
}