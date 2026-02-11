import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/shop/screens/order/widgets/order_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('My Orders',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(padding: UPadding.screenPadding,
        child: UOrderListItems(),


      ),

    );
  }
}
