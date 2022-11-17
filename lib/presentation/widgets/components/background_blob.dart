import 'package:flutter/material.dart';
import 'package:local_library/core/themes/palette.dart';

class BackgroundBlob {
  static List<Positioned> getBlobs({
    required final double screenWidth,
    required final int blobCount,
  }) {
    final List<Positioned> blobs = [
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/img/signup_top.png',
          width: screenWidth * .45,
          color: Palette.lightGreenSalad.withOpacity(.7),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Image.asset(
          'assets/img/main_bottom.png',
          color: Palette.lightGreenSalad.withOpacity(.4),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Image.asset(
          'assets/img/login_bottom.png',
          width: screenWidth * .6,
          color: Palette.lightGreenSalad.withOpacity(.25),
        ),
      ),
    ];

    return blobs.sublist(0, blobCount > 3 ? 3 : blobCount);
  }
}
