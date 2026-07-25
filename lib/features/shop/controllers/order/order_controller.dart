// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
// import 'package:e_commerce_application/features/shop/controllers/cart/cart_controller.dart';
// import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'dart:math';
//
// import '../../../../common/widgets/screeens/success_screen.dart';
// import '../../../../data/repositories/order/order_repository.dart';
// import '../../../../navigation_menu.dart';
// import '../../../../utils/constants/enums.dart';
// import '../../../../utils/constants/images.dart';
// import '../../../../utils/helpers/pricing_calculator.dart';
// import '../../../../utils/pop_ups/full_screen_loader.dart';
// import '../../../personalisation/controllers/address_controller.dart';
// import '../../models/cart_item_model.dart';
// import '../../models/order_model.dart';
// import '../checkout/checkout_controller.dart';
// import '../promo_code/promo_code_controller.dart';
//
// class OrderController extends GetxController {
//   static OrderController get instance => Get.find();
//   final cartController = CartController.instance;
//   final checkoutControllerc = CheckoutController.instance;
//   final addressController = AddressController.instance;
//   final _repository = Get.put(OrderRepository());
//
//
//   Future<void> processOrder(double totalAmount) async {
//     try {
//       // start loading
//       UFullScreenLoader.openLoadingDialog('Processing your order...');
//
//       // check user existence
//       String userId = AuthenticationReposiotory.instance.currentUser!.uid;
//       if (userId.isEmpty) return;
//
//       // 🔥 STEP 1: CART ITEMS KO VENDOR ID KE BASIS PE GROUP KARO
//       Map<String, List<CartItemModel>> groupedItems = {};
//       for (var item in cartController.cartItems) {
//         String vendorId = item.vendorId ?? 'unknown_vendor';
//
//         if (!groupedItems.containsKey(vendorId)) {
//           groupedItems[vendorId] = [];
//         }
//         groupedItems[vendorId]!.add(item);
//       }
//
//       // 🔥 STEP 2: MASTER ORDER (User ke dashboard ke liye)
//       String generatedPin = (Random().nextInt(9000) + 1000).toString();
//
//       OrderModel order = OrderModel(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         status: 'Order Placed',
//         items: cartController.cartItems.toList(),
//         totalAmount: totalAmount,
//         orderDate: DateTime.now(),
//         userId: userId,
//         paymentMethod: checkoutControllerc.selectedPaymentMethod.value.name,
//         address: addressController.selectedAddress.value,
//         deliveryDate: DateTime.now().add(const Duration(days: 3)),
//         deliveryOtp: generatedPin,
//       );
//
//       // Master Order Save
//       await _repository.saveOrder(order);
//
//       // 🔥 STEP 3: SUB-ORDERS (Vendors ke liye)
//       // 🔥 STEP 3: SUB-ORDERS (Vendors ke liye)
//       for (var vendorId in groupedItems.keys) {
//         // Vendor ki specific items ka base price
//         double vendorTotal = groupedItems[vendorId]!.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
//
//         // 🟢 FIX: Ab tere UPricingCalculator se exact tax aur delivery amount nikal rahe hain
//         // Yahan location parameter mein humne empty string '' bhej di hai kyunki calculator usko use nahi kar raha
//         double taxAmount = double.tryParse(UPricingCalculator.calculateTax(vendorTotal, '')) ?? 0.0;
//         double deliveryFee = double.tryParse(UPricingCalculator.calculateShippingCost(vendorTotal, '')) ?? 0.0;
//
//         // UPricingCalculator ka total method call kar rahe hain delivery boy ke collectable amount ke liye
//         double collectableAmount = UPricingCalculator.calculateTotalPrice(vendorTotal, '');
//
//         // 🟢 Store ki location laane ka logic
//         double storeLat = 0.0;
//         double storeLng = 0.0;
//         String storeName = "Unknown Store";
//
//         if (vendorId != 'unknown_vendor') {
//           try {
//             QuerySnapshot storeQuery = await FirebaseFirestore.instance
//                 .collection('Stores')
//                 .where('vendorId', isEqualTo: vendorId)
//                 .limit(1)
//                 .get();
//
//             if (storeQuery.docs.isNotEmpty) {
//               var sData = storeQuery.docs.first.data() as Map<String, dynamic>;
//
//               double parseToDouble(dynamic val) {
//                 if (val == null) return 0.0;
//                 if (val is double) return val;
//                 if (val is int) return val.toDouble();
//                 if (val is String) return double.tryParse(val) ?? 0.0;
//                 return 0.0;
//               }
//
//               storeLat = parseToDouble(sData['latitude']);
//               storeLng = parseToDouble(sData['longitude']);
//               storeName = sData['storeName'] ?? "Store";
//
//               print("✅ SUCCESS: Store Location Mil Gayi -> Lat: $storeLat, Lng: $storeLng");
//             } else {
//               print("❌ Store Doc nahi mila is vendorId par: $vendorId");
//             }
//           } catch (e) {
//             print("🚨 ERROR fetching store location: $e");
//           }
//         }
//
//         // 🟢 Database mein exact figures save karna
//         await FirebaseFirestore.instance.collection('Store_Orders').doc().set({
//           'masterOrderId': order.id,
//           'vendorId': vendorId,
//           'userId': userId,
//           'items': groupedItems[vendorId]!.map((e) => e.toJson()).toList(),
//
//           'vendorTotal': vendorTotal, // Sirf items ka total (₹23000)
//           'taxAmount': taxAmount,     // Tax amount (₹1150)
//           'deliveryFee': deliveryFee, // Delivery fee (₹15)
//           'collectableAmount': collectableAmount, // 🔥 TOTAL (₹24165) Yahi Delivery Boy dekhega aur collect karega!
//
//           'status': 'Pending',
//           'orderDate': Timestamp.now(),
//           'userName': addressController.selectedAddress.value.name,
//           'deliveryOtp': generatedPin,
//           'paymentMethod': checkoutControllerc.selectedPaymentMethod.value.name,
//
//           // Address & Locations
//           'address': addressController.selectedAddress.value.toJson(),
//           'storeName': storeName,
//           'storeLat': storeLat,
//           'storeLng': storeLng,
//           'deliveryDate':DateTime.now().add(const Duration(days: 2)),
//         });
//       }
//
//       // Promo logic
//       if (PromoCodeController.instance.appliedPromoCode.value.id.isNotEmpty) {
//         await PromoCodeController.instance.addUserToPromoCode();
//         await PromoCodeController.instance.decreaseNoOfPromoCodes();
//       }
//
//       cartController.clearCart();
//
//       Get.to(() => SuccessScreen(
//         image: UImages.successfulPaymentIcon,
//         title: 'Payment Success',
//         subTitle: 'Your Items will be Shipped Soon',
//         onTap: () => Get.offAll(() => NavigationMenu()),
//       ));
//
//     } catch (e) {
//       USnackBarHelpers.errorSnackBar(title: 'Order Failed', message: e.toString());
//     }
//   }
//
//
//
//
// // 🔥 NAYA METHOD: Real-time LIVE status for Store_Orders (Package wise tracking)
//   Stream<List<OrderModel>> getLiveStoreOrdersStream() {
//     try {
//       final userId = AuthenticationReposiotory.instance.currentUser?.uid;
//       if (userId == null || userId.isEmpty) return const Stream.empty();
//
//       return FirebaseFirestore.instance
//           .collection('Store_Orders') // 🔥 ASLI JADOO: Yahan saare naye status aayenge
//           .where('userId', isEqualTo: userId)
//           .orderBy('orderDate', descending: true)
//           .snapshots()
//           .map((snapshot) => snapshot.docs.map((doc) {
//         var data = doc.data();
//         // Store_Orders mein totalAmount ki jagah collectableAmount/vendorTotal hai, usko map kar diya
//         data['totalAmount'] = data['collectableAmount'] ?? data['vendorTotal'] ?? 0.0;
//         data['id'] = doc.id;
//         return OrderModel.fromJson(data); // Ya jo bhi tera fromSnapshot logic hai
//       }).toList());
//     } catch (e) {
//       print('Error fetching live store orders: $e');
//       return const Stream.empty();
//     }
//   }
//
//
//
//
//
//   Future<List<OrderModel>> fetchUserOrders() async {
//     try {
//       final orders = await _repository.fetchUserOrders();
//       return orders;
//     } catch (e) {
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//       return [];
//     }
//   }
//
//   Future<void> processOrderFromRazorpay(String paymentId) async {
//     await processOrder(cartController.totalCartPrice.value);
//   }
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart'; // 🔥 ADDED: Geolocator distance napne ke liye

