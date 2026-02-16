import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalisation/models/address_model.dart';
import '../../../utils/constants/key.dart';
import '../../../utils/exception/firebase_exception.dart';
import '../../../utils/exception/format_exception.dart';
import '../../../utils/exception/platform_exception.dart';


class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// [Upload] - Function to store user address
  Future<String> addAddress(AddressModel address) async{
    try{

      final userId = AuthenticationReposiotory.instance.currentUser!.uid;
      final currentAddress = await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).add(address.toJson());
      return currentAddress.id;

    }on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong while saving Address Information. Please try again';
    }
  }

  /// [Fetch] - Function to fetch user addresses
  Future<List<AddressModel>> fetchUserAddresses() async{
    try{

      final userId = AuthenticationReposiotory.instance.currentUser!.uid;
      if(userId.isEmpty) throw 'User not found. Please login again';
      final query = await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).get();
      if(query.docs.isNotEmpty){
        List<AddressModel> addresses = query.docs.map((doc) => AddressModel.fromDocumentSnapshot(doc)).toList();
        return addresses;
      }

      return [];

    }on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Unable to find addresses. Please try again';
    }
  }

  /// [Update] - Function to update Selected Address Field of Address
  Future<void> updateSelectedField(String addressId, bool selected) async{
    try{
      final userId = AuthenticationReposiotory.instance.currentUser!.uid;
      await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).doc(addressId).update({'selectedAddress' : selected});
    }catch(e){
      throw 'Unable to update selected address. Please try again';
    }
  }
}