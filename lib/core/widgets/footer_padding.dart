import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterPadding extends StatelessWidget {
  const FooterPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox(height: MediaQuery.paddingOf(context).bottom);
    } else {
      return SizedBox(height: 16.h + MediaQuery.paddingOf(context).bottom);
    }
  }
}
