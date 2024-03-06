import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen>
    with TextStyleMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: appBarShape(),
        shadowColor: Colors.white,
        elevation: 2,
        toolbarHeight: 56.h,
        title: Text(
          "Address Details",
          style: appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        leading: const AppBarLeading(),
        centerTitle: true,
        flexibleSpace: const AppBarFlexibleSpace(),
      ),
    );
  }
}
