import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String id;
  String vendorId;
  String storeName;
  String ownerName;
  String phoneNumber;
  double latitude;
  double longitude;
  String address;
  bool isActive;
  double deliveryRadius; // 🔥 Naya Addition: Har vendor apna radius set kar sakega

  StoreModel({
    required this.id,
    required this.vendorId,
    required this.storeName,
    required this.ownerName,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.isActive = true,
    this.deliveryRadius = 10.0, // Default 10 KM radius
  });

  Map<String, dynamic> toJson() {
    return {
      'vendorId': vendorId,
      'storeName': storeName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'isActive': isActive,
      'deliveryRadius': deliveryRadius,
    };
  }

  factory StoreModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StoreModel(
      id: document.id,
      vendorId: data['vendorId'] ?? '',
      storeName: data['storeName'] ?? '',
      ownerName: data['ownerName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      latitude: double.tryParse(data['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(data['longitude'].toString()) ?? 0.0,
      address: data['address'] ?? '',
      isActive: data['isActive'] ?? true,
      deliveryRadius: double.tryParse(data['deliveryRadius'].toString()) ?? 10.0,
    );
  }
}