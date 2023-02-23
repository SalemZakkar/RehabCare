import 'package:flutter/material.dart';

import '../config/config_export.dart';

class EndSplashScreen extends StatelessWidget {
  final double size;

  const EndSplashScreen({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AppAssets.endImageBackground,
            // height: size,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppAssets.endImageForeground,
            // height: size,
            width: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
