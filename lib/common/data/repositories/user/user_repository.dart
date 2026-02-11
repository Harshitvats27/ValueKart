import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/utils/constants/key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../features/authentication/models/user_model.dart';
import '../../../../utils/exception/firebase_auth_exception.dart';
import '../../../../utils/exception/firebase_exception.dart';
import '../../../../utils/exception/format_exception.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Function to store user data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection(UKeys.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on UFormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
// Read => Function to fetch user data
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(UKeys.userCollection)
          .doc(AuthenticationReposiotory.instance.currentUser!.uid)
          .get();
      if (documentSnapshot.exists) {
        UserModel user = UserModel.fromSnapshot(documentSnapshot);
        return user;
      }
      return UserModel.empty();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on UFormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update
  Future<void> updateSingleField(Map<String, dynamic> map) async {
    try {
    await _db .collection(UKeys.userCollection)
          .doc(AuthenticationReposiotory.instance.currentUser!.uid).update(map);

    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on UFormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



  Future<void> removeUserRecord(String userId) async {
    try {
      await _db .collection(UKeys.userCollection)
          .doc(userId).delete();

    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on UFormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<String> uploadProfileImage(File image) async {
    try {
      final uid = AuthenticationReposiotory.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(uid)
          .child('profile.jpg');


      await ref.putFile(image);

      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;

    } catch (e) {
      throw 'Image upload failed';
    }
  }

  Future<void> deleteProfileImage(String userId) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userId)
          .child('profile.jpg');

      await ref.delete();
    } on FirebaseException catch (e) {
      /// If image doesn't exist, ignore safely
      if (e.code != 'object-not-found') {
        rethrow;
      }
    }
  }


}
