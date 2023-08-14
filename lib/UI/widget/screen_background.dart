import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/asset_utils.dart';

class screen_background extends StatelessWidget {
  final Widget child;
  const screen_background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            AssetUtils.BackgroundSVG,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(child: child)
      ],
    );
  }
}