import '../../../../common/widgets/screeens/success_screen.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/pop_ups/full_screen_loader.dart';
import '../../../personalisation/controllers/address_controller.dart';
import '../../models/cart_item_model.dart';
import '../../models/order_model.dart';
import '../checkout/checkout_controller.dart';
import '../promo_code/promo_code_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final cartController = CartController.instance;
  final checkoutControllerc = CheckoutController.instance;
  final addressController = AddressController.instance;
  final _repository = Get.put(OrderRepository());

  Future<void> processOrder(double totalAmount) async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Processing your order...');

      // check user existence
      String userId = AuthenticationReposiotory.instance.currentUser!.uid;
      if (userId.isEmpty) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // =======================================================
      // 🔥 PRE-CHECK: DOUBLE VERIFICATION AT CHECKOUT! 🛑
      // Check if user changed address at the last minute and went out of range
      // =======================================================
      final selectedAddress = addressController.selectedAddress.value;
      if (selectedAddress.id.isEmpty || selectedAddress.latitude == 0.0) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'Address Missing', message: 'Please select a valid delivery address.');
        return;
      }

      // Fetch all stores to verify radius
      QuerySnapshot storeSnapshot = await FirebaseFirestore.instance.collection('Stores').get();
      final allStores = storeSnapshot.docs;

      for (var item in cartController.cartItems) {
        // Find the store for this cart item
        QueryDocumentSnapshot? storeDoc;
        try {
          storeDoc = allStores.firstWhere((s) => (s.data() as Map<String, dynamic>)['vendorId'] == item.vendorId);
        } catch (e) {
          storeDoc = null;
        }

        if (storeDoc != null) {
          var sData = storeDoc.data() as Map<String, dynamic>;
          double sLat = double.tryParse(sData['latitude'].toString()) ?? 0.0;
          double sLng = double.tryParse(sData['longitude'].toString()) ?? 0.0;
          double sRadius = double.tryParse(sData['deliveryRadius'].toString()) ?? 10.0;

          double distanceInMeters = Geolocator.distanceBetween(
              selectedAddress.latitude, selectedAddress.longitude, sLat, sLng
          );

          double distanceInKm = distanceInMeters / 1000;

          // 🔥 Agar product ki distance limit cross ho gayi toh order BLOCK kar do!
          if (distanceInKm > sRadius) {
            UFullScreenLoader.stopLoading(); // Loader band karo
            USnackBarHelpers.warningSnackBar(
                title: 'Pan-India Order 🌍',
                message: '"${item.title}" is outside your ${sRadius.toInt()} KM zone. Remove it to continue or contact grabkrt@gmail.com to order.'
            );
            return; // 🛑 ORDER PROCESS YAHIN RUK JAYEGA
          }
        }
      }
      // =======================================================
      // 🔥 PRE-CHECK DONE! Ab aage ka normal process chalega...
      // =======================================================

      // 🔥 STEP 1: CART ITEMS KO VENDOR ID KE BASIS PE GROUP KARO
      Map<String, List<CartItemModel>> groupedItems = {};
      for (var item in cartController.cartItems) {
        String vendorId = item.vendorId ?? 'unknown_vendor';

        if (!groupedItems.containsKey(vendorId)) {
          groupedItems[vendorId] = [];
        }
        groupedItems[vendorId]!.add(item);
      }

      // 🔥 STEP 2: MASTER ORDER (User ke dashboard ke liye)
      String generatedPin = (Random().nextInt(9000) + 1000).toString();

      OrderModel order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        status: 'Order Placed',
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: userId,
        paymentMethod: checkoutControllerc.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        deliveryOtp: generatedPin,
      );

      // Master Order Save
      await _repository.saveOrder(order);

      // 🔥 STEP 3: SUB-ORDERS (Vendors ke liye)
      for (var vendorId in groupedItems.keys) {
        // Vendor ki specific items ka base price
        double vendorTotal = groupedItems[vendorId]!.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

        double taxAmount = double.tryParse(UPricingCalculator.calculateTax(vendorTotal, '')) ?? 0.0;
        double deliveryFee = double.tryParse(UPricingCalculator.calculateShippingCost(vendorTotal, '')) ?? 0.0;

        double collectableAmount = UPricingCalculator.calculateTotalPrice(vendorTotal, '');

        // 🟢 Store ki location laane ka logic
        double storeLat = 0.0;
        double storeLng = 0.0;
        String storeName = "Unknown Store";

        if (vendorId != 'unknown_vendor') {
          try {
            QuerySnapshot storeQuery = await FirebaseFirestore.instance
                .collection('Stores')
                .where('vendorId', isEqualTo: vendorId)
                .limit(1)
                .get();

            if (storeQuery.docs.isNotEmpty) {
              var sData = storeQuery.docs.first.data() as Map<String, dynamic>;

              double parseToDouble(dynamic val) {
                if (val == null) return 0.0;
                if (val is double) return val;
                if (val is int) return val.toDouble();
                if (val is String) return double.tryParse(val) ?? 0.0;
                return 0.0;
              }

              storeLat = parseToDouble(sData['latitude']);
              storeLng = parseToDouble(sData['longitude']);
              storeName = sData['storeName'] ?? "Store";

              print("✅ SUCCESS: Store Location Mil Gayi -> Lat: $storeLat, Lng: $storeLng");
            } else {
              print("❌ Store Doc nahi mila is vendorId par: $vendorId");
            }
          } catch (e) {
            print("🚨 ERROR fetching store location: $e");
          }
        }

        // 🟢 Database mein exact figures save karna
        await FirebaseFirestore.instance.collection('Store_Orders').doc().set({
          'masterOrderId': order.id,
          'vendorId': vendorId,
          'userId': userId,
          'items': groupedItems[vendorId]!.map((e) => e.toJson()).toList(),

          'vendorTotal': vendorTotal,
          'taxAmount': taxAmount,
          'deliveryFee': deliveryFee,
          'collectableAmount': collectableAmount,

          'status': 'Pending',
          'orderDate': Timestamp.now(),
          'userName': addressController.selectedAddress.value.name,
          'deliveryOtp': generatedPin,
          'paymentMethod': checkoutControllerc.selectedPaymentMethod.value.name,

          // Address & Locations
          'address': addressController.selectedAddress.value.toJson(),
          'storeName': storeName,
          'storeLat': storeLat,
          'storeLng': storeLng,
          'deliveryDate': DateTime.now().add(const Duration(days: 2)),
        });
      }

      // Promo logic
      if (PromoCodeController.instance.appliedPromoCode.value.id.isNotEmpty) {
        await PromoCodeController.instance.addUserToPromoCode();
        await PromoCodeController.instance.decreaseNoOfPromoCodes();
      }

      cartController.clearCart();

      Get.to(() => SuccessScreen(
        image: UImages.successfulPaymentIcon,
        title: 'Payment Success',
        subTitle: 'Your Items will be Shipped Soon',
        onTap: () => Get.offAll(() => NavigationMenu()),
      ));

    } catch (e) {
      UFullScreenLoader.stopLoading(); // Ensure loader stops on error
      USnackBarHelpers.errorSnackBar(title: 'Order Failed', message: e.toString());
    }
  }

  // 🔥 NAYA METHOD: Real-time LIVE status for Store_Orders (Package wise tracking)
  Stream<List<OrderModel>> getLiveStoreOrdersStream() {
    try {
      final userId = AuthenticationReposiotory.instance.currentUser?.uid;
      if (userId == null || userId.isEmpty) return const Stream.empty();

      return FirebaseFirestore.instance
          .collection('Store_Orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
        var data = doc.data();
        data['totalAmount'] = data['collectableAmount'] ?? data['vendorTotal'] ?? 0.0;
        data['id'] = doc.id;
        return OrderModel.fromJson(data);
      }).toList());
    } catch (e) {
      print('Error fetching live store orders: $e');
      return const Stream.empty();
    }
  }

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await _repository.fetchUserOrders();
      return orders;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  Future<void> processOrderFromRazorpay(String paymentId) async {
    await processOrder(cartController.totalCartPrice.value);
  }
}