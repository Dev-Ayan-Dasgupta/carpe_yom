import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportAgent extends StatelessWidget {
  const SupportAgent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SvgPicture.asset(ImageConstants.supportAgent),
    );
  }
}
